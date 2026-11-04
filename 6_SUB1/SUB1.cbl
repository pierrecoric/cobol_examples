      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
      *-----------------------------------------------------------------
       PROGRAM-ID SUB1.
       AUTHOR "Pierre".

      *-----------------------------------------------------------------
       ENVIRONMENT DIVISION.
      *-----------------------------------------------------------------
       
      *-----------------------------------------------------------------
       DATA DIVISION.
       WORKING-STORAGE SECTION. 
      *-----------------------------------------------------------------

       01 PARAM-NAME   PIC X(20).
      
       
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
      *-----------------------------------------------------------------
           
      *
      *                                       This program calls another
      *                                 programm called HELLO. The links
      *                                        are specified in the JCL.
      *                                      At the end of HELLO, GOBACK
      *                                  stops it and gives control back
      *                                          to the calling program.
      *    
           CALL "HELLO".
      *
      *                           It then calls another program, HELLO2,
      *                                      which can take a parameter.
      *                                        It calls it a second time 
      *                            after filling the PARAM-NAME variable
      *                                with null characters to replicate
      *                                        that program being called
      *                                    on its own without parameter.
      *
           MOVE "Pierre" TO PARAM-NAME.
           CALL "HELLO2" USING PARAM-NAME
           MOVE LOW-VALUES TO PARAM-NAME.
           CALL "HELLO2" USING PARAM-NAME.
      *
      *                                   STOP RUN stops the entire run.
      *                                       GOBACK could also be used.
      *
           STOP RUN.
