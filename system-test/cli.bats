#!/usr/bin/env bats

setup() {
  # Not using BATS_TMPDIR since they don't provide enough integrity
  # for indvidual tests
  # see https://github.com/bats-core/bats-core/issues/226
  BATS_RUN_TMPDIR=$(mktemp -d)

  # Build package in order to not only test the basic functionality
  # but also the package itself. Package tests catch for example missing dependencies
  export VERSION=0.1.2
  python -m build --wheel .

  # Install package in virtual environment
  python -m venv $BATS_RUN_TMPDIR/venv
  source $BATS_RUN_TMPDIR/venv/bin/activate
  pip install dist/verso-${VERSION}-py3-none-any.whl

  cd $BATS_RUN_TMPDIR
}

@test "current branch" {
  output=$(verso current-branch)
  result=$?
  echo "output: ${output}"
  [ "$output" = "Not yet implemented." ]
  [ "$result" = 0 ]
}

@test "current version" {
  output=$(verso current-version)
  result=$?
  echo "output: ${output}"
  [ "$output" = "Not yet implemented." ]
  [ "$result" = 0 ]
}
@test "next version" {
  output=$(verso next-version)
  result=$?
  echo "output: ${output}"
  [ "$output" = "Not yet implemented." ]
  [ "$result" = 0 ]
}

@test "set version" {
  output=$(verso set-version 1.2.3)
  result=$?
  echo "output: ${output}"
  [ "$output" = "Not yet implemented (1.2.3)." ]
  [ "$result" = 0 ]
}
