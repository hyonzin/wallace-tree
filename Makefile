all:
	iverilog -o exe *.v

run: all
	./exe

clean:
	rm -f exe

