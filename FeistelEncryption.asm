@255 // 00000000 11111111
D = A
    
@Ri // [16]
M = D
    
@2
D = M
    
@Ri // Get the right side of the 16 bit number
M = D & M

@32640 // 01111111 10000000
D = A
D = D + A // 11111111 00000000

@Li // [17]
M = D

@2
D = M

@Li // Get the left side of the 16 bit number
M = D & M

@8
M = A

(ShiftLeft) // Shift left side onto right
    @16384 // 01000000 00000000
    D = A
    D = D + A // 10000000 00000000
    
    @MASK // [18]
    M = D
    
    @Li
    D = D & M
    
    @MSB // [19]
    M = D
    
    @Li
    D = M
    D = D + M
    M = D
    
    @MSB
    D = M
    
    @LSB
    D;JEQ
    
    @Li
    M = M + 1
    
    (LSB)
    @8
    M = M - 1
    D = M
    
    @ShiftLeft
    D;JGT

@4
M = A
(LOOP)
    // XOR
    @1
    D = M

    @NotK // [20]
    M = !D

    @255
    D = A

    @NotK // NOT K and MASK
    M = M & D

    @1
    D = M

    @Ri
    D = D & M

    @RNext // (K AND  Ri) [21]
    M = D

    @Ri
    D = !M

    @NotK
    D = D & M // (NOT K AND NOT Ri)

    @RNext
    M = D | M // (NOT K AND NOT Ri) OR (K AND Ri)
    D = !M

    @Li
    D = D & M

    @temp // (NOT RNext AND Li) [22]
    M = D

    @Li
    D = !M

    @RNext
    D = D & M // (NOT Li AND RNext)

    @temp // (NOT Li AND RNext) OR (NOT RNext AND Li)
    M = D | M
    D = M

    @RNext
    M = D
    
    @Ri
    D = M

    @Li
    M = D

    @RNext
    D = M

    @Ri
    M = D
    
    @128 // 00000000 10000000
    D = A
    
    @1 // Shift k
    D = D & M
    
    @KMSB
    M = D
    
    @1
    D = M
    M = D + M
    
    @KMSB
    D = M
    
    @KLSB
    D;JEQ
    
    @1
    M = M + 1
    
    (KLSB)
    @4
    M = M - 1
    D = M
    
    @LOOP
    D;JGT

@8
M = A

(ShiftRight) // Shift Li from right side onto left side
    @Li
    D = M
    M = M + D
    
    @8
    M = M - 1
    D = M
    
    @ShiftRight
    D;JGT
    
@Ri
D = M

@Li
D = D | M

@0
M = D

(END) // Loop continuously until end
@END
0;JMP
