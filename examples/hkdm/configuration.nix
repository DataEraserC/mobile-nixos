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
    

  };
}
