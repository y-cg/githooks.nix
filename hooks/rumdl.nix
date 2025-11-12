{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.custom.git-hooks.rumdl = {
    # Option to enable/disable the hook via your custom path
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable the rumdl git hook through custom options.";
    };

    # Option to hold the rumdl specific settings
    settings = mkOption {
      type = types.attrsOf (types.attrsOf (types.anything)); # This type allows for nested attributes like 'global'
      default = { };
      description = "Configuration settings for the rumdl linter.";
    };
  };

  config = {
    git-hooks.hooks.rumdl = mkIf config.custom.git-hooks.rumdl.enable {
      enable = true;
      # The name of the hook (appears on the report table):
      name = "Format all markdown files";
      # The command to execute (mandatory):
      entry =
        let
          settingsFormat = pkgs.formats.toml { };
          settingsFile = settingsFormat.generate "rumdl.toml" config.custom.git-hooks.rumdl.settings;
        in
        "${pkgs.rumdl}/bin/rumdl --config ${settingsFile} fmt --fix";
      # The pattern of files to run on (default: "" (all))
      # see also https://pre-commit.com/#hooks-files
      files = "\\.md$";
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
