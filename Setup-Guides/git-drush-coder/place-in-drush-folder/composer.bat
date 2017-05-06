@echo off
REM @SET PATH=C:\Program Files (x86)\DevDesktop\php5_4;%PATH%

IF "%PHP_ID%"=="" (SET PHP_ID=php7_0)
@SET PATH=C:\Program Files (x86)\DevDesktop\%PHP_ID%;%PATH%

REM @php.exe composer.phar %*

REM use current directory composer
@php.exe "%~dp0composer.phar" %*