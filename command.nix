{lib, ...}@args:
let
  inherit (lib) mkOption types mkIf;
  typesAvailable = [
    "str" # string
    "int" # integer number
  ];
  defaultType = "str";
in rec {
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
      singleKeyword = mkOption {
        description = "What is the single character flag keyword? Ex: h -> -h";
        type = types.nullOr types.str;
        default = if (builtins.stringLength name) == 1 then name else null;
      };
      composedKeyword = mkOption {
        description = "What is the word sized flag keyword? Ex: help -> --help";
        type = types.nullOr types.str;
        default = if (builtins.stringLength name) > 1 then name else null;
      };
      flagType = mkOption {
        description = "Type of the flag value";
        type = types.enum typesAvailable;
        default = defaultType;
      };
      description = mkOption {
        description = "Flag description for the man page";
        type = types.str;
      };
    };
  };
  argument = {...}: {
    options = {
      name = mkOption {
        description = "Name of the argument";
        type = types.str;
      };
      argumentType = mkOption {
        description = "Type of the positional parameter value";
        type = types.enum typesAvailable;
        default = defaultType;
      };
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
