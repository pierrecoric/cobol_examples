      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID COND1.
       AUTHOR "Pierre".
      *-----------------------------------------------------------------

      *-----------------------------------------------------------------
       ENVIRONMENT DIVISION.
      *-----------------------------------------------------------------

      *-----------------------------------------------------------------
       DATA DIVISION.
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.

       01 SOMETHING PIC 9(2) VALUE 5.
       01 LINE-DASH PIC X(10) VALUE "----------".
      

      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
      *-----------------------------------------------------------------
           
           PERFORM REPORT-STATUS.

           IF SOMETHING IS GREATER THAN 10
               THEN DISPLAY "Greater than 10."
               ELSE DISPLAY "Not greater than 10."
           END-IF.

           DISPLAY "Moving 11 to Something.".
           MOVE 11 TO SOMETHING.
           PERFORM REPORT-STATUS.
           PERFORM EVAL-SOMETHING.

           DISPLAY "Moving 0 to Something.".
           MOVE 0 TO SOMETHING.
           PERFORM REPORT-STATUS.
           PERFORM EVAL-SOMETHING.

           DISPLAY "Moving 10 to Something.".
           MOVE 10 TO SOMETHING.
           PERFORM REPORT-STATUS.
           PERFORM EVAL-SOMETHING.

           PERFORM DRAW-LINE.
           DISPLAY "Next Example.".
           PERFORM DRAW-LINE.

           DISPLAY "Moving 1 to Something.".
           MOVE 1 TO SOMETHING.
           PERFORM REPORT-STATUS.
           PERFORM EVAL-SOMETHING-AGAIN.

           DISPLAY "Moving 22 to Something.".
           MOVE 1 TO SOMETHING.
           PERFORM REPORT-STATUS.
           PERFORM EVAL-SOMETHING-AGAIN.





       STOP-CLOSE.
           DISPLAY "Goodbye."
           STOP RUN.

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

       EVAL-SOMETHING-AGAIN.
           EVALUATE SOMETHING
               WHEN 1               PERFORM HANDLE-LOW
               WHEN 2 THROUGH 20    PERFORM HANDLE-MID
               WHEN OTHER           PERFORM HANDLE-UNKNOWN
           END-EVALUATE.
       EVAL-SOMETHING-AGAIN-END.

       DRAW-LINE.
           DISPLAY LINE-DASH.
       DRAW-LINE-END.

       DISPLAY-SOMETHING.
           DISPLAY "The variable now contains " SOMETHING.
       DISPLAy-SOMETHING-END.

       REPORT-STATUS.
           PERFORM DISPLAY-SOMETHING
           PERFORM DRAW-LINE
       REPORT-STATUS-END.

       HANDLE-LOW.
           DISPLAY "The value is 1".
       HANDLE-LOW-END.

       HANDLE-MID.
           DISPLAY "The value is between 2 and 20".
       HANDLE-MID-END.

       HANDLE-UNKNOWN.
           DISPLAY "Not a valid case.".
       HANDLE-UNKNOWN-END.
