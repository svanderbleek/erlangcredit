build:
	erl -make
	cd ebin; erl -noshell -s systools make_script credit -s erlang halt
	cd ebin; erl -noshell -s systools make_tar credit -s erlang halt

clean:
	rm -f ebin/*.beam
	rm -f ebin/*.boot
	rm -f ebin/*.script
	rm -f ebin/*.tar.gz
	rm -f ebin/*.dump

test: clean build
	erl -noshell -pa ebin -eval "eunit:test(operations, [verbose])" -s init stop
	erl -noshell -pa ebin -eval "eunit:test(validation, [verbose])" -s init stop

.PHONY: test build clean
