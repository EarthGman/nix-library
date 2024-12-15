{
  description = "my custom nix packages and functions";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    fonts = {
      url = "https://raw.githubusercontent.com/EarthGman/assets/master/fonts.json";
      flake = false;
    };
  };

  outputs = { nixpkgs, ... } @ inputs:
    let
      lib = import ./lib { inherit nixpkgs; };
      inherit (lib) forAllSystems;
    in
    {
      inherit lib;
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
