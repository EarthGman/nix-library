{ pkgs, inputs, ... }:
let
  inherit (pkgs) callPackage;
in
{
  astronaut = callPackage ./sddm-themes/astronaut.nix { };
  nixos = callPackage ./grub-themes/nixos.nix { };
  nordvpn = callPackage ./nordvpn.nix { };
  gnome-tilingShell = callPackage ./tilingshell.nix { };
  userchrome-toggle-extended = callPackage ./uct-extended.nix { };
  betterfox = callPackage ./firefox-themes/betterfox.nix { };
  shyfox = callPackage ./firefox-themes/shyfox.nix { };
  omori-font = callPackage ./fonts/omori-font.nix { inherit inputs; };
  "8-bit-operator-font" = callPackage ./fonts/8-bit-operator-jve.nix { inherit inputs; };
  mov-cli-youtube = callPackage ./mov-cli-plugins/youtube.nix { };
}
