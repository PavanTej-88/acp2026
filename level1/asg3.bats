#!/usr/bin/env bats

# --- GROUP 1: BASIC ARRAY LOGIC (10 Cases) ---

@test "1: Two floors, second is higher" {
  run ./asg3 <<EOF
2
10 10 2
20 20 2
EOF
  [[ "$output" == *"Floor 2 has highest cost"* ]]
  [[ "$output" == *"Total cost = 800.00"* ]]
}

@test "2: Three floors, first is higher" {
  run ./asg3 <<EOF
3
50 50 1
10 10 1
5 5 1
EOF
  [[ "$output" == *"Floor 1 has highest cost"* ]]
  [[ "$output" == *"Total cost = 2500.00"* ]]
}

@test "3: Single floor (Highest is itself)" {
  run ./asg3 <<EOF
1
12 10 5
EOF
  [[ "$output" == *"Floor 1 has highest cost"* ]]
  [[ "$output" == *"Area = 120.00"* ]]
  [[ "$output" == *"Total cost = 600.00"* ]]
}

@test "4: Highest cost floor in the middle of five" {
  run ./asg3 <<EOF
5
1 1 1
2 2 2
50 50 10
3 3 3
4 4 4
EOF
  [[ "$output" == *"Floor 3 has highest cost"* ]]
}

@test "5: All floors have identical costs" {
  run ./asg3 <<EOF
3
10 10 1
10 10 1
10 10 1
EOF
  # Since your loop uses '>', it should pick the first index (Floor 1)
  [[ "$output" == *"Floor 1 has highest cost"* ]]
}

@test "6: Different dimensions, same total cost" {
  run ./asg3 <<EOF
2
10 10 1
20 5 1
EOF
  [[ "$output" == *"Floor 1 has highest cost"* ]]
}

@test "7: Floating point dimensions" {
  run ./asg3 <<EOF
2
10.5 10.5 1
5 5 1
EOF
  [[ "$output" == *"Area = 110.25"* ]]
}

@test "8: Small dimensions, large cost per unit" {
  run ./asg3 <<EOF
2
1 1 5000
10 10 1
EOF
  [[ "$output" == *"Floor 1 has highest cost"* ]]
  [[ "$output" == *"Total cost = 5000.00"* ]]
}

@test "9: Decimal cost per unit" {
  run ./asg3 <<EOF
2
10 10 1.55
10 10 1.54
EOF
  [[ "$output" == *"Total cost = 155.00"* ]]
}

@test "10: Large number of floors (10)" {
  run ./asg3 <<EOF
10
1 1 1
1 1 1
1 1 1
1 1 1
10 10 10
1 1 1
1 1 1
1 1 1
1 1 1
1 1 1
EOF
  [[ "$output" == *"Floor 5 has highest cost"* ]]
}

# --- GROUP 2: ERROR HANDLING & BOUNDARIES (10 Cases) ---

@test "11: Invalid floors (Zero)" {
  run ./asg3 <<EOF
0
EOF
  [[ "$output" == *"Invalid number of floors"* ]]
}

@test "12: Invalid floors (Negative)" {
  run ./asg3 <<EOF
-5
EOF
  [[ "$output" == *"Invalid number of floors"* ]]
}

@test "13: Zero dimensions (Cost 0)" {
  run ./asg3 <<EOF
2
0 0 10
1 1 1
EOF
  [[ "$output" == *"Floor 2 has highest cost"* ]]
}

@test "14: Cost per unit is zero" {
  run ./asg3 <<EOF
2
100 100 0
5 5 1
EOF
  [[ "$output" == *"Floor 2 has highest cost"* ]]
}

@test "15: Area calculation check" {
  run ./asg3 <<EOF
1
12.5 2
10
EOF
  [[ "$output" == *"Area = 25.00"* ]]
  [[ "$output" == *"Total cost = 250.00"* ]]
}

@test "16: High precision difference" {
  run ./asg3 <<EOF
2
10 10 1.0001
10 10 1.0000
EOF
  [[ "$output" == *"Floor 1 has highest cost"* ]]
}

@test "17: Large float values" {
  run ./asg3 <<EOF
2
1000 1000 1000
1 1 1
EOF
  [[ "$output" == *"Total cost = 1000000000.00"* ]]
}

@test "18: Descending costs" {
  run ./asg3 <<EOF
3
30 1 1
20 1 1
10 1 1
EOF
  [[ "$output" == *"Floor 1 has highest cost"* ]]
}

@test "19: Ascending costs" {
  run ./asg3 <<EOF
3
10 1 1
20 1 1
30 1 1
EOF
  [[ "$output" == *"Floor 3 has highest cost"* ]]
}

@test "20: Tie between first and last" {
  run ./asg3 <<EOF
3
100 1 1
50 1 1
100 1 1
EOF
  [[ "$output" == *"Floor 1 has highest cost"* ]]
}

# --- GROUP 3: STRICT OUTPUT & FORMATTING (10 Cases) ---

@test "21: Check 'Length =' output label" {
  run ./asg3 <<EOF
1
10 5 2
EOF
  [[ "$output" == *"Length = 10.00"* ]]
}

@test "22: Check 'Width =' output label" {
  run ./asg3 <<EOF
1
10 5 2
EOF
  [[ "$output" == *"Width = 5.00"* ]]
}

@test "23: Check 'Area =' output label" {
  run ./asg3 <<EOF
1
10 5 2
EOF
  [[ "$output" == *"Area = 50.00"* ]]
}

@test "24: Check 'Total cost =' label" {
  run ./asg3 <<EOF
1
10 5 2
EOF
  [[ "$output" == *"Total cost = 100.00"* ]]
}

@test "25: Floor indexing (1-based check)" {
  run ./asg3 <<EOF
2
1 1 1
10 10 10
EOF
  # Should say Floor 2, not Floor 1 (if 0-based error)
  [[ "$output" == *"Floor 2 has highest cost"* ]]
}

@test "26: Rounding check (.555)" {
  run ./asg3 <<EOF
1
1 1 10.555
EOF
  [[ "$output" == *"Total cost = 10.56"* ]]
}

@test "27: Multiple floors, max cost tie at end" {
  run ./asg3 <<EOF
4
1 1 1
1 1 1
50 50 1
50 50 1
EOF
  [[ "$output" == *"Floor 3 has highest cost"* ]]
}

@test "28: Inputs with leading zeros" {
  run ./asg3 <<EOF
2
05 05 02
01 01 01
EOF
  [[ "$output" == *"Total cost = 50.00"* ]]
}

@test "29: Minimum student count (1)" {
  run ./asg3 <<EOF
1
5 5 5
EOF
  [[ "$output" == *"Floor 1 has highest cost"* ]]
}

@test "30: Maximum integer input check" {
  run ./asg3 <<EOF
2
100 100 100
99 99 99
EOF
  [[ "$output" == *"Floor 1 has highest cost"* ]]
}