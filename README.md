# arbw
Ada Runtime and Bindngs for WASM

## How to build

Setup GNAT-LLVM developmemnt environment.

Checkout ARBW repository into gnat-llvm/llvm-interface as arbw_src.

Create symbolic link for Makefile.wasm

Add "include Makefile.wasm" to Makefile.

Use "make wasm" to build compiler and RTL
