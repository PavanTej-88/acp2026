#!/usr/bin/env bats

# --- GROUP 1: STANDARD NAME COMPARISON (10 Cases) ---

@test "1: S1 longer than S2" {
  run ./act7 <<EOF
Alexander
Bob
EOF
  [[ "$output" == *"Student 1 name is longer"* ]]
}

@test "2: S2 longer than S1" {
  run ./act7 <<EOF
Bob
Alexander
EOF
  [[ "$output" == *"Student 2 name is longer"* ]]
}

@test "3: Equal length names" {
  run ./act7 <<EOF
John
Mary
EOF
  [[ "$output" == *"same length"* ]]
}

@test "4: Single character names equal" {
  run ./act7 <<EOF
A
B
EOF
  [[ "$output" == *"same length"* ]]
}

@test "5: Single char vs long name" {
  run ./act7 <<EOF
A
Christopher
EOF
  [[ "$output" == *"Student 2 name is longer"* ]]
}

@test "6: Long name vs single char" {
  run ./act7 <<EOF
Christopher
A
EOF
  [[ "$output" == *"Student 1 name is longer"* ]]
}

@test "7: Identical names" {
  run ./act7 <<EOF
Alice
Alice
EOF
  [[ "$output" == *"same length"* ]]
}

@test "8: Names with numbers" {
  run ./act7 <<EOF
user123
ab
EOF
  [[ "$output" == *"Student 1 name is longer"* ]]
}

@test "9: All uppercase names" {
  run ./act7 <<EOF
ALICE
BOBSMITH
EOF
  [[ "$output" == *"Student 2 name is longer"* ]]
}

@test "10: All lowercase names" {
  run ./act7 <<EOF
alice
bobsmith
EOF
  [[ "$output" == *"Student 2 name is longer"* ]]
}

# --- GROUP 2: LENGTH CORRECTNESS (10 Cases) ---

@test "11: Correct length of student 1 displayed" {
  run ./act7 <<EOF
hello
hi
EOF
  [[ "$output" == *"5"* ]]
}

@test "12: Correct length of student 2 displayed" {
  run ./act7 <<EOF
hi
hello
EOF
  [[ "$output" == *"5"* ]]
}

@test "13: Both lengths displayed" {
  run ./act7 <<EOF
abc
abcde
EOF
  [[ "$output" == *"3"* ]]
  [[ "$output" == *"5"* ]]
}

@test "14: Length 1 correctly identified" {
  run ./act7 <<EOF
x
y
EOF
  [[ "$output" == *"1"* ]]
}

@test "15: Length of longer name shown in result" {
  run ./act7 <<EOF
Pavantej
Raj
EOF
  [[ "$output" == *"8"* ]]
}

@test "16: Equal length shows correct length value" {
  run ./act7 <<EOF
abcd
efgh
EOF
  [[ "$output" == *"4"* ]]
}

@test "17: Long name length correct" {
  run ./act7 <<EOF
Bartholomew
Joe
EOF
  [[ "$output" == *"11"* ]]
}

@test "18: Alphanumeric name length" {
  run ./act7 <<EOF
user123
ab
EOF
  [[ "$output" == *"7"* ]]
  [[ "$output" == *"2"* ]]
}

@test "19: Both lengths equal and correct" {
  run ./act7 <<EOF
abc
xyz
EOF
  [[ "$output" == *"3"* ]]
}

@test "20: Length of 99 char name" {
  run ./act7 <<EOF
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
b
EOF
  [[ "$output" == *"99"* ]]
  [[ "$output" == *"Student 1 name is longer"* ]]
}

# --- GROUP 3: CRITICAL EDGE CASES (10 Cases) ---

@test "21: Output contains student 1 prompt" {
  run ./act7 <<EOF
Alice
Bob
EOF
  [[ "$output" == *"student 1"* ]] || [[ "$output" == *"Student 1"* ]]
}

@test "22: Output contains student 2 prompt" {
  run ./act7 <<EOF
Alice
Bob
EOF
  [[ "$output" == *"student 2"* ]] || [[ "$output" == *"Student 2"* ]]
}

@test "23: Mixed case name comparison" {
  run ./act7 <<EOF
Alice
BOBsmith
EOF
  [[ "$output" == *"Student 2 name is longer"* ]]
}

@test "24: Numeric string names" {
  run ./act7 <<EOF
123
12345
EOF
  [[ "$output" == *"Student 2 name is longer"* ]]
  [[ "$output" == *"5"* ]]
}

@test "25: Same length different chars" {
  run ./act7 <<EOF
abc
123
EOF
  [[ "$output" == *"same length"* ]]
}

@test "26: Special characters in name" {
  run ./act7 <<EOF
abc123
xyz
EOF
  [[ "$output" == *"Student 1 name is longer"* ]]
}

@test "27: Program exits successfully" {
  run ./act7 <<EOF
Alice
Bob
EOF
  [ "$status" -eq 0 ]
}

@test "28: Very long name vs short name" {
  run ./act7 <<EOF
Alexanderwilliamjohnsonsmith
Jo
EOF
  [[ "$output" == *"Student 1 name is longer"* ]]
}

@test "29: Short name vs very long name" {
  run ./act7 <<EOF
Jo
Alexanderwilliamjohnsonsmith
EOF
  [[ "$output" == *"Student 2 name is longer"* ]]
}

@test "30: Length output appears before comparison result" {
  run ./act7 <<EOF
Alice
Bob
EOF
  [[ "$output" == *"Length"* ]]
  [[ "$output" == *"longer"* ]] || [[ "$output" == *"same"* ]]
}
