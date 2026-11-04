      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
      *-----------------------------------------------------------------
       PROGRAM-ID. DATA1.
       AUTHOR. "Pierre".
      
      *-----------------------------------------------------------------
       ENVIRONMENT DIVISION.
      *-----------------------------------------------------------------

      *-----------------------------------------------------------------
       DATA DIVISION.
      *-----------------------------------------------------------------
      *                               WORKING-STORAGE SECTION is used to
      *                     describe data that is not part of a dataset.
      *                        Data that is created as part of a program
      *
      *                                       Level number 77 is used to
      *                                  declare independent data items.
      *                                                                 
      *                               The PIC (picture) clause describes 
      *                                   the nature of a piece of data.
      *
       WORKING-STORAGE SECTION.
       77  NUMERIC-DATA                         PIC 9(2) VALUE 10.
       77  ALPHANUMERIC-DATA                    PIC x(10) VALUE "Hey!".
       77  DECIMAL-NUMBER                       PIC 9(2)V99 VALUE 12.34.
      
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
      *-----------------------------------------------------------------
           DISPLAY NUMERIC-DATA.
           DISPLAY ALPHANUMERIC-DATA.
           DISPLAY DECIMAL-NUMBER.
      *
      *                                          The MOVE clause assigns
      *                                           a value to a variable.
      *
           MOVE 99 TO NUMERIC-DATA .
           DISPLAY NUMERIC-DATA.
      *
      *                        The Compute clause performs an arithmetic 
      *                  opperation an assigns the result to a variable.
      *
           COMPUTE DECIMAL-NUMBER = NUMERIC-DATA - DECIMAL-NUMBER.
           DISPLAY DECIMAL-NUMBER.

           GOBACK.
