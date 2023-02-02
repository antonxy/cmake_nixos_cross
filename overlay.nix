final: prev: {
    ffmpeg = (prev.callPackage ./ffmpeg.nix {});
    cmake_cross_test = (final.callPackage ./package.nix {});
}
