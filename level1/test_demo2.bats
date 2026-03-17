#!/usr/bin/env bats

# --- Group 1: Unique Winners ---

@test "Unique winner: Rectangle 1" {
run ./demo2 <<EOF
RectA
10.0
5.0
RectB
2.0
2.0
RectC
1.0
1.0
EOF
[[ "$output" == *"RectA has largest area = 50.00"* ]]
}

@test "Unique winner: Rectangle 2" {
run ./demo2 <<EOF
R1
1.0
1.0
R2
20.0
5.0
R3
5.0
5.0
EOF
[[ "$output" == *"R2 has largest area = 100.00"* ]]
}

@test "Unique winner: Rectangle 3" {
run ./demo2 <<EOF
Small1
2.0
2.0
Small2
3.0
3.0
Big3
10.0
10.0
EOF
[[ "$output" == *"Big3 has largest area = 100.00"* ]]
}

# --- Group 2: Two-Way Ties (Your new logic) ---

@test "Two-way tie: R1 and R2 are largest" {
run ./demo2 <<EOF
Alpha
10.0
4.0
Beta
8.0
5.0
Gamma
2.0
2.0
EOF
[[ "$output" == *"Alpha and Beta have equal largest area = 40.00"* ]]
}

@test "Two-way tie: R2 and R3 are largest" {
run ./demo2 <<EOF
Low
1.0
1.0
MidA
10.0
5.0
MidB
25.0
2.0
EOF
[[ "$output" == *"MidA and MidB have equal largest area = 50.00"* ]]
}

@test "Two-way tie: R1 and R3 are largest" {
run ./demo2 <<EOF
TopA
15.0
2.0
Low
2.0
2.0
TopB
10.0
3.0
EOF
[[ "$output" == *"TopA and TopB have equal largest area = 30.00"* ]]
}

# --- Group 3: All Equal & Precision ---

@test "All three rectangles are equal" {
run ./demo2 <<EOF
Same1
5.0
4.0
Same2
10.0
2.0
Same3
20.0
1.0
EOF
[[ "$output" == *"Areas are equal"* ]]
}

@test "Floating point precision: Large values" {
run ./demo2 <<EOF
Huge
1000.5
2.0
Tiny1
0.5
0.5
Tiny2
0.5
0.5
EOF
[[ "$output" == *"Huge has largest area = 2001.00"* ]]
}