all: dir bin/exe

dir:
	mkdir -p bin

bin/exe: src/*
	iverilog -o bin/exe src/*.v

run: all
	vvp bin/exe -lxt2

clean:
	rm -f bin/exe
