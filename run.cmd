@echo off

REM setlocal enabledelayedexpansion

REM set errorlevel=

:: Debug = 0, Release = 1
if "%2" == "" (
    set release_mode=0
) else if "%2" == "--debug" (
    set release_mode=0
) else if "%2" == "--release" (
    set release_mode=1
) else (
    goto :HELP
)

set compiler=cl.exe

set compiler_flags=-std:c++20 /utf-8 -nologo -Oi -TP -fp:precise -Gm- -MP -FC -EHsc- -GR- -GF
set compiler_defines=-DUNICODE -D_UNICODE

if %release_mode% EQU 0 ( REM Debug
    set compiler_flags=%compiler_flags% -Od -MDd
    REM -Z7
    set compiler_defines=%compiler_defines% -DDEBUG -D_DEBUG
) else ( REM Release
    set compiler_flags=%compiler_flags% -O2 -MT
    REM -Z7
    set compiler_defines=%compiler_defines% -NDEBUG
)

set compiler_warnings= ^
    -W4 -WX ^
    -wd4100 -wd4101 -wd4127 -wd4146 ^
    -wd4505 ^
    -wd4456 -wd4457

set compiler_settings=%compiler_flags% %compiler_defines% %compiler_warnings%


if        "%1" == "message_box"     ( goto :MESSAGE_BOX
REM ) else if "%1" == "window"          ( goto :WINDOW
) else                              ( goto :HELP
)


:HELP
    echo Usage : $ run.cmd [directory's name]
    echo   Example: $ run.cmd message_box
goto :EOF


:MESSAGE_BOX
    pushd %1
    %compiler% %compiler_settings% main.cpp -Fo:main ^
        /link user32.lib -OUT:%1.exe && %1.exe
    popd
goto :EOF

REM vim: ft=dosbatch fenc=utf8 ff=dos
