[![CircleCI](https://circleci.com/gh/godunko/adawebpack.svg?style=svg)](https://circleci.com/gh/godunko/adawebpack)

# AdaWebPack
Ada WASM Runtime and Bindings for Web API

## How to install

Prebuild package is available for Fedora Linux, see https://bintray.com/reznikmm/matreshka/adawebpack/
It includes GNAT-LLVM compiler for WebAssembly target, GNAT Run Time Library and AdaWebPack bindings for Web API.

## How to build

Setup GNAT Community 2019 for ARM to default location.

Setup GNAT-LLVM development environment, see
[GNAT-LLVM](https://github.com/AdaCore/gnat-llvm). Note, you need to use
externally build LLVM with enabled 'lld' project and 'WebAssembly' target,
so, cmake command line should contain among other switches:

```
cmake ... -DLLVM_ENABLE_PROJECTS='...;clang;lld' -DLLVM_TARGETS_TO_BUILD="...;WebAssembly"
```

Checkout AdaWebPack repository into `gnat-llvm/llvm-interface` as
`adawebpack_src` and create link for Makefile.target.

```
cd gnat-llvm/llvm-interface
git clone git@github.com:godunko/adawebpack.git adawebpack_src
ln -s adawebpack_src/source/rtl/Makefile.target
```

Create link to RTS source code

```
cd gnat-llvm/llvm-interface
ln -s ~/opt/GNAT/2019-arm-elf/arm-eabi/include/rts-sources/
```

Use `make wasm` to build compiler and Run Time Library

```
cd gnat-llvm/llvm-interface
make wasm
```

## Unsupported features

 - nested subprograms are not supported

 - exceptions support is limited to local exceptions propagation and last
   chance handler

 - protected objects and tasks are not supported

## License

Web API bindings is licensed under BSD3 license.

GNAT Runtime Library is licensed under GPL3 license.
