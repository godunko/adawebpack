# SPDX-FileCopyrightText: 2021-2022 Max Reznik <reznikmm@gmail.com>
#
# SPDX-License-Identifier: MIT
#

# To check run with
# make -f .copr/Makefile srpm spec=$PWD/.copr/adawebpack.spec outdir=/tmp/

srpm:
	mkdir /tmp/.copr
	tar cavf /tmp/.copr/`grep ^Source0: $(spec)| sed -e 's/^.* //'` \
	  --exclude-vcs -C .. `basename $(realpath .)`
	curl -L -o /tmp/.copr/gnat-llvm.zip https://github.com/AdaCore/gnat-llvm/archive/e3f56dce0df148c5f27e97d973cfbdc1bd72248f.zip
	curl -L -o /tmp/.copr/bb-runtimes.zip https://github.com/Fabien-Chouteau/bb-runtimes/archive/7a4674ae9221d2fa046bed20fbaf9de9caa09d41.zip
	curl -L -o /tmp/.copr/gcc.zip https://github.com/gcc-mirror/gcc/archive/e078de24eae8253fd4f24342f65166b525dd99c6.zip
	rpmbuild -bs $(spec) --define="_sourcedir /tmp/.copr" --define="_srcrpmdir $(outdir)"
