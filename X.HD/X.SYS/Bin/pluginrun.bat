@echo off 
echo Type 'quit' to return to Xonade 
echo Type 'list' to list all plugins 
:pluginLoop 
cd "%~dp0"
cd..
cd..
cd X.DAT
cd Plugins
set /p input=X.HD^/X.DAT^/Plugins^/^> 
if "%input%" == "quit" goto quitPluginRun 
if "%input%" == "list" goto listPluginRun 
if exist "%input%.bat" goto runPlugin 
echo Plugin doesn't Exist! 
goto pluginLoop 
:runPlugin 
call "%input%.bat" 
goto pluginLoop 
:listPluginRun 
dir /b /a-d 
goto pluginLoop 
:quitPluginRun 
