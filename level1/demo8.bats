#!/usr/bin/env bats

# --- GROUP 1: BASIC CONCATENATION (10 Cases) ---

@test "1: Simple words" {
  run ./demo8 <<EOF
Hello
World
EOF
  [[ "$output" == *"Concatenated string: HelloWorld"* ]]
}

@test "2: Single characters" {
  run ./demo8 <<EOF
A
B
EOF
  [[ "$output" == *"Concatenated string: AB"* ]]
}

@test "3: Number strings" {
  run ./demo8 <<EOF
123
456
EOF
  [[ "$output" == *"Concatenated string: 123456"* ]]
}

@test "4: Mixed Alpha-Numeric" {
  run ./demo8 <<EOF
User
01
EOF
  [[ "$output" == *"Concatenated string: User01"* ]]
}

@test "5: Special characters" {
  run ./demo8 <<EOF
#@!
$%^
EOF
  [[ "$output" == *"Concatenated string: #@!$%^"* ]]
}

@test "6: Different case" {
  run ./demo8 <<EOF
lower
UPPER
EOF
  [[ "$output" == *"Concatenated string: lowerUPPER"* ]]
}

@test "7: Hyphenated strings" {
  run ./demo8 <<EOF
part-one
-part-two
EOF
  [[ "$output" == *"Concatenated string: part-one-part-two"* ]]
}

@test "8: Underscore strings" {
  run ./demo8 <<EOF
first_
second
EOF
  [[ "$output" == *"Concatenated string: first_second"* ]]
}

@test "9: Long prefix, short suffix" {
  run ./demo8 <<EOF
ThisIsALongString
X
EOF
  [[ "$output" == *"Concatenated string: ThisIsALongStringX"* ]]
}

@test "10: Short prefix, long suffix" {
  run ./demo8 <<EOF
Y
ThisIsALongString
EOF
  [[ "$output" == *"Concatenated string: YThisIsALongString"* ]]
}

# --- GROUP 2: BOUNDARY & LENGTH TESTS (10 Cases) ---

@test "11: Very long strings" {
  run ./demo8 <<EOF
abcdefghijklmnopqrstuvwxyz
ABCDEFGHIJKLMNOPQRSTUVWXYZ
EOF
  [[ "$output" == *"Concatenated string: abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"* ]]
}

@test "12: Repeating characters" {
  run ./demo8 <<EOF
aaaaa
bbbbb
EOF
  [[ "$output" == *"Concatenated string: aaaaabbbbb"* ]]
}

@test "13: S1 is single char, S2 is single char" {
  run ./demo8 <<EOF
1
2
EOF
  [[ "$output" == *"Concatenated string: 12"* ]]
}

@test "14: S1 is a word, S2 is a punctuation" {
  run ./demo8 <<EOF
Done
!
EOF
  [[ "$output" == *"Concatenated string: Done!"* ]]
}

@test "15: Concatenating identical strings" {
  run ./demo8 <<EOF
copy
copy
EOF
  [[ "$output" == *"Concatenated string: copycopy"* ]]
}

@test "16: S2 is a numeric suffix" {
  run ./demo8 <<EOF
v
1.0
EOF
  [[ "$output" == *"Concatenated string: v1.0"* ]]
}

@test "17: File extension simulation" {
  run ./demo8 <<EOF
document
.pdf
EOF
  [[ "$output" == *"Concatenated string: document.pdf"* ]]
}

@test "18: URL simulation" {
  run ./demo8 <<EOF
google
.com
EOF
  [[ "$output" == *"Concatenated string: google.com"* ]]
}

@test "19: Path simulation" {
  run ./demo8 <<EOF
/home/user
/docs
EOF
  [[ "$output" == *"Concatenated string: /home/user/docs"* ]]
}

@test "20: Concatenating digits" {
  run ./demo8 <<EOF
000
111
EOF
  [[ "$output" == *"Concatenated string: 000111"* ]]
}

# --- GROUP 3: LOGIC & SYMBOL STRESS (10 Cases) ---

@test "21: All brackets" {
  run ./demo8 <<EOF
([])
{}
EOF
  [[ "$output" == *"Concatenated string: ([]){}"* ]]
}

@test "22: CamelCase join" {
  run ./demo8 <<EOF
Camel
Case
EOF
  [[ "$output" == *"Concatenated string: CamelCase"* ]]
}

@test "23: Join with dot" {
  run ./demo8 <<EOF
version
2
EOF
  [[ "$output" == *"Concatenated string: version2"* ]]
}

@test "24: Hexadecimal strings" {
  run ./demo8 <<EOF
0x
FF
EOF
  [[ "$output" == *"Concatenated string: 0xFF"* ]]
}

@test "25: Binary strings" {
  run ./demo8 <<EOF
1010
0101
EOF
  [[ "$output" == *"Concatenated string: 10100101"* ]]
}

@test "26: S1 ends in digit, S2 starts in digit" {
  run ./demo8 <<EOF
Area5
1
EOF
  [[ "$output" == *"Concatenated string: Area51"* ]]
}

@test "27: Mathematical symbols" {
  run ./demo8 <<EOF
x+y
=z
EOF
  [[ "$output" == *"Concatenated string: x+y=z"* ]]
}

@test "28: Abbreviation join" {
  run ./demo8 <<EOF
U
SA
EOF
  [[ "$output" == *"Concatenated string: USA"* ]]
}

@test "29: Escape-like characters" {
  run ./demo8 <<EOF
back
slash
EOF
  [[ "$output" == *"Concatenated string: backslash"* ]]
}

@test "30: Large buffer test" {
  run ./demo8 <<EOF
ThisIsExactlyThirtyCharacters-
AndThisIsTheSecondPartOfIt-
EOF
  [[ "$output" == *"Concatenated string: ThisIsExactlyThirtyCharacters-AndThisIsTheSecondPartOfIt-"* ]]
}