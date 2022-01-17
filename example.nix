import ./default.nix {
  command = {
    flags = {
      verbose = {
        description = "Run command on verbose mode";
        singleKeyword = "v";
      };
      help = {
        description = "Show help message";
        singleKeyword = "h";
      };
    };
    subcommands = {
      hello = {
        positionalArguments = [
          { name = "Name"; argumentType = "str"; }
        ];
      };
    };
  };
}
