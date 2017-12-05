COMPILER=iverilog
RUN_ENGINE=vvp

all: dir bin/exe

dir:
	mkdir -p bin

bin/exe: src/*
	$(COMPILER) -o bin/exe src/*.v

run: all
	$(RUN_ENGINE) bin/exe -lxt2

clean:
	rm -f bin/exe
