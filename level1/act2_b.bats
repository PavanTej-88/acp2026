#!/usr/bin/env bats

# --- GROUP 1: THE "FREE SCHEME" BOUNDARY (Units < 50) ---

@test "1: Zero units (Free)" {
  run ./act2_b <<EOF
0
10.0
EOF
  [[ "$output" == *"Electricity Bill = 0.00"* ]]
  [[ "$output" == *"You are qualified for free unit scheme"* ]]
}

@test "2: Single unit (Free)" {
  run ./act2_b <<EOF
1
100.0
EOF
  [[ "$output" == *"Electricity Bill = 0.00"* ]]
}

@test "3: Boundary: 48 units (Free)" {
  run ./act2_b <<EOF
48
5.5
EOF
  [[ "$output" == *"Electricity Bill = 0.00"* ]]
}

@test "4: Boundary: 49 units (Last possible free unit)" {
  run ./act2_b <<EOF
49
20.0
EOF
  [[ "$output" == *"Electricity Bill = 0.00"* ]]
  [[ "$output" == *"You are qualified for free unit scheme"* ]]
}

# --- GROUP 2: THE "PAID" BOUNDARY (Units >= 50) ---

@test "5: Boundary: Exactly 50 units (First paid unit)" {
  run ./act2_b <<EOF
50
10.0
EOF
  [[ "$output" == *"Electricity Bill = 500.00"* ]]
  [[ ! "$output" == *"qualified for free unit scheme"* ]]
}

@test "6: Boundary: 51 units (Paid)" {
  run ./act2_b <<EOF
51
10.0
EOF
  [[ "$output" == *"Electricity Bill = 510.00"* ]]
}

@test "7: High consumption (500 units)" {
  run ./act2_b <<EOF
500
2.0
EOF
  [[ "$output" == *"Electricity Bill = 1000.00"* ]]
}

# --- GROUP 3: INPUT VALIDATION ERRORS (Negative Values) ---

@test "8: Error: Negative units (-1)" {
  run ./act2_b <<EOF
-1
EOF
  [[ "$output" == *"Invalid number of units"* ]]
}

@test "9: Error: Large negative units (-9999)" {
  run ./act2_b <<EOF
-9999
EOF
  [[ "$output" == *"Invalid number of units"* ]]
}

@test "10: Error: Negative rate (-5.0)" {
  run ./act2_b <<EOF
100
-5.0
EOF
  [[ "$output" == *"Invalid rate per unit"* ]]
}

@test "11: Error: Zero units but negative rate" {
  # Program should ask for rate even if units are 0 because 0 is not < 0
  run ./act2_b <<EOF
0
-1.0
EOF
  [[ "$output" == *"Invalid rate per unit"* ]]
}

# --- GROUP 4: FLOATING POINT & PRECISION ---

@test "12: Rate with high precision (3.333)" {
  run ./act2_b <<EOF
100
3.333
EOF
  [[ "$output" == *"Rate per unit = 3.33"* ]]
  [[ "$output" == *"Electricity Bill = 333.30"* ]]
}

@test "13: Rate with smallest positive decimal (0.01)" {
  run ./act2_b <<EOF
100
0.01
EOF
  [[ "$output" == *"Electricity Bill = 1.00"* ]]
}

@test "14: Large bill amount calculation" {
  run ./act2_b <<EOF
1000
99.99
EOF
  [[ "$output" == *"Electricity Bill = 99990.00"* ]]
}

@test "15: Paid units with zero rate" {
  run ./act2_b <<EOF
100
0.0
EOF
  [[ "$output" == *"Electricity Bill = 0.00"* ]]
  [[ ! "$output" == *"qualified for free unit scheme"* ]]
}

# --- GROUP 5: OUTPUT STRING VERIFICATION ---

@test "16: Verify summary header presence" {
  run ./act2_b <<EOF
10
5
EOF
  [[ "$output" == *"Electricity bill summary:"* ]]
}

@test "17: Verify units displayed correctly" {
  run ./act2_b <<EOF
77
5
EOF
  [[ "$output" == *"Number of units consumed = 77"* ]]
}

# --- GROUP 6: STRESS & LOGIC PERMUTATIONS ---

@test "18: Units = 49, Rate = 0" {
  run ./act2_b <<EOF
49
0
EOF
  [[ "$output" == *"Electricity Bill = 0.00"* ]]
  [[ "$output" == *"You are qualified"* ]]
}

@test "19: Units = 50, Rate = 0" {
  run ./act2_b <<EOF
50
0
EOF
  [[ "$output" == *"Electricity Bill = 0.00"* ]]
  [[ ! "$output" == *"You are qualified"* ]]
}

@test "20: Units = 49, Rate = 1000000" {
  run ./act2_b <<EOF
49
1000000
EOF
  [[ "$output" == *"Electricity Bill = 0.00"* ]]
}

@test "21: Units = 50, Rate = 0.001" {
  run ./act2_b <<EOF
50
0.001
EOF
  # %.2f will round 0.05 to 0.05
  [[ "$output" == *"Electricity Bill = 0.05"* ]]
}

@test "22: Units = 49, Rate = 0.001" {
  run ./act2_b <<EOF
49
0.001
EOF
  [[ "$output" == *"Electricity Bill = 0.00"* ]]
}

@test "23: High unit integer boundary" {
  run ./act2_b <<EOF
32767
1.0
EOF
  [[ "$output" == *"Electricity Bill = 32767.00"* ]]
}

@test "24: Decimal units input (Truncation test)" {
  # C scanf %d will take '45' from '45.9' and leave '.9' in buffer
  run ./act2_b <<EOF
45.9
10.0
EOF
  [[ "$output" == *"Number of units consumed = 45"* ]]
  [[ "$output" == *"Electricity Bill = 0.00"* ]]
}

@test "25: Units = 49.9 (Truncation test)" {
  run ./act2_b <<EOF
49
5.0
EOF
  [[ "$output" == *"qualified for free unit scheme"* ]]
}

@test "26: Rate = 12.3456 (Rounding test)" {
  run ./act2_b <<EOF
100
12.3456
EOF
  [[ "$output" == *"Rate per unit = 12.35"* ]]
}

@test "27: Units = 60, Rate = 1.5" {
  run ./act2_b <<EOF
60
1.5
EOF
  [[ "$output" == *"Electricity Bill = 90.00"* ]]
}

@test "28: Units = 40, Rate = 1.5" {
  run ./act2_b <<EOF
40
1.5
EOF
  [[ "$output" == *"Electricity Bill = 0.00"* ]]
}

@test "29: Multiple digit rate" {
  run ./act2_b <<EOF
100
123.45
EOF
  [[ "$output" == *"Electricity Bill = 12345.00"* ]]
}

@test "30: Maximum rate/unit combination" {
  run ./act2_b <<EOF
1000
1000
EOF
  [[ "$output" == *"Electricity Bill = 1000000.00"* ]]
}