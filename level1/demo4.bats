#!/usr/bin/env bats

# --- Group 1: Successful Search Scenarios ---

@test "Search: Destination exists at the first position (Index 0)" {
run ./demo4 <<EOF
AI101
NewYork
150
AI202
London
200
AI303
Paris
100
AI404
Tokyo
50
NewYork
EOF
[[ "$output" == *"Flight number AI101 is available to your destination"* ]]
}

@test "Search: Destination exists in the middle (Index 2)" {
run ./demo4 <<EOF
AI101
NewYork
150
AI202
London
200
AI303
Paris
100
AI404
Tokyo
50
Paris
EOF
[[ "$output" == *"Flight number AI303 is available to your destination"* ]]
}

@test "Search: Destination exists at the last position (Index 3)" {
run ./demo4 <<EOF
F1
Dubai
10
F2
Mumbai
20
F3
Delhi
30
F4
Singapore
40
Singapore
EOF
[[ "$output" == *"Flight number F4 is available to your destination"* ]]
}

# --- Group 2: Failure Scenarios ---

@test "Search: Destination does not exist in the list" {
run ./demo4 <<EOF
AI101
NewYork
150
AI202
London
200
AI303
Paris
100
AI404
Tokyo
50
Berlin
EOF
[[ "$output" == *"No flights for your destination"* ]]
}

# --- Group 3: Edge Cases ---

@test "Search: Case sensitivity check (Lowercase vs Uppercase)" {
# C's strcmp() is case-sensitive. "newyork" != "NewYork"
run ./demo4 <<EOF
AI101
NewYork
150
AI202
London
200
AI303
Paris
100
AI404
Tokyo
50
newyork
EOF
[[ "$output" == *"No flights for your destination"* ]]
}

@test "Search: Multiple matches (Should return only the first one found)" {
run ./demo4 <<EOF
FLIGHT1
London
10
FLIGHT2
London
20
FLIGHT3
Paris
30
FLIGHT4
Tokyo
40
London
EOF
# Your code uses 'return' after the first match, so it should NOT show FLIGHT2
[[ "$output" == *"Flight number FLIGHT1 is available to your destination"* ]]
[[ "$output" != *"Flight number FLIGHT2"* ]]
}

@test "Search: Handling numeric destination names" {
run ./demo4 <<EOF
FL1
12345
10
FL2
67890
20
FL3
13579
30
FL4
24680
40
13579
EOF
[[ "$output" == *"Flight number FL3 is available to your destination"* ]]
}

@test "Search: Empty string or space check (Partial Input)" {
# Testing if the program handles a simple string match correctly
run ./demo4 <<EOF
A
B
1
C
D
2
E
F
3
G
H
4
F
EOF
[[ "$output" == *"Flight number E is available to your destination"* ]]
}