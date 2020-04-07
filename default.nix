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
in
{
 polysemy-playground = myHaskellPackages.callPackage ./polysemy-playground.nix {};
}