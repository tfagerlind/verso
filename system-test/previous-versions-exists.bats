#!/usr/bin/env bats

setup() {
  # Not using BATS_TMPDIR since they don't provide enough integrity
  # for indvidual tests
  # see https://github.com/bats-core/bats-core/issues/226
  BATS_GIT_REPO_DIR=$(mktemp -d)

  # Configure Git
  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"
  git config --global init.defaultBranch "trunk"

  # Prepare a git repository with one file and one commit
  cd $BATS_GIT_REPO_DIR
  git init
  touch foofile
  git add foofile
  git commit -m "add foofile"
}

@test "Help message can be presented" {
  /app/verso --help | grep "Usage: verso \[OPTIONS\] COMMAND \[ARGS\]..."
}

@test "current version is 0.1.0 if the tag v0.1.0 is the biggest version" {
  git tag v0.1.0

  run -0 /app/verso current-version

  [ "$output" = "0.1.0" ]
}

@test "next version is 0.1.1 if the tag v0.1.0 is the biggest version" {
  git tag v0.1.0

  run -0 /app/verso next-version

  [ "$output" = "0.1.1" ]
}
