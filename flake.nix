{
  description = "my custom nix derivations";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nix-config = {
      url = "github:EarthGman/nix-config";
    };

    fonts = {
      url = "https://raw.githubusercontent.com/EarthGman/assets/master/fonts.json";
      flake = false;
    };
  };

  outputs = { nixpkgs, nix-config, ... } @ inputs:
    let
      lib = nix-config.lib;
      inherit (lib) forAllSystems;
    in
    {
      overlay = rec {
        packages = final: prev: import ./pkgs { pkgs = final; inherit inputs; };
        default = packages;
      };
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        in
        import ./pkgs { inherit pkgs inputs; }
      );
    };
}
