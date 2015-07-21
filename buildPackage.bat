@ECHO OFF
SET EXTNAME="extension-amazonads"

REM Build extension
zip -r %EXTNAME%.zip extension haxelib.json include.xml dependencies
