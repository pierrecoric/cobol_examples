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
       01  COVID-RECORD                   PIC X(150).

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
           05 NEW-CONF                    PIC X(8).
           05 TOTAL-CONF                  PIC X(8).
           05 NEW-DEATH                   PIC X(8).
           05 TOTAL-DEATH                 PIC X(8).
           05 NEW-REC                     PIC X(8).
           05 TOTAL-REC                   PIC X(8).
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
              10 NEW-CONF-FRMT            PIC 9(8).
              10 TOTAL-CONF-FRMT          PIC 9(8).
              10 NEW-DEATH-FRMT           PIC 9(8).
              10 TOTAL-DEATH-FRMT         PIC 9(8).
              10 NEW-REC-FRMT             PIC 9(8).
              10 TOTAL-REC-FRMT           PIC 9(8).
              10 DATE-FRMT                PIC X(10).
              10 TIME-FRMT                PIC X(15).
      *
       01  STR-LEN                        PIC 9(3).
       01  ENTRY-COUNT                    PIC 9(3) VALUE 0.
       01  ENTRY-INDEX                    PIC 9(3).
       01  LAST-RECORD                    PIC X(1) VALUE SPACE.

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
      *                                        Read the record one extra
      *                                        time to skip the headers.
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
      *                                          Paragraph to format the
      *                                  different fields of the record.
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

           COMPUTE NEW-CONF-FRMT(ENTRY-COUNT)
           = FUNCTION NUMVAL(NEW-CONF)

           COMPUTE TOTAL-CONF-FRMT(ENTRY-COUNT)
           = FUNCTION NUMVAL(TOTAL-CONF)

           COMPUTE NEW-DEATH-FRMT(ENTRY-COUNT)
           = FUNCTION NUMVAL(NEW-DEATH)

           COMPUTE TOTAL-DEATH-FRMT(ENTRY-COUNT)
           = FUNCTION NUMVAL(TOTAL-DEATH)

           COMPUTE NEW-REC-FRMT(ENTRY-COUNT)
           = FUNCTION NUMVAL(NEW-REC)

           COMPUTE TOTAL-REC-FRMT(ENTRY-COUNT)
           = FUNCTION NUMVAL(TOTAL-REC)

           MOVE DATE-TXT(2:11)
           TO DATE-FRMT(ENTRY-COUNT).

           MOVE DATE-TXT(12:10)
           TO TIME-FRMT(ENTRY-COUNT).
       FORMAT-RECORD-END.
      *
      *                            Paragraph to display all the records.
      *
       WRITE-RECORD.
           PERFORM VARYING ENTRY-INDEX FROM 1 BY 1
              UNTIL ENTRY-INDEX EQUAL ENTRY-COUNT
              DISPLAY
              "*********************************"
              "*********************************"

              DISPLAY
              "DATE: "
              DATE-FRMT(ENTRY-INDEX)

              DISPLAY
              "TIME: "
              TIME-FRMT(ENTRY-INDEX)

              DISPLAY
              "COUNTRY: "
              COUNTRY-FRMT(ENTRY-INDEX)

              DISPLAY
              "COUNTRY CODE: "
              COUNTRY-CODE-FRMT(ENTRY-INDEX)

              DISPLAY
              "SLUG: "
              SLUG-FRMT(ENTRY-INDEX)

              DISPLAY
              "NEW CONFIRMED CASES:   "
              NEW-CONF-FRMT(ENTRY-INDEX)

              DISPLAY
              "TOTAL CONFIRMED CASES: "
              TOTAL-CONF-FRMT(ENTRY-INDEX)

              DISPLAY
              "NEW DEATHS:            "
              NEW-DEATH-FRMT(ENTRY-INDEX)

              DISPLAY
              "TOTAL DEATHS:          "
              TOTAL-DEATH-FRMT(ENTRY-INDEX)

              DISPLAY
              "NEW RECOVERIES:        "
              NEW-REC-FRMT(ENTRY-INDEX)

              DISPLAY
              "TOTAL RECOVERIES:      "
              TOTAL-REC-FRMT(ENTRY-INDEX)

              DISPLAY
              "*********************************"
              "*********************************"

              DISPLAY " "
           END-PERFORM.
       WRITE-RECORD-END.

      *
      *                                             The required format.
      *
      ******************************************************************
      *DATE: 2020-04-22
      *TIME: T16:54:5
      *COUNTRY: "Antigua and Barbuda"
      *COUNTRY CODE: "AG"
      *SLUG: "antigua-and-barbuda"
      *NEW CONFIRMED CASES: 00000
      *TOTAL CONFIRMED CASES: 00023
      *NEW DEATHS: 00000
      *TOTAL DEATHS: 00003
      *NEW RECOVERIES: 00004
      *TOTAL RECOVERIES: 00007
      ******************************************************************
