#!/usr/bin/env bats

# --- GROUP 1: STANDARD CONSUMPTION (Units <= 100) ---

@test "1: Units at lower boundary (1 unit)" {
  run ./act2_a <<EOF
1
10.0
EOF
  [[ "$output" == *"Total electricity bill = 10.00"* ]]
  [[ "$output" != *"High consumption alert!"* ]]
}

@test "2: Units exactly 100 (Upper boundary of normal)" {
  run ./act2_a <<EOF
100
8.0
EOF
  [[ "$output" == *"Total electricity bill = 800.00"* ]]
  [[ "$output" != *"High consumption alert!"* ]]
}

@test "3: Standard consumption with 50 units" {
  run ./act2_a <<EOF
50
5.0
EOF
  [[ "$output" == *"Total electricity bill = 250.00"* ]]
}

@test "4: Standard consumption with decimal rate" {
  run ./act2_a <<EOF
80
4.5
EOF
  [[ "$output" == *"Total electricity bill = 360.00"* ]]
}

@test "5: Zero units consumed" {
  run ./act2_a <<EOF
0
10.0
EOF
  [[ "$output" == *"Total electricity bill = 0.00"* ]]
}

# --- GROUP 2: HIGH CONSUMPTION (Units > 100) ---

@test "6: Just over 100 units (101 units)" {
  # 100*rate + 1*(rate+5)
  run ./act2_a <<EOF
101
10.0
EOF
  [[ "$output" == *"High consumption alert!"* ]]
  [[ "$output" == *"Total electricity bill = 1015.00"* ]]
}

@test "7: High consumption with 110 units" {
  # 100*10 + 10*15 = 1000 + 150 = 1150
  run ./act2_a <<EOF
110
10.0
EOF
  [[ "$output" == *"Total electricity bill = 1150.00"* ]]
}

@test "8: High consumption with 200 units" {
  # 100*5 + 100*10 = 500 + 1000 = 1500
  run ./act2_a <<EOF
200
5.0
EOF
  [[ "$output" == *"Total electricity bill = 1500.00"* ]]
}

@test "9: High consumption with small rate (1.0)" {
  # 100*1 + 50*6 = 100 + 300 = 400
  run ./act2_a <<EOF
150
1.0
EOF
  [[ "$output" == *"Total electricity bill = 400.00"* ]]
}

@test "10: High consumption with fractional rate" {
  # 100*2.5 + 10*7.5 = 250 + 75 = 325
  run ./act2_a <<EOF
110
2.5
EOF
  [[ "$output" == *"Total electricity bill = 325.00"* ]]
}

# --- GROUP 3: MESSAGE VERIFICATION ---

@test "11: Verify warning message exists for 101" {
  run ./act2_a <<EOF
101
5
EOF
  [[ "$output" == *"High consumption alert!"* ]]
  [[ "$output" == *"Extra charges applied"* ]]
}

@test "12: Verify warning message does NOT exist for 100" {
  run ./act2_a <<EOF
100
5
EOF
  [[ "$output" != *"High consumption alert!"* ]]
}

# --- GROUP 4: VARIED RATES & PRECISION ---

@test "13: Very high rate standard consumption" {
  run ./act2_a <<EOF
10
100.0
EOF
  [[ "$output" == *"Total electricity bill = 1000.00"* ]]
}

@test "14: High units, very low base rate" {
  run ./act2_a <<EOF
500
0.5
EOF
  [[ "$output" == *"Total electricity bill = 2250.00"* ]]
}

@test "15: Rate with many decimals" {
  run ./act2_a <<EOF
100
3.333
EOF
  [[ "$output" == *"Total electricity bill = 333.30"* ]]
}

# --- GROUP 5: SYSTEM STRESS & LARGE NUMBERS ---

@test "16: Units as a large integer" {
  run ./act2_a <<EOF
1000
10.0
EOF
  [[ "$output" == *"Total electricity bill = 14500.00"* ]]
}

@test "17: Very high consumption" {
  run ./act2_a <<EOF
5000
2.0
EOF
  [[ "$output" == *"Total electricity bill = 34500.00"* ]]
}

@test "18: Low units, high decimal rate" {
  run ./act2_a <<EOF
25
12.75
EOF
  [[ "$output" == *"Total electricity bill = 318.75"* ]]
}

@test "19: Exactly 101 units with ₹0 rate" {
  # 100*0 + 1*5 = 5
  run ./act2_a <<EOF
101
0.0
EOF
  [[ "$output" == *"Total electricity bill = 5.00"* ]]
}

@test "20: Exactly 100 units with ₹0 rate" {
  run ./act2_a <<EOF
100
0.0
EOF
  [[ "$output" == *"Total electricity bill = 0.00"* ]]
}

# --- GROUP 6: POSITIONAL LOGIC & SEQUENCING ---

@test "21: 99 units check" {
  run ./act2_a <<EOF
99
10.0
EOF
  [[ "$output" == *"Total electricity bill = 990.00"* ]]
}

@test "22: 102 units check" {
  # 100*10 + 2*15 = 1000 + 30 = 1030
  run ./act2_a <<EOF
102
10.0
EOF
  [[ "$output" == *"Total electricity bill = 1030.00"* ]]
}

@test "23: High units (150) with ₹20 rate" {
  # 100*20 + 50*25 = 2000 + 1250 = 3250
  run ./act2_a <<EOF
150
20.0
EOF
  [[ "$output" == *"Total electricity bill = 3250.00"* ]]
}

@test "24: Standard units (10) with ₹20 rate" {
  run ./act2_a <<EOF
10
20.0
EOF
  [[ "$output" == *"Total electricity bill = 200.00"* ]]
}

@test "25: Units = 150, rate = 0.1" {
  # 100*0.1 + 50*5.1 = 10 + 255 = 265
  run ./act2_a <<EOF
150
0.1
EOF
  [[ "$output" == *"Total electricity bill = 265.00"* ]]
}

@test "26: Large decimal rate for 101 units" {
  run ./act2_a <<EOF
101
9.99
EOF
  [[ "$output" == *"Total electricity bill = 1013.99"* ]]
}

@test "27: Consumption 100, rate 9.99" {
  run ./act2_a <<EOF
100
9.99
EOF
  [[ "$output" == *"Total electricity bill = 999.00"* ]]
}

@test "28: Consumption 300, rate 5" {
  # 100*5 + 200*10 = 500 + 2000 = 2500
  run ./act2_a <<EOF
300
5.0
EOF
  [[ "$output" == *"Total electricity bill = 2500.00"* ]]
}

@test "29: Minimum positive consumption" {
  run ./act2_a <<EOF
1
0.01
EOF
  [[ "$output" == *"Total electricity bill = 0.01"* ]]
}

@test "30: Maximum integer units test" {
  run ./act2_a <<EOF
10000
1.0
EOF
  [[ "$output" == *"Total electricity bill = 59500.00"* ]]
}