IF EXIST "%userprofile%\Program Files\Pazer\cfg\playerlist.json" (goto :newplayerlist) ELSE (goto :printversion)
:newplayerlist
%userprofile%\bin\jq-win64.exe -s --tab ".[0].players=[.[].players[]] | .[0]" playerlist-empty.joekiller.json playerlist-raw.joekiller.json "%userprofile%\Program Files\Pazer\cfg\playerlist.json" 1> "playerlist-raw.joekiller.json.tmp"
%userprofile%\bin\jq-win64.exe -c "." playerlist-raw.joekiller.json.tmp 1> "playerlist.joekiller.json"
mv playerlist-raw.joekiller.json.tmp playerlist-raw.joekiller.json
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a%%b)
mv "%userprofile%\Program Files\Pazer\cfg\playerlist.json" "%userprofile%\Program Files\Pazer\cfg\playerlist-%mydate%_%mytime%.json"
REM - https://ss64.com/nt/delayedexpansion.html
for /F "tokens=1-3 delims=." %%A in ('git describe --tags --abbrev^=0') do (
    set /a "b=%%B+1"
    set a=%%A
)
git commit -a -m "chore: update latest list"
git tag -a -m "%a%.%b%.0" %a%.%b%.0
git push --follow-tags
goto :eof

:printversion
for /F "tokens=1-3 delims=." %%A in ('git describe --tags --abbrev^=0') do (
    set /a "b=%%B+1"
    set a=%%A
)
echo git tag -a -m "%a%.%b%.0" %a%.%b%.0
