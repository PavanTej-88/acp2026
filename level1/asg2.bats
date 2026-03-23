#!/usr/bin/env bats

# --- GROUP 1: SINGLE HIGHEST COST (9 Cases) ---

@test "1: Floor 1 is strictly highest" {
  run ./asg2 <<EOF
FloorA 10 10 5
FloorB 5 5 2
FloorC 2 2 1
EOF
  [[ "$output" == *"Floor FloorA is highest, cost = 500.00"* ]]
}

@test "2: Floor 2 is strictly highest" {
  run ./asg2 <<EOF
FloorA 2 2 1
FloorB 10 10 5
FloorC 5 5 2
EOF
  [[ "$output" == *"Floor FloorB is highest, cost = 500.00"* ]]
}

@test "3: Floor 3 is strictly highest" {
  run ./asg2 <<EOF
FloorA 2 2 1
FloorB 5 5 2
FloorC 10 10 5
EOF
  [[ "$output" == *"Floor FloorC is highest, cost = 500.00"* ]]
}

@test "4: Large dimensions, small cost" {
  run ./asg2 <<EOF
GrandHall 100 100 0.5
RoomA 10 10 5
RoomB 10 10 5
EOF
  [[ "$output" == *"Floor GrandHall is highest, cost = 5000.00"* ]]
}

@test "5: Small dimensions, high cost per unit" {
  run ./asg2 <<EOF
Marble 2 2 1000
Wood 10 10 10
Tile 20 20 5
EOF
  [[ "$output" == *"Floor Marble is highest, cost = 4000.00"* ]]
}

@test "6: Decimal dimensions (Length/Width)" {
  run ./asg2 <<EOF
F1 10.5 10.5 1
F2 5 5 1
F3 2 2 1
EOF
  [[ "$output" == *"cost = 110.25"* ]]
}

@test "7: Decimal cost per unit" {
  run ./asg2 <<EOF
F1 10 10 5.75
F2 10 10 2.50
F3 10 10 1.00
EOF
  [[ "$output" == *"cost = 575.00"* ]]
}

@test "8: Single highest with very close values" {
  run ./asg2 <<EOF
F1 10 10 1.001
F2 10 10 1.000
F3 10 10 0.999
EOF
  [[ "$output" == *"Floor F1 is highest"* ]]
}

@test "9: Dimensions result in zero cost" {
  run ./asg2 <<EOF
Empty 0 0 10
Real 1 1 1
Small 0.1 0.1 1
EOF
  [[ "$output" == *"Floor Real is highest, cost = 1.00"* ]]
}

# --- GROUP 2: TIES FOR HIGHEST (9 Cases) ---

@test "10: Tie between Floor 1 and Floor 2 (Highest)" {
  run ./asg2 <<EOF
F1 10 10 5
F2 10 10 5
F3 2 2 1
EOF
  [[ "$output" == *"Floor F1 and floor F2 is highest, cost = 500.00"* ]]
}

@test "11: Tie between Floor 2 and Floor 3 (Highest)" {
  run ./asg2 <<EOF
F1 2 2 1
F2 10 10 5
F3 10 10 5
EOF
  [[ "$output" == *"Floor F2 and floor F3 is highest, cost = 500.00"* ]]
}

@test "12: Tie between Floor 1 and Floor 3 (Highest)" {
  run ./asg2 <<EOF
F1 10 10 5
F2 2 2 1
F3 10 10 5
EOF
  [[ "$output" == *"Floor F1 and floor F3 is highest, cost = 500.00"* ]]
}

@test "13: All floors equal cost" {
  run ./asg2 <<EOF
A 10 10 2
B 10 10 2
C 10 10 2
EOF
  [[ "$output" == *"all floors is equal, cost = 200.00"* ]]
}

@test "14: All floors equal cost with different dimensions" {
  run ./asg2 <<EOF
A 10 10 1
B 20 5 1
C 50 2 1
EOF
  [[ "$output" == *"all floors is equal, cost = 100.00"* ]]
}

@test "15: All floors equal cost with decimal dimensions" {
  run ./asg2 <<EOF
A 2.5 4 10
B 5 2 10
C 10 1 10
EOF
  [[ "$output" == *"all floors is equal, cost = 100.00"* ]]
}

@test "16: Tie for highest with 0.00 cost" {
  run ./asg2 <<EOF
A 0 10 5
B 0 5 2
C -1 0 0
EOF
  # Note: Negative dims result in illogical but mathematical zero if handled by code
  [[ "$output" == *"all floors is equal, cost = 0.00"* ]]
}

@test "17: Tie between F1 and F2, F3 is lower but non-zero" {
  run ./asg2 <<EOF
F1 10 10 1
F2 5 20 1
F3 5 5 1
EOF
  [[ "$output" == *"Floor F1 and floor F2 is highest"* ]]
}

@test "18: High precision tie (Floats)" {
  run ./asg2 <<EOF
F1 1.1111 1 1
F2 1.1111 1 1
F3 1.0 1 1
EOF
  [[ "$output" == *"Floor F1 and floor F2 is highest"* ]]
}

# --- GROUP 3: INPUT & FORMATTING (12 Cases) ---

@test "19: Verify prompt sequence" {
  run ./asg2 <<EOF
N 1 1 1
N 1 1 1
N 1 1 1
EOF
  [[ "$output" == *"Enter details for floor 1"* ]]
  [[ "$output" == *"Enter details for floor 2"* ]]
}

@test "20: Name with 49 characters (Max buffer)" {
  LONGNAME="Floor_AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
  run ./asg2 <<EOF
$LONGNAME 10 10 1
B 1 1 1
C 1 1 1
EOF
  [[ "$output" == *"$LONGNAME"* ]]
}

@test "21: Input with special characters in floor name" {
  run ./asg2 <<EOF
Room#101 10 10 1
Room-B 1 1 1
Room_C 1 1 1
EOF
  [[ "$output" == *"Room#101"* ]]
}

@test "22: All zero inputs" {
  run ./asg2 <<EOF
Z1 0 0 0
Z2 0 0 0
Z3 0 0 0
EOF
  [[ "$output" == *"all floors is equal, cost = 0.00"* ]]
}

@test "23: Extremely small values (Underflow check)" {
  run ./asg2 <<EOF
Small 0.001 0.001 0.001
Tiny 0.0001 0.0001 0.0001
Min 0.00001 0.00001 0.00001
EOF
  [[ "$output" == *"Floor Small is highest"* ]]
}

@test "24: Cost calculation check (10*10*10.5)" {
  run ./asg2 <<EOF
A 10 10 10.5
B 1 1 1
C 1 1 1
EOF
  [[ "$output" == *"cost = 1050.00"* ]]
}

@test "25: Name includes digits" {
  run ./asg2 <<EOF
1stFloor 10 10 1
2ndFloor 5 5 1
3rdFloor 2 2 1
EOF
  [[ "$output" == *"1stFloor"* ]]
}

@test "26: Large cost per unit tie" {
  run ./asg2 <<EOF
Gold 1 1 1000000
Platinum 1 1 1000000
Lead 1 1 1
EOF
  [[ "$output" == *"cost = 1000000.00"* ]]
}

@test "27: Floating point rounding check (85.555)" {
  run ./asg2 <<EOF
A 1 1 85.555
B 1 1 10
C 1 1 5
EOF
  # %.2f rounds .555 to .56
  [[ "$output" == *"cost = 85.56"* ]]
}

@test "28: Suffix check: All equal cost" {
  run ./asg2 <<EOF
F1 5 5 4
F2 5 5 4
F3 5 5 4
EOF
  [[ "$output" == *"all floors is equal"* ]]
}

@test "29: Mixed large and small dimensions" {
  run ./asg2 <<EOF
Narrow 100 1 10
Wide 10 10 10
Square 1 100 10
EOF
  [[ "$output" == *"all floors is equal, cost = 1000.00"* ]]
}

@test "30: Maximum buffer capacity for names and float stress" {
  run ./asg2 <<EOF
Max_Name_Length_Testing_String_For_Input_Function_A 100 100 99
B 10 10 1
C 10 10 1
EOF
  [[ "$output" == *"cost = 990000.00"* ]]
}