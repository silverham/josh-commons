@ECHO OFF
setlocal DISABLEDELAYEDEXPANSION
REM OLD
REM SET BIN_TARGET=%~dp0/../squizlabs/php_codesniffer/scripts/phpcs
REM NEW relative to outside vendor
SET BIN_TARGET=%~dp0/vendor/squizlabs/php_codesniffer/scripts/phpcs
php "%BIN_TARGET%" %*
