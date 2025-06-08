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

  listToEnableOption = list:
    let
      # Helper function to escape attribute names if needed
      escapeAttrName = name:
        if builtins.match "[a-zA-Z_][a-zA-Z0-9_'-]*" name != null
        then name
        else "\"${name}\"";

      # Recursive function to build nested attribute set
      buildNested = remaining:
        if builtins.length remaining == 2
        then {
          ${escapeAttrName (builtins.head remaining)}.${builtins.elemAt remaining 1} = true;
        }
        else {
          ${escapeAttrName (builtins.head remaining)} = buildNested (builtins.tail remaining);
        };
    in
    if builtins.length list == 1
    then { ${builtins.head list} = true; }
    else buildNested list;
}
