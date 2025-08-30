{ pkgs, ... }:
{
  commands = [
    {
      package = pkgs.lynx;
      name = "lynx";
    }
    {
      package = pkgs.gnugrep;
      name = "grep";
    }
    {
      package = pkgs.gawk;
      name = "awk";
    }
    {
      package = pkgs.nixfmt-rfc-style;
      name = "nixfmt";
    }
  ];
}
