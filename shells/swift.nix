with import <nixpkgs> {};

clangStdenv.mkDerivation {
  name = "clang-nix-shell";
  buildInputs = [ 
    cmake
    valgrind
    swift-corelibs-libdispatch
    swift
    swiftPackages.swiftpm
  ];
}