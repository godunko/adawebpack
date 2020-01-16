# AdaWebPack
Ada WASM Runtime and Bindings for Web API

## How to build

Setup GNAT Community 2019 for ARM to default location.

Setup GNAT-LLVM development environment, see
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

Create link to RTS source code

```
ln -s ~/opt/GNAT/2019-arm-elf/arm-eabi/include/rts-sources/
```

Use `make wasm` to build compiler and Run Time Library

## Unsupported features

 - nested subprograms are not supported

 - exceptions support is limited to local exceptions propagation and last
   chance handler

 - protected objects and tasks are not supported

## License

Web API bindings is licensed under BSD3 license.

GNAT Runtime Library is licensed under GPL3 license.
