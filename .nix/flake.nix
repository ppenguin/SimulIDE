{
  description = "SimulIDE for Nix (flake)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }:

  #flake-utils.lib.eachDefaultSystem (system:

    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      packages.x86_64-linux.simulide = pkgs.libsForQt5.callPackage ./simulide { };
      # packages.x86_64-linux.default = self.packages.x86_64-linux.simulide;
    };
  #);
}

