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

SET DEVDESKTOP_DRUPAL_SETTINGS_DIR=%USERPROFILE%\.acquia\DevDesktop\DrupalSettings
SET PATH=C:\Program Files (x86)\DevDesktop\common\msys\bin;C:\Program Files (x86)\DevDesktop\%PHP_ID%;C:\Program Files (x86)\DevDesktop\mysql\bin;%PATH%
IF EXIST "%USERPROFILE%\.acquia\DevDesktop\ssh-agent-params.bat" (
  CALL "%USERPROFILE%\.acquia\DevDesktop\ssh-agent-params.bat"
)

IF "%COMPOSER_HOME%"=="" (
  REM echo NOT SET
  REM file exists
  IF EXIST "%USERPROFILE%/AppData/Roaming/Composer/vendor/bin/drush.phar" (
    REM Run drush launcher.
    SET BIN_TARGET="%USERPROFILE%/AppData/Roaming/Composer/vendor/bin/drush.phar"
  ) ELSE IF EXIST "%~dp0drush.phar" (
    REM Run drush launcher.
    SET BIN_TARGET="%~dp0drush.phar" 
  ) ELSE IF EXIST "%USERPROFILE%/AppData/Roaming/Composer/vendor/drush/drush/drush" (
    REM Run drush php script.
    REM Note: not using "drush" script as it fails on updb with file/volume incorrect error.
    SET BIN_TARGET="%USERPROFILE%/AppData/Roaming/Composer/vendor/drush/drush/drush"
  ) ELSE IF EXIST "%~dp0vendor/drush/drush/drush" (
    REM fallback to devdesktop drush.php
    SET BIN_TARGET="%~dp0vendor/drush/drush/drush"
  )
) ELSE (
  IF EXIST "%COMPOSER_HOME%/vendor/bin/drush.phar" (
    SET BIN_TARGET="%COMPOSER_HOME%/vendor/bin/drush.phar"
  ) ELSE IF EXIST "%COMPOSER_HOME%/vendor/drush/drush/drush" (
    SET BIN_TARGET="%COMPOSER_HOME%/vendor/drush/drush/drush"
  )
)

IF %BIN_TARGET%=="" (
  echo drush not found. RUN:
  echo ------------------------
  echo composer global require drush/drush:8.*
  echo ------------------------
  echo to download it. Trying in current dir anyway....
  SET BIN_TARGET="%~dp0vendor/drush/drush/drush"
)

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
  REM Run the command
  @php.exe %BIN_TARGET% --php="php.exe" %*
)
