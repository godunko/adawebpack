
all: adawebpack.mjs
	gprbuild $(GPRBUILD_FLAGS) -p -P test.gpr

adawebpack.mjs:
	ln -s ../../source/adawebpack.mjs

clean:
	rm -rf .objs main.wasm adawebpack.mjs
