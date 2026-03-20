#!/usr/bin/env bats

# --- GROUP 1: BASIC VOWEL/CONSONANT COUNTING (10 Cases) ---

@test "1: Simple lowercase word" {
  run ./act8 <<EOF
apple
EOF
  [[ "$output" == *"Number of vowels in apple = 2"* ]]
  [[ "$output" == *"Number of consonants in apple = 3"* ]]
}

@test "2: Simple uppercase word" {
  run ./act8 <<EOF
BANANA
EOF
  [[ "$output" == *"Number of vowels in BANANA = 3"* ]]
  [[ "$output" == *"Number of consonants in BANANA = 3"* ]]
}

@test "3: Mixed case word" {
  run ./act8 <<EOF
iNteRneT
EOF
  [[ "$output" == *"Number of vowels in iNteRneT = 3"* ]]
  [[ "$output" == *"Number of consonants in iNteRneT = 5"* ]]
}

@test "4: All vowels (Lowercase)" {
  run ./act8 <<EOF
aeiou
EOF
  [[ "$output" == *"Number of vowels in aeiou = 5"* ]]
  [[ "$output" == *"Number of consonants in aeiou = 0"* ]]
}

@test "5: All vowels (Uppercase)" {
  run ./act8 <<EOF
AEIOU
EOF
  [[ "$output" == *"Number of vowels in AEIOU = 5"* ]]
  [[ "$output" == *"Number of consonants in AEIOU = 0"* ]]
}

@test "6: All consonants (Lowercase)" {
  run ./act8 <<EOF
rhythm
EOF
  [[ "$output" == *"Number of vowels in rhythm = 0"* ]]
  [[ "$output" == *"Number of consonants in rhythm = 6"* ]]
}

@test "7: All consonants (Uppercase)" {
  run ./act8 <<EOF
STRENGTH
EOF
  [[ "$output" == *"Number of vowels in STRENGTH = 1"* ]]
  [[ "$output" == *"Number of consonants in STRENGTH = 7"* ]]
}

@test "8: Single vowel" {
  run ./act8 <<EOF
a
EOF
  [[ "$output" == *"Number of vowels in a = 1"* ]]
  [[ "$output" == *"Number of consonants in a = 0"* ]]
}

@test "9: Single consonant" {
  run ./act8 <<EOF
z
EOF
  [[ "$output" == *"Number of vowels in z = 0"* ]]
  [[ "$output" == *"Number of consonants in z = 1"* ]]
}

@test "10: Long alphanumeric string" {
  run ./act8 <<EOF
Engineering2026
EOF
  [[ "$output" == *"Number of vowels in Engineering2026 = 5"* ]]
  [[ "$output" == *"Number of consonants in Engineering2026 = 6"* ]]
}

# --- GROUP 2: CRITICAL EDGE CASES (Non-Alphabetic) (10 Cases) ---

@test "11: Only digits" {
  run ./act8 <<EOF
123456789
EOF
  [[ "$output" == *"Number of vowels in 123456789 = 0"* ]]
  [[ "$output" == *"Number of consonants in 123456789 = 0"* ]]
}

@test "12: Only special characters" {
  run ./act8 <<EOF
@#$%^&*()
EOF
  [[ "$output" == *"Number of vowels in @#$%^&*() = 0"* ]]
  [[ "$output" == *"Number of consonants in @#$%^&*() = 0"* ]]
}
@test "13: Mixed letters and symbols" {
  run ./act8 <<EOF
A!b@e#i^
EOF
  [[ "$output" == *"Number of vowels in A!b@e#i^ = 3"* ]]
  [[ "$output" == *"Number of consonants in A!b@e#i^ = 1"* ]]
}

@test "14: Zero/Null string behavior" {
  # Scanf %s needs input; providing a dot as a placeholder
  run ./act8 <<EOF
.
EOF
  [[ "$output" == *"Number of vowels in . = 0"* ]]
  [[ "$output" == *"Number of consonants in . = 0"* ]]
}

@test "15: Vowels at start and end" {
  run ./act8 <<EOF
area
EOF
  [[ "$output" == *"Number of vowels in area = 3"* ]]
}

@test "16: Consonants at start and end" {
  run ./act8 <<EOF
trust
EOF
  [[ "$output" == *"Number of consonants in trust = 4"* ]]
}

@test "17: Y as a vowel/consonant (In English 'y' is a consonant in C logic)" {
  run ./act8 <<EOF
sky
EOF
  [[ "$output" == *"Number of vowels in sky = 0"* ]]
  [[ "$output" == *"Number of consonants in sky = 3"* ]]
}

@test "18: Path with symbols" {
  run ./act8 <<EOF
/usr/bin/gcc
EOF
  [[ "$output" == *"Number of vowels in /usr/bin/gcc = 2"* ]]
  [[ "$output" == *"Number of consonants in /usr/bin/gcc = 7"* ]]
}

@test "19: Repetitive vowels" {
  run ./act8 <<EOF
aaaaaeeeee
EOF
  [[ "$output" == *"Number of vowels in aaaaaeeeee = 10"* ]]
}

@test "20: Repetitive consonants" {
  run ./act8 <<EOF
zzzzzyyyyy
EOF
  [[ "$output" == *"Number of consonants in zzzzzyyyyy = 10"* ]]
}

# --- GROUP 3: STRICT BOUNDARY & SYSTEM STRESS (10 Cases) ---

@test "21: Maximum buffer length (99 chars)" {
  # 50 'a's and 49 'b's
  STR="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
  run ./act8 <<EOF
$STR
EOF
  [[ "$output" == *"Number of vowels in $STR = 50"* ]]
  [[ "$output" == *"Number of consonants in $STR = 49"* ]]
}

@test "22: Scanf whitespace check (Should stop at space)" {
  run ./act8 <<EOF
hello world
EOF
  # Only 'hello' should be processed
  [[ "$output" == *"Number of vowels in hello = 2"* ]]
  [[ "$output" == *"Number of consonants in hello = 3"* ]]
}

@test "23: String ending in a number" {
  run ./act8 <<EOF
Pavantej01
EOF
  [[ "$output" == *"Number of vowels in Pavantej01 = 3"* ]]
  [[ "$output" == *"Number of consonants in Pavantej01 = 5"* ]]
}

@test "24: Mixed case AEIOU variations" {
  run ./act8 <<EOF
aEiOu
EOF
  [[ "$output" == *"Number of vowels in aEiOu = 5"* ]]
}

@test "25: Check 'y' and 'w' (Strict consonant check)" {
  run ./act8 <<EOF
yellow
EOF
  [[ "$output" == *"Number of vowels in yellow = 2"* ]]
  [[ "$output" == *"Number of consonants in yellow = 4"* ]]
}

@test "26: Punctuation at the end" {
  run ./act8 <<EOF
Wow!
EOF
  [[ "$output" == *"Number of vowels in Wow! = 1"* ]]
  [[ "$output" == *"Number of consonants in Wow! = 2"* ]]
}

@test "27: Empty-looking dots" {
  run ./act8 <<EOF
...
EOF
  [[ "$output" == *"Number of vowels in ... = 0"* ]]
  [[ "$output" == *"Number of consonants in ... = 0"* ]]
}

@test "28: Very long string with no vowels" {
  run ./act8 <<EOF
bcdfg-hjklm-npqrst-vwxyz
EOF
  [[ "$output" == *"Number of vowels in bcdfg-hjklm-npqrst-vwxyz = 0"* ]]
}

@test "29: Very long string with no consonants" {
  run ./act8 <<EOF
aeiouaeiouaeiouaeiou
EOF
  [[ "$output" == *"Number of consonants in aeiouaeiouaeiouaeiou = 0"* ]]
}

@test "30: Lowercase-Uppercase boundary test" {
  run ./act8 <<EOF
aAzZ
EOF
  [[ "$output" == *"Number of vowels in aAzZ = 2"* ]]
  [[ "$output" == *"Number of consonants in aAzZ = 2"* ]]
}