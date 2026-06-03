@echo off
REM Installs Jerry's commonly-used pi extensions.
REM Safe to re-run; pi will skip already-installed packages.

where pi >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: pi CLI not found on PATH. Install it first: https://pi.dev
    exit /b 1
)

echo Installing pi extensions...

call pi install npm:@jerryan/pi-pyvenv
if %errorlevel% neq 0 echo WARNING: failed to install pi-pyvenv

call pi install npm:@jerryan/pi-todo-lite
if %errorlevel% neq 0 echo WARNING: failed to install pi-todo-lite

call pi install npm:@thinkscape/pi-status
if %errorlevel% neq 0 echo WARNING: failed to install pi-status

call pi install npm:@jerryan/pi-hashline-edit
if %errorlevel% neq 0 echo WARNING: failed to install pi-hashline-edit
call pi install npm:@jerryan/pi-subagent-lite
if %errorlevel% neq 0 echo WARNING: failed to install pi-subagent-lite

call pi install npm:@jerryan/pi-sanity
if %errorlevel% neq 0 echo WARNING: failed to install pi-sanity

echo.
echo Done! Installed extensions:
pi list
