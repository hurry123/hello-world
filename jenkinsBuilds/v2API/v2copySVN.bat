echo off
set svnProject=v2_API
set svnLocation=https://csvnhou-pro.houston.hpecorp.net:18490/svn/hpit113962legacyecs

IF %1.==. GOTO NoParam

svn copy %svnLocation%/%svnProject%/trunk %svnLocation%/%svnProject%/tags/%1 -m "Tagged for Jenkins svn-tag plugin. Build:%1"
GOTO endMe

:NoParam
echo Usage: v2copySVN buildLabel
goto endMe

:endMe