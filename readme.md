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

# Whats in here?

NixOS grub theme: 
-  https://github.com/AdisonCavani/distro-grub-themes
- package name = nixos-grub

Gnome Tiling Shell: 
- https://extensions.gnome.org/extension/7065/tiling-shell/
- pacakge name = gnome-tilingShell

Userchrome Toggle Extended:
- Expanded version of Userchrome Toggle extension for Firefox
- package name = uct-extended

Betterfox javascript patch for Firefox:
- https://github.com/yokoffing/BetterFox
- package name = betterfox

Shyfox theme by Naezr:
- https://github.com/Naezr/ShyFox
- package name = shyfox

Font from the game OMORI:
- package name = omori-font

8 Bit operator font from Undertale: 
- package name = "8-bit-operator-font" # note the quotes

Youtube Extension for mov-cli:
- https://github.com/mov-cli/mov-cli-youtube
- mov-cli-youtube

CuteNTR, streaming client for New Nintendo 3ds:
- https://gitlab.com/BoltsJ/cuteNTR
- package name = cutentr

------------------------------------------------------------------------

autoImport function - takes a directory and returns a list of all files and directories inside as nix paths. Can be used on ./modules in a nixos configuration to easily import all modules.
