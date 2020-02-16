%undefine _hardened_build
%define _gprdir %_GNAT_project_dir
%define rtl_version 0.1

#brp-strip-static-archive stips index from libgnat.a
%define __os_install_post %{nil}

Name:       adawebpack
Version:    0.1.0
Release:    git%{?dist}
Summary:    Ada WASM Runtime and Bindings for Web API
Group:      Development/Libraries
License:    MIT
URL:        https://github.com/godunko/adawebpack
### Direct download is not availeble
Source0:    adawebpack.tar.gz
Source1:    gnat-llvm.tar.gz
Source2:    gnat_src.tar.gz
# https://community.download.adacore.com/v1/d40edcdd2d3cc8c64e0f9600ca274bc13d5b49ba?filename=gnat-2019-20190517-18C94-src.tar.gz
Source3:    gnat-2019-20190517-18C94-src.tar.gz
BuildRequires:   gcc-gnat
BuildRequires:   fedora-gnat-project-common  >= 3 
BuildRequires:   gprbuild
BuildRequires:   gcc-c++
BuildRequires:   libstdc++-static
BuildRequires:   lld
BuildRequires:   llvm-devel
BuildRequires:   clang
BuildRequires:   chrpath

# gprbuild only available on these:
ExclusiveArch: %GPRbuild_arches

%description
Ada WASM Runtime and Bindings for Web API

%prep
%setup -q -b 1 -b 2 -b 3 -n gnat-llvm
mv ../gnat_src   llvm-interface/
mv ../adawebpack llvm-interface/adawebpack_src
mv ../gnat-2019-20190517-18C94-src/src/ada/hie llvm-interface/rts-sources
ln -s adawebpack_src/source/rtl/Makefile.target llvm-interface/
cd llvm-interface/rts-sources
mkdir {math,mem,zfp,math/hardsp,math/harddp}
mv a-elchha__zfp.ads zfp/a-elchha.ads
mv s-assert__xi.adb zfp/s-assert.adb
mv s-sssita.ad[sb] zfp/
for J in a-ngelfu a-nlelfu a-nllefu a-nuelfu s-gcmain s-lidosq s-libdou s-libm s-libpre s-libsin s-lisisq ; do mv -v ${J}__ada.ads math/$J.ads; done
for J in s-gcmain s-libdou s-libm s-libsin a-ngelfu; do mv -v ${J}__ada.adb math/$J.adb; done
mv -v s-lisisq__fpu.adb math/hardsp/s-lisisq.adb
mv -v s-lidosq__fpu.adb math/harddp/s-lidosq.adb
mv -v s-memcom.ad[sb] s-memcop.ad[sb] s-memmov.ad[sb] s-memset.ad[sb] s-memtyp.ads mem/

%build
make -C llvm-interface/ wasm
PATH=$PATH:`pwd`/llvm-interface/bin make -C llvm-interface/adawebpack_src  GPRBUILD_FLAGS=--db\ `pwd`/llvm-interface/adawebpack_src/packages/Fedora

%install
cd llvm-interface
chrpath -d bin/*
mkdir -p %{buildroot}/usr/share/gprconfig
mkdir -p %{buildroot}/usr/lib/gnat
cp adawebpack_src/packages/Fedora/llvm.xml  %{buildroot}/usr/share/gprconfig/
cp adawebpack_src/gnat/adawebpack_config.gpr %{buildroot}/usr/lib/gnat/
cp -r bin lib %{buildroot}/usr
PATH=$PATH:`pwd`/bin gprconfig --batch -o /tmp/llvm.cgpr --db `pwd`/adawebpack_src/packages/Fedora --target=llvm --config=ada,,
PATH=$PATH:`pwd`/bin gprinstall --target=llvm --prefix=%{buildroot}/usr --project-subdir=%{buildroot}/usr/lib/gnat -P adawebpack_src/gnat/adawebpack.gpr -p --config=/tmp/llvm.cgpr

%files
%dir /usr/include/%{name}
%dir /usr/lib/%{name}
%dir /usr/lib/rts-native
%dir /usr/lib/gnat
/usr/bin/llvm-*
/usr/include/%{name}/*.ad[sb]
/usr/lib/%{name}/*.{ali,o}
/usr/lib/rts-native/adainclude/*.ad[sb]
/usr/lib/rts-native/adalib/*.ali
/usr/lib/rts-native/adalib/libgnat.a
/usr/lib/gnat/adawebpack*.gpr
/usr/lib/gnat/manifests/adawebpack
/usr/share/gprconfig/llvm.xml

%changelog
* Fri Feb 21 2020 Maxim Reznik <reznikmm@gmail.com> - 0.1.0-git
- Initial package
