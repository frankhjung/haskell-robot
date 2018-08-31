#!/usr/bin/env make

.PHONY:	all bench build check clean cleanall doc exec ghci install lint setup style tags test

TARGET	:= robot
SUBS	:= $(wildcard */)
SRCS	:= $(wildcard $(addsuffix *.hs, $(SUBS)))
ARGS	:= ''

build:
	@stack build

all:	check build test doc exec

check:	tags style lint

tags:
	@hasktags --ctags --extendedctag $(SRCS)

lint:
	@hlint $(SRCS)

style:
	@stylish-haskell --config=.stylish-haskell.yaml --inplace $(SRCS)

test:
	@stack test --coverage

bench:
	@stack bench --benchmark-arguments '-o .stack-work/benchmark.html'

doc:
	@stack haddock

exec:
	@stack exec $(TARGET) -- $(ARGS) +RTS -s

install:
	@stack install --local-bin-path $(HOME)/bin $(TARGET)

setup:
	-stack setup
	-stack build --dependencies-only --test --no-run-tests
	-stack query
	-stack ls dependencies

install:
	@stack install --local-bin-path $(HOME)/bin $(TARGET)

clean:
	@cabal clean
	@stack clean
	@$(RM) -rf dist

cleanall: clean
	@$(RM) -rf .stack-work/ $(TARGET)

ghci:
	@stack ghci --ghci-options -Wno-type-defaults
