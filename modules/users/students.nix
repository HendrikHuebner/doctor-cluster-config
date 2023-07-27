{ config, lib, ... }:
let

  paulKeys = [
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEBXRWrVa4+O0OulhfKo7US7baIVO7b3NqhBYJ8O4Bg+MFQj8lwcVkgteia9K0VYV4xJbzdyBlrHk2LXsN/SBkI= DSE@secretive.Paul’s-MacBook-Pro.local"
  ];

  mfKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINK0/PSpRypoFe8NQ1BHjCyxraIvhX/0q6OIO7DYnmyq Martin Fink"
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBCshvYXlVtnaApJlB5BFhfZLWXnY4/9JKdNf3PFuPV8ZKU2Ssk7uAR5O5COVKDb9HnvArF7v+eoxKFmhwGXnlEU= Martin Fink"
  ];

  julianKeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDZs04queaSB/BGQesCEiunOkeEydB5rJ2WUXSrGlDLVoJ6/Q7fAHM99200fxK7h0vtKda4OkdUEBtRtq2wn+Z0YW51mFvzJ7214ZIY4JKtYX02KW8r7gVXYmjoX3VWEKi5iKfld0WO9jaDN3InU5CYyYx1nHl+BNasxIHtUzjhHCC+Ggxt3Kc+IxW2DV8J9/JwhKhgedqvqbc93+V05/UeYwG0Q9z1mwBEuOlGv8yP6uhCWmHzxbJYo+oxU5nSXM0lPHecxa7M8hROXEVrSxg27vUg7JoiSQ1wt3lzNQS4Abd8JLqOJlQYQvbz5Xxd0KhD0kaBCptXBCxdOo+YLi06XNs16rRtQPM51jTrero3h1wfA51XR7w7j52nbLC2ZGMyaSO1c5IQ5d5Xad/F1ZcOQQWvFhK+ie9LJzvR0AXiFXzEBvmPiZ82rLdjWGPO4975fSYTOxshZojk7oV4fQyd5vKCsjChL0JC2chPfYRv2kti/9CVqVseznVMPE/JgdE= julian@mind"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCkHALCUCursw1AvmYaQLfYBee1lGR4sqqlTEHfatyAqQrCxFnWNnO03ScEfNsDQKDZPRQ/RZYOOHlNxoKQzYaHlpbFafePKNH+lKZWibabp4HT3ho0mi56i2sqXLSMP+y3nz4S7vx678CVgyK1/gW9wB0ORNh1Ss1NqPhi/DFxHVxcLig3mjCVoC6QzIzTLq8uVP/bOD2jtED/PSdAFQQNd2RjKWea7UjjH7IiQvvJHwl1OB8X1x7mxwuQuHCMj7kwwKfEEvqOy3NiDzY9Ewc7HihFLkROMK3obbYLoQjYf/tP9SYpekWx4Q8CpgmvAblwDcv8unmnYAN2Cj5PQ4YulBPCOwNfmVCvsp3gX8eLG6XNYjnHt7DIEm8Yj4EeSCuB6DLOR2Em5eKH57qzQFHyubdIwVoY1xzfdd1wzaKuL+ahoLKmZ23Q6bK795BwZBogyoceREg9surF9P8l9mJi2Yn8aGMtCF9ecIySNGYwI1AqKGYX14Vo9HA3nfADCI1wCND5LyqD6UDGfM1iBV38gGl05jyywcTgpctI4ryQy6SUDf9x+CZuDwHXihR6Rj9Oj1Vy6zFdCKq4xt76xCsIPuy+6CY4RdOkCNmQn3NKeRnttLmyYIpLbHkTdYs8GIyLsf1mz6uHZNcWg5fwPTabgT8PJ5yJRQo9IoXGawf+vQ== julian.pritzi@gmail.com"
  ];

  mwerndleKeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsZ8xTt0Ti6evYqvLBMXLaExS0SP0KZB7oSA7RO3tQinlVT62KIxJ5NXxrKgCOy3evCtN+fqYFvshGHZ6/FPcOj3i3PfJRHaj6WjQicIIfVFEbfLtzh2QxDDVXBkfh747fBmPHrfXJwxCRjRpSwYBmDBcJVjH3weHLqVm6f4SioDWMZ8arCYipZSPlfCFvcqR532ipiKQH3pHinjtopLMLmZnZQeXOsK1lsIDLs7/onkK1cNhCeX7Hq69N7gp/2AYUoXjnZ2/vvDq6QAofz5jASDjPfZz1eHdz4owc6I+LoAc76QxE/37mV6PCiGO4YiQji8byvjuIq94moOMfIDkj teppichseite@DESKTOP-NRKB54G"
  ];

  gierensKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBevyJ5i0237DNoS29F9aii2AJwrSxXNz3hP61hWXfRl sandro@reaper.gierens.de"
  ];

  yiheKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJgQ10239M1Ehw6nmY7mFxGyqfpCkfSHAjZzSZZZ7NLA"
  ];

  jonasKeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCklke4DPtQ3FaOyEF7bFncskfGayXfTOoP5LRbwP0L+J33h5iZGWrP8ejL2NpAgt/TAbt6G6e/hAkraShcW8XaiN3woPyhY9fuKLjf8JGQGFX6Vh33KHDWxa/v70pyai8iWS6XgTzcdymcQLypRSDgpAlEYmG8tc4sHFKsQX+e/2a5PHG19+6MgPcn1ipYyj/I3EV3WlHcf7TZvANBtW7pNQJUeZ4zMibvl2kHrzJJyLQhowBJqLp8D9z/MTmyPbQYzUTE+4DFDiV2O2enax8lgTsiuP4HDfmIzv4qXxbZZoxiLhw4N+OiVSRbUkC5nWBW7e9k6gIpT0QR5+JAXPD6E4wzKq7pviAASj/hirRgSz64GBjHZMGbmXCOXvsV3pEF1dfibHBA9dnNHkSNcfpKqcvsOSJwSjq+CfEwyAUwPOgM1bn49ozpdGMMstYbn+u25NfMLdfPVb2Ney42WeG7uncVGDDccp4V8AmSIPi1sNs6P7kwAmZpH6+w83wvG10= jonas@pop-os"
  ];

  robertKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAA3PSbVdQzIvsWTNWYhR298oaYDl9ySe/PBUZrlcjPB scha@in.tum.de"
  ];

  theoKeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCvGQ0aKNGTkaEjjkGkaQ+8vA83Tbl5fpjuGTPrmszZuxzmSx4/6kw7Py4faLRJfcFNPdPp9FfFxsqCLpYMWKYVmdojQHIGBTugTtaadCrQ4W0Su6WcTN3OLa6n9heo+SE4Z+Uk1dUys0jMaZoKH7x/x2Yd9Zwg9sd0O2oa65VFV831mVGnagSrk+pJBh1MprmDEgobsRVFDEC8bENe23S58Hpvp6c7kLJnNlb11ojVAJBPBmH1QLwKceW66iRQPAmHJdqx5xCIWO1qkOut/hzNuDQMghGabsfh9huWpInZBVSH29pEWWw4CiPgACVzFBTojqcmlRiTMiszX7MiPkIfLCilpQF/KtavhGihq4yRs+6UxKV/4ErYItZeDaI5kgU+19cug12newP8wks9hJNpXX3N0wXYM0M8ZPvXc61z7EfRfpBMh5XLj9RMnSfuGFfoGKkRcWgx9nx+69FwqNQYsbL+id8U0lHqas6ai6gEbecF8UJv/r2h0zDaoKhNv70= taugoust@fedora"
  ];

  simonkKeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDrdEe2/aOcUzaPtkDLJQ8VrcfiF8tNpk02SPLIVrsTywSHrBueOMz/cVR/Dkk7HREkI8iPshIefYogGgXNrwXp4ogu7DFA/5FS58QgrUS/il/LYT1pIcC4URFt0s5UHxvXbVP/zPVVpDZ7AqXLzz0H95csR9mO5eY2CgZh5+haC1dNhBEZK7v2pcsp+TrDzcxKjo5ZjqFAUNRBAT/lMJy2t0Zdm9cnkNFYymC2n57mgve2W9L8mRsMTYdQbwT7S7PgV3605e7bphnvGVl09iSkwkbQZ9oiqvZFdVn9id6tPxlf6wnnMo2YU9fuqRJoF6kKGN5Mvqvmm6bIUW5y9cFjpAniJg7lPY2Dc/em/q5jpdYirnkPnjnjpqdNBKnroRbsNL8bUWPyyZM4seSAIaw61OUQLhJHClUx9sAb3nyWRq6k2PAB1HcBeY9dVgv3b+0ZzNsR52IqEzs3VOZGAS174Kd8FFk7oyV15a1qfyhCzKxNJIbW8AHXh+S7EcVnyYyJguJ/hblUOwsc4Un/3UQkmhTTOkZOb3zZklHM62isA4yA6uAUkCxASgaG0UMtvzeJiynYLr1x4YR2jTKU2VD79n8pcKienJmBH0d80FtnPMiJPZA4EiVSXYAZ1PKbVsSBk47Ia7SmgZr46VX4ha5frAY/kQNzFk9qyImuyPyIyw== kammerme ge35tem"
  ];

  shuKeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDdNJJX/Y6xOkSKwrHubpZNti5Gk9VFycn9hLzP2x9fo/ZbqrSfNNSAmj2OMHjXKpXHkyVuD2V4Yw/N7ulIX070o05ljn3zbZO4z6upg1czjXys//LvGevCm6cItg5i4bk/XVz+1Q+iaQgPQbkQJ0cM9h1kIwq1p9S+mh37yj4JVmSb6w+hVD6kWOTrE9UL88HEPmBClr/syqQ9KJt9/KvnoeBV5GE58swYvCNCenUdSHYzhpE4WUKeJhqO38i1Oux6aXSJbjdQaR+YaHTXPHkHLOpkY6lHleRj2M9ooEwYzAjIoU9zGgjoj1fxOp9IGdlS/BhnFVaPh/z2Hu1KPpOmY+Cby9hIUf13KCUnp3eLGf5HB3IUBRTf6t12A65cPHeVISBOLO+6gcrOWKHnNAOq8RJaNBvNQ+N0AZejXYdojqvSod2+0ATT57bSlUiL3E+u5KN7gG7/dohY4OdxSMqt+Hvi3fsMYt2FKVUFWK4AqvgaXzDj4mjIZ44DAHdS408= gedatsu@fedora"
  ];

  felixKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOtPYKJOWfanR0dTkoQuYWA7XtiiPiVTYqpldjIuEk4w"
  ];

  eaypekKeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCgvtsWzXcCS8gCXFHZ+7wlgdxWBZETkVytZl33MLgLaYniRaOnPUThS7wuevMKS7cRzX87Sut7Gf3ILIWp5VoTVgHkfJgM8oYhdHMQOMmHhaHlJ7DTlhDAiYdLJKolBnFyy/icXtR6U3SPdZAyf8+aIT1ZyTrkZmFgxNKXDU12CFuX7aVvJXHbgr5GcJpv/cS0Bp8IF42yyRqtx+lSWGGCMA94XJjKIwaJXun55yPVzZotHVUlcs6cB+6eg35EeFLGWpuji/yyUSYW7hux2A7V0v3BZrdI3hWq++zDhM/Ai5WAJUf21VQpFzd8pjrm+WVz7vQK4LulPd3aWLnO5eZ1+iVmdqBYm74gLeiObynZgEhwO/EsUpTglDwfSv9uqcmDfkH/iFR6rrGm+7A79f4KjMANSCTb8A2ppJ+nKAlW+Me4Ut6w+R6WACpqYuj4LRASvAX6Eada/21j15tJ6W07CrI7HpDB7Ay4jhlhyRM2LIqxu0A06hevMbCwHjq6qs0= eaypek@ertugrul"
  ];

  raitoKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICaw9ihTG7ucB8P38XdalEWev8+q96e2yNm4B+/I9IJp raito@paris-laptop"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKiXXYkhRh+s7ixZ8rvG8ntIqd6FELQ9hh7HoaHQJRPU raito@munich-laptop"
  ];

  kaiKeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDV3oHLMnrwqomwg7mZh43uV4IORsJHpzZQGDlTV5lz2aKlSdnB8UX7abgt5HwGPYqjHb+Q3HL6WRBMIMVqPk18LvITg7fOJxeIhgSOpJolr4UOM0Gb8ITqmKUDRloyr/74bx6JDC27+snaBfTD1vWyrH80t0xepvDlgWMD+Osx68a6lKV/832vRb3EZxOcdQe3oJPb+MEDMP+jQTbRn2US6TAi2zI3z1XgSPnPy4CKeFKmsIhMw0MVDKVKTfVxW0croX3pPk383XwKTe1M7qBH6UtNV7AqTR5imsI+7FCJbEKQBynaYgBjYEoSUKNfNATeBo+p4oKkz8hcLnAEXL+lvym1iEFJXDzh8keNfPYY30yBRV+kNANduFkWbPlKzTXS+l8ICdVJWFtmLLL/kTYTtfS2qR8spNpkbUq9AVpTYVBQHxG4KTI0CqYhmP2N8OIsERNayezc8yhC"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM+ApCfMsWq6WAKeElbZyxH+fve33DB7k5cFzOMo8ic5"
  ];

  kamilKeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPCKEUYZMotuVIMsFnwgTeSfv3oqfazkmpfrahmL0xqt2TLRvNpiNs1OE5JS3loPPefQ5OmskItTovgm5uo2ZoR+6aJmaKnbYhIT3C9TOWO/WbPL+XpN+Go49MK2P92h0TgMQ+Ilff99BvNWIn/rbkmO6tWJByXpuQnCMYpCDO3rgeNBxYKYN1asEij18TgPSOxbgNq9Fy0zxNXwU+raozbx3/t6FQpMkKPcZ5uwlER8RidZOakZa9gioQKZmN6pGnEN4oQUhuQA8V5g+RrPaJcJhUGC5ZOQaOyr0sGH/s4la/rbTSMh5imcoC/74ZeRg44t34XSDP0XapS0ePWiY9WuQDn7elbNU4m188f3G41ZOnIBOkfle1mtfao8gO7zzJd1tbi056HkB9KGj9v96rN4LtG5CF6n8mQsyHIgeP91HWAkqdKwFC2LX3m7urzWvaA9JjejgFqOMMDlGSYrZ5MYfZaeRQPxukT4LlDyYnluOy08MpgQ7fvviY2PwvHfjdrVGDusBAiKSfbOB77qFr8WE1Xh0SQteJ9mADNqTeJG/aYw33a/HEaRs/gDlco4mRF9mw/RsPC/t5O7lb9GHIB0OfKPlGv2EbahHxbiWbsE7nFmzbG69GEL+9zVC3rbQ1fzjIkGHYlfLZ8ygrOVPGdtNeskDBx+kkjiHNwIptuw== kamilkozakowski@Kamils-MacBook-Air.local"
  ];

  nateKeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCwt42sLSi5MwnD73x9eZnyiClBf+p9N4SMrbMkkqtGUJ6x87UBOX8oUT++/ZetfbXHffMlDVgeUqEk5YfsqAGA7lbU1k3oqtW9ey+Ucyu0ai+J9hgbYQUBY8bVrcgjwUC5PFDFfrjk2yt5WBxVmTmi/AZB7rZRK8liECH8gCfewAbpHV0IsQo+JV+K4VZzOL0gqXeEhxXs8qMujYD5ptp5cLfSyEpEaGXcakb/XHCgtJIMXnq8gXqQ0uKSFEN3aGlqYdCwT28yxAiICSLQJ6D4yrY5zwJ+m87xIarDAHZMn2CS+zp26SMezYQcSOL0FuJb5tYD4DouAJ/MaY7r9f+IAH60r58GKe0PtmNGnOOEorYIhzp3sCPSDtoFY4tl7TC6Qat/wWzDTpR9eDH5lBP1x6sZtzl1q1tJ79QgfcIFHdSdgp+28k6clwCqNb3Hcv4Tls2dPLB2cI7j7ehbtZJDIIeqqx+FxcacUj83av5O8p6RKK5fHyKQNCGYqcNZD08= nathanieltornow@Nathaniels-MBP"
  ];

  robertoKeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDcpGTfG8vzYCdGGeJ3YnO3W7kjN+r7tdRbV4ybDCUH3PJMxUap587HIvSDs1Y3xvMZme6Wb8NjEm7HWxd3/aRd1iwzzC+lCVQ/jAfrqnAbeGfx1v+e3zBTsXrUCe1rn9bDJ7ZJnvG1ZFtEbgnTTxtHao87VAQacxPJzkkXUu/ngWyQ7QMGarbs1BjVXFjWoOuWKDPFwjLeW8qiECSAJREyyN7AqMh4i9UzQDcc1Kms5k7iZA4HbGHlxwqcaRG5fluv1a/onlPwrU6rytgdgCn6V7rFUbO77aWwvK4F7y+H1JatzWYkWQvFZSZ8JbNyAsq46weOch+qOGgUeKr1r9Gp70/H3YbIDPzfIkZGY9prCoEv/9uUVus4wG7wcUtH43+3ehg7T00/4gzVhV+lwtpYyECti1X39AZHvFSCaE0PnYqQneF0XC78YySSG3UnaQU1uN5ct+JyI26f5H3Ayw1a4ItdgfxkdJBgzVpjE3cYlyxmYeEmRb9MnmR+MdThc9E= rc@w203-1y-v4.eduroam.dynamic.rbg.tum.de"
  ];

  fritzKeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/RJrLS8Wjy5mTP+9c0Qg17SSjEytq5fdRBlXuz4GFKyr1rD064hIWeEP2mRiprbME2smiLl8jJG8d/WJKcK6xIPYs1qExCn4gt39kYPUmRnOwtcepfkdNTjIBvYAnPPjA+9t+m31wr2NUO6ns43SyDlkcz0YxXM1JuYpf77EDQ3HCHg3c+pn9MGXXaBrLqqP+7MNiIHHyygwASPxx5c4f98Me06DDlyZjGsriZB/X+W4eKum8AZsQAUpo9u1Njsb7BB2V4Y+WXnzJewyWUQNONeJVgzxB47k3PlVUvjWn4ZJ63uCVm8kDrfLM92RCSmDwVkd6SDHCefmh6L0g1cdl fritz.rehde@tum.de"
  ];

  iuliaKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDWO997ZygpIs+41KpvcZ9glH+vv/Wz0j59x1owYPyP6 iulia.cornea@tum.de"
  ];


  martinLKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKs9HeN8+UkNXlfYBSFZmF7L+1lG/tckc1UxnI94bOt3 fair"
  ];

  elizaKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKva0ESsYg2pmkK5b7t0FbwZLk/ObmDJk07E9x5EdWH7 liza@w196-3i-v4.eduroam.dynamic.rbg.tum.de"
  ];

  florianKeys = [
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIK4f12ldfJGJhMUbAYOz5E3aXc+F6SScLb2n2KdVfqu4AAAAC3NzaDp0ZXJtaXVz"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIOJpaI1Zb1R9gcipR71Ulh1SNxJj1frEK9XfzRFe/uJmAAAAC3NzaDp0ZXJtaXVz"
  ];

  m00wlKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKj82MjggZ8uEbi/1cITRA84Ou2I6TYfCPfFHwhXm2Tx moritz.lumme@tum.de"
  ];

in
{
  # for new students please use a uid in the range between 2000-3000
  # You can set `users.users.<name>.allowedHosts` to restrict access to certain machines.
  users.users = (import ../lawful-access/add.nix { inherit config lib; }) {
    # Paul Heidekrüger, Babish's BA student (Dependency ordering in the linux kernel)
    paul = {
      isNormalUser = true;
      home = "/home/paul";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/zsh";
      uid = 1007;
      openssh.authorizedKeys.keys = paulKeys;
    };

    # Martin Fink (HiWi)
    martin = {
      isNormalUser = true;
      home = "/home/martin";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/zsh";
      uid = 1016;
      openssh.authorizedKeys.keys = mfKeys;
    };

    # Julian Pritzi, Harshas's student (Benchmarking tool for ICU project)
    julian = {
      isNormalUser = true;
      home = "/home/julian";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/bash";
      uid = 2000;
      openssh.authorizedKeys.keys = julianKeys;
    };

    # Matthias Werndle, Dimitris' BSc student (Generic programming model for PM)
    mwerndle = {
      isNormalUser = true;
      home = "/home/mwerndle";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/bash";
      uid = 2001;
      openssh.authorizedKeys.keys = mwerndleKeys;
    };

    # Sandro Gierens, Peter's BSc student (applying ioregionfd to KVM/qemu devices)
    gierens = {
      isNormalUser = true;
      home = "/home/gierens";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/bash";
      uid = 2003;
      openssh.authorizedKeys.keys = gierensKeys;
    };

    # Yi He, Sys-lab WS22 (Sebastian's group), and now a HiWi
    yihe = {
      isNormalUser = true;
      home = "/home/yihe";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/zsh";
      uid = 2006;
      openssh.authorizedKeys.keys = yiheKeys;
    };

    # Jonas Zöschg, Harsha's student (End-to-end on-chip encryption)
    jonas = {
      isNormalUser = true;
      home = "/home/jonas";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/bash";
      uid = 2014;
      openssh.authorizedKeys.keys = jonasKeys;
    };


    # Robert Schambach, Dimitra MSc student (Opentitan -- t-nic project)
    robert = {
      isNormalUser = true;
      home = "/home/robert";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/zsh";
      uid = 2015;
      openssh.authorizedKeys.keys = robertKeys;
    };

    # Theofilos Augoustis, Redha's MSc student (Arancini project)
    theo = {
      isNormalUser = true;
      home = "/home/theo";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/zsh";
      uid = 2016;
      openssh.authorizedKeys.keys = theoKeys;
    };

    # Simon Kammermeier, Redha's BSc student (Arancini project)
    simonk = {
      isNormalUser = true;
      home = "/home/simonk";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/zsh";
      uid = 2017;
      openssh.authorizedKeys.keys = simonkKeys;
    };

    # Shi Anzai, former intern (Atsushi)
    shu = {
      isNormalUser = true;
      home = "/home/shu";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/bash";
      uid = 2019;
      openssh.authorizedKeys.keys = shuKeys;
    };

    # Felix Gust, Atsushi's Master student (Trustworthy disaggregation)
    felix = {
      isNormalUser = true;
      home = "/home/felix";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/bash";
      uid = 2022;
      openssh.authorizedKeys.keys = felixKeys;
    };

    # Ertugrul Aypek, Dimitris' BSc student (GDPRuler)
    eaypek = {
      isNormalUser = true;
      home = "/home/eaypek";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/bash";
      uid = 2023;
      openssh.authorizedKeys.keys = eaypekKeys;
    };

    #  Ryan Lahfa, intern 2023 (Jörg)
    raito = {
      isNormalUser = true;
      home = "/home/raito";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/zsh";
      uid = 2024;
      openssh.authorizedKeys.keys = raitoKeys;
    };

    # Kai-Chun Hsieh, MSc student with Masa (unikernel bpf verif)
    kai = {
      isNormalUser = true;
      home = "/home/kai";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/bash";
      uid = 2025;
      openssh.authorizedKeys.keys = kaiKeys;
    };

    # Kamil Patryk Kozakowski, MSc student with Dimitra (FPGA-based RDMA stack)
    kamilk = {
      isNormalUser = true;
      home = "/home/kamilk";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/zsh";
      uid = 2026;
      openssh.authorizedKeys.keys = kamilKeys;
    };

    #  Nathaniel Tornow, working on the Quantum project + tutor
    nate = {
      isNormalUser = true;
      home = "/home/nate";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/zsh";
      uid = 2028;
      openssh.authorizedKeys.keys = nateKeys;
    };

    # Roberto Castellotti, MSc student (guided research) with Masa (unik)
    # disabled for now
    #roberto = {
    #  isNormalUser = true;
    #  home = "/home/roberto";
    #  inherit (config.users.users.joerg) extraGroups;
    #  shell = "/run/current-system/sw/bin/bash";
    #  uid = 2027;
    #  openssh.authorizedKeys.keys = robertoKeys;
    #};

    # Fritz Rehde, Bsc student with Martin (memory safety for wasm)
    # Remove after SS23
    fritz = {
      isNormalUser = true;
      home = "/home/fritz";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/zsh";
      uid = 2029;
      allowedHosts = [ "rose" "graham" ];
      openssh.authorizedKeys.keys = fritzKeys;
    };

    # Iulia Cornea, Ma Thesis with Evgeny (configurable cloud deploymet w/ openstack and kubernetes)
    # Remove after SS23
    iulia = {
      isNormalUser = true;
      home = "/home/iulia";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/bash";
      uid = 2030;
      allowedHosts = [ "clara" "graham" ];
      openssh.authorizedKeys.keys = iuliaKeys;
    };

    # Martin Lambeck, Ma Thesis with Jiyang (FAIR)
    # Remove after SS23
    martinL = {
      isNormalUser = true;
      home = "/home/martinL";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/bash";
      uid = 2031;
      allowedHosts = [ "amy" "clara" ];
      openssh.authorizedKeys.keys = martinLKeys;
    };

    # Elizaveta Boriskova, Thesis with Babis/Atsushi (FPGA serverless porting)
    # Remove after WS23
    eliza = {
      isNormalUser = true;
      home = "/home/eliza";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/bash";
      uid = 2032;
      allowedHosts = [ "clara" ];
      openssh.authorizedKeys.keys = elizaKeys;
    };

    # Florian Freudiger, Thesis with Peter (NIC queue multiplexing)
    # Remove after WS23
    florian = {
      isNormalUser = true;
      home = "/home/florian";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/zsh";
      uid = 2033;
      allowedHosts = [ "graham" "jackson" "christina" "wilfred" "river" "clara" ];
      openssh.authorizedKeys.keys = florianKeys;
    };

    # Moritz Lumme (fix gnugrep/musl on ARM)
    m00wl = {
      isNormalUser = true;
      home = "/home/m00wl";
      inherit (config.users.users.joerg) extraGroups;
      shell = "/run/current-system/sw/bin/bash";
      uid = 1014;
      openssh.authorizedKeys.keys = m00wlKeys;
      allowedHosts = [ "yasmin" ];
    };

    root.openssh.authorizedKeys.keys = raitoKeys ++ yiheKeys;
  };

  # DANGER ZONE!
  # Make sure all data is backed up before adding user names here. This will
  # delete all data of the associated user
  users.deletedUsers = [
    "alexa"
    "vincent"
    "ml"
    "philip"
    "he"
    "justusvonderbeek"
    "rohanfernandez"
    "alexandermaslew"
    "zixuanli"
    "yiwenliu"
    "hanwenliu"
    "wonbangseo"
    "vanda"
    "mikilio"
    "jasper"
    "mflatus"
    "emil"
    "turkmen"
    "sarac"
  ];
}
