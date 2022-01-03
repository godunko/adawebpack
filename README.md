[![CircleCI](https://circleci.com/gh/godunko/adawebpack.svg?style=svg)](https://circleci.com/gh/godunko/adawebpack)
[![Copr build status](https://copr.fedorainfracloud.org/coprs/reznik/adawebpack/package/adawebpack/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/reznik/adawebpack/package/adawebpack/)

# AdaWebPack
Ada WASM Runtime and Bindings for Web API

## How to install

Prebuild package is available for Fedora Linux, see https://copr.fedorainfracloud.org/coprs/reznik/adawebpack/
It includes GNAT-LLVM compiler for WebAssembly target, GNAT Run Time Library and AdaWebPack bindings for Web API.

## How to build

Setup some GNAT compiler and gprbuild tool (GNAT CE and GNAT FSF 11 is know to work fine).

Checkout latest known good revision of GNAT-LLVM (11fa85dcdaedc632ab77f3eb1dfe476aac531c95).

Checkout latest known good revision of FSF GCC (6447f6f983ffeaecb8753ef685d702bf2594968b).

Checkout latest known good revision of bb-runtimes (7a4674ae9221d2fa046bed20fbaf9de9caa09d41).

Setup GNAT-LLVM development environment, see
[GNAT-LLVM](https://github.com/AdaCore/gnat-llvm). Note, you need to use
externally build LLVM with enabled 'lld' project and 'WebAssembly' target,
so, cmake command line should contain among other switches:

```
cmake ... -DLLVM_ENABLE_PROJECTS='...;clang;lld' -DLLVM_TARGETS_TO_BUILD="...;WebAssembly"
```

On Ubuntu it is possible to install prebuild LLVM/CLang packages (`llvm-13`, `clang-13` and `lld-13`).
However, alternatives need to be updated using provided script:

```
sudo utilities/update-alternatives-clang.sh 13 100
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
ln -s <bb-runtimes>/gnat_rts_sources/include/rts-sources
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

GNAT Runtime Library is licensed under GPL3 license with GCC Runtime Library Exception
