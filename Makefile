.PHONY: syntax-check test

syntax-check:
	docker run --rm -t -v $(CURDIR):/workdir \
		tmaier/markdown-spellcheck:latest --report "**/*.md"

test: syntax-check

