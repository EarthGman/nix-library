{
  description = "my custom nix derivations";

  inputs = {
    fonts = {
      url = "https://raw.githubusercontent.com/EarthGman/assets/master/fonts.json";
      flake = false;
    };
  };

  outputs = { ... } @ inputs: {
    overlay = rec {
      packages = final: prev: import ./pkgs { pkgs = final; inherit inputs; };
      default = packages;
    };
  };
}
