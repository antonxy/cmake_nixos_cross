let
  overlay = (self: super: {
      cmake_cross_test = super.callPackage ./package.nix { };
   });
  winpkgs = import <nixpkgs> {
    crossSystem = (import <nixpkgs>{}).lib.systems.examples.mingwW64;
    overlays = [ overlay ];
  };
 
in winpkgs.cmake_cross_test
