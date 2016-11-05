SHELL=/bin/bash
MAKEFLAGS = --no-print-directory
OPENFL_ARGS ?=
GAME_NAME = GamejamFall2016
VERSION = 0.0.1
UNAME:=$(shell uname)

ifeq ($(UNAME), Linux)
	export EDITOR=emacs
	export USER_NAME=$(USER)
	OS=linux64
endif
ifeq ($(UNAME), Darwin)
	OS=mac64
endif

all:
	make cpp

cpp:
	make bcpp rcpp
bcpp:
	haxe -cp src -main Main -cpp bin
rcpp:
	(cd bin && ./Main)

clean:
	rm -rf bin
fix:
	haxelib install hxcpp
