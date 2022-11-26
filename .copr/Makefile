# SPDX-FileCopyrightText: 2021-2022 Max Reznik <reznikmm@gmail.com>
#
# SPDX-License-Identifier: MIT
#

# To check run with
# make -f .copr/Makefile srpm spec=$PWD/.copr/adawebpack.spec outdir=/tmp/

srpm:
	mkdir /tmp/.copr
	cp -v `dirname $(spec)`/../patches/gnat-llvm.patch /tmp/.copr
	tar cavf /tmp/.copr/`grep ^Source0: $(spec)| sed -e 's/^.* //'` \
	  --exclude-vcs -C .. `basename $(realpath .)`
	curl -L -o /tmp/.copr/gnat-llvm.zip https://github.com/AdaCore/gnat-llvm/archive/28c91e94c4227e6d9eabb2aeed4c0c12f6a4f3de.zip
	curl -L -o /tmp/.copr/bb-runtimes.zip https://github.com/Fabien-Chouteau/bb-runtimes/archive/c1d089bd8880cec250266cf71d6a22cc74fdba79.zip
	curl -L -o /tmp/.copr/gcc.zip https://github.com/gcc-mirror/gcc/archive/64d5610f44c995b88261bf83f53a200355cb530f.zip
	rpmbuild -bs $(spec) --define="_sourcedir /tmp/.copr" --define="_srcrpmdir $(outdir)"
