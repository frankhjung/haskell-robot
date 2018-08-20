#!/usr/bin/env make

TARGET 	:= robot
SUBS	:= $(wildcard */)
SRCS	:= $(wildcard $(addsuffix *.hs, $(SUBS)))
ARGS 	:= ''

all:	check build test exec

check:	style lint tags

style:	$(SRCS)
	@stylish-haskell -c .stylish-haskell.yaml -i $(SRCS)

lint:	$(SRCS)
	@hlint $(SRCS) --git --color --show

tags:	$(SRCS)
	@hasktags --ctags --extendedctag $(SRCS)

build:	$(SRCS)
	@stack build

exec:	build
	@stack exec $(TARGET) -- $(ARGS)

test:	build
	@stack test

bench:	build
	@stack bench

docs:	build
	@stack haddock

install:
	@stack install --local-bin-path $(HOME)/bin $(TARGET)

clean:
	@stack clean
	@$(RM) -rf dist

cleanall: clean
	@$(RM) -rf .stack-work/

ghci:
	@stack ghci --ghci-options -Wno-type-defaults
