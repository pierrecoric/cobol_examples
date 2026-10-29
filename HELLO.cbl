      *-----------------------------------------------------------------
      *A   A                         Certain parts of code must start in 
      *R   R                                    either Area A or Area B.
      *E   E
      *A   A
      *    
      *A   B
      *-----------------------------------------------------------------
      
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
      *-----------------------------------------------------------------
       PROGRAM-ID. HELLO.
       AUTHOR. "Pierre".
      

      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
      *-----------------------------------------------------------------
           DISPLAY "Hello!".
           GOBACK.
      

      *-----------------------------------------------------------------
      *    Four Divisions:
      *    IDENTIFICATION
      *    DATA
      *    ENVIRONMENT
      *    PROCEDURE
      *
      *    DISPLAY transfers the content of the operand 
      *    to the output device.
      *
      *    GOBACK terminates the program.
      *-----------------------------------------------------------------
