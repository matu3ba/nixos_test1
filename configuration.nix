{ config, pkgs, .. }:
{
  imports =
    [
      # microcode, uefi, bootloader,
      # loader, kernel, filesystems
      ./hardware-configuration.nix
    ];

  # disk + power settings
  services.fstrim.enable = true;
  services.tlp.enable = true;

  # TODO ssd optimziations (perf + durability)
  # TODO ssh settings

  networking.hostName = "nixos_test1";
  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = true;

  time.timeZone = "Europe/Berlin";

  i18 = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_MESSAGES = "en_US.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  users.users.user = {
    isNormalUser = true;
    initialPassword = "password123";
    extraGroups = [ "wheel" ];
  };
  environment.systemPackages = with pkgs; [
    curl
    lynx
    unzip
    wget
    vim
  ];

  #TODO setup gpg with creating
  #own key for machine

  #TODO setup ssh
  #services.openssh.enable = true;

  system.stateVersion = "21.11";
}
