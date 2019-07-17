:: Batch add Site Address to Java Except List 
:: add by Nureli Tashpolat
:: nurelit@gmail.com
::
@echo off
setlocal enabledelayedexpansion

:: Site Addresses
SET "SEC_SITE=https://www.aaa.com https://www.bbb.com https://www.ccc.com https://www.ddd.com https://www.eee.com"

:: Check Exception List File Location
@echo ...
@echo working, completed in 1-2 minute...
@echo Please Waiting...
@echo Please, don't close this window ...
@dir /s /b %systemdrive%\deployment.properties > tmp.txt
for /f "delims=" %%i in (tmp.txt) do (
	set tpath=%%i
	set npath=!tpath:~-41!
	if "!npath!" == "Sun\Java\Deployment\deployment.properties" (
		set spath=!tpath! 
		set dtpath=!spath:~0,-22!
		set dpath=!dtpath!%security\
		SET "CFILE=!dpath!EXCEPTION.SITES"

		:: for check running status
		echo !spath!
		echo !dtpath!
		echo !dpath!
		echo !CFILE!

		:: add site addresses to Exception List
		FOR %%S IN (%SEC_SITE%) DO (
			ECHO %%S >> "!CFILE!"
			echo %%S added !
		)
	)
)
:: Remove cache file
@TASKKILL /F /FI "IMAGENAME EQ J*" 2>nul
@RD "%dtpath%CACHE" /S /Q 2>nul
@del tmp.txt
@ECHO Operetion completed ...
@PAUSE 
