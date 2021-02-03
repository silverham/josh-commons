@ECHO OFF
setlocal DISABLEDELAYEDEXPANSION
REM OLD
REM SET BIN_TARGET=%~dp0/../squizlabs/php_codesniffer/scripts/phpcbf
REM NEW COMPOSER HOME or relative to outside vendor
REM SET BIN_TARGET=%~dp0/vendor/squizlabs/php_codesniffer/bin/phpcbf

REM Don't make our environment variable changes persist after script finishes.
SETLOCAL

REM SETLOCAL enabledelayedexpansion enableextensions
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

IF "%COMPOSER_HOME%"=="" (
  REM echo NOT SET
  IF EXIST "%USERPROFILE%/AppData/Roaming/Composer/vendor/squizlabs/php_codesniffer/bin/phpcbf" (
    REM file exists
    SET BIN_TARGET="%USERPROFILE%/AppData/Roaming/Composer/vendor/squizlabs/php_codesniffer/bin/phpcbf"
  ) ELSE IF EXIST "%~dp0vendor/squizlabs/php_codesniffer/bin/phpcbf" (
    SET BIN_TARGET="%~dp0vendor/squizlabs/php_codesniffer/bin/phpcbf"
  )
) ELSE (
  IF EXIST "%COMPOSER_HOME%/vendor/squizlabs/php_codesniffer/bin/phpcbf" (
    SET BIN_TARGET="%COMPOSER_HOME%/vendor/squizlabs/php_codesniffer/bin/phpcbf"
  )
)


IF "%BIN_TARGET%"=="" (
  echo phpcbf not found. RUN:
  echo ------------------------
  echo composer global require drupal/coder
  echo ------------------------
  echo to download it. Trying in current dir anyway....
  SET BIN_TARGET="%~dp0vendor/squizlabs/php_codesniffer/bin/phpcs"
)

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
  REM Run the command
  php.exe %BIN_TARGET% %*
)
