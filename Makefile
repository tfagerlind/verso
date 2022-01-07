.PHONY: project-check makefile-check syntax-check test

project-check:
	docker run -v "$(CURDIR):/project" --rm tomologic/project-checker

spell-check:
	docker run --rm -t -v $(CURDIR):/workdir \
		tmaier/markdown-spellcheck:latest --report "**/*.md"

makefile-check:
	docker run --rm -v $(CURDIR):/data cytopia/checkmake Makefile

syntax-check: project-check spell-check makefile-check

test: syntax-check
