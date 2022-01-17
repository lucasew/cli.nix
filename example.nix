import ./default.nix {
  command = {
    flags = {
      verbose = {
        description = "Run command on verbose mode";
      };
      help = {
        description = "Show help message";
      };
    };
  };
}
