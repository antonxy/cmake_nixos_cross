(import <nixpkgs>{crossSystem = (import <nixpkgs>{}).lib.systems.examples.mingwW64;}).callPackage ./package.nix { }
