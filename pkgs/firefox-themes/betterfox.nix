{ pkgs, stdenvNoCC, ... }:

stdenvNoCC.mkDerivation {
  pname = "betterfox";
  version = "133.0";

  src = pkgs.fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "8c39175a02db144d002b899a0c8431332f5184da";
    hash = "sha256-QEZZBlIzVWhI+Eurhzi82Pa8h3/DCbWWGFZd8ACRfoc=";
  };

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
