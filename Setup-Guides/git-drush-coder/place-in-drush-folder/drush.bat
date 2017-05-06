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

IF "%PHP_ID%"=="" (SET PHP_ID=php7_0)

SET DEVDESKTOP_DRUPAL_SETTINGS_DIR=%USERPROFILE%\.acquia\DevDesktop\DrupalSettings
SET PATH=C:\Program Files (x86)\DevDesktop\common\msys\bin;C:\Program Files (x86)\DevDesktop\%PHP_ID%;C:\Program Files (x86)\DevDesktop\mysql\bin;%PATH%
IF EXIST "%USERPROFILE%\.acquia\DevDesktop\ssh-agent-params.bat" (
  CALL "%USERPROFILE%\.acquia\DevDesktop\ssh-agent-params.bat"
)

IF "%COMPOSER_HOME%"=="" (
  REM echo NOT SET
  REM file exists
  IF EXIST "%USERPROFILE%/AppData/Roaming/Composer/vendor/drush/drush/drush" (
    REM Try "proper" drush script
    SET BIN_TARGET="%USERPROFILE%/AppData/Roaming/Composer/vendor/drush/drush/drush"
  ) ELSE IF EXIST "%~dp0vendor/drush/drush/drush" (
    REM fallback to devdesktop "proper" drush
    SET BIN_TARGET="%~dp0vendor/drush/drush/drush"
  ) ELSE IF EXIST "%~dp0vendor/drush/drush/drush.php" (
    REM fallback to devdesktop drush.php
    SET BIN_TARGET="%~dp0vendor/drush/drush/drush.php"
  )
) ELSE (
  IF EXIST "%COMPOSER_HOME%/vendor/drush/drush/drush" (
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

@php.exe %BIN_TARGET% --php="php.exe" %*
