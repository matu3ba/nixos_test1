# stubs for now
{ config, pkgs, .. }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];
  # TODO ssd optimziations (perf + durability)
  # TODO uefi settings
  # TODO ssh settings

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
    vim
    wget
    lynx
  ];

  system.stateVersion = "21.11";
}
