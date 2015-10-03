@echo off
SET dir=%~dp0
cd %dir%
SET EXTNAME="extension-amazonads"

haxelib remove %EXTNAME%
haxelib local %EXTNAME%.zip
