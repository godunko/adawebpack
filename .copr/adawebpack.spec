%undefine _hardened_build
%define _gprdir %_GNAT_project_dir
%define rtl_version 0.1

#brp-strip-static-archive stips index from libgnat.a
%define __os_install_post %{nil}

Name:       adawebpack
Version:    24.0.0
Release:    git%{?dist}
Summary:    Ada WASM Runtime and Bindings for Web API
Group:      Development/Libraries
License:    MIT
URL:        https://github.com/godunko/adawebpack
Source0:    adawebpack.tar.gz
Source1:    gnat-llvm.zip
Source2:    bb-runtimes.zip
Source3:    gcc.zip
Patch0:     gnat-llvm.patch
Patch1:     llvm_wrapper2.patch
BuildRequires:   bsdtar
BuildRequires:   gcc-gnat
BuildRequires:   fedora-gnat-project-common  >= 3
BuildRequires:   gprbuild
BuildRequires:   gcc-c++
BuildRequires:   libstdc++-static
BuildRequires:   lld
BuildRequires:   llvm16-devel
BuildRequires:   clang16-devel
BuildRequires:   chrpath

# gprbuild only available on these:
ExclusiveArch: %GPRbuild_arches

%description
Ada WASM Runtime and Bindings for Web API

%prep
%setup -T -b1 -a 0 -a 2 -n gnat-llvm-66e36d929524972353600db5d604d0189cf0308f/
#export LANG=C.utf8
LANG=C.utf8 bsdtar -x -f %{S:3} gcc-*/gcc/ada
mv -v gcc-*/gcc/ada llvm-interface/gnat_src
mv %{name} llvm-interface/%{name}_src
mv -v bb-runtimes-*/gnat_rts_sources/include/rts-sources llvm-interface/
ln -s %{name}_src/source/rtl/Makefile.target llvm-interface/
%patch 0 -p0
%patch 1 -p0


%build
for J in /usr/bin/{llvm-config,opt,llvm-dis,llvm-ranlib}-16; do ln -v -s $J `basename $J -16`; done
export PATH=$PWD:$PATH

ln -s /usr/lib64/llvm16/lib/libclang-cpp.so ./libclangBasic.so

export LIBRARY_PATH=$PWD

make -C llvm-interface/ wasm
rm -v -f llvm-config opt llvm-dis llvm-ranlib
for J in /usr/bin/*-16; do ln -v -s $J `basename $J -16`; done
PATH=`pwd`/llvm-interface/bin:$PATH make -C llvm-interface/%{name}_src GPRBUILD_FLAGS=--db\ `pwd`/llvm-interface/%{name}_src/packages/Fedora

%install
cd llvm-interface
find -D exec bin -size +100k -exec chrpath -d {} \;
mkdir -p %{buildroot}/usr/share/gprconfig
mkdir -p %{buildroot}/usr/lib/gnat
mkdir -p %{buildroot}/usr/share/%{name}
cp %{name}_src/packages/Fedora/llvm.xml %{buildroot}/usr/share/gprconfig/
cp %{name}_src/gnat/%{name}_config.gpr %{buildroot}/usr/lib/gnat/
cp -r bin lib %{buildroot}/usr
cp -v %{name}_src/source/%{name}.mjs %{buildroot}/usr/share/%{name}/
cp -v %{name}_src/utilities/update-alternatives-clang.sh %{buildroot}/usr/share/%{name}/
PATH=$PATH:`pwd`/bin gprconfig --batch -o /tmp/llvm.cgpr --db `pwd`/%{name}_src/packages/Fedora --target=llvm --config=ada,,
PATH=$PATH:`pwd`/bin gprinstall --target=llvm --prefix=%{buildroot}/usr --project-subdir=%{buildroot}/usr/lib/gnat -P %{name}_src/gnat/%{name}.gpr -p --config=/tmp/llvm.cgpr

%files
%dir /usr/include/%{name}
%dir /usr/lib/%{name}
%dir /usr/share/%{name}
%dir /usr/lib/rts-native
%dir /usr/lib/gnat
/usr/bin/llvm-*
/usr/bin/target.atp
/usr/include/%{name}/*.ad[sb]
/usr/lib/%{name}/*.{ali,o}
/usr/lib/rts-native/adainclude/*.ad[sb]
/usr/lib/rts-native/adalib/*.ali
/usr/lib/rts-native/adalib/libgnat.a
/usr/lib/gnat/%{name}*.gpr
/usr/lib/gnat/manifests/%{name}
/usr/share/gprconfig/llvm.xml
/usr/share/%{name}/%{name}.mjs
/usr/share/%{name}/update-alternatives-clang.sh

%changelog
* Thu Jun 27 2024 Maxim Reznik <reznikmm@gmail.com> - 24.0.0-git
- Update to LLVM 16 and GCC 14

* Fri Feb 21 2020 Maxim Reznik <reznikmm@gmail.com> - 0.1.0-git
- Initial package
