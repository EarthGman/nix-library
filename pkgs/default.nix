{ pkgs, inputs, ... }:
let
  inherit (pkgs) callPackage;
in
{
  nixos-grub = callPackage ./grub-themes/nixos.nix { };
  userchrome-toggle-extended = callPackage ./firefox-extensions/uct-extended.nix { };
  betterfox = callPackage ./firefox-themes/betterfox.nix { };
  shyfox = callPackage ./firefox-themes/shyfox.nix { };
  omori-font = callPackage ./fonts/omori-font.nix { inherit inputs; };
  "8-bit-operator-font" = callPackage ./fonts/8-bit-operator-jve.nix { inherit inputs; };
  mov-cli-youtube = callPackage ./mov-cli-plugins/youtube.nix { };
  fzf-edit = callPackage ./scripts/fzf-edit.nix { };

  extraVimPlugins = import ./extraVimPlugins { inherit pkgs inputs; };

  # verion locks from nixpkgs. Used if newer versions are bugged
  waybar_012 = callPackage ./version-locks/waybar.nix { };
}
