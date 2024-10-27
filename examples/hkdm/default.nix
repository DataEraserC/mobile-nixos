{
  device ? null,
  pkgs ? (import ../../pkgs.nix {}),
  nur-DataEraserC ? (import ../../nur-DataEraserC.nix)
} @ args': let
  args = args' // {inherit pkgs;};
in
  import ../../lib/eval-with-configuration.nix (args
    // {
      configuration = [
        (import ./configuration.nix)
        nur-DataEraserC.nixosModules.hkdm
        {_module.args.nur-DataEraserC = nur-DataEraserC;}
      ];
      additionalHelpInstructions = ''
        You can build the `-A outputs.default` attribute to build the default output
        for your device.

         $ nix-build examples/hkdm --argstr device ${device} -A outputs.default
      '';
    })
