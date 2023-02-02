(import <nixpkgs> {
  overlays = [ (import ./overlay.nix) ];
}).cmake_cross_test
