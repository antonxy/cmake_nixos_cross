# (Cross-)building using CMake and NixOS

This is an example how to use Nix(OS) and CMake for (cross-)compiling a C++ application.

Goals are:
- Platform independence
- Correctness (no hidden dependencies)
- Cleanliness (no horrible mess of CMake variables)

I had trouble finding online what are the best practices in modern CMake, so I wanted to document what I found.
This is mostly for my own reference and experimentation.
Feel free to use everything here but it might also not be _the_ right way.
I would be glad to hear if you know a better way to do things.

## Resources
https://cliutils.gitlab.io/modern-cmake/
https://cmake.org/cmake/help/book/mastering-cmake/index.html

https://nixos.org/manual/nixpkgs/stable/#ssec-stdenv-dependencies
https://nixos.org/manual/nixpkgs/stable/#chap-cross
