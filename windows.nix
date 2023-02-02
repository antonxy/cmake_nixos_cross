(import <nixpkgs> {
  crossSystem = (import <nixpkgs>{}).lib.systems.examples.mingwW64;
  overlays = [ (import ./overlay.nix) ];
}).cmake_cross_test
