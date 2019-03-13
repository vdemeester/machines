{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hardware-builder.nix
      ./machine.nix
      ./custom-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # remove the fsck that runs at startup. It will always fail to run, stopping
  # your boot until you press *.
  boot.initrd.checkJournalingFS = false;

  # Services to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable DBus
  services.dbus.enable    = true;

  # Replace nptd by timesyncd
  services.timesyncd.enable = true;

  # Packages for Vagrant
  environment.systemPackages = with pkgs; [
    iputils
  ];

  # Creates a "vincent" users with password-less sudo access
  users = {
    extraGroups = [ { name = "vincent"; } ];
    extraUsers  = [
      # Try to avoid ask password
      { name = "root"; password = "vincent"; }
      {
        description     = "Vincent User";
        name            = "vincent";
        group           = "vincent";
        extraGroups     = [ "users" "wheel" ];
        password        = "vincent";
        home            = "/home/vincent";
        createHome      = true;
        useDefaultShell = true;
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDO1sx5h44xnK/k0ODnQ3aQR8+nr7HC7u94fS3OhwQ6AvjqDGLnI6EP4sr4Yh2eXf8lHX+lkg8iZ6Z+y9dVnnzwveZfqbfOyh6t8Hg+M1nl26rwdYv+guU8khvh+Kzl9Vdb5dexf/hWQ/LcWvsuPO+tBmqajNTLYbGinqrMm3Bw2jJS/+DitgoT8hiuSTU1smY1CGzggHEdsx4+oDMuDMvRYwOBBHrUF00lZLx3zB3nGl1VFYD2St3vzlmzoZNrW7Rx8TRg02BTVAwd4qPHOMz8Kg+JmDhVig9yeqHo4FCwXxQ8+jk54Cd2el6TjfaA5HD2+e4FYLP6bMSLIabLTfLP vincent@wakasu"
        ];
      }
    ];
  };

  security.sudo.configFile =
    ''
      Defaults:root,%wheel env_keep+=LOCALE_ARCHIVE
      Defaults:root,%wheel env_keep+=NIX_PATH
      Defaults:root,%wheel env_keep+=TERMINFO_DIRS
      Defaults env_keep+=SSH_AUTH_SOCK
      Defaults lecture = never
      root   ALL=(ALL) SETENV: ALL
      %wheel ALL=(ALL) NOPASSWD: ALL, SETENV: ALL
    '';

}
