
all: adawebpack.js
	gprbuild $(GPRBUILD_FLAGS) -p -P test.gpr

adawebpack.js:
	ln -s ../../source/adawebpack.js

clean:
	rm -rf .objs main.wasm adawebpack.js
