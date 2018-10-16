@echo off
cd..>nul 2>&1
cd Accounts>nul 2>&1

:accounts.MainMenu
cls
echo Xonade Account Manager v1.0
echo -
echo.
echo          Choose Option
echo.
echo     1 ^| Login
echo     2 ^| Register
echo.
echo     0 ^| Quit
echo.
echo -
set /p input=
if "%input%" == "1" goto accounts.LoginMenu
if "%input%" == "2" goto accounts.RegisterMenu
if "%input%" == "0" goto accounts.Quit
goto accounts.MainMenu

:accounts.LoginMenu
cls
echo Xonade Account Manager by Ervin K.
echo -
echo.
echo          Login to Account
echo.
set /p username=     Username ^| 
set /p password=     Password ^| 
echo.
echo -
echo.

echo Checking Compatibility...
if exist "%username%.account.bat" goto accounts.LoginMenu.exist
echo X.ERR404 - Account doesn't Exist
pause>nul
goto accounts.MainMenu

:accounts.LoginMenu.exist
echo Account Exists!
call "%username%.account.bat"
if "%password%" == "%pword%" goto accounts.LoginMenu.password
echo X.ERR400 - Bad Request, Wrong Password
pause>nul
goto accounts.MainMenu

:accounts.LoginMenu.password
echo Successfully logged into %username%
pause>nul
set /a accountsManagerSession="%uname%"
goto accounts.dashboard

:accounts.RegisterMenu
cls
echo Xonade Account Manager v1.1
echo -
echo.
echo          Register Account
echo.
set /p username=     Username ^| 
set /p password=     Password ^| 
echo.
set /p confirm= Confirm (Y/N) ^| 
echo.
echo -
echo.

echo Checking Confirmation...
if "%confirm%" == "n" goto accounts.RegisterMenu.unconfirmed

echo Checking Compatibility...
if exist "%username%.account.bat" goto accounts.RegisterMenu.taken

echo Creating Account...
echo Saving Username...
echo set uname=%username%> %username%.account.bat
echo Saving Password...
echo set pword=%password%>> %username%.account.bat
echo Saved as '%username%.account.bat' inside Accounts Directory
goto accounts.MainMenu

:accounts.RegisterMenu.taken
echo X.ERR409 - Conflict, Username Taken
pause>nul
goto accounts.MainMenu

:accounts.RegisterMenu.unconfirmed
echo X.ERR401 - Unauthorized, Confirmation Reply: %confirm%
pause>nul
goto accounts.MainMenu

:accounts.dashboard
cls
echo Xonade Account Manager by Ervin K.
echo -
echo.
echo      Logged in as %uname%
echo.
echo     1 ^| Logout
echo     2 ^| Delete Account
echo.
echo     0 ^| Quit
echo.
echo -
set /p input=
if "%input%" == "1" goto accounts.MainMenu
if "%input%" == "2" goto accounts.DelAccount
if "%input%" == "0" goto accounts.Quit
goto accounts.dashboard

:accounts.DelAccount
cls
echo Are you sure you want to delete your account?
set /p input=(Y^/N) 
if "%input%" == "y" goto accounts.DelAccount.confirm
if "%input%" == "n" goto accounts.dashboard
goto accounts.DelAccount
:accounts.DelAccount.confirm
del "%uname%.account.bat"
echo Account Deleted!
pause>nul
goto accounts.MainMenu

:accounts.Quit