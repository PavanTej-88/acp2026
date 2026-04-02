#!/usr/bin/env bats

# --- GROUP 1: BASIC FILE READ/WRITE & CALCULATION (10 Cases) ---

@test "1: Single employee payroll" {
  run ./act9 <<EOF
1
101 Alice 50000.60
EOF
  [[ "$output" == *"Total expenditure = 50000.60"* ]]
  [ -f payroll.txt ]
}

@test "2: Multiple employees standard calculation" {
  run ./act9 <<EOF
3
1 Bob 1000.00
2 Sam 2000.00
3 Joe 3000.00
EOF
  [[ "$output" == *"Total expenditure = 6000.00"* ]]
}

@test "3: Employees with zero salary" {
  run ./act9 <<EOF
2
1 Intern 0.00
2 Volunteer 0.00
EOF
  [[ "$output" == *"Total expenditure = 0.00"* ]]
}

@test "4: High precision salary values" {
  run ./act9 <<EOF
2
1 A 1000.55
2 B 2000.44
EOF
  [[ "$output" == *"Total expenditure = 3000.99"* ]]
}

@test "5: Salary with large integer component" {
  run ./act9 <<EOF
1
99 CEO 1000000.00
EOF
  [[ "$output" == *"Total expenditure = 1000000.00"* ]]
}

@test "6: Employee names with numbers" {
  run ./act9 <<EOF
1
101 Agent007 7000.00
EOF
  [[ "$output" == *"Total expenditure = 7000.00"* ]]
}

@test "7: Very small fractional salaries" {
  run ./act9 <<EOF
2
1 X 0.01
2 Y 0.02
EOF
  [[ "$output" == *"Total expenditure = 0.03"* ]]
}

@test "8: Sequential Employee IDs" {
  run ./act9 <<EOF
4
1 A 10
2 B 10
3 C 10
4 D 10
EOF
  [[ "$output" == *"Total expenditure = 40.00"* ]]
}

@test "9: Large number of employees (10)" {
  run ./act9 <<EOF
10
1 A 100
2 B 100
3 C 100
4 D 100
5 E 100
6 F 100
7 G 100
8 H 100
9 I 100
10 J 100
EOF
  [[ "$output" == *"Total expenditure = 1000.00"* ]]
}

@test "10: Overwriting payroll.txt (Persistence test)" {
  # Run once
  echo -e "1\n1 A 100" | ./act9
  # Run again with different data
  run ./act9 <<EOF
1
2 B 500
EOF
  # Should show 500, not 600 (sum) because of "w" mode in fopen
  [[ "$output" == *"Total expenditure = 500.00"* ]]
}

# --- GROUP 2: EDGE CASES & ERROR HANDLING (10 Cases) ---

@test "11: Invalid number of employees (0)" {
  run ./act9 <<EOF
0
EOF
  [[ "$output" == *"Invalid number"* ]]
}

@test "12: Invalid number of employees (-1)" {
  run ./act9 <<EOF
-1
EOF
  [[ "$output" == *"Invalid number"* ]]
}

@test "13: Employee ID is 0" {
  run ./act9 <<EOF
1
0 ZeroID 1200
EOF
  [[ "$output" == *"Total expenditure = 1200.00"* ]]
}

@test "14: Negative Employee ID (Logic check)" {
  run ./act9 <<EOF
1
-5 NegID 1500
EOF
  [[ "$output" == *"Total expenditure = 1500.00"* ]]
}

@test "15: Negative Salary (Mathematical check)" {
  run ./act9 <<EOF
2
1 Profit 1000
2 Loss -200
EOF
  [[ "$output" == *"Total expenditure = 800.00"* ]]
}

@test "16: Longest possible name (49 chars)" {
  LONGNAME="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvw"
  run ./act9 <<EOF
1
1 $LONGNAME 5000
EOF
  [[ "$output" == *"Total expenditure = 5000.00"* ]]
}

@test "17: Name containing special characters" {
  run ./act9 <<EOF
1
101 Emp_#1! 3000
EOF
  [[ "$output" == *"Total expenditure = 3000.00"* ]]
}

@test "18: Salary with many decimal places (Rounding check)" {
  run ./act9 <<EOF
1
1 A 10.5555
EOF
  # Display logic %.2f should round up
  [[ "$output" == *"Total expenditure = 10.56"* ]]
}

@test "19: File format check (Reading back correctly)" {
  run ./act9 <<EOF
1
55 Test 99.99
EOF
  # Check if payroll.txt exists and contains the data
  grep "55 Test 99.99" payroll.txt
}

@test "20: Empty string simulation for name" {
  run ./act9 <<EOF
1
1 . 100
EOF
  [[ "$output" == *"Total expenditure = 100.00"* ]]
}

# --- GROUP 3: SYSTEM STRESS & FORMATTING (10 Cases) ---

@test "21: Check 'Total expenditure =' label" {
  run ./act9 <<EOF
1
1 A 100
EOF
  [[ "$output" == *"Total expenditure ="* ]]
}

@test "22: All employees have same ID but different names" {
  run ./act9 <<EOF
2
1 Alice 100
1 Bob 100
EOF
  [[ "$output" == *"Total expenditure = 200.00"* ]]
}

@test "23: Space in input stream (Scanf check)" {
  run ./act9 <<EOF
1
101 
John 
5000
EOF
  [[ "$output" == *"Total expenditure = 5000.00"* ]]
}

@test "24: Maximum Salary value test" {
  run ./act9 <<EOF
1
1 Rich 999999.99
EOF
  [[ "$output" == *"Total expenditure = 999999.99"* ]]
}

@test "25: Smallest non-zero student count (1)" {
  run ./act9 <<EOF
1
1 A 1
EOF
  [[ "$output" == *"Total expenditure = 1.00"* ]]
}

@test "26: Large gap in IDs" {
  run ./act9 <<EOF
2
1 Start 100
9999 End 100
EOF
  [[ "$output" == *"Total expenditure = 200.00"* ]]
}

@test "27: Mixed ID types (Integer limits)" {
  run ./act9 <<EOF
1
2147483647 MaxIntID 500
EOF
  [[ "$output" == *"Total expenditure = 500.00"* ]]
}

@test "28: Scientific notation in float input" {
  run ./act9 <<EOF
1
1 Sci 1e2
EOF
  # 1e2 is 100.00
  [[ "$output" == *"Total expenditure = 100.00"* ]]
}

@test "29: Multiple employees with very long names" {
  run ./act9 <<EOF
2
1 LongNameOne_LongNameOne_LongNameOne_LongNameOne_ 10
2 LongNameTwo_LongNameTwo_LongNameTwo_LongNameTwo_ 20
EOF
  [[ "$output" == *"Total expenditure = 30.00"* ]]
}

@test "30: System exit check (Exit 0)" {
  run ./act9 <<EOF
1
1 A 10
EOF
  [ "$status" -eq 0 ]
}