#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

Width = A_ScreenWidth /= 2
Height = A_ScreenHeight /= 2

Gui, Show, w300 h300 xCenter yCenter, GTH-Macro HelloScreen

Sleep, 850

Run %A_ScriptDir%\data\gth.ahk
ExitApp
