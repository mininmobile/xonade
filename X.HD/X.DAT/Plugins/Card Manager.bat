@echo off
cd "%~dp0">nul 2>&1
cd..>nul 2>&1
cd..>nul 2>&1
cd X.HME>nul 2>&1

if exist "CreditCards" goto cards.main
mkdir CreditCards

:cards.main
cd CreditCards>nul 2>&1
cls
echo Credit Card Manager for Xonade
echo Type 'quit' to quit plugin
echo.
:cards.loop
set /p input= ^> 
if "%input%" == "quit" goto cards.quit
if exist "%input%.bat" goto cards.exist

echo Card doesn't exist!
set /p confirm=Create it? (Y^/N) 
if "%confirm%" == "y" goto cards.create
if "%confirm%" == "Y" goto cards.create
goto cards.loop

:cards.exist
cls
call "%input%.bat"
echo Type 'return' to return to card select
echo Type 'delete' to delete card
echo Type 'credit' to add to balance
echo Type 'debit' to charge card
echo Type 'view' to view card contents
echo Type 'save' to save card contents - DO THIS BEFORE VIEWING
:cards.exist.loop
set /p input= Card Action ^> 
if "%input%" == "delete" goto cards.exist.delete
if "%input%" == "return" goto cards.loop
if "%input%" == "credit" goto cards.exist.credit
if "%input%" == "debit" goto cards.exist.debit
if "%input%" == "view" goto cards.exist.view
if "%input%" == "save" goto cards.exist.save
goto cards.exist.loop

:cards.exist.credit
echo How much do you want to give them?
set /p credit=$
set /a cardBalance=%cardBalance%+%credit%
echo Finished, Please save though!
pause>nul
goto cards.exist.loop

:cards.exist.debit
echo How much do you want to give them?
set /p debit=$
set /a cardBalance=%cardBalance%-%debit%
echo Finished, Please save though!
pause>nul
goto cards.exist.loop

:cards.exist.save
echo Saving...
echo set cardOwner=%cardOwner% > %cardPin%.bat
echo set /a cardBalance=%cardBalance% >> %cardPin%.bat
echo set /a cardPin=%cardPin% >> %cardPin%.bat

echo Updating Information...
call "%cardPin%.bat"

echo Finished!
pause>nul
goto cards.exist.loop

:cards.exist.view
echo Owner: %cardOwner%
echo Balance: $%cardBalance%
echo Pin: %cardPin%
goto cards.exist.loop

:cards.exist.delete
set /p confirm=Are you Sure? (Y^/N) 
if "%confirm%" == "y" goto cards.exist.delete.confirm
if "%confirm%" == "Y" goto cards.exist.delete.confirm
goto cards.exist.loop

:cards.exist.delete.confirm
del "%cardPin%.bat"
echo Card Terminated!
echo Please pay back the owner %cardBalance%$!
pause>nul
goto cards.loop

:cards.create
set /a SETUPcardPin=%input%
set /p SETUPownerName=Name of Owner ^> 

echo Checking...
if exist "%SETUPcardPin%.bat" goto cards.create.exist

echo Saving...
echo set cardOwner=%SETUPownerName% > %SETUPcardPin%.bat
echo set /a cardBalance=0 >> %SETUPcardPin%.bat
echo set /a cardPin=%SETUPcardPin% >> %SETUPcardPin%.bat

echo Card Created!
pause>nul
goto cards.loop

:cards.create.exist
echo Card with that PIN already exists!
pause>nul
goto cards.loop

:cards.quit