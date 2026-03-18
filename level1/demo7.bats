#!/usr/bin/env bats

# --- GROUP 1: EQUALITY (5 Cases) ---
@test "1: Identical lowercase" {
  run ./demo7 <<EOF
apple
apple
EOF
  [[ "$output" == *"Both strings are equal"* ]]
}

@test "2: Identical uppercase" {
  run ./demo7 <<EOF
BANANA
BANANA
EOF
  [[ "$output" == *"Both strings are equal"* ]]
}

@test "3: Single character equal" {
  run ./demo7 <<EOF
z
z
EOF
  [[ "$output" == *"Both strings are equal"* ]]
}

@test "4: Numeric strings equal" {
  run ./demo7 <<EOF
12345
12345
EOF
  [[ "$output" == *"Both strings are equal"* ]]
}

@test "5: Special characters equal" {
  run ./demo7 <<EOF
@#$
@#$
EOF
  [[ "$output" == *"Both strings are equal"* ]]
}

# --- GROUP 2: STRING 1 IS LARGER (Lexicographical) (8 Cases) ---
@test "6: S1 larger - first char" {
  run ./demo7 <<EOF
zebra
apple
EOF
  [[ "$output" == *"String 1 is larger"* ]]
}

@test "7: S1 larger - middle char" {
  run ./demo7 <<EOF
abcde
abcad
EOF
  [[ "$output" == *"String 1 is larger"* ]]
}

@test "8: S1 larger - last char" {
  run ./demo7 <<EOF
hellp
hello
EOF
  [[ "$output" == *"String 1 is larger"* ]]
}

@test "9: S1 larger - length (S2 is prefix)" {
  run ./demo7 <<EOF
canary
can
EOF
  [[ "$output" == *"String 1 is larger"* ]]
}

@test "10: S1 larger - case (lower vs upper)" {
  run ./demo7 <<EOF
apple
Apple
EOF
  [[ "$output" == *"String 1 is larger"* ]]
}

@test "11: S1 larger - numbers" {
  run ./demo7 <<EOF
2
1
EOF
  [[ "$output" == *"String 1 is larger"* ]]
}

@test "12: S1 larger - special vs alpha" {
  run ./demo7 <<EOF
a
!
EOF
  [[ "$output" == *"String 1 is larger"* ]]
}

@test "13: S1 larger - long strings" {
  run ./demo7 <<EOF
aaaaaaaaab
aaaaaaaaaa
EOF
  [[ "$output" == *"String 1 is larger"* ]]
}

# --- GROUP 3: STRING 2 IS LARGER (Lexicographical) (8 Cases) ---
@test "14: S2 larger - first char" {
  run ./demo7 <<EOF
apple
banana
EOF
  [[ "$output" == *"String 2 is larger"* ]]
}

@test "15: S2 larger - middle char" {
  run ./demo7 <<EOF
light
limit
EOF
  [[ "$output" == *"String 2 is larger"* ]]
}

@test "16: S2 larger - last char" {
  run ./demo7 <<EOF
boat
boaz
EOF
  [[ "$output" == *"String 2 is larger"* ]]
}

@test "17: S2 larger - length (S1 is prefix)" {
  run ./demo7 <<EOF
cat
category
EOF
  [[ "$output" == *"String 2 is larger"* ]]
}

@test "18: S2 larger - case (upper vs lower)" {
  run ./demo7 <<EOF
Zebra
apple
EOF
  [[ "$output" == *"String 2 is larger"* ]]
}

@test "19: S2 larger - numbers" {
  run ./demo7 <<EOF
555
556
EOF
  [[ "$output" == *"String 2 is larger"* ]]
}

@test "20: S2 larger - alpha vs special" {
  run ./demo7 <<EOF
#
z
EOF
  [[ "$output" == *"String 2 is larger"* ]]
}

@test "21: S2 larger - nearly identical" {
  run ./demo7 <<EOF
testing
testinh
EOF
  [[ "$output" == *"String 2 is larger"* ]]
}

# --- GROUP 4: EDGE CASES & MIXED CONTENT (9 Cases) ---
@test "22: Mixed alphanumeric S1 larger" {
  run ./demo7 <<EOF
user2
user1
EOF
  [[ "$output" == *"String 1 is larger"* ]]
}

@test "23: Mixed alphanumeric S2 larger" {
  run ./demo7 <<EOF
abc1
abc2
EOF
  [[ "$output" == *"String 2 is larger"* ]]
}

@test "24: Different capitalization same word" {
  run ./demo7 <<EOF
WORD
word
EOF
  [[ "$output" == *"String 2 is larger"* ]]
}

@test "25: Single char vs long string S1 larger" {
  run ./demo7 <<EOF
z
aaaaa
EOF
  [[ "$output" == *"String 1 is larger"* ]]
}

@test "26: Single char vs long string S2 larger" {
  run ./demo7 <<EOF
a
bbbbb
EOF
  [[ "$output" == *"String 2 is larger"* ]]
}

@test "27: Common prefix with case difference" {
  run ./demo7 <<EOF
InterNet
Internet
EOF
  [[ "$output" == *"String 2 is larger"* ]]
}

@test "28: Symbol comparison (ASCII 33 vs 126)" {
  run ./demo7 <<EOF
~
!
EOF
  [[ "$output" == *"String 1 is larger"* ]]
}

@test "29: Minimum length difference" {
  run ./demo7 <<EOF
a
aa
EOF
  [[ "$output" == *"String 2 is larger"* ]]
}

@test "30: Maximum length difference (1 char vs limit)" {
  run ./demo7 <<EOF
thisisalongstringtoseeifthebufferlimitcausesanyissuesinthecomparisonlogic
z
EOF
  [[ "$output" == *"String 2 is larger"* ]]
}