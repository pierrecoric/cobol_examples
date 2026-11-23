      *----------------------------------------------------------------- 
       IDENTIFICATION DIVISION.
      *-----------------------------------------------------------------
       PROGRAM-ID. COVID.
       AUTHOR. "Pierre".

      *-----------------------------------------------------------------
       ENVIRONMENT DIVISION.
      *-----------------------------------------------------------------
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT COVID-REPORT ASSIGN TO COVIDIN.

      *-----------------------------------------------------------------
       DATA DIVISION.
      *-----------------------------------------------------------------
       FILE SECTION.
       FD COVID-REPORT RECORDING MODE F.
       01  COVID-RECORD                   PIC X(210).

       WORKING-STORAGE SECTION. 

      *                                              Format of the data:
      *
      *                                              Country
      *                                              CountryCode
      *                                              Slug
      *                                              NewConfirmed
      *                                              TotalConfirmed
      *                                              NewDeaths
      *                                              TotalDeaths
      *                                              NewRecovered
      *                                              TotalRecovered
      *                                              Date 
      *
      *                              Fields to get the raw textual data. 
      *
       01  RECORD-TXT.
           05 COUNTRY                     PIC X(50).
           05 COUNTRY-CODE                PIC X(8).
           05 SLUG                        PIC X(50).
           05 NEW-CONF                    PIC X(12).
           05 TOTAL-CONF                  PIC X(12).
           05 NEW-DEATH                   PIC X(12).
           05 TOTAL-DEATH                 PIC X(12).
           05 NEW-REC                     PIC X(12).
           05 TOTAL-REC                   PIC X(12).
           05 DATE-TXT                    PIC X(25).
      *
      *                                    Initializing a table with 250
      *                            entries to store the formated fields.
      *
       01  RECORD-TABLE.
           05 FORMATTED-ENTRY OCCURS 250 TIMES.
              10 COUNTRY-FRMT             PIC X(50).
              10 COUNTRY-CODE-FRMT        PIC X(8).
              10 SLUG-FRMT                PIC X(50).
              10 NEW-CONF-FRMT            PIC 9(12).
              10 TOTAL-CONF-FRMT          PIC 9(12).
              10 NEW-DEATH-FRMT           PIC 9(12).
              10 TOTAL-DEATH-FRMT         PIC 9(12).
              10 NEW-REC-FRMT             PIC 9(12).
              10 TOTAL-REC-FRMT           PIC 9(12).
              10 DATE-FRMT                PIC X(25).
      * 
       77  STR-LEN                        PIC 9(3).
       77  ENTRY-COUNT                    PIC 9(3) VALUE 0.
       77  ENTRY-INDEX                    PIC 9(3).
       77  LAST-RECORD                    PIC X(1) VALUE SPACE.
      
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
      *-----------------------------------------------------------------
      *
      *                                                   Open the file.
      *
       OPEN-FILE.     
           OPEN INPUT COVID-REPORT.
       OPEN-FILE-END.
      *
      *                      This order of operation to skip the header.
      *                                                       To review.
      *
       READ-NEXT-RECORD.
           PERFORM READ-RECORD
           PERFORM READ-RECORD.
           PERFORM UNTIL LAST-RECORD EQUAL "Y"
              PERFORM POPULATE-RECORD-TXT
              PERFORM FORMAT-RECORD
              PERFORM READ-RECORD
           END-PERFORM.
       READ-NEXT-RECORD-END.
      *
      *            Call the WRITE-RECORD paragraph to output the result.
      *
           PERFORM WRITE-RECORD.
      *
      *                                                  Close the file. 
      *
       CLOSE-STOP.
           CLOSE COVID-REPORT.
           STOP RUN.
      *
      *                       Read a record, change the flag at the end.
      *
       READ-RECORD.
           READ COVID-REPORT
           AT END MOVE "Y" TO LAST-RECORD
           END-READ.
       READ-RECORD-END.
      *
      *                  Paragraph to populate the record with raw text.
      *
       POPULATE-RECORD-TXT.
           MOVE SPACES TO RECORD-TXT
           UNSTRING COVID-RECORD DELIMITED BY ','
           INTO
           COUNTRY
           COUNTRY-CODE 
           SLUG 
           NEW-CONF 
           TOTAL-CONF 
           NEW-DEATH 
           TOTAL-DEATH 
           NEW-REC 
           TOTAL-REC
           DATE-TXT
           END-UNSTRING
           ADD 1 TO ENTRY-COUNT.
       POPULATE-RECORD-TXT-END.
      *
      *                                 Paragraph to format the records.
      *
       FORMAT-RECORD.
           COMPUTE STR-LEN = FUNCTION 
           LENGTH(FUNCTION TRIM(COUNTRY TRAILING))
           MOVE COUNTRY(2:STR-LEN - 2) 
           TO COUNTRY-FRMT(ENTRY-COUNT)
           
           COMPUTE STR-LEN = FUNCTION 
           LENGTH(FUNCTION TRIM(COUNTRY-CODE TRAILING))
           MOVE COUNTRY-CODE(2:STR-LEN - 2)
           TO COUNTRY-CODE-FRMT(ENTRY-COUNT)
           
           COMPUTE STR-LEN = FUNCTION 
           LENGTH(FUNCTION TRIM(SLUG TRAILING))
           MOVE SLUG(2:STR-LEN - 2)
           TO SLUG-FRMT(ENTRY-COUNT)
           
           MOVE FUNCTION NUMVAL(NEW-CONF)
           TO NEW-CONF-FRMT(ENTRY-COUNT)
           
           MOVE FUNCTION NUMVAL(TOTAL-CONF)
           TO TOTAL-CONF-FRMT(ENTRY-COUNT)
           
           MOVE FUNCTION NUMVAL(NEW-DEATH)
           TO NEW-DEATH-FRMT(ENTRY-COUNT)

           MOVE FUNCTION NUMVAL(TOTAL-DEATH)
           TO TOTAL-DEATH-FRMT(ENTRY-COUNT)

           MOVE FUNCTION NUMVAL(NEW-REC)
           TO NEW-REC-FRMT(ENTRY-COUNT)

           MOVE FUNCTION NUMVAL(TOTAL-REC)
           TO TOTAL-REC-FRMT(ENTRY-COUNT)

           COMPUTE STR-LEN = FUNCTION 
           LENGTH(FUNCTION TRIM(DATE-TXT TRAILING))
           MOVE DATE-TXT(2:STR-LEN - 2)
           TO DATE-FRMT(ENTRY-COUNT).
       FORMAT-RECORD-END.
      *
      *Let's just display for now.
      *
       WRITE-RECORD.
           PERFORM VARYING ENTRY-INDEX FROM 1 BY 1
              UNTIL ENTRY-INDEX > ENTRY-COUNT
              DISPLAY FORMATTED-ENTRY(ENTRY-INDEX)
           END-PERFORM.
       WRITE-RECORD-END.
      