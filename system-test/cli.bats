#!/usr/bin/env bats

setup() {
  # Not using BATS_TMPDIR since they don't provide enough integrity
  # for indvidual tests
  # see https://github.com/bats-core/bats-core/issues/226
  BATS_GIT_REPO_DIR=$(mktemp -d)
  BATS_RUN_TMPDIR=$(mktemp -d)

  # Build package in order to not only test the basic functionality
  # but also the package itself. Package tests catch for example
  # missing dependencies
  export VERSION=0.1.2
  python -m build --wheel .

  # Install package in virtual environment
  python -m venv $BATS_RUN_TMPDIR/venv
  source $BATS_RUN_TMPDIR/venv/bin/activate
  pip install dist/verso-${VERSION}-py3-none-any.whl

  # Configure Git
  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

  # Prepare a git repository with one file and one commit
  cd $BATS_GIT_REPO_DIR
  git init
  touch foofile
  git add foofile
  git commit -m "add foofile"
}

@test "current version is 0.0.0 if there are no tags" {
  output=$(verso current-version)
  result=$?
  [ "$output" = "0.0.0" ]
  [ "$result" = 0 ]
}

@test "next version is 0.1.0 if there are no tags" {
  output=$(verso next-version)
  result=$?
  echo "output: ${output}"
  [ "$output" = "0.1.0" ]
  [ "$result" = 0 ]
}
