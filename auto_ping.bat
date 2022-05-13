@echo off

MODE 95,35
echo " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
echo "[96m          _    _ _______ ____    _____ _____ _   _  _____ _  [0m"
echo "[96m     /\  | |  | |__   __/ __ \  |  __ \_   _| \ | |/ ____| | [0m"
echo "[96m    /  \ | |  | |  | | | |  | | | |__) || | |  \| | |  __| | [0m"
echo "[96m   / /\ \| |  | |  | | | |  | | |  ___/ | | |   \ | | |_ | | [0m"
echo "[96m  / ____ \ |__| |  | | | |__| | | |    _| |_| |\  | |__| |_| [0m"
echo "[96m /_/    \_\____/   |_|  \____/  |_|   |_____|_| \_|\_____(_) [0m"
echo "[96m                                                             [0m"
echo " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
PAUSE

SET /A i=1
SET /p target=<auto_ping.cfg
REM READS LINE NUMBER 2
FOR /f "skip=1" %%G IN (auto_ping.cfg) DO IF NOT DEFINED LINE SET /a "repeat=%%G"

:CHECK_FILE_EXISTS
REM Initialising the variable i, check if file ping-n.txt exists
IF EXIST .\output\ping-%i%.txt (
	SET /A i=%i%+1
	GOTO :CHECK_FILE_EXISTS
)

SET /A i=%i%-1

:LOOP_START

SET /A i=%i%+1

ECHO pinging ...
ECHO.
ECHO #######################################################################
REM ping %target% > "./output/ping-%i%.txt" 
POWERSHELL "ping -n %repeat% %target% | tee './output/ping-%i%.txt'"
ECHO.
ECHO #######################################################################
ECHO.

:ASK_INPUT
ECHO Would you like to save this output to [./output/ping-%i%.txt]? (Y/N) 
SET us_resp="no input"
SET /p us_resp="> "

IF %us_resp%==Y GOTO :SAVE_OUTPUT
IF %us_resp%==y GOTO :SAVE_OUTPUT
IF %us_resp%==N GOTO :DONT_SAVE
IF %us_resp%==n GOTO :DONT_SAVE

ECHO [7mInvalid input, I'll ask the question again.[0m
GOTO :ASK_INPUT

:SAVE_OUTPUT

ECHO [91m[*] Outputs of the command have been saved to ./output/ping-%i%.txt[0m 
GOTO :PAUSE_ENTER

:DONT_SAVE
DEL /A .\output\ping-%i%.txt
SET /A i=%i%-1
ECHO [91m[*] Outputs of the command have[0m [41m NOT [0m [91mbeen saved[0m 

:PAUSE_ENTER

ECHO [92mPress ENTER to run again[0m
pause

GOTO :LOOP_START

