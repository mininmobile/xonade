@echo off
:: INITIALIZE
:start

:: Init Hard-Drive
:initHD
echo Detecting Hard-Drive...

if exist "X.HD" goto HDskip

echo.
echo No Hard-Drive detected!
echo Creating X.HD Directory now...

mkdir X.HD
goto HDmade

:HDskip
echo.
echo Hard-Drive already exists!
goto initEnviroment

:HDmade
echo.
echo Hard-Drive created!

:: Init Enviroment
:initEnviroment
echo.
echo Checking for Xonade Enviroment...

cd X.HD
if exist "setup.dat" goto EnviromentSkip

echo.
echo Enviroment isn't created!
echo Creating Xonade Enviroment...
echo Leaving creation Signature...

echo X.SKIPCHECK /EnviromentSkip > setup.dat

echo.
echo Creating System Directory...

mkdir X.SYS

echo.
echo Directory create finished!

echo.
echo Creating data Directory...
mkdir X.DAT
echo Operation Finished!

echo.
echo Creating home Directory...
mkdir X.HME
echo Operation Finished!

cd X.HME

echo Creating Documents Directory...
mkdir Documents
echo Finished Operation!

cd..
cd X.DAT

echo Creating data Directories...

echo.
echo Creating Plugins Directory...
mkdir Plugins
echo Operation Finished!

echo Creating Accounts Directory...
mkdir Accounts
echo Operation Finished!

echo.
echo Finished Operation!

cd..
cd X.SYS

echo Creating required Directories...

echo.
echo Creating Variables Directory...
mkdir Variables
echo Operation Finished!

echo Creating Bin Directory...
mkdir Bin
echo Operation Finished!

echo.
echo Required Directories created!

echo.
echo Creating System Variables...

cd Variables

echo set /a home="%home%" > x.sysVars.bat
echo set /a PlaceholderVariable2=Placeholder2 >> x.sysVars.bat

echo Operation Finished!
echo Calling Variables...
call "x.sysVars.bat"
echo Finished!

cd..

echo.
echo Creating Required Files...

cd Bin

:: CREATE COMMANDS
echo.
echo Creating 'escape.bat'...

echo @echo off  > escape.bat
echo echo Type 'quit' to return to Xonade >> escape.bat
echo :escapeLoop >> escape.bat
echo set /p input= %%cd%%^^^> >> escape.bat
echo if "%%input%%" == "quit" goto escapeQuit >> escape.bat
echo %%input%% >> escape.bat
echo goto escapeLoop >> escape.bat
echo :escapeQuit >> escape.bat

echo Finished Operation!
echo.
echo Creating 'help.bat'...

echo @echo off  > help.bat
echo echo help - Displays list of Public Commands >> help.bat
echo echo escape - Runs CMD.exe inside of Xonade Runtime >> help.bat
echo echo pluginrun - Runs the selected plugin from the Plugins Directory >> help.bat

echo Finished Operation!
echo.
echo Creating 'pluginrun.bat'...

echo @echo off > pluginrun.bat
echo echo Type 'quit' to return to Xonade >> pluginrun.bat
echo echo Type 'list' to list all plugins >> pluginrun.bat
echo :pluginLoop >> pluginrun.bat
echo cd "%%~dp0">nul 2>&1 >> pluginrun.bat
echo cd..>nul 2>&1 >> pluginrun.bat
echo cd..>nul 2>&1 >> pluginrun.bat
echo cd X.DAT>nul 2>&1 >> pluginrun.bat
echo cd Plugins>nul 2>&1 >> pluginrun.bat
echo set /p input=X.HD^^^/X.DAT^^^/Plugins^^^/^^^> >> pluginrun.bat
echo if "%%input%%" == "quit" goto quitPluginRun >> pluginrun.bat
echo if "%%input%%" == "list" goto listPluginRun >> pluginrun.bat
echo if exist "%%input%%.bat" goto runPlugin >> pluginrun.bat
echo echo Plugin doesn't Exist! >> pluginrun.bat
echo goto pluginLoop >> pluginrun.bat
echo :runPlugin >> pluginrun.bat
echo call "%%input%%.bat" >> pluginrun.bat
echo goto pluginLoop >> pluginrun.bat
echo :listPluginRun >> pluginrun.bat
echo dir /b /a-d >> pluginrun.bat
echo goto pluginLoop >> pluginrun.bat
echo :quitPluginRun >> pluginrun.bat

echo Finished Operation!

echo.
echo Required files created!

:: FINISH SETUP
echo.
echo Enviroment has been created!
echo Starting up...

goto Xonade.INITSTAR

:EnviromentSkip
echo.
echo Enviroment already created!

:: STARTUP
:Xonade.INITSTAR
echo.
echo Setup Finished!

cls
echo Xonade // 1.0.0
echo Created by Minin Productions

:: EXECUTION LOOP
:Xonade.EXECLOOP
cd "%~dp0">nul 2>&1
cd X.HD>nul 2>&1
cd X.SYS>nul 2>&1
cd Bin>nul 2>&1
set /p Xloop= ^> 

if exist "%Xloop%.bat" goto Xonade.EXECCOMD

echo X.ERR404 - File '%Xloop%.bat' Doesn't Exist!
goto Xonade.EXECLOOP

:Xonade.EXECCOMD
call "%Xloop%.bat"

goto Xonade.EXECLOOP