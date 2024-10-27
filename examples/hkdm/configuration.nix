{ config, lib, pkgs, ... }:

let
  defaultUserName = "alice";
in
{
  imports = [
    ./hkdm.nix
    #./bluetooth.nix
    #../common-configuration.nix
  ];

  config = {
    users.users."${defaultUserName}" = {
      isNormalUser = true;
      password = "1234";
      extraGroups = [

      ];
    };
  users.users.root.password  = "nixos";
  # mobile.quirks.qualcomm.sdm845-modem.enable = true;
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
    # Networking, modem and misc.
    {
      # Ensures any rndis config from stage-1 is not clobbered by NetworkManager
      networking.networkmanager.unmanaged = [ "rndis0" "usb0" ];

      # Setup USB gadget networking in initrd...
      mobile.boot.stage-1.networking.enable = lib.mkDefault true;
    }

    # SSH
    {
      # Start SSH by default...
      # Not a good idea given the fact this config is insecure (well-known password).
      services.openssh.enable = true;
    }
  };
}
