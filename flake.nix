{
  description = "A collection of git hooks";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    {
      # lib is platform-agnostic
      lib = {
        forge-fmt = import ./hooks/forge-fmt.nix;
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # Platform-specific checks
        checks.lib-eval = builtins.deepSeq self.lib (pkgs.writeText "lib-check" "ok");
      }
    );
}
