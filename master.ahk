#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

Width = A_ScreenWidth /= 2
Height = A_ScreenHeight /= 2

logo = %A_ScriptDir%\data\logo.jpg

Gui, Add, Picture, x0 y0 w400 h150, %logo%
Gui, Show, w400 h150 xCenter yCenter, GTH-Macro HelloScreen

Sleep, 2000

Run %A_ScriptDir%\data\gth.ahk
ExitApp

/*

*   -   -   -   -   -   -   -   -   -   -  
*       This script just a hello screen
*   -   -   -   -   -   -   -   -   -   -

*/