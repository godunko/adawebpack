
all: adawebpack.js
	gprbuild -p -P test.gpr

adawebpack.js:
	ln -s ../../source/adawebpack.js

clean:
	rm -rf .objs main.wasm adawebpack.js
