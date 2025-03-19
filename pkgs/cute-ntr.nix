{ stdenv
, libsForQt5
, fetchFromGitLab
, makeDesktopItem
, fetchurl
, ...
}:
let
  icon = fetchurl {
    url = "https://gitlab.com/BoltsJ/cuteNTR/-/blob/d217aae4f5708b72c5229174cd53556eea107468/setup/gui/com.gitlab.BoltsJ.cuteNTR.svg";
    sha256 = "sha256-bnSNJh13E2U11b+qW0SjfvZQ/VQi5Dbuz65g3svTgWo=";
  };

  desktopItem = makeDesktopItem {
    name = "cuteNTR";
    desktopName = "cuteNTR";
    icon = "cutentr";
    exec = "cutentr";
    categories = [ "Game" ];
  };
in
stdenv.mkDerivation {
  pname = "cuteNTR";
  version = "0.3.1";

  src = fetchFromGitLab {
    owner = "BoltsJ";
    repo = "cuteNTR";
    rev = "d217aae4f5708b72c5229174cd53556eea107468";
    hash = "sha256-NNmA88BKTS8EGiL3IyDnI+6CA8AWSP3pBlYojHEamgU=";
  };

  buildInputs = with libsForQt5.qt5; [
    qtbase
    wrapQtAppsHook
  ];

  buildPhase = ''
    qmake
    make
  '';

  installPhase = ''
    runHook preinstall
    mkdir -p $out/bin
    cp -r cutentr $out/bin

    install -m 444 -D "${desktopItem}/share/applications/"* \
      -t $out/share/applications/

    mkdir -p $out/share/icons/hicolor/"512"x"512"/apps
    cp ${icon} $out/share/icons/hicolor/"512"x"512"/apps/cutentr.svg
    runHook postInstall
  '';
}
