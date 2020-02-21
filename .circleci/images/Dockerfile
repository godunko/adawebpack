FROM registry.fedoraproject.org/fedora-minimal:31
RUN microdnf install \
  make \
  rpmdevtools \
  gcc-gnat \
  gcc-c++ \
  libstdc++-static \
  clang \
  llvm-devel \
  lld \
  gprbuild \
  gdb \
  git \
  subversion \
  openssh-server \
  tar \
  gzip \
  chrpath \
  ca-certificates && \
 microdnf clean all