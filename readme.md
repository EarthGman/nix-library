# My personal Nixpkgs

------------------------------------------------------------------------

Repo for packages and functions that are too niche for or waiting to be merged into Nixpkgs.

# How to consume

in your flake.nix

```nix
inputs.gmans-nixpkgs = {
  url = "github:EarthGman/nix-library";
  inputs.nixpkgs.follows = "nixpkgs"; # optional, can cause breakage
};
```


To add lib functions to Nixpkgs.lib

```nix
lib = nixpkgs.lib.extend (final: prev: inputs.gmans-nixpkgs.lib);

# for nixos configurations
nixosConfigurations.nixos = lib.mkNixosSystem {
  specialArgs = inherit lib;
};
```


Finally create an overlay to append to pkgs

```nix
# configuration.nix
{ inputs, ... }:;

nixpkgs.overlays = [ inputs.gmans-nixpkgs.overlays.default ];
```