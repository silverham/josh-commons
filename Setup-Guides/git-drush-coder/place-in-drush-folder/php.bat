@echo off 

REM PHP bat file - A wrapper for dev desktop php.exe file
REM needed for phpcs in sublime etc.
REM usage: php -r "echo 'test';"

REM use older php for druapl less than 7.50 - php7 is faster.
REM IF "%PHP_ID%"=="" (SET PHP_ID=php5_6)

IF "%PHP_ID%"=="" (SET PHP_ID=php7_0)

SET PATH=C:\Program Files (x86)\DevDesktop\common\msys\bin;C:\Program Files (x86)\DevDesktop\%PHP_ID%;C:\Program Files (x86)\DevDesktop\mysql\bin;%PATH%

@php.exe %*
