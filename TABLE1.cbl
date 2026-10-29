      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
      *-----------------------------------------------------------------
       PROGRAM-ID. TABLE1.
       AUTHOR. "Pierre".
      
      *-----------------------------------------------------------------
       ENVIRONMENT DIVISION.
      *-----------------------------------------------------------------

      *-----------------------------------------------------------------
       DATA DIVISION.
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.
      *
      *      Definition of a hard-coded group itemp named NUMBER-VALUES.
      *                              The FILLER reserved word is used to
      *                    claim memory space without naming a variable.
      *
       01 NUMBER-VALUES.
          05 FILLER          PIC X(10) VALUE "Raz".
          05 FILLER          PIC X(10) VALUE "Dwa".
          05 FILLER          PIC X(10) VALUE "Trzy".
          05 FILLER          PIC X(10) VALUE "Cztery".
          05 FILLER          PIC X(10) VALUE "Pięc".
      *
      *              Redifining the table NUMBER-VALUES as a table named
      *              NUMBER-TABLE containing 5 elements named WS-NUMBER.
      *
       01 NUMBER-TABLE REDEFINES NUMBER-VALUES.
          05 WS-NUMBER       PIC X(10) OCCURS 5 TIMES.
      *
      *                      Declaring a variable to navigate the table.
      * 
       77 INDEX-COUNT        PIC 9(1) VALUE 1.

      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
      *-----------------------------------------------------------------
      *
      *                                       Displaying the group item.
      *                           A group item is a group of data pieces
      *                                 in a continuous block of memory.
      *
           DISPLAY NUMBER-VALUES.
      *
      *                                       Tables are indexed from 1.
      * 
           DISPLAY "---------------".
           DISPLAY WS-NUMBER (1).
           DISPLAY "---------------".
      *
      *                              More on PERFORM in another example.
      *             Iterating over the table and displaying its content.
      * 
           PERFORM UNTIL INDEX-COUNT > 5
               DISPLAY WS-NUMBER (INDEX-COUNT)
               ADD 1 TO INDEX-COUNT
           END-PERFORM.

           GOBACK.
