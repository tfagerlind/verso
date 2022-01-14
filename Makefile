.PHONY: build project-check makefile-check dockerfile-check syntax-check test
.PHONY: smoke pylint-check filelint-check flake8-check

build:
	docker build -t verso .

project-check:
	docker run -v "$(CURDIR):/project" --rm tomologic/project-checker

spell-check:
	docker run --rm -t -v $(CURDIR):/workdir \
		tmaier/markdown-spellcheck:latest --report "**/*.md"

makefile-check:
	docker run --rm -v $(CURDIR):/data cytopia/checkmake Makefile

dockerfile-check:
	docker run --rm -i hadolint/hadolint < Dockerfile

pylint-check: build
	docker run --rm verso python -m pylint verso core

flake8-check:
	docker run --rm -v $(CURDIR):/apps alpine/flake8:3.5.0 .

syntax-check: project-check spell-check makefile-check dockerfile-check
syntax-check: pylint-check filelint-check flake8-check

system-test: build
	docker run --rm verso bats system-test

test: build syntax-check system-test
