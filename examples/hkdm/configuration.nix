{ config, lib, pkgs, nur-DataEraserC, ... }:

let
  inherit (lib) mkForce;
  system_type = config.mobile.system.type;

  defaultUserName = "alice";
in
{
  imports = [
    ./hkdm.nix
    #./bluetooth.nix
    ../common-configuration.nix
  ];

  config = lib.mkMerge [
    # INSECURE STUFF FIRST
    # Users and hardcoded passwords.
    {
      # Forcibly set a password on users...
      # Note that a numeric password is currently required to unlock a session
      # with the plasma mobile shell :/
     
      
      users.users.${defaultUserName} = {
        isNormalUser = true;
        # Numeric pin makes it **possible** to input on the lockscreen.
        password = "1234";
        home = "/home/${defaultUserName}";
        extraGroups = [
      #    "dialout"
      #    "feedbackd"
          "networkmanager"
          "video"
          "wheel"
        ];
        uid = 1000;
      };

      users.users.root.password  = "nixos";
      # mobile.quirks.qualcomm.sdm845-modem.enable = true;
      nixpkgs.config.allowUnfree = true;
      system.stateVersion = "24.11";
      nix.settings.experimental-features = [ "nix-command" "flakes" ];

    }

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
   # HKDM
   {
      services.hkdm.enable = true;
      services.hkdm.configFile = "${nur-DataEraserC.packages.${pkgs.system}.ttyescape}/etc/hkdm/config.d/ttyescape.toml";  # Provide the config file path here
   }
  ];
}
