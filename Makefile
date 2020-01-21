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
	@hlint --color $(SRCS)

build:
	@stack build

test:
	@stack test

doc:
	@stack haddock

exec:
	@stack exec $(TARGET) -- +RTS -s

install:
	@stack install --local-bin-path $(HOME)/bin

setup:
	-stack setup
	-stack build --dependencies-only
	-stack query
	-stack ls dependencies

ghci:
	@stack ghci --ghci-options -Wno-type-defaults

clean:
	@cabal clean
	@stack clean
	@$(RM) -rf $(TARGET).tix

cleanall: clean
	@stack purge
