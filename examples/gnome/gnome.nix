#
# This file represents safe opinionated defaults for a basic Phosh system.
#
# NOTE: this file and any it imports **have** to be safe to import from
#       an end-user's config.
#
{ config, lib, pkgs, options, ... }:

{
  mobile.beautification = {
    silentBoot = lib.mkDefault true;
    splash = lib.mkDefault true;
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  programs.calls.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
    vim
    git
    wget
    mpv
    yt-dlp
    podman
    nmon
    htop
    cmus
    fastfetch
    go-musicfox
    gnome-console # Terminal
  ];

  hardware.sensor.iio.enable = true;
  #sound.enable = true;
  #nixpkgs.config.pulseaudio = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = lib.mkForce false; # mkDefault to help out users wanting pipewire
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;
  powerManagement.enable = true;

 # systemd.tmpfiles.rules =
 # [
 #   "d /etc/pulse/default.pa.d 0444 root root"
 # ] ;


security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;
};

}
