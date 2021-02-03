@echo OFF
rem Drush automatically determines the user's home directory by checking for
rem HOME or HOMEDRIVE/HOMEPATH environment variables, and the temporary
rem directory by checking for TEMP, TMP, or WINDIR environment variables.
rem The home path is used for caching Drush commands and the git --reference
rem cache. The temporary directory is used by various commands, including
rem package manager for downloading projects.
rem You may want to specify a path that is not user-specific here; e.g., to
rem keep cache files on the same filesystem, or to share caches with other
rem users.

rem set HOME=H:/drush
rem set TEMP=H:/drush

REM See http://drupal.org/node/506448 for more information.\

REM use older php for druapl less than 7.50 - php7 is faster.
REM IF "%PHP_ID%"=="" (SET PHP_ID=php5_5)

REM Don't make our environment variable changes persist after script finishes. (set local)
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

@SET PATH=C:\%PHP_ID%\mysql\bin;%PATH%
@SET PATH=C:\%PHP_ID%\php;%PATH%

REM get path from path to file.
REM e.g. C:\path\file.exe
REM into C:\path
REM call :file_name_from_path result !myPath!
REM echo %result%
REM :file_name_from_path <resultVar> <pathVar>
REM (
REM     set "%~1=%~nx2"
REM     exit /b
REM )

IF "%COMPOSER_HOME%"=="" (
  REM echo NOT SET
  REM file exists
REM  IF EXIST "%USERPROFILE%/AppData/Roaming/Composer/vendor/bin/drush.phar" (
REM    REM Run drush launcher.
REM    SET BIN_TARGET="%USERPROFILE%/AppData/Roaming/Composer/vendor/bin/drush.phar"
REM  ) ELSE IF EXIST "%~dp0drush.phar" (
REM     REM Run drush launcher.
REM     SET BIN_TARGET="%~dp0drush.phar" 
REM   ) ELSE
  IF EXIST "%USERPROFILE%/AppData/Roaming/Composer/vendor/drush/drush/drush.php" (
    REM Run drush php script.
    REM Note: not using "drush" script as it fails on updb with file/volume incorrect error.
    SET BIN_TARGET="%USERPROFILE%/AppData/Roaming/Composer/vendor/drush/drush/drush.php"
  ) ELSE IF EXIST "%~dp0vendor/drush/drush/drush.php" (
    REM fallback to devdesktop drush.php
    SET BIN_TARGET="%~dp0vendor/drush/drush/drush.php"
  )
) ELSE (
REM  IF EXIST "%COMPOSER_HOME%/vendor/bin/drush.phar" (
REM    SET BIN_TARGET="%COMPOSER_HOME%/vendor/bin/drush.phar"
REM  ) ELSE 
  IF EXIST "%COMPOSER_HOME%/vendor/drush/drush/drush.php" (
    SET BIN_TARGET="%COMPOSER_HOME%/vendor/drush/drush/drush.php"
  )
)

IF %BIN_TARGET%=="" (
  echo drush not found. RUN:
  echo ------------------------
  echo composer global require drush/drush:8.*
  echo ------------------------
  echo to download it. Trying in current dir anyway....
  SET BIN_TARGET="%~dp0vendor/drush/drush/drush.php"
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
  @php.exe %BIN_TARGET% --php="php.exe" %*
)
