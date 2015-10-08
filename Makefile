NAME = altsol/rexster
VERSION = 2.6.0

.PHONY: all build tag_latest

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest
