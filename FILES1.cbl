      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
      *-----------------------------------------------------------------
       PROGRAM-ID. FILES1.
       AUTHOR. "Pierre".

      *-----------------------------------------------------------------
       ENVIRONMENT DIVISION.
      *-----------------------------------------------------------------
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT WORDS-LIST ASSIGN TO WRDLIST.

      *-----------------------------------------------------------------
       DATA DIVISION.
      *-----------------------------------------------------------------
      *
      *                              In the FILE SECTION we describe the
      *                different files that will be used by the program.
      *                                   FD (File Definition) describes
      *                       the types of records that are to be found.
      *
      *                                The program reads data as blocks.
      *                      In this example, each record (WORDS-RECORD)
      *                          comprises of 4 fields of 20 characters.
      * 
       FILE SECTION.
       FD WORDS-LIST RECORDING MODE F.
       01  WORDS-RECORD.
           05 FRENCH           PIC X(20).
           05 ENGLISH          PIC X(20).
           05 CROATIAN         PIC X(20).
           05 POLISH           PIC X(20).
      *
      *                                           LAST-RECORD is a flag.
      *
       WORKING-STORAGE SECTION.
       77  LAST-RECORD         PIC X(1) VALUE SPACE.

      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
      *-----------------------------------------------------------------

      *
      *                                    A paragraph to open the file.
      * 
       OPEN-FILE.
           OPEN INPUT WORDS-LIST.
      
      *
      *                            The paragraph READ-NEXT-RECORD starts
      *                     by a perform statement calling the paragraph
      *             READ-RECORD to ensure that it is read at least once.
      *
      *                             It is followed by a loop that checks
      *                                           the state of the flag.
      *
      *                            If the record still contains data, it
      *                          displays them by calling DISPLAY-RECORD
      *                   and calls READ-RECORD to read the next record.
      *
       READ-NEXT-RECORD.
           PERFORM READ-RECORD
           PERFORM UNTIL LAST-RECORD = 'Y'
               PERFORM DISPLAY-RECORD
               PERFORM READ-RECORD
           END-PERFORM.

      *
      *                                    Paragraph CLOSE-STOP to close
      *                                    the file and end the program.
      *
       CLOSE-STOP.
           CLOSE WORDS-LIST.
           GOBACK.
      
      *
      *                           READ-RECORD paragraph reads the fields
      *                          as they are described above (FD clause)
      *                             It sets LAST-RECORD flag to "Y" when
      *                               it reaches the end of the data set
      *
       READ-RECORD.
           READ WORDS-LIST
           AT END MOVE "Y" TO LAST-RECORD
           END-READ.
      
      *
      *                                     The DISPLAY-RECORD Paragraph
      *                             simply displays the different fields
      *
       DISPLAY-RECORD.
           DISPLAY FRENCH
                   ENGLISH
                   CROATIAN
                   POLISH.
