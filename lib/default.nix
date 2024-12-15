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

  # takes a string and seperator. Returns a list of elements split by the seperator
  # EX stringToList "alice,bob" "," -> [ "alice" "bob" ]
  stringToList = string: seperator: builtins.filter builtins.isString (builtins.split "${seperator}" string);

  # read a directory and return a list of all filenames inside
  autoImport = dir:
    let
      workingDirectory = dir;
    in
    lib.forEach (builtins.attrNames (builtins.readDir workingDirectory)) (dirname: workingDirectory + /${dirname});
}
