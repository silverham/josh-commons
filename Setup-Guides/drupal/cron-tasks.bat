@echo OFF
REM Add sourcetree's bash commnds to PATH
SET PATH=C:\Users\joshua.graham\AppData\Local\Atlassian\SourceTree\git_local\mingw32\bin;%PATH%

REM Start these concurrently - not wait to to exit.
echo "Starting Cron: dev-site.build.localtest.me"
@start /b cmd /c "curl -s http://dev-site.build.localtest.me/cron.php?cron_key=MYKEY"
echo "Starting Cron: dev-site2.build.localtest.me"
@start /b cmd /c "curl -s http://dev-site2.build.localtest.me/cron.php?cron_key=MYKEY"

