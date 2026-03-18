#!/usr/bin/env bats

# --- GROUP 1: POSITIONAL EXTREMES (Where is the Max/Min?) ---

@test "1: Max first, Min last" {
  run ./act1 <<EOF
40.5
30.0
25.0
20.0
15.0
10.0
5.0
EOF
  [[ "$output" == *"Highest temperature = 40.50"* ]]
  [[ "$output" == *"Lowest temperature = 5.00"* ]]
}

@test "2: Min first, Max last" {
  run ./act1 <<EOF
-5.0
0.0
5.0
10.0
15.0
20.0
25.2
EOF
  [[ "$output" == *"Highest temperature = 25.20"* ]]
  [[ "$output" == *"Lowest temperature = -5.00"* ]]
}

@test "3: Max and Min in the middle" {
  run ./act1 <<EOF
20.0
22.0
45.0
18.0
10.0
12.0
15.0
EOF
  [[ "$output" == *"Highest temperature = 45.00"* ]]
  [[ "$output" == *"Lowest temperature = 10.00"* ]]
}

@test "4: Max and Min are adjacent" {
  run ./act1 <<EOF
20.0
20.0
50.0
1.0
20.0
20.0
20.0
EOF
  [[ "$output" == *"Highest temperature = 50.00"* ]]
  [[ "$output" == *"Lowest temperature = 1.00"* ]]
}

# --- GROUP 2: NEGATIVE & MIXED TEMPERATURES ---

@test "5: All negative temperatures" {
  run ./act1 <<EOF
-10.5
-20.0
-5.2
-30.0
-15.0
-12.0
-8.0
EOF
  [[ "$output" == *"Highest temperature = -5.20"* ]]
  [[ "$output" == *"Lowest temperature = -30.00"* ]]
}

@test "6: Mixed positive and negative" {
  run ./act1 <<EOF
-2.5
3.0
-10.0
15.5
0.0
-1.0
8.0
EOF
  [[ "$output" == *"Highest temperature = 15.50"* ]]
  [[ "$output" == *"Lowest temperature = -10.00"* ]]
}

@test "7: Zero as the lowest value" {
  run ./act1 <<EOF
5.5
10.0
20.0
0.0
40.0
50.0
60.0
EOF
  [[ "$output" == *"Lowest temperature = 0.00"* ]]
}

# --- GROUP 3: EQUALITY & TIES ---

@test "8: All temperatures identical" {
  run ./act1 <<EOF
25.0
25.0
25.0
25.0
25.0
25.0
25.0
EOF
  [[ "$output" == *"Highest temperature = 25.00"* ]]
  [[ "$output" == *"Lowest temperature = 25.00"* ]]
}

@test "9: Multiple days with same High" {
  run ./act1 <<EOF
40.0
40.0
10.0
5.0
10.0
40.0
10.0
EOF
  [[ "$output" == *"Highest temperature = 40.00"* ]]
}

@test "10: Multiple days with same Low" {
  run ./act1 <<EOF
10.0
2.0
30.0
2.0
50.0
2.0
10.0
EOF
  [[ "$output" == *"Lowest temperature = 2.00"* ]]
}

# --- GROUP 4: PRECISION & FRACTIONAL VALUES ---

@test "11: Small fractional differences" {
  run ./act1 <<EOF
20.10
20.15
20.05
20.20
20.01
20.18
20.12
EOF
  [[ "$output" == *"Highest temperature = 20.20"* ]]
  [[ "$output" == *"Lowest temperature = 20.01"* ]]
}

@test "12: Large values check" {
  run ./act1 <<EOF
100.5
200.7
50.2
300.1
150.0
10.0
99.9
EOF
  [[ "$output" == *"Highest temperature = 300.10"* ]]
}

# --- GROUP 5: TREND SCENARIOS ---

@test "13: Strictly ascending week" {
  run ./act1 <<EOF
10
11
12
13
14
15
16
EOF
  [[ "$output" == *"Highest temperature = 16.00"* ]]
  [[ "$output" == *"Lowest temperature = 10.00"* ]]
}

@test "14: Strictly descending week" {
  run ./act1 <<EOF
30
29
28
27
26
25
24
EOF
  [[ "$output" == *"Highest temperature = 30.00"* ]]
  [[ "$output" == *"Lowest temperature = 24.00"* ]]
}

@test "15: Heatwave in middle of week" {
  run ./act1 <<EOF
25
26
45
48
42
28
25
EOF
  [[ "$output" == *"Highest temperature = 48.00"* ]]
}

@test "16: Cold snap in middle of week" {
  run ./act1 <<EOF
20
18
5
-2
4
15
22
EOF
  [[ "$output" == *"Lowest temperature = -2.00"* ]]
}

@test "17: Alternating high/low" {
  run ./act1 <<EOF
30
10
30
10
30
10
30
EOF
  [[ "$output" == *"Highest temperature = 30.00"* ]]
  [[ "$output" == *"Lowest temperature = 10.00"* ]]
}

@test "18: Near freezing (0.1 / -0.1)" {
  run ./act1 <<EOF
0.1
-0.1
0.2
-0.2
0.0
0.5
-0.5
EOF
  [[ "$output" == *"Highest temperature = 0.50"* ]]
  [[ "$output" == *"Lowest temperature = -0.50"* ]]
}

# --- GROUP 6: NUMERICAL BOUNDARIES ---

@test "19: Very large positive value" {
  run ./act1 <<EOF
9999
0
0
0
0
0
0
EOF
  [[ "$output" == *"Highest temperature = 9999.00"* ]]
}

@test "20: Very large negative value" {
  run ./act1 <<EOF
0
0
0
-9999
0
0
0
EOF
  [[ "$output" == *"Lowest temperature = -9999.00"* ]]
}

@test "21: High start and High end" {
  run ./act1 <<EOF
50
20
20
20
20
20
50
EOF
  [[ "$output" == *"Highest temperature = 50.00"* ]]
}

@test "22: Low start and Low end" {
  run ./act1 <<EOF
5
40
40
40
40
40
5
EOF
  [[ "$output" == *"Lowest temperature = 5.00"* ]]
}

@test "23: One decimal point variation" {
  run ./act1 <<EOF
10.1
10.2
10.3
10.4
10.5
10.6
10.7
EOF
  [[ "$output" == *"Highest temperature = 10.70"* ]]
}

@test "24: Mixed Integers and Floats" {
  run ./act1 <<EOF
20
20.5
21
21.5
22
22.5
23
EOF
  [[ "$output" == *"Highest temperature = 23.00"* ]]
  [[ "$output" == *"Lowest temperature = 20.00"* ]]
}

@test "25: Smallest possible gap" {
  run ./act1 <<EOF
10.001
10.002
10.003
10.004
10.005
10.006
10.007
EOF
  [[ "$output" == *"Highest temperature = 10.01"* ]]
}

@test "26: Large range gap" {
  run ./act1 <<EOF
-100
500
-100
500
-100
500
0
EOF
  [[ "$output" == *"Highest temperature = 500.00"* ]]
  [[ "$output" == *"Lowest temperature = -100.00"* ]]
}

@test "27: Zero in every position except max" {
  run ./act1 <<EOF
0
0
100
0
0
0
0
EOF
  [[ "$output" == *"Highest temperature = 100.00"* ]]
}

@test "28: Zero in every position except min" {
  run ./act1 <<EOF
0
0
-100
0
0
0
0
EOF
  [[ "$output" == *"Lowest temperature = -100.00"* ]]
}

@test "29: High precision values" {
  run ./act1 <<EOF
1.123
2.234
3.345
4.456
5.567
6.678
7.789
EOF
  [[ "$output" == *"Highest temperature = 7.79"* ]]
}

@test "30: Descent into freezing" {
  run ./act1 <<EOF
5
4
3
2
1
0
-1
EOF
  [[ "$output" == *"Highest temperature = 5.00"* ]]
  [[ "$output" == *"Lowest temperature = -1.00"* ]]
}