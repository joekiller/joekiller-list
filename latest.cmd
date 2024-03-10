IF EXIST "%userprofile%\Program Files\Pazer\cfg\playerlist.json" (goto :newplayerlist) ELSE (goto :eof)
:newplayerlist
%userprofile%\bin\jq-win64.exe -s --tab ".[0].players=[.[].players[]] | .[0]" playerlist-empty.joekiller.json playerlist-raw.joekiller.json "%userprofile%\Program Files\Pazer\cfg\playerlist.json" 1> "playerlist-raw.joekiller.json.tmp"
%userprofile%\bin\jq-win64.exe -c "." playerlist-raw.joekiller.json.tmp 1> "playerlist.joekiller.json"
mv playerlist-raw.joekiller.json.tmp playerlist-raw.joekiller.json
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a%%b)
mv "%userprofile%\Program Files\Pazer\cfg\playerlist.json" "%userprofile%\Program Files\Pazer\cfg\playerlist-%mydate%_%mytime%.json"
setlocal EnableDelayedExpansion
for /F "tokens=1-3 delims=." %%a in ('git describe --tags --abbrev^=0') do (
    git commit -a -m "chore: update latest list"
    set /a "b=%%b+1"
    git tag -a -m %%a.%b%.0 %%a.%b%.0
    git push --follow-tags
)
