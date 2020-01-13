# arbw
Ada Runtime and Bindngs for WASM

## How to build

Setup GNAT-LLVM developmemnt environment.

Checkout ARBW repository into gnat-llvm/llvm-interface as arbw_src.

Create symbolic link for Makefile.wasm

Add "include Makefile.wasm" to Makefile.

Use "make wasm" to build compiler and RTL

## Supported and unsupported features

 - only local exceptions propagation (restriction No_Exception_Propagation)
   and last chance handler is supported

 - tagged types are supported

 - secondary stack are supported

 - memory pools are supported

 - protected objects and tasks are not supported
