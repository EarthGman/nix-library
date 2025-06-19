{
  description = "my custom nix packages and functions";

  outputs = { nixpkgs, ... } @ inputs:
    let
      lib = import ./lib { inherit nixpkgs; };
      inherit (lib) forAllSystems;
    in
    {
      inherit lib;
      overlays = rec {
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

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    blink-cmp = {
      url = "github:saghen/blink.cmp";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lzn = {
      url = "github:nvim-neorocks/lz.n";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fonts = {
      url = "https://raw.githubusercontent.com/EarthGman/assets/master/fonts.json";
      flake = false;
    };
  };
}
