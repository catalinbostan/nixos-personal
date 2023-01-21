# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      ./zerotierone.nix
    ];

  networking.hostId = "1973cafe";
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostName = "nixos"; # Define your hostname.
  networking.domain = "cata.dev.prosys";
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  time.timeZone = "Europe/Bucharest";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cata = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
  #     firefox
  #     thunderbird
     git
     ];
   };
  users.extraUsers.root.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDdYRretGQ50JGrg38/1a49M6z83rQ26kI249NIc/vmGx+WsleTuc1uEfdg4k3He15T+ZhDcUsyJdHa8IFDPZallG/s+zmI7AaPlr8E+RzFItysL7Q3sYIM4gE4bX2ZG+VBK0Kje34ocehnqesuolxStKT1yxT5NWvW/bSSJaAtLbBzWkyzsFb8Xq24y3FCNH276pczTEgUGKL3+dmJaXEunwP8iYGVRcXPtgetxwkekf5eiUWOKHFg6HXVQc4SuAR1ETnXhp4BHj7Ai6biGQNt29aMJibAe/LKXxYLm6Ca58NQOPpQE1GijP4QUhBLjrmYHg/DrSm0AFpbyW0BrIaOE9q/HTBecywpSiWrjFgqhoMfGCkaE7DFvnMAkBHlyXa1D+NiMc6cWl4WXs9AM0+qe13hjpm7Y8FwXoo2GqyaijCmBg2J8Jb45MWgwuwqDctVvlW6Mlpr7Reaw8W1ZkbvZ/PRfwXvU2TGMZMsU1GCn+7H5T4VVA1EVIc4X8BuYbtlffZQV3BTzu4El8FLc1nHqQHavWxuu1tdluTpdUtw5vH2580jCAnM5FIoBG/54cPXDSYBdWTgpxoRbsS1WnrlkvDOPvTjKRGCN7NR2M86UevP/e9PwRnCj1QV8eInUPQO+oJofO1J/0pTr4E9hZMKCWdrfJEGF1ZH4+Yul82f1w== catalinbostan@cataMPB.prosys.ro" ];
  environment.interactiveShellInit = ''
  PS1='$(hostname -f)@\u-->'
  '';
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
     mc
     wget
     htop
     screen
     zerotierone
     git
   ];

  # Enable/Config OpenSSH
  services.openssh = {
          enable = true;
          permitRootLogin = "prohibit-password";
  };
#  systemd.services.sshd.after = [ "network-interfaces.target" ];
  services.qemuGuest.enable = true;
  ## Enable/Config Zerotierone
  services.zerotierone.enable = true;
  services.zerotierone.joinNetworks  = [ "6f234732118ca67d" ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  #networking.firewall.trustedInterfaces = [ "enp6s18" "privateZeroTierInterfaces" ];
  networking.firewall.allowedTCPPorts = [ 22 ];
  #networking.firewall.interfaces."ztluzmxfdm".allowedTCPPorts = [ 22 ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
