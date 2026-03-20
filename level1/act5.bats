#!/usr/bin/env bats

# --- GROUP 1: STANDARD SWAPPING (10 Cases) ---

@test "1: Equal length words" {
  run ./act5 <<EOF
10
10
apple
lemon
EOF
  [[ "$output" == *"Strings after swapping:"* ]]
  [[ "$output" == *"lemon"* ]]
  [[ "$output" == *"apple"* ]]
}

@test "2: Single character strings" {
  run ./act5 <<EOF
2
2
A
B
EOF
  [[ "$output" == *"B"* ]]
  [[ "$output" == *"A"* ]]
}

@test "3: Numeric strings" {
  run ./act5 <<EOF
10
10
12345
67890
EOF
  [[ "$output" == *"67890"* ]]
  [[ "$output" == *"12345"* ]]
}

@test "4: Special character strings" {
  run ./act5 <<EOF
10
10
#@!
$%^
EOF
  [[ "$output" == *"$%^"* ]]
  [[ "$output" == *"#@!"* ]]
}

@test "5: Mixed case strings" {
  run ./act5 <<EOF
10
10
HELLO
world
EOF
  [[ "$output" == *"world"* ]]
  [[ "$output" == *"HELLO"* ]]
}

@test "6: Identical strings" {
  run ./act5 <<EOF
10
10
same
same
EOF
  [[ "$output" == *"same"* ]]
}

@test "7: Alphanumeric swap" {
  run ./act5 <<EOF
10
10
user1
pass2
EOF
  [[ "$output" == *"pass2"* ]]
  [[ "$output" == *"user1"* ]]
}

@test "8: Long word swap (within size)" {
  run ./act5 <<EOF
30
30
Programming
Engineering
EOF
  [[ "$output" == *"Engineering"* ]]
  [[ "$output" == *"Programming"* ]]
}

@test "9: Path simulation" {
  run ./act5 <<EOF
20
20
/usr/bin
/home/pav
EOF
  [[ "$output" == *"/home/pav"* ]]
  [[ "$output" == *"/usr/bin"* ]]
}

@test "10: Swap involving dots" {
  run ./act5 <<EOF
5
5
...
---
EOF
  [[ "$output" == *"---"* ]]
  [[ "$output" == *"..."* ]]
}

# --- GROUP 2: SIZE & LENGTH VARIATIONS (10 Cases) ---

@test "11: S1 shorter than S2 (Both fit in both sizes)" {
  run ./act5 <<EOF
20
20
cat
elephant
EOF
  [[ "$output" == *"elephant"* ]]
  [[ "$output" == *"cat"* ]]
}

@test "12: S1 longer than S2 (Both fit in both sizes)" {
  run ./act5 <<EOF
20
20
crocodile
dog
EOF
  [[ "$output" == *"dog"* ]]
  [[ "$output" == *"crocodile"* ]]
}

@test "13: Size input is 2 (Min for 1 char + \0)" {
  run ./act5 <<EOF
2
2
x
y
EOF
  [[ "$output" == *"y"* ]]
  [[ "$output" == *"x"* ]]
}

@test "14: Exact boundary match (Size 6 for 5 chars)" {
  run ./act5 <<EOF
6
6
abcde
12345
EOF
  [[ "$output" == *"12345"* ]]
  [[ "$output" == *"abcde"* ]]
}

@test "15: Different allocated sizes, same string length" {
  run ./act5 <<EOF
10
50
hello
world
EOF
  [[ "$output" == *"world"* ]]
  [[ "$output" == *"hello"* ]]
}

# --- GROUP 3: CRITICAL EDGE CASES & ERRORS (10 Cases) ---

@test "16: Memory stress: S2 larger than S1 allocation" {
  # This is a critical test. str1 is size 5, str2 is size 20. 
  # Swapping 'elephant' (8 chars) into str1 (size 5) usually causes an error.
  run ./act5 <<EOF
5
20
hi
elephant
EOF
  # If the program survives, it should show the swap
  [[ "$output" == *"elephant"* ]]
}

@test "17: Truncation/Overflow check: S1 larger than S2 allocation" {
  run ./act5 <<EOF
20
5
alligator
bye
EOF
  [[ "$output" == *"bye"* ]]
}

@test "18: Empty input simulation" {
  # Note: scanf %s skips whitespace/newlines, so we provide single chars
  run ./act5 <<EOF
5
5
a
b
EOF
  [[ "$output" == *"b"* ]]
}

@test "19: Zero size input" {
  # Edge case: how does your VLA char str1[n1] handle 0?
  run ./act5 <<EOF
0
0
EOF
  [ "$status" -eq 0 ]
}

@test "20: Very large size input" {
  run ./act5 <<EOF
1000
1000
test1
test2
EOF
  [[ "$output" == *"test2"* ]]
}

@test "21: Repeating character strings" {
  run ./act5 <<EOF
10
10
aaaaa
bbbbb
EOF
  [[ "$output" == *"bbbbb"* ]]
}

@test "22: Strings with backslashes" {
  run ./act5 <<EOF
10
10
a\\b
c\\d
EOF
  [[ "$output" == *"c\\d"* ]]
}

@test "23: Numerical string vs Alphabetical string" {
  run ./act5 <<EOF
10
10
123
abc
EOF
  [[ "$output" == *"abc"* ]]
  [[ "$output" == *"123"* ]]
}

@test "24: Mixed alphanumeric and symbols" {
  run ./act5 <<EOF
15
15
user@123
pass#456
EOF
  [[ "$output" == *"pass#456"* ]]
}

@test "25: Check 'before' vs 'after' headers" {
  run ./act5 <<EOF
5
5
x
y
EOF
  [[ "$output" == *"Strings before swapping:"* ]]
  [[ "$output" == *"Strings after swapping:"* ]]
}

@test "26: Large size difference (10 vs 500)" {
  run ./act5 <<EOF
10
500
short
this_is_a_very_long_string_input_to_check_if_vla_handles_it
EOF
  [[ "$output" == *"this_is_a_very_long"* ]]
}

@test "27: Swap strings with '0' digits" {
  run ./act5 <<EOF
5
5
0
1
EOF
  [[ "$output" == *"1"* ]]
  [[ "$output" == *"0"* ]]
}

@test "28: Space-separated input (Scanf check)" {
  # Scanf %s stops at space. This tests if your program takes the next word.
  run ./act5 <<EOF
10
10
Hello World
EOF
  [[ "$output" == *"World"* ]]
}

@test "29: Alphabet sequence swap" {
  run ./act5 <<EOF
5
5
abc
xyz
EOF
  [[ "$output" == *"xyz"* ]]
}

@test "30: Maximum buffer capacity test" {
  run ./act5 <<EOF
100
100
the_quick_brown_fox_jumps_over_the_lazy_dog_1234567890
completely_different_string_to_ensure_no_memory_bleed
EOF
  [[ "$output" == *"completely_different"* ]]
}