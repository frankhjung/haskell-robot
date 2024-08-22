#!/usr/bin/env make

.DEFAULT_GOAL	:= default

TARGET:= robot
CABAL	:= Robot.cabal
SRCS	:= $(wildcard */*.hs)

.PHONY: default
default: tags format lint build test

.PHONY: all
all:	tags format lint build test doc exec

.PHONY: tags
tags:	$(SRCS)
	@echo tags ...
	@hasktags --ctags --extendedctag $(SRCS)

.PHONY: format
format:	$(SRCS)
	@echo format ...
	@cabal-fmt --inplace $(CABAL)
	@stylish-haskell --inplace $(SRCS)

.PHONY: lint
lint:	$(SRCS)
	@echo lint ...
	@hlint --cross --color --show $(SRCS)
	@cabal check

.PHONY: build
build:  $(SRCS)
	@cabal build

.PHONY: test
test:
	@cabal test --test-show-details=direct

.PHONY: doc
doc:
	@cabal haddock --haddock-quickjump --haddock-hyperlink-source

.PHONY: exec
exec:
	@cabal exec $(TARGET)

.PHONY: setup
setup:
	-touch -d "2018-10-10T10:42:16UTC" LICENSE
ifeq (,$(wildcard ${CABAL_CONFIG}))
	-cabal user-config init
	-cabal update --only-dependencies
else
	@echo Using user-config from ${CABAL_CONFIG} ...
endif

.PHONY: clean
clean:
	@cabal clean

.PHONY: distclean
distclean: clean
	@$(RM) tags
