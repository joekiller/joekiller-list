IF EXIST "%userprofile%\Program Files\Pazer\cfg\playerlist.json" (goto :newplayerlist) ELSE (goto :eof)
:newplayerlist
%userprofile%\bin\jq-win64.exe -s --tab ".[0].players=[.[].players[]] | .[0]" playerlist-empty.joekiller.json playerlist-raw.joekiller.json "%userprofile%\Program Files\Pazer\cfg\playerlist.json" 1> "playerlist-raw.joekiller.json.tmp"
%userprofile%\bin\jq-win64.exe -c "." playerlist-raw.joekiller.json.tmp 1> "playerlist.joekiller.json"
mv playerlist-raw.joekiller.json.tmp playerlist-raw.joekiller.json
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a%%b)
mv "%userprofile%\Program Files\Pazer\cfg\playerlist.json" "%userprofile%\Program Files\Pazer\cfg\playerlist-%mydate%_%mytime%.json"
