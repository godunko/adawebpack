# SPDX-FileCopyrightText: 2021 Max Reznik <reznikmm@gmail.com>
#
# SPDX-License-Identifier: MIT
#

# To check run with
# make -f .copr/Makefile srpm spec=$PWD/.copr/adawebpack.spec outdir=/tmp/

srpm:
	mkdir /tmp/.copr
	tar cavf /tmp/.copr/`grep ^Source0: $(spec)| sed -e 's/^.* //'` \
	  --exclude-vcs -C .. `basename $(realpath .)`
	cp packages/Fedora/*.patch /tmp/.copr/
	dnf --assumeyes install git subversion
	git clone https://github.com/AdaCore/gnat-llvm.git gnat-llvm
	git -C gnat-llvm checkout 5db6ab8
	tar czf /tmp/.copr/gnat-llvm.tar.gz --exclude-vcs gnat-llvm
	#git clone --depth=1 git://gcc.gnu.org/git/gcc.git
	#mv gcc/gcc/ada gnat_src
	svn export --force svn://gcc.gnu.org/svn/gcc/trunk/gcc/ada gnat_src
	tar czf /tmp/.copr/gnat_src.tar.gz --exclude-vcs gnat_src
	curl -L -o /tmp/.copr/gnat-2020-20200818-19951-src.tar.gz \
 https://community.download.adacore.com/v1/f51b6c0b5591edc6eff2928e8510a467bc8ce1e4?filename=gnat-2020-20200818-19951-src.tar.gz
	rpmbuild -bs $(spec) --define="_sourcedir /tmp/.copr" --define="_srcrpmdir $(outdir)"
