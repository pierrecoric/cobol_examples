//SUB1 JOB  1,NOTIFY=&SYSUID
//*-------------------------------------------------------------
//*                                     Step 1: compile and link
//*                                    the subprograms HELLO and
//*                                       HELLO2 into a library.
//*-------------------------------------------------------------
//SUB    EXEC IGYWCL,SRC=HELLO2
//LKED.SYSLMOD DD DISP=SHR,DSN=&SYSUID..LOAD(HELLO2)
//SUB    EXEC IGYWCL,SRC=HELLO
//LKED.SYSLMOD DD DISP=SHR,DSN=&SYSUID..LOAD(HELLO)
//*-------------------------------------------------------------
//*                                             Step 2: compile,
//*                                             link and run the
//*                                             calling program.
//*-------------------------------------------------------------
//MAIN   EXEC IGYWCLG,SRC=SUB1
//LKED.SYSLIB  DD DISP=SHR,DSN=CEE.SCEELKED
//             DD DISP=SHR,DSN=&SYSUID..LOAD
