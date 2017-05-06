@ECHO OFF

REM xampp version (default - different port to desktop)
@"C:\xampp\mysql\bin\mysqldump.exe" --defaults-file="C:\xampp\mysql\bin\my.ini" %*

REM dev desktop mysql (different port to xampp)
REM @"C:\Program Files (x86)\DevDesktop\mysql\bin\mysqldump.exe" --defaults-file="C:\Program Files (x86)\DevDesktop\mysql\my.cnf" %*