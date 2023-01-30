{ stdenv, cmake, boost, graphviz }:
stdenv.mkDerivation {
  name = "cmake_cross_test";
  src = ./.;
  nativeBuildInputs = [ cmake ];
  depsBuildBuild = [ graphviz ];
  buildInputs = [
    (boost.override {
        specificLibs = [ "system" "filesystem" "serialization" ];
      })
#    pkgs.gtest
  ];
}
