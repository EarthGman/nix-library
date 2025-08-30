{
  description = "my custom nix packages and functions";

  outputs =
    { nixpkgs, flake-parts, ... }@inputs:
    let
      lib = import ./lib { inherit nixpkgs; };
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
    in

    flake-parts.lib.mkFlake { inherit inputs; } {
      inherit systems;
      imports = [ inputs.devshell.flakeModule ];
      perSystem =
        { pkgs, system, ... }:
        {
          packages = import ./pkgs { inherit pkgs inputs; };
          devshells.default = import ./shell.nix { inherit pkgs; };
        };
      flake = {
        inherit lib;
        overlays = rec {
          packages =
            final: prev:
            import ./pkgs {
              pkgs = final;
              inherit inputs;
            };
          default = packages;
          images = final: prev: import ./overlays/images.nix;
        };
      };
    };

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
