#!/usr/bin/env bats

@test "test case 1" {
run ./demo1 <<EOF
3
1.2
5.6
2.4
EOF
[[ "$output" == *"Maximum value in the array is 5.60 at index 1"* ]]
}

@test "test case 2" {
run ./demo1 <<EOF
4
2.5
9.1
3.7
8.0
EOF
[[ "$output" == *"Maximum value in the array is 9.10 at index 1"* ]]
}

@test "test case 3" {
run ./demo1 <<EOF
2
-1.5
-0.5
EOF
[[ "$output" == *"Maximum value in the array is -0.50 at index 1"* ]]
}

@test "test case 4: max at first index" {
run ./demo1 <<EOF
3
9.9
3.3
1.1
EOF
[[ "$output" == *"Maximum value in the array is 9.90 at index 0"* ]]
}

@test "test case 5: max at last index" {
run ./demo1 <<EOF
4
1.0
2.0
3.0
4.0
EOF
[[ "$output" == *"Maximum value in the array is 4.00 at index 3"* ]]
}

@test "test case 6: single element" {
run ./demo1 <<EOF
1
7.5
EOF
[[ "$output" == *"Maximum value in the array is 7.50 at index 0"* ]]
}

@test "test case 7: all equal values" {
run ./demo1 <<EOF
3
5.0
5.0
5.0
EOF
[[ "$output" == *"Maximum value in the array is 5.00 at index 0"* ]]
}

@test "test case 8: all negative values" {
run ./demo1 <<EOF
3
-3.0
-1.0
-2.0
EOF
[[ "$output" == *"Maximum value in the array is -1.00 at index 1"* ]]
}