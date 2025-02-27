{ config
, lib
, pkgs
, ...
}:
# NFS failover setup based on syncoid.
#
# This setup works as follow:
# - The nfs server uses zsnapzend to sync its zfs pools to the nfs backup every 10 minutes
# - Both nfs server and nfs backup have a dedicated ip address: 2a09:80c0:102::f000:0/64 for the server
# - If the nfs server becomes unavailable the backup server can become the nfs
#   server by importing `nfs/server.nix` instead of `nfs/server-backup.nix`
# To migrate nfs service from one machine to another while both machines are still online, first remove
# their ipv6 addresses to avoid ipv6 duplicate address detection to fail:
#
# on the server
# ip addr del 2a09:80c0:102::f000:0/64 dev bond1
#
# on the backup machine
# ip addr del 2a09:80c0:102::f000:1/64 dev bond1
#
# Than swap the imports for `nfs/server.nix` and `nfs/server-backup.nix` in both nixos configurations.
{
  imports = [ ./. ];

  sops.secrets.syncoid.sopsFile = ./secrets.yml;
  sops.secrets.syncoid.owner = "syncoid";
  programs.ssh.extraConfig = ''
    Host nfs-backup
      User syncoid
      IdentityFile ${config.sops.secrets.syncoid.path}
  '';

  services.nfs.server.enable = true;
  # fsid is necessary so that we can failover to the backup nfs, without getting
  # stale mounts on our clients.
  #
  # 2a09:80c0:38::101/128 is our riscv board in the hardware lab
  # 2a09:80c0:38::222/128 is our m1 mac mini
  services.nfs.server.exports = ''
    /export/home 2a09:80c0:102::/64(async,rw,nohide,insecure,no_subtree_check,no_root_squash,fsid=25) ${config.networking.doctorwho.hosts.ruby.ipv6}/128(async,rw,nohide,insecure,no_subtree_check,no_root_squash,fsid=27) 2a09:80c0:38::222/128(async,rw,nohide,insecure,no_subtree_check,no_root_squash,fsid=29)
    /export/share 2a09:80c0:102::/64(async,rw,nohide,insecure,no_subtree_check,no_root_squash,fsid=26) ${config.networking.doctorwho.hosts.ruby.ipv6}/128(async,rw,nohide,insecure,no_subtree_check,no_root_squash,fsid=28) 2a09:80c0:38::222/128(async,rw,nohide,insecure,no_subtree_check,no_root_squash,fsid=30)
  '';

  systemd.tmpfiles.rules =
    let
      loginUsers = lib.filterAttrs (_n: v: v.isNormalUser) config.users.users;
    in
    (lib.mapAttrsToList (n: _v: "d /export/share/${n} 0755 ${n} users -") loginUsers)
    ++ (builtins.map (n: "R /export/share/${n} - - - - -") config.users.deletedUsers);

  boot.zfs.extraPools = [ "zpool1" "zpool2" ];

  fileSystems."/export/home" = {
    device = "zpool1/home";
    fsType = "zfs";
    options = [ "nofail" ];
  };

  fileSystems."/export/share" = {
    device = "zpool2/share";
    fsType = "zfs";
    options = [ "nofail" ];
  };

  systemd.services.syncoid-setup = {
    wantedBy = [ "multi-user.target" ];
    before = [ "syncoid.service"  ];
    after = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        # delete nfs backup server ip if present.
        "-${pkgs.iproute2}/bin/ip addr del 2a09:80c0:102::f000:1/64 dev bond1"
        # add nfs server ip
        "-${pkgs.iproute2}/bin/ip addr add 2a09:80c0:102::f000:0/64 dev bond1"
      ];
    };
  };

  services.syncoid = {
    enable = true;
    # every 15 minutes
    interval = "*:0/15";
    commands."zpool1/home" = {
      target = "syncoid@nfs-backup:zpool1/home";
      sshKey = config.sops.secrets.syncoid.path;
    };
    commands."zpool2/share" = {
      target = "syncoid@nfs-backup:zpool2/share";
      sshKey = config.sops.secrets.syncoid.path;
    };
  };

  systemd.services.syncoid-zpool1-home = {
    serviceConfig.ExecStopPost = [
      (
        "+${pkgs.writeShellScript "telegraf" ''
      umask 022
      cat > /var/log/telegraf/syncoid-home <<EOF
      task,frequency=tenminutes last_run=$(date +%s)i,state="ok"
      EOF
    ''}"
      )
    ];
  };

  systemd.services.syncoid-zpool2-share = {
    serviceConfig.ExecStopPost = [
      (
        "+${pkgs.writeShellScript "telegraf" ''
      umask 022
      cat > /var/log/telegraf/syncoid-share <<EOF
      task,frequency=tenminutes last_run=$(date +%s)i,state="ok"
      EOF
    ''}"
      )
    ];
  };

  sops.secrets.tum-borgbackup-password.sopsFile = ./secrets.yml;
  sops.secrets.tum-borgbackup-home-ssh.sopsFile = ./secrets.yml;
  sops.secrets.tum-borgbackup-share-ssh.sopsFile = ./secrets.yml;

  systemd.services.borgbackup-job-nfs-share.serviceConfig.ReadWritePaths = [
    "/var/log/telegraf"
  ];

  services.borgbackup.jobs.nfs-share = {
    paths = [
      "/export/share"
    ];
    repo = "il1dsenixosbk@doctor.r:/mnt/backup/nfs-share";
    exclude = [
      # large memory traces
      "/export/share/redha/traces"
      # vm images
      "/export/share/cmainas/**/*.img"
      "/export/share/martinL/**/*.img"
    ];
    encryption = {
      mode = "repokey";
      passCommand = "cat ${config.sops.secrets.tum-borgbackup-password.path}";
    };
    compression = "auto,zstd";
    startAt = "daily";
    preHook = ''
      set -x
      eval $(ssh-agent)
      ssh-add ${config.sops.secrets.tum-borgbackup-share-ssh.path}
    '';

    postHook = ''
      cat > /var/log/telegraf/borgbackup-job-nfs-share.service <<EOF
      task,frequency=daily last_run=$(date +%s)i,state="$([[ $exitStatus == 0 ]] && echo ok || echo fail)"
      EOF
    '';

    prune.keep = {
      within = "1d"; # Keep all archives from the last day
      daily = 7;
      weekly = 4;
      monthly = 0;
    };
  };

  systemd.services.borgbackup-job-nfs-home.serviceConfig.ReadWritePaths = [
    "/var/log/telegraf"
  ];

  services.borgbackup.jobs.nfs-home = {
    paths = [
      "/export/home"
    ];
    repo = "il1dsenixosbk@doctor.r:/mnt/backup/nfs-home";
    encryption = {
      mode = "repokey";
      passCommand = "cat ${config.sops.secrets.tum-borgbackup-password.path}";
    };
    compression = "auto,zstd";
    startAt = "daily";
    exclude = [
      "*.pyc"
      "*.swp"
      "*.o"
      "/export/home/*/.direnv"
      "/export/home/*/.cache"
      "/export/home/*/.npm"
      "/export/home/*/.m2"
      "/export/home/*/.gradle"
      "/export/home/*/.opam"
      "/export/home/*/.clangd"

      # these users have qemu images in their home directories, which causes borgbackup to fail
      # /export/home/gierens/images/guest.qcow2: file changed while we backed it up
      # /export/home/simonk/ubuntu-riscv64.img: file changed while we backed it up
      # /export/home/patrick/vmuxio/VMs/.nfs00000000000ec37a00000003: file changed while we backed it up
      # /export/home/patrick/vmuxio/VMs/.nfs00000000000ec7e900000004: file changed while we backed it up
      "/export/home/gierens/"
      "/export/home/simonk/"
      "/export/home/patrick/"
    ];
    preHook = ''
      set -x
      eval $(ssh-agent)
      ssh-add ${config.sops.secrets.tum-borgbackup-home-ssh.path}
    '';

    postHook = ''
      cat > /var/log/telegraf/borgbackup-job-nfs-home.service <<EOF
      task,frequency=daily last_run=$(date +%s)i,state="$([[ $exitStatus == 0 ]] && echo ok || echo fail)"
      EOF
    '';

    prune.keep = {
      within = "1d"; # Keep all archives from the last day
      daily = 7;
      weekly = 4;
      monthly = 0;
    };
  };
}
