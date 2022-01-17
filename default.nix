{ pkgs ? import <nixpkgs> {}
, modules ? []
, specialArgs ? {}
, ...
}@args:
let
  inherit (builtins) removeAttrs;
  inherit (pkgs) lib;
  inherit (lib) evalModules;
  mainModule = removeAttrs args ["pkgs" "modules" "specialArgs"];
  input = pkgs.lib.evalModules {
    modules = [
      (args: mainModule)
      ./base.nix
    ] ++ modules;
    specialArgs = specialArgs // {
      inherit pkgs;
      inherit (pkgs) lib;
    };
  };
in input
