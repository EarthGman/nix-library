{ pkgs, ... }:
pkgs.writeShellScriptBin "fzf-edit" ''
  fzf | ${pkgs.findutils}/bin/xargs -n 1 $EDITOR
''
