{ pkgs, stdenvNoCC, ... }:
stdenvNoCC.mkDerivation {
  pname = "8-bit-operator-font";
  version = "1.0";
  src = pkgs.fetchZip {
    url = "https://www.1001freefonts.com/d/14007/8-bit-operator.zip";
    hash = "sha256-1gd6fh92593d44alfmkk20p4r6znjf8wmqjdqkfnd8kma07w0ha0";
  };
  installPhase = ''
    mkdir -p $out/share/fonts
    cp -r $src $out/share/fonts
    	'';
}
