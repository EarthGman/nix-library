{ nixpkgs, ... }:
let
  lib = nixpkgs.lib;
in
{
  forAllSystems = lib.genAttrs [
    "aarch64-linux"
    "aarch64-darwin"
    "i686-linux"
    "x86_64-linux"
    "x86_64-darwin"
  ];

  # read a directory and return a list of all filenames inside except any default.nix
  autoImport = dir:
    let
      fileNames = builtins.attrNames (builtins.readDir dir);
      strippedFileNames = lib.filter (name: name != "default.nix") fileNames;
    in
    lib.forEach (strippedFileNames)
      (fileName: dir + /${fileName});

  mkProgramOption =
    { pkgs
    , programName
    , packageName ? programName
    , description ? null
    , extraPackageArgs ? { }
    }:
    let
      inherit (lib)
        mkEnableOption
        mkPackageOption
        optionalString;
    in
    {
      enable = mkEnableOption (programName + " " + optionalString (description != null) description);
      package = mkPackageOption pkgs packageName extraPackageArgs;
    };
}
