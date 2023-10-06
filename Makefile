#!/usr/bin/env make

SUBS	:= $(wildcard */)
SRCS	:= $(wildcard $(addsuffix *.hs, $(SUBS)))
YAML	:= $(shell git ls-files | grep --perl \.y?ml)

.PHONY: default
default: format check build test

.PHONY: all
all:	format check build test doc exec

.PHONY: format
format:
	@echo format ...
	@stylish-haskell --config=.stylish-haskell.yaml --inplace $(SRCS)
	@cabal-fmt --inplace Robot.cabal

.PHONY: check
check:	tags lint

.PHONY: tags
tags: $(SRC)
	@echo tags ...
	@hasktags --ctags --extendedctag $(SRCS)

.PHONY: lint
lint:
	@echo lint ...
	@cabal check
	@hlint --cross --color --show $(SRCS)
	@yamllint --strict $(YAML)

.PHONY: build
build:
	@echo build ...
	@stack build --pedantic --fast

.PHONY: test
test:
	@echo test ...
	@stack test --fast

.PHONY: doc
doc:
	@echo doc ...
	@stack haddock

.PHONY: exec
exec:
	@stack exec main -- +RTS -s

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
