[![Build binaries](https://github.com/godunko/adawebpack/actions/workflows/build.yml/badge.svg)](https://github.com/godunko/adawebpack/actions/workflows/build.yml)

# AdaWebPack
AdaWebPack includes GNAT-LLVM compiler for WebAssembly target, GNAT Run Time Library and AdaWebPack bindings for Web API.

## How to install

Prebuild packages are available on [Release page](https://github.com/godunko/adawebpack/releases).

## How to build

 * Setup GNAT using [Alire](https://alire.ada.dev/) or GNAT Community 2021.

 * Clone [GNAT-LLVM](https://github.com/AdaCore/gnat-llvm). Latest known good revision of GNAT-LLVM compatible with GNAT FSF is `e3f56dce`.
   ```
   git clone https://github.com/AdaCore/gnat-llvm
   git -C gnat-llvm checkout e3f56dce
   ```

 * Clone [bb-runtimes](https://github.com/Fabien-Chouteau/bb-runtimes). Use `gnat-fsf-11` branch.
   ```
   git clone -b gnat-fsf-11 https://github.com/Fabien-Chouteau/bb-runtimes gnat-llvm/llvm-interface/bb-runtimes
   ```

 * Clone [GCC](https://github.com/gcc-mirror/gcc) sources. Use, for instance, `e078de24` commit.
   ```
   git clone --single-branch --shallow-since=01-12-2021 https://github.com/gcc-mirror/gcc gnat-llvm/llvm-interface/gcc
   git -C gnat-llvm/gcc checkout e078de24
   ```

 * Setup GNAT-LLVM development environment, see details in
   [GNAT-LLVM README](https://github.com/AdaCore/gnat-llvm). Note, you need to use
   externally build LLVM with enabled 'lld' project and 'WebAssembly' target,
   so, if you build it your-self, `cmake` command line should contain among other switches:

   ```
   cmake ... -DLLVM_ENABLE_PROJECTS='...;clang;lld' -DLLVM_TARGETS_TO_BUILD="...;WebAssembly"
   ```

   On Ubuntu it is possible to install prebuild LLVM/CLang packages (use LLVM/CLang 13). However,
   alternatives need to be updated using the provided script:

   ```
   sudo utilities/update-alternatives-clang.sh 13 100
   ```

   Or install a [LLVM 13 binary release](https://github.com/llvm/llvm-project/releases).

 * Checkout AdaWebPack repository into `gnat-llvm/llvm-interface` as
   `adawebpack_src` and create link for Makefile.target.

   ```
   cd gnat-llvm/llvm-interface
   git clone https://github.com/godunko/adawebpack.git adawebpack_src
   ln -s adawebpack_src/source/rtl/Makefile.target
   cd -
   ```

 * Create a link to RTS source code
   ```
   cd gnat-llvm/llvm-interface
   ln -s bb-runtimes/gnat_rts_sources/include/rts-sources/
   cd -
   ```

 * Create a link to GNAT source code (or copy it)
   ```
   cd gnat-llvm/llvm-interface
   ln -s gcc/gcc/ada gnat_src
   cd -
   ```

 * Use `make wasm` to build compiler and Run Time Library
   ```
   cd gnat-llvm/llvm-interface
   make wasm
   cd -
   ```

 * When `make` finishes, you will find toolchain in `gnat-llvm/llvm-interface/bin`.
   ```
   cd gnat-llvm/llvm-interface
   export PATH=$PWD/bin:$PATH
   cd -
   ```

 * Now you can build examples:
   ```
   cd gnat-llvm/llvm-interface/adawebpack_src
   make build_examples
   cd -
   ```

## Usage with Docker

It could be handy to use docker.
* Find latest build on our [Fedora COPR](https://copr.fedorainfracloud.org/coprs/reznik/adawebpack/) repository.
* Build a container image (make sure to replace `curl` argument with latest RPM URL)
  ```
  docker build --tag wgprbuild - <<EOF
  FROM registry.fedoraproject.org/fedora-minimal:35
  RUN microdnf --assumeyes install \
    make \
    rpmdevtools \
    libstdc++-static \
    libgnat \
    clang \
    llvm-devel \
    lld \
    gprbuild \
    gdb \
    git \
    openssh-server \
    tar \
    gzip \
    chrpath \
    ca-certificates && \
  curl -O \
  https://download.copr.fedorainfracloud.org/results/reznik/adawebpack/fedora-35-x86_64/03123013-adawebpack/adawebpack-22.0.1-git.fc35.x86_64.rpm && \
  rpm -i adawebpack*.rpm && \
  rm -f adawebpack*.rpm && \
  microdnf clean all
  EOF
  ```
* Write a `bash` wrapper script to replace `gprbuild` like this:
  ```bash
  #!/bin/bash
  exec docker run --rm --tmpfs /tmp/ --user $UID --volume $HOME:$HOME --workdir $PWD wgprbuild gprbuild "$@"
  ```


## Unsupported features

 - nested subprograms are not supported

 - exceptions support is limited to local exceptions propagation and last
   chance handler

 - tasks and protected objects are not supported

## License

Web API bindings is licensed under BSD3 license.

GNAT Runtime Library is licensed under GPL3 license with GCC Runtime Library Exception.
