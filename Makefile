.PHONY: project-check syntax-check test

project-check:
	docker run -v "${CURDIR}:/project" --rm tomologic/project-checker

spell-check:
	docker run --rm -t -v $(CURDIR):/workdir \
		tmaier/markdown-spellcheck:latest --report "**/*.md"

syntax-check: project-check spell-check

test: syntax-check
