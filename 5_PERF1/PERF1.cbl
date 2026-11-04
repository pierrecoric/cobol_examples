      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
      *-----------------------------------------------------------------
       PROGRAM-ID PERF1.
       AUTHOR "Pierre".

      *-----------------------------------------------------------------
       ENVIRONMENT DIVISION.
      *-----------------------------------------------------------------

      *-----------------------------------------------------------------
       DATA DIVISION.
      *-----------------------------------------------------------------
      *
      *                                  Declaring a counter to display.
      *                         Declaring a String Buffer and a pointer.
      *
       WORKING-STORAGE SECTION.

       77  COUNTER                      PIC 9(2) VALUE 0.
       77  WS-STRING-BUFFER             PIC X(10) VALUE SPACE.
       77  WS-STR-PTR                   PIC 9(2) VALUE 1.

      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
      *-----------------------------------------------------------------
      *
      *                                Using perform to call a paragraph
      *                                        until a condition is met.
      *                                 In this example, DISPLAY-COUNTER
      *                                              increments counter.
      *
           PERFORM DISPLAY-COUNTER UNTIL COUNTER EQUAL 10.
      *
      *                                      PERFORM can also be used to
      *                                  call a paragraph a single time.
      *                   DISPLAY-LINE prints some dashes to the output.
      *
           PERFORM DISPLAY-LINE.
      *
      *                                  TIMES allow to repeat an action
      *                                         a given amount of times.
      *
           PERFORM 5 TIMES
               DISPLAY "HELLO"
           END-PERFORM.

           PERFORM DISPLAY-LINE.
      *
      *
      *
           PERFORM VARYING COUNTER FROM 00 BY 1 UNTIL COUNTER EQUAL 10
               DISPLAY
               "HEY"
               COUNTER
           END-PERFORM.
      *
      *                             The paragraph END-PROGRAM is reached
      *                                     once the last PERFORM exits.
      *
       END-PROGRAM.
           PERFORM DISPLAY-LINE.
           PERFORM DISPLAY-TRIANGLE.
           DISPLAY "Goodbye".
           GOBACK.
      *
      *                                       The paragraph displays the
      *                                       counter and increments it.
      *
       DISPLAY-COUNTER.
           DISPLAY COUNTER
           ADD 1 TO COUNTER.
      *
      *                                         This paragraphs displays
      *                              a dividing line made out of dashes.
      *
       DISPLAY-LINE.
           DISPLAY "------------------------".
      *
      *                DISPLAY-TRIANGLE introduces the notion of string.
      *         WS-STR-PTR is a pointer that is being updated by STRING.
      *                             Not part of the class at this point.
      *
       DISPLAY-TRIANGLE.
           PERFORM 9 TIMES
               STRING "#" DELIMITED BY SIZE
                    INTO WS-STRING-BUFFER WITH POINTER WS-STR-PTR
               END-STRING
               DISPLAY WS-STRING-BUFFER
           END-PERFORM.
