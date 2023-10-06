#!/usr/bin/env make

SRCS	:= $(wildcard *.hs **/*.hs)
YAML	:= $(shell git ls-files "*.y*ml")

.PHONY: default
default: format check build test exec

.PHONY: all
all:	default doc

.PHONY: format
format:
	@stylish-haskell --config=.stylish-haskell.yaml --inplace $(SRCS)
	@cabal-fmt --inplace Robot.cabal

.PHONY: check
check:	tags lint

.PHONY: tags
tags: $(SRC)
	@hasktags --ctags --extendedctag $(SRCS)

.PHONY: lint
lint:
	@cabal check
	@hlint --cross --color --show $(SRCS)
	@yamllint --strict $(YAML)

.PHONY: build
build:
	@stack build --pedantic --fast

.PHONY: test
test:
	@stack test --fast

.PHONY: doc
doc:
	@stack haddock

.PHONY: exec
exec:
	@stack exec main

.PHONY: setup
setup:
	stack path
	stack query
	stack ls dependencies

.PHONY: clean
clean:
	@cabal clean
	@stack clean

cleanall: clean
	@stack purge
	@rm -f stack.yaml.lock
