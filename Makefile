#!/usr/bin/env make

.PHONY:	all bench build check clean cleanall doc exec ghci install lint setup style tags test

TARGET	:= robot
SUBS	:= $(wildcard */)
SRCS	:= $(wildcard $(addsuffix *.hs, $(SUBS)))

.PHONY: default
default:	check build test

all:	check build test doc exec

check:	tags style lint

tags:
	@hasktags --ctags --extendedctag $(SRCS)

style:
	@stylish-haskell --config=.stylish-haskell.yaml --inplace $(SRCS)

lint:
	@hlint $(SRCS)

build:
	@stack build

test:
	@stack test

bench:
	@stack bench --benchmark-arguments '-o .stack-work/benchmark.html'

doc:
	@stack test --coverage --no-run-tests
	@stack haddock

exec:
	@stack exec $(TARGET) -- +RTS -s

install:
	@stack install --local-bin-path $(HOME)/bin $(TARGET)

setup:
	-stack setup
	-stack build --dependencies-only --test --no-run-tests
	-stack query
	-stack ls dependencies

clean:
	@cabal clean
	@stack clean
	@$(RM) -rf dist

cleanall: clean
	@$(RM) -rf .stack-work/

ghci:
	@stack ghci --ghci-options -Wno-type-defaults
