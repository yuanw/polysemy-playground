{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc882" }:
let
  bootstrap = import <nixpkgs> {};

  nixpkgs = builtins.fromJSON (builtins.readFile ./nixpkgs.json);

  src = bootstrap.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    inherit (nixpkgs) rev sha256;
  };

  pkgs = import src {};
  myHaskellPackages = pkgs.haskell.packages."${compiler}";

  myPackages = myHaskellPackages ./polysemy-playground.nix {};
in
myHaskellPackages.shellFor {
  withHoogle = true;
  packages = p: [myPackages];
  inherit ((import ./pre-commit.nix).pre-commit-check) shellHook;
  buildInputs = with myHaskellPackages;
    [
      hlint
      ghcid
      cabal2nix
      ormolu
      cabal-install
      cabal-fmt
    ];
}
