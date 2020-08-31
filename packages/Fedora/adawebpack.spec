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
Source0:    %{name}.tar.gz
Source1:    gnat-llvm.tar.gz
Source2:    gnat_src.tar.gz
# https://community.download.adacore.com/v1/f51b6c0b5591edc6eff2928e8510a467bc8ce1e4?filename=gnat-2020-20200818-19951-src.tar.gz
Source3:    gnat-2020-20200818-19951-src.tar.gz
Patch0:     gnat-adafinal_conv.patch
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
mv ../gnat_src llvm-interface/
%patch0 -p0
mv ../%{name} llvm-interface/%{name}_src
mv ../gnat-2020-20200818-19951-src/src/ada/hie llvm-interface/rts-sources
cp -v  ../gnat-2020-20200818-19951-src/src/ada/libgnat/s-{stratt,statxd}.ad[sb] llvm-interface/gnat_src/libgnat/
ln -s %{name}_src/source/rtl/Makefile.target llvm-interface/
cd llvm-interface/rts-sources
mkdir {math,mem,zfp,full,math/hardsp,math/harddp}
mv a-elchha__zfp.ads zfp/a-elchha.ads
mv s-assert__xi.adb zfp/s-assert.adb
mv s-sssita.ad[sb] zfp/
mv s-init.ads full/
for J in a-ngelfu a-nlelfu a-nllefu a-nuelfu s-gcmain s-lidosq s-libdou s-libm s-libpre s-libsin s-lisisq ; do mv -v ${J}__ada.ads math/$J.ads; done
for J in s-gcmain s-libdou s-libm s-libsin a-ngelfu; do mv -v ${J}__ada.adb math/$J.adb; done
mv -v s-lisisq__fpu.adb math/hardsp/s-lisisq.adb
mv -v s-lidosq__fpu.adb math/harddp/s-lidosq.adb
mv -v s-memcom.ad[sb] s-memcop.ad[sb] s-memmov.ad[sb] s-memset.ad[sb] s-memtyp.ads mem/

%build
make -C llvm-interface/ wasm
PATH=$PATH:`pwd`/llvm-interface/bin make -C llvm-interface/%{name}_src GPRBUILD_FLAGS=--db\ `pwd`/llvm-interface/%{name}_src/packages/Fedora

%install
cd llvm-interface
chrpath -d bin/*
mkdir -p %{buildroot}/usr/share/gprconfig
mkdir -p %{buildroot}/usr/lib/gnat
mkdir -p %{buildroot}/usr/share/%{name}
cp %{name}_src/packages/Fedora/llvm.xml %{buildroot}/usr/share/gprconfig/
cp %{name}_src/gnat/%{name}_config.gpr %{buildroot}/usr/lib/gnat/
cp -r bin lib %{buildroot}/usr
cp -v %{name}_src/source/%{name}.mjs %{buildroot}/usr/share/%{name}/
PATH=$PATH:`pwd`/bin gprconfig --batch -o /tmp/llvm.cgpr --db `pwd`/%{name}_src/packages/Fedora --target=llvm --config=ada,,
PATH=$PATH:`pwd`/bin gprinstall --target=llvm --prefix=%{buildroot}/usr --project-subdir=%{buildroot}/usr/lib/gnat -P %{name}_src/gnat/%{name}.gpr -p --config=/tmp/llvm.cgpr

%files
%dir /usr/include/%{name}
%dir /usr/lib/%{name}
%dir /usr/share/%{name}
%dir /usr/lib/rts-native
%dir /usr/lib/gnat
/usr/bin/llvm-*
/usr/include/%{name}/*.ad[sb]
/usr/lib/%{name}/*.{ali,o}
/usr/lib/rts-native/adainclude/*.ad[sb]
/usr/lib/rts-native/adalib/*.ali
/usr/lib/rts-native/adalib/libgnat.a
/usr/lib/gnat/%{name}*.gpr
/usr/lib/gnat/manifests/%{name}
/usr/share/gprconfig/llvm.xml
/usr/share/%{name}/%{name}.mjs

%changelog
* Fri Feb 21 2020 Maxim Reznik <reznikmm@gmail.com> - 0.1.0-git
- Initial package
