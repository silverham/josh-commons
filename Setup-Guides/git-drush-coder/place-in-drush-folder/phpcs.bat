@ECHO OFF
setlocal DISABLEDELAYEDEXPANSION
REM OLD
REM SET BIN_TARGET=%~dp0/../squizlabs/php_codesniffer/scripts/phpcs
REM NEW COMPOSER HOME or relative to outside vendor
REM SET BIN_TARGET=%~dp0/vendor/squizlabs/php_codesniffer/scripts/phpcs

IF "%COMPOSER_HOME%"=="" (
  REM echo NOT SET
  IF EXIST "%USERPROFILE%/AppData/Roaming/Composer/vendor/squizlabs/php_codesniffer/scripts/phpcs" (
    REM file exists
    SET BIN_TARGET="%USERPROFILE%/AppData/Roaming/Composer/vendor/squizlabs/php_codesniffer/scripts/phpcs"
  ) ELSE IF EXIST "%~dp0vendor/squizlabs/php_codesniffer/scripts/phpcs" (
    SET BIN_TARGET="%~dp0vendor/squizlabs/php_codesniffer/scripts/phpcs"
  )
) ELSE (
  IF EXIST "%COMPOSER_HOME%/vendor/squizlabs/php_codesniffer/scripts/phpcs" (
    SET BIN_TARGET="%COMPOSER_HOME%/vendor/squizlabs/php_codesniffer/scripts/phpcs"
  )
)


IF "%BIN_TARGET%"=="" (
  echo phpcs not found. RUN:
  echo ------------------------
  echo composer global require drupal/coder
  echo ------------------------
  echo to download it. Trying in current dir anyway....
  SET BIN_TARGET="%~dp0vendor/squizlabs/php_codesniffer/scripts/phpcs"
)

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

php %BIN_TARGET% %*
