{ pkgs, stdenvNoCC, ... }:

stdenvNoCC.mkDerivation rec {
  pname = "betterfox";
  version = "140.0";

  src = pkgs.fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "${version}";
    hash = "sha256-gHFA/1PeQ0iNAcjATGwgJOqRlR9YmxD/RJKkYN36QYA";
  };

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
