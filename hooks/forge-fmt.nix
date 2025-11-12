{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkOption mkIf types;
in
{
  options.custom.git-hooks.forge-fmt = {
    # Option to enable/disable the hook via your custom path
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable the forge fmt git hook through custom options.";
    };
  };

  config = {
    git-hooks.hooks.forge-fmt = mkIf config.custom.git-hooks.forge-fmt.enable {
      enable = true;
      # The name of the hook (appears on the report table):
      name = "Format all solidity source";
      # The command to execute (mandatory):
      entry = "forge fmt";
      # The pattern of files to run on (default: "" (all))
      # see also https://pre-commit.com/#hooks-files
      files = "\\.sol$";
      # Exclude files that were matched by these patterns (default: [ ] (none)):
      excludes = [
        ".devenv"
      ];
      # The language of the hook - tells pre-commit
      # how to install the hook (default: "system")
      # see also https://pre-commit.com/#supported-languages
      language = "system";
      # Set this to false to not pass the changed files
      # to the command (default: true):
      pass_filenames = true;
    };
  };
}
