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
	dnf --assumeyes install git
	git clone https://github.com/AdaCore/gnat-llvm.git gnat-llvm
	git -C gnat-llvm checkout 1d76aa3a057a8fa8d267fc1c5a75d0c729c48840
	tar czf /tmp/.copr/gnat-llvm.tar.gz --exclude-vcs gnat-llvm
	
	#git init gcc
	#git -C gcc remote add origin https://github.com/gcc-mirror/gcc.git
	#git -C gcc fetch --depth=1 origin acf190b208ae6883e94bcaa13adf9e3439bee63d
	#git -C gcc reset --hard FETCH_HEAD
	#git clone --depth=1 git://gcc.gnu.org/git/gcc.git
	#mv gcc/gcc/ada gnat_src
	#svn export --force svn://gcc.gnu.org/svn/gcc/trunk/gcc/ada gnat_src
	#tar czf /tmp/.copr/gnat_src.tar.gz --exclude-vcs gnat_src
	
	curl -L -o /tmp/.copr/gnat-2021-20210519-19A70-src.tar.gz \
 https://community.download.adacore.com/v1/005d2b2eff627177986d2517eb31e1959bec6f3a?filename=gnat-2021-20210519-19A70-src.tar.gz
	rpmbuild -bs $(spec) --define="_sourcedir /tmp/.copr" --define="_srcrpmdir $(outdir)"
