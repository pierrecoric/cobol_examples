//COVID JOB 1,NOTIFY=&SYSUID
//***************************************************/
//COBRUN  EXEC IGYWCL
//COBOL.SYSIN  DD DSN=&SYSUID..CBL(COVID),DISP=SHR
//LKED.SYSLMOD DD DSN=&SYSUID..LOAD(COVID),DISP=SHR
//***************************************************/
// IF RC = 0 THEN
//***************************************************/
//RUN     EXEC PGM=COVID
//STEPLIB   DD DSN=&SYSUID..LOAD,DISP=SHR
//COVIDIN   DD DSN=&SYSUID..COVID.CSV,DISP=SHR
//PRTLINE   DD SYSOUT=*,OUTLIM=15000
//SYSOUT    DD SYSOUT=*,OUTLIM=15000
//CEEDUMP   DD DUMMY
//SYSUDUMP  DD DUMMY
//***************************************************/
// ELSE
// ENDIF
