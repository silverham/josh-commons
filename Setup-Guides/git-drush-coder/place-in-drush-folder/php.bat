@echo off 

REM PHP bat file - A wrapper for dev desktop php.exe file
REM needed for phpcs in sublime etc.
REM usage: php -r "echo 'test';"

REM use older php for druapl less than 7.50 - php7 is faster.
REM IF "%PHP_ID%"=="" (SET PHP_ID=php5_6)

REM Use latest PHP version we have.
IF "%PHP_ID%"=="" (
  REM taken fromhttps://stackoverflow.com/a/180749
  for /f "usebackq delims=|" %%f in (`dir /b /O:-N "%~dp0.." ^| findstr /R php[0-9]`) do (
    SET PHP_ID=%%f
    goto :endforloop
  )
)
:endforloop

SET PATH=C:\Program Files (x86)\DevDesktop\common\msys\bin;C:\Program Files (x86)\DevDesktop\%PHP_ID%;C:\Program Files (x86)\DevDesktop\mysql\bin;%PATH%

@php.exe %*
