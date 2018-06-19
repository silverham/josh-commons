@ECHO OFF

REM Don't make our environment variable changes persist after script finishes.
SETLOCAL

REM xampp version (default - different port to desktop)
@"C:\xampp\mysql\bin\mysql.exe" --defaults-file="C:\xampp\mysql\bin\my.ini" %*

REM dev desktop mysql (different port to xampp)
REM @"C:\Program Files (x86)\DevDesktop\mysql\bin\mysql.exe" --defaults-file="C:\Program Files (x86)\DevDesktop\mysql\my.cnf" %*
