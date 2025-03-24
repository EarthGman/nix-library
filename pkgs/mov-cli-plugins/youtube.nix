{ pkgs, ... }:
let
  python3Packages = pkgs.python3Packages.override {
    overrides = final: prev: {
      pytubefix = prev.pytubefix.overridePythonAttrs (old: {
        doCheck = false; # test fails to resolve domain name lol
      });
    };
  };
in

python3Packages.buildPythonPackage {
  pname = "mov-cli-youtube";
  version = "1.3.5";
  pyproject = true;

  src = pkgs.fetchFromGitHub {
    owner = "mov-cli";
    repo = "mov-cli-youtube";
    rev = "9040c1276af08d25d6977aa33a8a408f7d733324";
    hash = "sha256-cJQGLaGubhtvWEPhe5NpTeLGXlMjUhKU2I5+z8pMWVw=";
  };

  dependencies = with python3Packages; [
    setuptools
    pytubefix
    requests
    yt-dlp
  ];
}
