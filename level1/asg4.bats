#!/usr/bin/env bats

# --- GROUP 1: BASIC FILTERING (10 Cases) ---

@test "1: All 4 cars are modern (2023+)" {
  run ./asg4 <<EOF
101 ModelA 2023 15000
102 ModelB 2024 20000
103 ModelC 2025 25000
104 ModelD 2026 30000
EOF
  [[ "$output" == *"ModelA"* ]]
  [[ "$output" == *"ModelB"* ]]
  [[ "$output" == *"ModelC"* ]]
  [[ "$output" == *"ModelD"* ]]
}

@test "2: No cars are modern (All <= 2022)" {
  run ./asg4 <<EOF
101 OldA 2020 5000
102 OldB 2021 6000
103 OldC 2022 7000
104 OldD 2019 4000
EOF
  [[ "$output" == *"No modern cars available manufactured after 2022"* ]]
}

@test "3: Exactly one modern car at index 0" {
  run ./asg4 <<EOF
101 Modern 2023 15000
102 Old 2022 5000
103 Old 2022 5000
104 Old 2022 5000
EOF
  [[ "$output" == *"Car ID: 101"* ]]
  [[ "$output" == *"Model name: Modern"* ]]
}

@test "4: Exactly one modern car at last index" {
  run ./asg4 <<EOF
101 Old 2020 5000
102 Old 2020 5000
103 Old 2020 5000
104 Modern 2024 18000
EOF
  [[ "$output" == *"Car ID: 104"* ]]
}

@test "5: Boundary Check: Year 2022 should be excluded" {
  run ./asg4 <<EOF
101 Tesla 2022 50000
102 BMW 2022 60000
103 Audi 2022 70000
104 Merc 2022 80000
EOF
  [[ "$output" == *"No modern cars available manufactured after 2022"* ]]
}

@test "6: Boundary Check: Year 2023 should be included" {
  run ./asg4 <<EOF
101 NewCar 2023 20000
102 Old 2020 10000
103 Old 2020 10000
104 Old 2020 10000
EOF
  [[ "$output" == *"Manufacture year(after 2022): 2023"* ]]
}

@test "7: Modern cars with zero price" {
  run ./asg4 <<EOF
101 Concept 2025 0
102 Old 2020 10
103 Old 2020 10
104 Old 2020 10
EOF
  [[ "$output" == *"Price: 0.00"* ]]
}

@test "8: Price with high precision decimals" {
  run ./asg4 <<EOF
101 Luxury 2024 99999.99
102 Old 2020 1
103 Old 2020 1
104 Old 2020 1
EOF
  [[ "$output" == *"Price: 99999.99"* ]]
}

@test "9: Car ID is negative (Logic test)" {
  run ./asg4 <<EOF
-1 Ghost 2025 5000
102 Old 2020 1
103 Old 2020 1
104 Old 2020 1
EOF
  [[ "$output" == *"Car ID: -1"* ]]
}

@test "10: Two modern cars, two old cars" {
  run ./asg4 <<EOF
101 New1 2023 100
102 Old1 2021 100
103 New2 2024 100
104 Old2 2022 100
EOF
  [[ "$output" == *"New1"* ]]
  [[ "$output" == *"New2"* ]]
  [[ ! "$output" == *"Old1"* ]]
}

# --- GROUP 2: DATA INTEGRITY & BOUNDARIES (10 Cases) ---

@test "11: Model name with maximum characters (49)" {
  LONGNAME="Model_Name_With_Exactly_Forty_Nine_Chars_Long_XYZ"
  run ./asg4 <<EOF
1 $LONGNAME 2024 5000
2 Old 2020 1
3 Old 2020 1
4 Old 2020 1
EOF
  [[ "$output" == *"$LONGNAME"* ]]
}

@test "12: Manufacture year in the far future" {
  run ./asg4 <<EOF
101 HoverCar 3000 99999
102 Old 2020 1
103 Old 2020 1
104 Old 2020 1
EOF
  [[ "$output" == *"Manufacture year(after 2022): 3000"* ]]
}

@test "13: Mixed numeric and alpha model names" {
  run ./asg4 <<EOF
101 X-AE-12 2025 45000
102 Old 2020 1
103 Old 2020 1
104 Old 2020 1
EOF
  [[ "$output" == *"Model name: X-AE-12"* ]]
}

@test "14: All cars have year 0 (Edge case)" {
  run ./asg4 <<EOF
1 A 0 0
2 B 0 0
3 C 0 0
4 D 0 0
EOF
  [[ "$output" == *"No modern cars available manufactured after 2022"* ]]
}

@test "15: Duplicate Car IDs with different years" {
  run ./asg4 <<EOF
101 CarA 2025 100
101 CarB 2020 100
102 CarC 2021 100
102 CarD 2026 100
EOF
  [[ "$output" == *"CarA"* ]]
  [[ "$output" == *"CarD"* ]]
  [[ ! "$output" == *"CarB"* ]]
}

@test "16: Very large Car ID" {
  run ./asg4 <<EOF
2147483647 MaxID 2024 5000
2 Old 2020 1
3 Old 2020 1
4 Old 2020 1
EOF
  [[ "$output" == *"Car ID: 2147483647"* ]]
}

@test "17: Model name contains digits" {
  run ./asg4 <<EOF
1 911-Turbo 2025 120000
2 Old 2020 1
3 Old 2020 1
4 Old 2020 1
EOF
  [[ "$output" == *"911-Turbo"* ]]
}

@test "18: Space separated input across lines" {
  run ./asg4 <<EOF
101 
Tesla
2025
60000
102 Old 2020 1
103 Old 2020 1
104 Old 2020 1
EOF
  [[ "$output" == *"Tesla"* ]]
}

@test "19: Model name with special symbols" {
  run ./asg4 <<EOF
101 @Model#1 2026 5000
102 Old 2020 1
103 Old 2020 1
104 Old 2020 1
EOF
  [[ "$output" == *"@Model#1"* ]]
}

@test "20: Floating point price rounding (85.555)" {
  run ./asg4 <<EOF
101 Test 2024 85.555
102 Old 2020 1
103 Old 2020 1
104 Old 2020 1
EOF
  [[ "$output" == *"Price: 85.56"* ]]
}

# --- GROUP 3: SYSTEM STRESS & OUTPUT (10 Cases) ---

@test "21: Check header message presence" {
  run ./asg4 <<EOF
1 A 2025 1
2 B 2025 1
3 C 2025 1
4 D 2025 1
EOF
  [[ "$output" == *"Modern cars manufactured after 2022"* ]]
}

@test "22: All years are negative (Invalid but testable)" {
  run ./asg4 <<EOF
1 A -2025 1
2 B -2024 1
3 C -2023 1
4 D -2022 1
EOF
  [[ "$output" == *"No modern cars available manufactured after 2022"* ]]
}

@test "23: One car is exactly 2023, others are 0" {
  run ./asg4 <<EOF
1 New 2023 500
2 Old 0 0
3 Old 0 0
4 Old 0 0
EOF
  [[ "$output" == *"New"* ]]
}

@test "24: Price is a very small decimal" {
  run ./asg4 <<EOF
101 Nano 2025 0.01
102 Old 2020 1
103 Old 2020 1
104 Old 2020 1
EOF
  [[ "$output" == *"Price: 0.01"* ]]
}

@test "25: Car IDs are sequential" {
  run ./asg4 <<EOF
1 A 2023 1
2 B 2023 1
3 C 2023 1
4 D 2023 1
EOF
  [[ "$output" == *"Car ID: 1"* ]]
  [[ "$output" == *"Car ID: 4"* ]]
}

@test "26: Large price value (Millions)" {
  run ./asg4 <<EOF
1 Ferrari 2025 1500000
2 Old 2020 1
3 Old 2020 1
4 Old 2020 1
EOF
  [[ "$output" == *"Price: 1500000.00"* ]]
}

@test "27: Scanf string truncation check (49 chars)" {
  # Input > 49 chars
  run ./asg4 <<EOF
101 ThisIsAVeryLongNameThatExceedsTheFiftyCharacterLimitIncludingNull 2025 5000
102 Old 2020 1
103 Old 2020 1
104 Old 2020 1
EOF
  [[ "$output" == *"Car ID: 101"* ]]
}

@test "28: Manufacture year is exactly 2022.9 (Float input for int)" {
  run ./asg4 <<EOF
101 Glitch 2022.9 5000
102 Old 2020 1
103 Old 2020 1
104 Old 2020 1
EOF
  # Scanf %d will read 2022 and leave .9 in buffer, excluding the car
  [[ "$output" == *"No modern cars available manufactured after 2022"* ]]
}

@test "29: All cars have the same Model Name" {
  run ./asg4 <<EOF
1 Same 2025 1
2 Same 2020 1
3 Same 2024 1
4 Same 2021 1
EOF
  [[ "$output" == *"Manufacture year(after 2022): 2025"* ]]
  [[ "$output" == *"Manufacture year(after 2022): 2024"* ]]
}

@test "30: Maximum fleet input check" {
  run ./asg4 <<EOF
1 A 2023 1
2 B 2024 2
3 C 2025 3
4 D 2026 4
EOF
  [[ "$output" == *"Car ID: 1"* ]]
  [[ "$output" == *"Car ID: 4"* ]]
}