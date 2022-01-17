{lib, ...}@args:
let
  inherit (lib) mkOption types mkIf;
in rec {
  type = mkOption {
    description = "Argument type";
    type = types.enum [
      "string" # plain string
      "symbol" # alphanumeric with no spaces
      "number" # number ¯\_(ツ)_/¯ 
    ];
    default = "string";
  };
  flag = {name, config, ...}: {
    config = {
      key = name;
    };
    options = {
      key = mkOption {
        description = "Flag key to be used in parameter variables";
        type = types.str;
        internal = true;
      };
      inherit type;
      description = mkOption {
        description = "Flag description for the man page";
        type = types.str;
      };
    };
  };
  argument = {...}: {
    options = {
      name = {
        description = "Name of the argument";
        type = types.str;
      };
      inherit type;
    };
  };
  command = {...}@args: {
    options = {
      description = mkOption {
        description = "Command/subcommand description";
        type = types.str;
        default = "* no description provided *";
      };
      flags = mkOption {
        description = "Command or subcommand flags";
        type = types.attrsOf (types.submodule flag);
        default = {};
      };
      positionalArguments = mkOption {
        description = "Arguments";
        type = types.listOf (types.submodule argument);
        default = [];
      };
      subcommands = mkOption {
        description = "Subcommands";
        type = types.attrsOf (types.submodule command);
        default = {};
      };
    };
    # config = (builtins.trace (builtins.toJSON (builtins.attrNames args))) null; #(mkIf (positionalArguments != null && subcommands != null) throw "positionalArguments and subcommands cant both be defined at the same time");
  };
}
