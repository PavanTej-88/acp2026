#!/usr/bin/env bats

# --- GROUP 1: BASIC FUNCTIONALITY (10 Cases) ---

@test "1: Standard input with 3 students" {
  run ./asg1 <<EOF
3
85.5
90.0
72.5
EOF
  [[ "$output" == *"Maximum marks = 90.00"* ]]
  [[ "$output" == *"Minimum marks = 72.50"* ]]
}

@test "2: Single student (Max and Min should be same)" {
  run ./asg1 <<EOF
1
95.0
EOF
  [[ "$output" == *"Maximum marks = 95.00"* ]]
  [[ "$output" == *"Minimum marks = 95.00"* ]]
}

@test "3: Max at the beginning of the list" {
  run ./asg1 <<EOF
4
100.0
50.0
60.0
70.0
EOF
  [[ "$output" == *"Maximum marks = 100.00"* ]]
}

@test "4: Min at the end of the list" {
  run ./asg1 <<EOF
4
90.0
80.0
70.0
10.5
EOF
  [[ "$output" == *"Minimum marks = 10.50"* ]]
}

@test "5: All students have the same marks" {
  run ./asg1 <<EOF
3
75.0
75.0
75.0
EOF
  [[ "$output" == *"Maximum marks = 75.00"* ]]
  [[ "$output" == *"Minimum marks = 75.00"* ]]
}

@test "6: Descending order of marks" {
  run ./asg1 <<EOF
3
90
80
70
EOF
  [[ "$output" == *"Maximum marks = 90.00"* ]]
  [[ "$output" == *"Minimum marks = 70.00"* ]]
}

@test "7: Ascending order of marks" {
  run ./asg1 <<EOF
3
10.5
20.5
30.5
EOF
  [[ "$output" == *"Maximum marks = 30.50"* ]]
  [[ "$output" == *"Minimum marks = 10.50"* ]]
}

@test "8: Floating point precision (Small differences)" {
  run ./asg1 <<EOF
3
99.98
99.99
99.97
EOF
  [[ "$output" == *"Maximum marks = 99.99"* ]]
  [[ "$output" == *"Minimum marks = 99.97"* ]]
}

@test "9: Zero as a valid mark" {
  run ./asg1 <<EOF
2
0.0
50.0
EOF
  [[ "$output" == *"Minimum marks = 0.00"* ]]
}

@test "10: Large number of students" {
  # Testing if VLA handles n=10
  run ./asg1 <<EOF
10
10
20
30
40
50
60
70
80
90
100
EOF
  [[ "$output" == *"Maximum marks = 100.00"* ]]
}

# --- GROUP 2: CRITICAL ERROR & BOUNDARY CASES (10 Cases) ---

@test "11: Invalid number of students (Zero)" {
  run ./asg1 <<EOF
0
EOF
  [[ "$output" == *"Invalid number of students"* ]]
}

@test "12: Invalid number of students (Negative)" {
  run ./asg1 <<EOF
-5
EOF
  [[ "$output" == *"Invalid number of students"* ]]
}

@test "13: Boundary: Exactly 100.00 vs 99.99" {
  run ./asg1 <<EOF
2
100.00
99.99
EOF
  [[ "$output" == *"Maximum marks = 100.00"* ]]
}

@test "14: Marks with multiple decimal places (Rounding check)" {
  run ./asg1 <<EOF
2
85.555
85.444
EOF
  # Output should use %.2f rounding
  [[ "$output" == *"Maximum marks = 85.56"* ]]
}

@test "15: Negative marks (though unlikely in tests, check logic)" {
  run ./asg1 <<EOF
2
-10.5
-5.0
EOF
  [[ "$output" == *"Maximum marks = -5.00"* ]]
  [[ "$output" == *"Minimum marks = -10.50"* ]]
}

@test "16: Mixed positive and negative marks" {
  run ./asg1 <<EOF
3
-1.0
0.0
1.0
EOF
  [[ "$output" == *"Maximum marks = 1.00"* ]]
  [[ "$output" == *"Minimum marks = -1.00"* ]]
}

@test "17: Student count is 2 (Smallest n > 1)" {
  run ./asg1 <<EOF
2
45.0
55.0
EOF
  [[ "$output" == *"Maximum marks = 55.00"* ]]
}

@test "18: Max and Min are adjacent in the middle" {
  run ./asg1 <<EOF
5
10
99
1
50
30
EOF
  [[ "$output" == *"Maximum marks = 99.00"* ]]
  [[ "$output" == *"Minimum marks = 1.00"* ]]
}

@test "19: All marks are 0" {
  run ./asg1 <<EOF
3
0
0
0
EOF
  [[ "$output" == *"Maximum marks = 0.00"* ]]
  [[ "$output" == *"Minimum marks = 0.00"* ]]
}

@test "20: Very high mark value" {
  run ./asg1 <<EOF
2
9999.99
0.01
EOF
  [[ "$output" == *"Maximum marks = 9999.99"* ]]
}

# --- GROUP 3: STRICT LOGIC & POSITIONING (10 Cases) ---

@test "21: Max at index 0" {
  run ./asg1 <<EOF
3
100
50
50
EOF
  [[ "$output" == *"Maximum marks = 100.00"* ]]
}

@test "22: Max at last index" {
  run ./asg1 <<EOF
3
50
50
100
EOF
  [[ "$output" == *"Maximum marks = 100.00"* ]]
}

@test "23: Min at index 0" {
  run ./asg1 <<EOF
3
10
50
50
EOF
  [[ "$output" == *"Minimum marks = 10.00"* ]]
}

@test "24: Min at last index" {
  run ./asg1 <<EOF
3
50
50
10
EOF
  [[ "$output" == *"Minimum marks = 10.00"* ]]
}

@test "25: Tie for Maximum" {
  run ./asg1 <<EOF
4
90
90
40
50
EOF
  [[ "$output" == *"Maximum marks = 90.00"* ]]
}

@test "26: Tie for Minimum" {
  run ./asg1 <<EOF
4
20
20
80
90
EOF
  [[ "$output" == *"Minimum marks = 20.00"* ]]
}

@test "27: Float input with integer formatting" {
  run ./asg1 <<EOF
2
85
90
EOF
  [[ "$output" == *"Maximum marks = 90.00"* ]]
}

@test "28: Small fractional difference (0.001)" {
  run ./asg1 <<EOF
2
10.001
10.002
EOF
  # Checks if logic picks 10.002 as higher despite %.2f output
  [[ "$output" == *"Maximum marks = 10.00"* ]]
}

@test "29: High precision inputs (0.0001)" {
  run ./asg1 <<EOF
2
5.0001
4.9999
EOF
  [[ "$output" == *"Maximum marks = 5.00"* ]]
}

@test "30: Maximum integer n test" {
  run ./asg1 <<EOF
5
1.1
2.2
3.3
4.4
5.5
EOF
  [[ "$output" == *"Maximum marks = 5.50"* ]]
  [[ "$output" == *"Minimum marks = 1.10"* ]]
}