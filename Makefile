clean:
	rm -f ebin/*.beam
	rm -f *.dump
	rm -f credit

build: clean
	erl -make
	./rebar escriptize

test: clean build
	erl -noshell -pa ebin -eval "eunit:test(operations, [verbose])" -s init stop
	erl -noshell -pa ebin -eval "eunit:test(validation, [verbose])" -s init stop

test_file: clean build
	cat testfile | ./credit

.PHONY: clean build test test_file
