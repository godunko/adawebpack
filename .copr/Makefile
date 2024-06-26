# SPDX-FileCopyrightText: 2021-2022 Max Reznik <reznikmm@gmail.com>
#
# SPDX-License-Identifier: MIT
#

# To check run with
# make -f .copr/Makefile srpm spec=$PWD/.copr/adawebpack.spec outdir=/tmp/

srpm:
	mkdir /tmp/.copr
	cp -v `dirname $(spec)`/../patches/*.patch /tmp/.copr
	tar cavf /tmp/.copr/`grep ^Source0: $(spec)| sed -e 's/^.* //'` \
	  --exclude-vcs -C .. `basename $(realpath .)`
	curl -L -o /tmp/.copr/gnat-llvm.zip https://github.com/AdaCore/gnat-llvm/archive/66e36d929524972353600db5d604d0189cf0308f.zip
	curl -L -o /tmp/.copr/bb-runtimes.zip https://github.com/Fabien-Chouteau/bb-runtimes/archive/e59080e0c4b49d12e00538595052dea2dceb5a6e.zip
	curl -L -o /tmp/.copr/gcc.zip https://github.com/gcc-mirror/gcc/archive/cd0059a1976303638cea95f216de129334fc04d1.zip
	rpmbuild -bs $(spec) --define="_sourcedir /tmp/.copr" --define="_srcrpmdir $(outdir)"
