@echo off
REM @SET PATH=C:\Program Files (x86)\DevDesktop\php5_4;%PATH%

REM Don't make our environment variable changes persist after script finishes.
SETLOCAL

REM Use latest PHP version we have.
IF "%PHP_ID%"=="" (
  REM taken fromhttps://stackoverflow.com/a/180749
  for /f "usebackq delims=|" %%f in (`dir /b /O:-N "%~dp0.." ^| findstr /R php[0-9]`) do (
    SET PHP_ID=%%f
    goto :endforloop
  )
)
:endforloop

@SET PATH=C:\Program Files (x86)\DevDesktop\%PHP_ID%;%PATH%

REM @php.exe composer.phar %*

REM check if php.exe was found
WHERE php.exe >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
  ECHO php.exe wasn't found in PATH
  ECHo The following php folders are available ^(SET PHP_ID=foldername^)
  REM Finds folders with phpNUM_NUM* (1 or more numbers after)
  dir "C:\Program Files (x86)\DevDesktop" /A | findstr ^<DIR^> | findstr php[0-9]_[0-9]*$
  REM Exit with error code 1
  exit /b 1
) ELSE (
  REM use current directory composer
  @php.exe "%~dp0composer.phar" %*
)


