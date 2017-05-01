@IF EXIST "%~dp0\node.exe" (
  "%~dp0\node.exe"  "%~dp0\node_modules\gulp\bin\gulp.js" %*
) ELSE (
  REM #### start custom code ####
  REM ## don't display commands we are running.
  @ECHO OFF
  REM ## don't evaluate variables in for loop until we get to them.
  setlocal enabledelayedexpansion
  set frontend_source_folders=( frontend-source static prototype)
  REM ## folders to check relative to current folder.
  REM ## NOTE:  first is "(" which is ignored as the first checked folder in the for loop is current folder.
  set first_run=1
  set current_dir=%cd%
  
  REM foreach folder, see if a gulpfile is inside, if so change directory into that folder so gulp runs.
  FOR %%f IN (%frontend_source_folders%) DO (
    REM ## if first time run and gulp file exists.
    if !first_run!==1 IF EXIST "%cd%/gulpfile.js" (
      set first_run=0
      goto :endforloop
    )
    IF EXIST "%cd%/%%f/gulpfile.js" (
      cd "%cd%/%%f/"
    )
  )
  :endforloop
  setlocal disabledelayedexpansion
  REM #### end custom code ####
  @SETLOCAL
  @SET PATHEXT=%PATHEXT:;.JS;=;%
  node  "%~dp0\node_modules\gulp\bin\gulp.js" %*
)
REM #### start custom code ####
REM ## set back to folder we were in.
cd %current_dir%
REM ## let eth code code be passed back to parent process (not tested)
exit /b %errorlevel%
REM #### end custom code ####
