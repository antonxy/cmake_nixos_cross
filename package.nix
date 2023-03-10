{ stdenv, cmake, boost, graphviz, ffmpeg }:
stdenv.mkDerivation {
  name = "cmake_cross_test";
  src = ./.;
  nativeBuildInputs = [ cmake ];
  
  # Graphviz has to be in build build or it doesn't work. I don't fully understand.
  # I thought since it isn't a compiler nativeBuildInputs of depsBuildBuild doesn't matter.
  depsBuildBuild = [ graphviz ];

  buildInputs = [
    (boost.override {
        specificLibs = [ "system" "filesystem" "serialization" ];
      })
    ffmpeg
#    pkgs.gtest
  ];
}
