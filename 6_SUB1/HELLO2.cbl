      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
      *-----------------------------------------------------------------
       PROGRAM-ID. HELLO2.
       AUTHOR. "Pierre".

      *-----------------------------------------------------------------
       ENVIRONMENT DIVISION.
      *-----------------------------------------------------------------

      *-----------------------------------------------------------------
       DATA DIVISION.
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.
       01  BEGIN-MSG                 PIC X(7) VALUE "Hello, ".
       01  END-MSG                   PIC X(1) VALUE "!".
       01  DEF-NAME                  PIC X(7) VALUE "Jadwiga".
       01  NAME-PERSON               PIC x(20).

      *
      *                               Description in the LINKAGE SECTION
      *                      of what can be passed by a calling program.
      *
       LINKAGE SECTION.
       01 PARAM-NAME   PIC X(20).

      *-----------------------------------------------------------------
       PROCEDURE DIVISION USING PARAM-NAME.
      *-----------------------------------------------------------------
           MOVE DEF-NAME TO NAME-PERSON.
      *
      *                                     Checking here that the value
      *                              in PARAM-NAME has been initialized.
      *                            That way, the program still functions
      *                              on its own, without being called by
      *                                     another program using USING.
      *
           IF PARAM-NAME NOT EQUAL LOW-VALUES
               MOVE PARAM-NAME TO NAME-PERSON
           END-IF.
      *
      *                                        The FUNCTION TRIM removes
      *                                    the spaces from the variable.
      *
           DISPLAY BEGIN-MSG
                   FUNCTION TRIM(NAME-PERSON)
                   END-MSG.
           GOBACK.
