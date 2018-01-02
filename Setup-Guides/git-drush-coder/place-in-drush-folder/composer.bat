@echo off
REM @SET PATH=C:\Program Files (x86)\DevDesktop\php5_4;%PATH%

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

REM @php.exe composer.phar %*

REM use current directory composer
@php.exe "%~dp0composer.phar" %*