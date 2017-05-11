@ECHO OFF
setlocal DISABLEDELAYEDEXPANSION
REM OLD
REM SET BIN_TARGET=%~dp0/../squizlabs/php_codesniffer/scripts/phpcbf
REM NEW COMPOSER HOME or relative to outside vendor
REM SET BIN_TARGET=%~dp0/vendor/squizlabs/php_codesniffer/scripts/phpcbf

IF "%COMPOSER_HOME%"=="" (
  REM echo NOT SET
  IF EXIST "%USERPROFILE%/AppData/Roaming/Composer/vendor/squizlabs/php_codesniffer/scripts/phpcbf" (
    REM file exists
    SET BIN_TARGET="%USERPROFILE%/AppData/Roaming/Composer/vendor/squizlabs/php_codesniffer/scripts/phpcbf"
  ) ELSE IF EXIST "%~dp0vendor/squizlabs/php_codesniffer/scripts/phpcbf" (
    SET BIN_TARGET="%~dp0vendor/squizlabs/php_codesniffer/scripts/phpcbf"
  )
) ELSE (
  IF EXIST "%COMPOSER_HOME%/vendor/squizlabs/php_codesniffer/scripts/phpcbf" (
    SET BIN_TARGET="%COMPOSER_HOME%/vendor/squizlabs/php_codesniffer/scripts/phpcbf"
  )
)


IF "%BIN_TARGET%"=="" (
  echo phpcbf not found. RUN:
  echo ------------------------
  echo composer global require drupal/coder
  echo ------------------------
  echo to download it. Trying in current dir anyway....
  SET BIN_TARGET="%~dp0vendor/squizlabs/php_codesniffer/scripts/phpcs"
)

IF "%PHP_ID%"=="" (SET PHP_ID=php7_0)

@SET PATH=C:\Program Files (x86)\DevDesktop\%PHP_ID%;%PATH%

php %BIN_TARGET% %*
