{ pkgs, stdenvNoCC, ... }:

stdenvNoCC.mkDerivation {
  pname = "betterfox";
  version = "133.0";

  src = pkgs.fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "140.0";
    hash = "sha256-gHFA/1PeQ0iNAcjATGwgJOqRlR9YmxD/RJKkYN36QYA";
  };

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
