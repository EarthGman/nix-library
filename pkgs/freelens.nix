{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  makeDesktopItem,
  copyDesktopItems,

  python3Packages,
  gnumake,
  nss_latest,
  nodejs_22,
  pnpm,
}:
let
  description = "Free and open-source kubernetes IDE";
  version = "1.5.1";
  platforms = [ "x86_64-linux" ];
in
stdenvNoCC.mkDerivation {
  pname = "freelens";
  inherit version;

  src = fetchFromGitHub {
    owner = "freelensapp";
    repo = "freelens";
    rev = "v${version}";
    hash = "sha256-88anN0SGkOssFzWsErNvH17h0yYeMKdDf5sbUJXC1Y4=";
  };

  nativeBuildInputs = [
    copyDesktopItems
    nss_latest
    nodejs_22
    pnpm
    python3Packages.setuptools
    gnumake
  ];

  buildPhase = ''
    runHook preBuild
    pnpm i
    pnpm build
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -m 444 -D freelens/build/icon.svg $out/share/icons/hicolor/scalable/apps/freelens.svg
    runHook postInstall
  '';

  desktopItems = lib.singleton makeDesktopItem {
    name = "freelens";
    desktopName = "FreeLens";
    comment = description;
    exec = "freelens";
    terminal = false;
    type = "Application";
    icon = "freelens";
    startupWMClass = "FreeLens";
    # categories = [ "Development" ];
  };

  meta = {
    inherit description platforms;
    mainProgram = "freelens";
    homepage = "https://freelensapp.github.io/";
    license = "MIT";
    maintainers = [ lib.maintainers.EarthGman ];
  };
}
