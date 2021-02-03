@echo off
REM @SET PATH=C:\Program Files (x86)\DevDesktop\php5_4;%PATH%

REM Don't make our environment variable changes persist after script finishes.
SETLOCAL

REM REM Use latest PHP version we have.
REM IF "%PHP_ID%"=="" (
REM   REM taken fromhttps://stackoverflow.com/a/180749
REM   for /f "usebackq delims=|" %%f in (`dir /b /O:-N "%~dp0.." ^| findstr /R php[0-9]`) do (
REM     SET PHP_ID=%%f
REM     goto :endforloop
REM   )
REM )
REM :endforloop

IF "%PHP_ID%"=="" (
  SET PHP_ID="xampp-7-1-64bit"
)

@SET PATH=C:\%PHP_ID%\php;%PATH%

REM @php.exe composer.phar %*

REM check if php.exe was found
WHERE php.exe >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
  ECHO php.exe wasn't found in PATH
  ECHo The following php folders are available ^(SET PHP_ID=foldername^)
  REM Finds folders with phpNUM_NUM* (1 or more numbers after)
  REM dir "C:\Program Files (x86)\DevDesktop" /A | findstr ^<DIR^> | findstr php[0-9]_[0-9]*$
  dir "C:\" /A | findstr ^<DIR^> | findstr ^xampp
  REM Exit with error code 1
  exit /b 1
) ELSE (
  REM use current directory composer
  REM @php.exe "%~dp0composer.phar" %*
  @php.exe -d memory_limit=-1 "%~dp0composer.phar" %*
)


