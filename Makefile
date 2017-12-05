all: dir bin/exe

dir:
	mkdir -p bin

bin/exe:
	iverilog -o bin/exe src/*.v

run: all
	bin/exe

clean:
	rm -f bin/exe
