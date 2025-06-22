# My personal Nixpkgs

------------------------------------------------------------------------

Personal repo for packages and functions that are too niche for or waiting to be merged into Nixpkgs.

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
nixosConfigurations.nixos = lib.nixosSystem {
  specialArgs = inherit lib; # pass new lib through to your modules
};
```

Finally consume the overlay to append the pkgs argument.

```nix
# configuration.nix
{ inputs, ... }:;

nixpkgs.overlays = [ inputs.gmans-nixpkgs.overlays.default ];
```

# Whats in here?

NixOS grub theme: 
-  https://github.com/AdisonCavani/distro-grub-themes
- package name = nixos-grub


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
- package name = mov-cli-youtube


extraVimPluigins:
- vague theme:
    -  https://github.com/vague2k/vague.nvim
    -  package name = extraVimPlugins.nvim-vague
- direnv-nvim:
	- https://github.com/NotAShelf/direnv.nvim
	- package name = extraVimPlugins.direnv-nvim
- universal-clipboard:
    - https://github.com/swaits/universal-clipboard.nvim
    - package name = extraVimPlugins.nvim-universal-clipboard
- lzn:
    - https://github.com/nvim-neorocks/lz.n
    - package name = extraVimPlugins.lzn

------------------------------------------------------------------------
# lib functions:

# autoImport
- takes a directory and returns a list of all files and directories inside (except files named "default.nix") as nix paths. Can be used to easily import all Nix modules as they are added automatically.

# mkProgramOption
- Used for wrapping basic program options for NixOS or home-manager
- takes pkgs programName and an optional description. It returns an enable and package option attribute set. The package used defaults to programName, if different then use the optional packageName argument.

# listToEnableOption
- takes a list of strings and returns a nested set assigned with a value of true. 
- EX: [ "profiles" "default" "enable" ] -> { profiles.default.enable = true; }