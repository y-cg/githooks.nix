{
  description = "A collection of git hooks";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    {
      modules = {
        default = import ./hooks;
        forge-fmt = import ./hooks/forge-fmt.nix;
      };
    };
}
