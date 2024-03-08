(LOOP)
    @16384
    D = A
    D = D + A
    
    @MASK
    M = D
    
    @3
    D = D & M
    
    @MSB
    M = D
    
    @3
    D = M
    D = D + M
    M = D
    
    @MSB
    D = M
    
    @LSB
    D;JEQ
    
    @3
    M = M + 1
    
    (LSB)
    @4
    M = M - 1
    D = M
    
    @LOOP
    D;JGT

@3
D = M

@5
M = D

(END)
@END
0;JMP
    
    

    
    

