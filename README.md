# AdaWebPack
Ada WASM Runtime and Bindngs for Web API

## How to build

Setup GNAT-LLVM developmemnt environment, see
[GNAT-LLVM](https://github.com/AdaCore/gnat-llvm).

Checkout AdaWebPack repository into `gnat-llvm/llvm-interface` as
`adawebpack_src` and create link for Makefile.wasm.

```
cd gnat-llvm/llvm-interface
git clone git@github.com:godunko/adawebpack.git adawebpack_src
ln -s adawebpack_src/source/rtl/Makefile.wasm
```

Apply patch in patches directory to gnat-llvm.

```
cd gnat-llvm/llvm-interface
patch -p0 < adawebpack_src/patches/gnat-llvm.patch
```

Use `make wasm` to build compiler and Run Time Library

## Unsupported features

 - nested subprograms are not supported

 - exceptions support is limited to local exceptions propagation and last
   chance handler

 - protected objects and tasks are not supported
