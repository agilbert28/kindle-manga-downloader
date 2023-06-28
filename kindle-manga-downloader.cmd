:: === kindle-manga-downloader.cmd ============================================
:: This batch file uses KCC and mangadex-downlaoder to Download, Convert, and
:: Send to Kindle.
::
:: This script requires that the user has Python 3.8 or higher installed
::
:: --- Reference --------------------------------------------------------------
:: TODO: Insert References
::
:: --- License ----------------------------------------------------------------
:: Copyright (c) 2023 Austin Gilbert <austingilbert28@gmail.com>
::
:: Permission is hereby granted, free of charge, to any person obtaining a copy
:: of this software and associated documentation files (the “Software”), to
:: deal in the Software without restriction, including without limitation the
:: rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
:: sell copies of the Software, and to permit persons to whom the Software is
:: furnished to do so, subject to the following conditions:
::
:: The above copyright notice and this permission notice shall be included in
:: all copies or substantial portions of the Software.
:: THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
:: IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
:: FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
:: AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
:: LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
:: FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
:: IN THE SOFTWARE.
:: ============================================================================

:: Initialize Program ---------------------------------------------------------
@ECHO OFF
TITLE Kindle Manga Downloader
ECHO This program will download, convert, and send manga titles from Mangadex
ECHO to your kindle using KCC and mangadex-dowloader.
ECHO.

:: Global Variables -----------------------------------------------------------
SET kindleModel=KPW5
SET drive =E:
SET path =E:\Manga\

:: Check for & Install Necessary Dependencies ---------------------------------
ECHO Checking for and installing necessary dependencies...

:: Install Chocolatey
choco >nul 2>&1
if '%errorlevel%' NEQ '0' (
    ECHO Installing Chocolatey...
    SET DIR=%~dp0%
    %systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://community.chocolatey.org/install.ps1','%DIR%install.ps1'))"
    %systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%DIR%install.ps1' %*"
)

:: Install GitHub CLI
gh >nul 2>&1
if '%errorlevel%' NEQ '0' (
    ECHO Installing GitHub CLI...
    choco install gh
)

:: Install KCC
kcc-c2e >nul 2>&1
if '%errorlevel%' NEQ '0' (
    ECHO Installing KCC...
    :: mkdir C:\Program Files\Kindle Comic Converter
    :: gh release download --repo [https://github.com/]ciromattia/kcc/ --dir C:\Program Files\Kindle Comic Converter

    :: choco install kindlepreviewer

    SET Key="HKCU\Environment"
    FOR /F "usebackq tokens=2*" %%A IN (`REG QUERY %Key% /v PATH`) DO Set CurrPath=%%B
    ECHO %CurrPath% > user_path_bak.txt
    SETX PATH "%CurrPath%";"Test" REM TODO: Change this from Test
    
:: Update KCC
) else (

)

:: Install mangadex-downloader
mangadex-dl >nul 2>&1
if '%errorlevel%' NEQ '0' (
    :: Install pip
    pip  >nul 2>&1
    if '%errorlevel%' NEQ '0' (
        ECHO Installing pip...
        python -m ensurepip --upgrade
    )
    ECHO Installing mangadex-dowloader...
    py -3 -m pip install mangadex-downloader
    py -3 -m pip install mangadex-downloader
:: Update mangadex-downloader
) else (
    mangadex-dl --update
)

ECHO.
PAUSE
