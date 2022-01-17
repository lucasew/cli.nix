{pkgs, lib, config, ...}@args:
let
  inherit (lib) mkOption types optional;
in {
  imports = [
    ./gen
  ];
  options = {
    target = mkOption {
      type = types.attrsOf types.str;
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
