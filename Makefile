.PHONY: build project-check makefile-check dockerfile-check syntax-check test
.PHONY: smoke pylint-check filelint-check flake8-check unit-test upload-test
.PHONY: upload-prod yamllint-check

build:
	docker build -t verso .

project-check:
	docker run -v "$(CURDIR):/project" --rm tomologic/project-checker

spell-check:
	docker run --rm -t -v $(CURDIR):/workdir \
		tmaier/markdown-spellcheck:latest \
			--ignore-numbers --report "**/*.md"

yamllint-check:
	docker run --rm -v $(CURDIR):/data cytopia/yamllint .

makefile-check:
	docker run --rm -v $(CURDIR):/data cytopia/checkmake Makefile

dockerfile-check:
	docker run --rm -i hadolint/hadolint < Dockerfile

pylint-check: build
	docker run --rm verso python -m pylint \
		--ignore-patterns=test_.*\.py \
		verso core setup.py

flake8-check:
	docker run --rm -v $(CURDIR):/apps alpine/flake8:6.0.0 .

syntax-check: project-check spell-check makefile-check dockerfile-check
syntax-check: pylint-check filelint-check flake8-check yamllint-check

unit-test: build
	docker run --rm verso pytest -rA .

system-test: build
	docker run --rm verso bats --verbose-run system-test

package: build
	[ -n "${VERSION}" ] # Environment variable VERSION must be set
	docker run --rm -v $(CURDIR)/dist:/app/dist \
		-e VERSION=${VERSION} verso:latest python -m build .

upload-test: package
	docker run --rm -it -v $(CURDIR)/dist:/app/dist verso:latest \
		twine upload \
		--repository-url https://test.pypi.org/legacy/ dist/*

upload-prod: package
	docker run --rm -it -v $(CURDIR)/dist:/app/dist verso:latest \
		twine upload dist/*

test: build syntax-check unit-test system-test
