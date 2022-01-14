#!/usr/bin/env bats

@test "current branch" {
  output=$(./verso current-branch)
  result=$?
  echo "output: ${output}"
  [ "$output" = "Not yet implemented." ]
  [ "$result" = 0 ]
}

@test "current version" {
  output=$(./verso current-version)
  result=$?
  echo "output: ${output}"
  [ "$output" = "Not yet implemented." ]
  [ "$result" = 0 ]
}
@test "next version" {
  output=$(./verso next-version)
  result=$?
  echo "output: ${output}"
  [ "$output" = "Not yet implemented." ]
  [ "$result" = 0 ]
}

@test "set version" {
  output=$(./verso set-version 1.2.3)
  result=$?
  echo "output: ${output}"
  [ "$output" = "Not yet implemented (1.2.3)." ]
  [ "$result" = 0 ]
}
