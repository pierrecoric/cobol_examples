      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID COND1.
       AUTHOR "Pierre".
      *-----------------------------------------------------------------
      *
      *-----------------------------------------------------------------
       ENVIRONMENT DIVISION.
      *-----------------------------------------------------------------
      *
      *-----------------------------------------------------------------
       DATA DIVISION.
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.

       01 SOMETHING PIC 9(2) VALUE 5.
       01 LINE-DASH PIC X(10) VALUE "----------".
      *
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
      *-----------------------------------------------------------------
      *
      *                                REPORT-STATUS is a paragraph that
      *                   displays what the variable SOMETHING contains.
      *     
           PERFORM REPORT-STATUS.
      *
      *                                            Structure of a simple
      *                                  IF/ELSE (cobol has no ELSE IF).
      *
           IF SOMETHING IS GREATER THAN 10
               THEN DISPLAY "Greater than 10."
               ELSE DISPLAY "Not greater than 10."
           END-IF.
      *
      *                              Changing the value of SOMETHING and
      *                                 calling two different paragraphs
      *                                               that use EVALUATE.
      *
           DISPLAY "Moving 11 to Something.".
           MOVE 11 TO SOMETHING.
           PERFORM REPORT-STATUS.
           PERFORM EVAL-SOMETHING.
      *
           DISPLAY "Moving 0 to Something.".
           MOVE 0 TO SOMETHING.
           PERFORM REPORT-STATUS.
           PERFORM EVAL-SOMETHING.
      *
           DISPLAY "Moving 10 to Something.".
           MOVE 10 TO SOMETHING.
           PERFORM REPORT-STATUS.
           PERFORM EVAL-SOMETHING.
      *
           PERFORM DRAW-LINE.
           DISPLAY "Next Example.".
           PERFORM DRAW-LINE.
      *
           DISPLAY "Moving 1 to Something.".
           MOVE 1 TO SOMETHING.
           PERFORM REPORT-STATUS.
           PERFORM EVAL-SOMETHING-AGAIN.
      *
           DISPLAY "Moving 22 to Something.".
           MOVE 1 TO SOMETHING.
           PERFORM REPORT-STATUS.
           PERFORM EVAL-SOMETHING-AGAIN.
      *
      *                                             End of this program.
      *
       STOP-CLOSE.
           DISPLAY "Goodbye."
           STOP RUN.
      *
      *                         EVALUATE checks a condition and compares
      *                        it to different options. To replicate the
      *                          idea of an IF, ELSE IF, ELSE structure,
      *                                       we can evaluate a boolean.
      *
      *                                      I am also now explicitingly
      *                      closing paragraphs with an empty paragraph.
      *
       EVAL-SOMETHING.
           EVALUATE TRUE
               WHEN SOMETHING GREATER THAN 10
                   DISPLAY "Greater than 10."
               WHEN SOMETHING LESS THAN 10
                   DISPLAY "Less than 10."
               WHEN SOMETHING EQUAL TO 10
                   DISPLAY "10."
           END-EVALUATE.
           PERFORM DRAW-LINE.
       EVAL-SOMETHING-END.
      *
      *                                 We can also evaluate a variable,
      *                                similar to a switch construction.
      *
       EVAL-SOMETHING-AGAIN.
           EVALUATE SOMETHING
               WHEN 1               PERFORM HANDLE-LOW
               WHEN 2 THROUGH 20    PERFORM HANDLE-MID
               WHEN OTHER           PERFORM HANDLE-UNKNOWN
           END-EVALUATE.
       EVAL-SOMETHING-AGAIN-END.
      *
      *                              Simple paragraph to display a line.
      *
       DRAW-LINE.
           DISPLAY LINE-DASH.
       DRAW-LINE-END.
      *
      *                   Paragraph to display the content of SOMETHING.
      *
       DISPLAY-SOMETHING.
           DISPLAY "The variable now contains " SOMETHING.
       DISPLAY-SOMETHING-END.
      *
      *                         Paragraph to call the two previous ones.
      *
       REPORT-STATUS.
           PERFORM DISPLAY-SOMETHING
           PERFORM DRAW-LINE.
       REPORT-STATUS-END.
      *
      *                                     Different paragraphs to call
      *                                  in the second EVALUATE example.
      *
       HANDLE-LOW.
           DISPLAY "The value is 1".
       HANDLE-LOW-END.
      *
       HANDLE-MID.
           DISPLAY "The value is between 2 and 20".
       HANDLE-MID-END.
      *
       HANDLE-UNKNOWN.
           DISPLAY "Not a valid case.".
       HANDLE-UNKNOWN-END.
