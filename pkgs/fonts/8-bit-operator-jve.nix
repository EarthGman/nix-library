{ inputs, pkgs, stdenvNoCC, ... }:
let
  fonts = builtins.fromJSON (builtins.readFile inputs.fonts.outPath);
in
stdenvNoCC.mkDerivation {
  pname = "8-bit-operator-font";
  version = "1.0";

  src = pkgs.fetchurl fonts."8-bit-operator";
  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/share/fonts
    ${pkgs.unzip}/bin/unzip $src -d $out/share/fonts 
  '';
}
