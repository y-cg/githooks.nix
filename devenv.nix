{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  imports = [
    ./hooks
  ];

  custom.git-hooks = {
    rumdl = {
      enable = true;
      settings = {
        "MD013" = {
          line-length = 80;
          code-blocks = false;
          tables = false;
          reflow = true; # Enable automatic line wrapping (required for --fix)
        };
      };
    };
  };

  # https://devenv.sh/packages/
  packages = with pkgs; [ lazygit ];

  # https://devenv.sh/languages/
  languages.nix.enable = true;

  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    nixfmt-rfc-style.enable = true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
