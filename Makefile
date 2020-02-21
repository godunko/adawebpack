GPRBUILD_FLAGS ?=

all: build build_examples

build:
	gprbuild $(GPRBUILD_FLAGS) -p -P gnat/adawebpack.gpr

build_examples:
	make -C examples

clean:
	rm -rf .objs
	make -C examples clean
