{pkgs, lib, config, ...}@args:
let
  inherit (lib) mkOption types optional;
in {
  options = {
    target = mkOption {
      type = types.attrsOf types.package;
      default = {};
      visible = false;
    };
    command = mkOption {
      description = "Root command";
      type = types.submodule (import ./command.nix args).command;
      default = {};
    };
  };
}
