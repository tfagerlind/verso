#!/usr/bin/env bats

setup() {
  # Not using BATS_TMPDIR since they don't provide enough integrity
  # for indvidual tests
  # see https://github.com/bats-core/bats-core/issues/226
  BATS_GIT_REPO_DIR=$(mktemp -d)

  # Configure Git
  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

  # Prepare a git repository with one file and one commit
  pushd $BATS_GIT_REPO_DIR
  git init
  touch foofile
  git add foofile
  git commit -m "add foofile"
  popd
}

@test "Help message can be presented" {
  ./verso --help | grep "Usage: verso \[OPTIONS\] COMMAND \[ARGS\]..."
}

@test "current version is 0.0.0 if there are no tags" {
  output=$(./verso current-version)
  result=$?
  [ "$output" = "0.0.0" ]
  [ "$result" = 0 ]
}

@test "next version is 0.1.0 if there are no tags" {
  output=$(./verso next-version)
  result=$?
  echo "output: ${output}"
  [ "$output" = "0.1.0" ]
  [ "$result" = 0 ]
}
