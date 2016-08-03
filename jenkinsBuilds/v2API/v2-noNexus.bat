echo off
set jenkinsUser=sangames
set jenkinsPassword=Rocklin5931
set svnProject=v2_API
set svnLocation=https://csvnhou-pro.houston.hpecorp.net:18490/svn/hpit113962legacyecs/%svnProject%/trunk
set workspaceLoc=/var/lib/jenkins/jobs/v2API_Build_and_Deploy_NoNexus_NoSVN_STAGE1/workspace

svn -q checkout %svnLocation% .
for /f "delims=" %%a in ('svnversion') do @set myvar= of Rev:%%a
echo %myvar% >> v2\src\main\resources\version.properties

tar -cf %svnProject%.tar *
gzip %svnProject%.tar
rm -rf ecs* Makefile README.txt pom.xml v2 v2interface svn .svn
plink -pw %jenkinsPassword% %jenkinsUser%@16.216.115.184 sudo rm -rf %workspaceLoc%/*
pscp -pw %jenkinsPassword% %svnProject%.tar.gz %jenkinsUser%@16.216.115.184:/tmp
rm -rf %svnProject%.tar.*
plink -pw %jenkinsPassword% %jenkinsUser%@16.216.115.184 sudo cp /tmp/%svnProject%.tar.gz  %workspaceLoc%
plink -pw %jenkinsPassword% %jenkinsUser%@16.216.115.184 sudo gunzip %workspaceLoc%/%svnProject%.tar.gz
plink -pw %jenkinsPassword% %jenkinsUser%@16.216.115.184 sudo tar -C %workspaceLoc% -xf %workspaceLoc%/%svnProject%.tar  
plink -pw %jenkinsPassword% %jenkinsUser%@16.216.115.184 sudo chown -R jenkins:jenkins %workspaceLoc%/*
plink -pw %jenkinsPassword% %jenkinsUser%@16.216.115.184 sudo rm -rf %workspaceLoc%/%svnProject%.tar /tmp/%svnProject%.tar.gz




