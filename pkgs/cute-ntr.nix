{ stdenv
, libsForQt5
, fetchFromGitLab
, ...
}:

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
    mkdir -p $out/bin
    cp -r cutentr $out/bin
  '';
}
