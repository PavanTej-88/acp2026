#!/usr/bin/env bats

# --- Group 1: Basic Swapping ---

@test "Success: Swap two arrays of size 3" {
run ./demo5 <<EOF
3
1
2
3
10
20
30
EOF
[[ "$output" == *"Elements of array 1 after swapping:"* ]]
[[ "$output" == *"10	20	30"* ]]
[[ "$output" == *"Elements of array 2 after swapping:"* ]]
[[ "$output" == *"1	2	3"* ]]
}

@test "Success: Swap two arrays of size 1 (Boundary)" {
run ./demo5 <<EOF
1
99
11
EOF
[[ "$output" == *"Elements of array 1 after swapping:"* ]]
[[ "$output" == *"11"* ]]
[[ "$output" == *"Elements of array 2 after swapping:"* ]]
[[ "$output" == *"99"* ]]
}

# --- Group 2: Numerical Edge Cases ---

@test "Success: Swap arrays with negative numbers" {
run ./demo5 <<EOF
2
-1
-5
100
500
EOF
[[ "$output" == *"Elements of array 1 after swapping:"* ]]
[[ "$output" == *"100	500"* ]]
[[ "$output" == *"Elements of array 2 after swapping:"* ]]
[[ "$output" == *"-1	-5"* ]]
}

@test "Success: Swap arrays containing zeros" {
run ./demo5 <<EOF
2
0
0
7
8
EOF
[[ "$output" == *"Elements of array 1 after swapping:"* ]]
[[ "$output" == *"7	8"* ]]
[[ "$output" == *"Elements of array 2 after swapping:"* ]]
[[ "$output" == *"0	0"* ]]
}

# --- Group 3: Logic & Identity ---

@test "Success: Swap two identical arrays" {
run ./demo5 <<EOF
2
5
5
5
5
EOF
# If both are same, they should still appear identical after swap
[[ "$output" == *"Elements of array 1 after swapping:"* ]]
[[ "$output" == *"5	5"* ]]
[[ "$output" == *"Elements of array 2 after swapping:"* ]]
[[ "$output" == *"5	5"* ]]
}

@test "Success: Swap arrays where one is all same values" {
run ./demo5 <<EOF
3
1
1
1
9
8
7
EOF
[[ "$output" == *"9	8	7"* ]]
[[ "$output" == *"1	1	1"* ]]
}

# --- Group 4: Large Size/Values ---

@test "Success: Larger array size (n=5)" {
run ./demo5 <<EOF
5
1
2
3
4
5
6
7
8
9
10
EOF
[[ "$output" == *"6	7	8	9	10"* ]]
[[ "$output" == *"1	2	3	4	5"* ]]
}

@test "Success: Large integer values" {
run ./demo5 <<EOF
2
1000000
2000000
3000000
4000000
EOF
[[ "$output" == *"3000000	4000000"* ]]
[[ "$output" == *"1000000	2000000"* ]]
}
