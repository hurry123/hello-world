echo off
set jenkinsUser=sangames
set jenkinsPassword=Rocklin5931
set svnProject=hub
set svnLocation=https://csvnhou-pro.houston.hpecorp.net:18490/svn/hpit113962legacyfcs/branches/y16p7/%svnProject%
set workspaceLoc=/var/lib/jenkins/jobs/ode_Build_and_Nexus_Deploy_NoSVN/workspace
svn -q checkout %svnLocation% .
for /f "delims=" %%a in ('svnversion') do @set myvar= of Rev:%%a
echo %myvar% >> ode-listener\src\main\resources\version.properties
tar -cf %svnProject%.tar *
gzip %svnProject%.tar
rm -rf Makefile pom.xml ode-* dml hub-* svn .svn
plink -pw %jenkinsPassword% %jenkinsUser%@16.216.115.184 sudo rm -rf %workspaceLoc%/*
pscp -pw %jenkinsPassword% %svnProject%.tar.gz %jenkinsUser%@16.216.115.184:/tmp
rm -rf %svnProject%.tar.*
plink -pw %jenkinsPassword% %jenkinsUser%@16.216.115.184 sudo cp /tmp/%svnProject%.tar.gz %workspaceLoc%
plink -pw %jenkinsPassword% %jenkinsUser%@16.216.115.184 sudo gunzip %workspaceLoc%/%svnProject%.tar.gz
plink -pw %jenkinsPassword% %jenkinsUser%@16.216.115.184 sudo tar -C %workspaceLoc% -xf %workspaceLoc%/%svnProject%.tar  
plink -pw %jenkinsPassword% %jenkinsUser%@16.216.115.184 sudo chown -R jenkins:jenkins %workspaceLoc%/*
plink -pw %jenkinsPassword% %jenkinsUser%@16.216.115.184 sudo rm -rf %workspaceLoc%/%svnProject%.tar /tmp/%svnProject%.tar.gz

