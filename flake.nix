{
  description = "my custom nix derivations";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    my-lib = {
      url = "github:EarthGman/nix-lib";
    };

    fonts = {
      url = "https://raw.githubusercontent.com/EarthGman/assets/master/fonts.json";
      flake = false;
    };
  };

  outputs = { nixpkgs, my-lib, ... } @ inputs:
    let
      inherit (my-lib) lib;
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
