EXAMPLE_DIRS = \
	call_ada \
	toggle_hidden \
	webgl_basic

all:
	for d in $(EXAMPLE_DIRS); do make -C $$d; done

clean:
	for d in $(EXAMPLE_DIRS); do make -C $$d clean; done
