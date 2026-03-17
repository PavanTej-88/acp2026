#!/usr/bin/env bats

# --- Group 1: Positional Tests (Where is the Max?) ---

@test "Max at first position (Index 0)" {
run ./demo3 <<EOF
3
50.0
2.0
5.0
5.0
2.0
2.0
EOF
[[ "$output" == *"Area of largest rectangle= 100.00"* ]]
[[ "$output" == *"Length of largest rectangle= 50.00"* ]]
}

@test "Max at middle position" {
run ./demo3 <<EOF
3
2.0
2.0
10.0
10.0
5.0
5.0
EOF
[[ "$output" == *"Area of largest rectangle= 100.00"* ]]
[[ "$output" == *"Length of largest rectangle= 10.00"* ]]
}

@test "Max at last position (Index n-1)" {
run ./demo3 <<EOF
4
1.0
1.0
2.0
2.0
3.0
3.0
20.0
5.0
EOF
[[ "$output" == *"Area of largest rectangle= 100.00"* ]]
[[ "$output" == *"Breadth of largest rectangle= 5.00"* ]]
}

# --- Group 2: Array Size Edge Cases ---

@test "Single rectangle (n=1)" {
run ./demo3 <<EOF
1
12.5
4.0
EOF
[[ "$output" == *"Area of largest rectangle= 50.00"* ]]
}

@test "Two rectangles (n=2)" {
run ./demo3 <<EOF
2
5.0
5.0
10.0
10.0
EOF
[[ "$output" == *"Area of largest rectangle= 100.00"* ]]
}

# --- Group 3: Ties and Equality ---

@test "Tie: Returns the first occurrence of the max" {
# Both Rect 1 and Rect 2 have Area 50. 
# Your code (r[i].a > r[index].a) stays on the first one found.
run ./demo3 <<EOF
3
25.0
2.0
10.0
5.0
1.0
1.0
EOF
[[ "$output" == *"Length of largest rectangle= 25.00"* ]]
[[ "$output" == *"Area of largest rectangle= 50.00"* ]]
}

@test "All rectangles are identical" {
run ./demo3 <<EOF
3
4.0
4.0
4.0
4.0
4.0
4.0
EOF
[[ "$output" == *"Area of largest rectangle= 16.00"* ]]
}

# --- Group 4: Numerical Precision ---

@test "Floating point precision check" {
run ./demo3 <<EOF
2
10.001
10.0
10.0
10.0
EOF
[[ "$output" == *"Area of largest rectangle= 100.01"* ]]
}

@test "Large values" {
run ./demo3 <<EOF
2
5000.0
2000.0
10.0
10.0
EOF
[[ "$output" == *"Area of largest rectangle= 10000000.00"* ]]
}