@echo off  
echo Type 'quit' to return to Xonade 
:escapeLoop 
set /p input= %cd%^> 
if "%input%" == "quit" goto escapeQuit 
%input% 
goto escapeLoop 
:escapeQuit 
