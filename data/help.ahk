#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

helpPic = %A_ScriptDir%\helpgui.jpg

Gui, Add, Picture,, %helpPic%
Gui, Show, xCenter yCenter AutoSize, Help

sc001::
    ExitApp
Return

Return