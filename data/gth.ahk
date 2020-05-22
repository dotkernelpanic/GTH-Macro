FileEncoding, UTF-8
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

/*
*   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *
*                                                                                                               *
*                                                                                                               *
*                                              DEVELOPED BY                                                     *
*                                                                                                               *
*                                                                                                               *
*                                                                                                               *
*                                                                                                               *
*                                                                                                               *
*                                                                                                               *
*   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *

*/



;                                                       ARRAYS THAT CONTAINS IMAGES
; ------------------------------------------------------------------------------------------------------------------------------------------- ;
  img_array := ["Blade", "Bullets", "Burger", "Beer", "BullpupShotgun", "Chino", "Chips", "CombatPDW", "CombatPistol",                        ;
                    , "eCola", "Faction", "Faction2", "Faggio2", "Flashlight", "Petrol", "GasolineCan", "Gauntlet2", "Hammer", "HeavyPistol", ;
                    , "Hermes", "HotDog", "Issi3", "Keys", "LotteryTicket", "MachinePistol", "Masks", "MountTool", "Pariah", "Pistol",        ;  
                    , "Pizza", "Sandwich", "SIM", "Sprunk", "Tornado", "Tornado2", "Tornado5", "Wrench"]                                      ;
;-------------------------------------------------------------------------------------------------------------------------------------------- ;


/*
*   GUI LAYOUT
*   [i] TITLE       [-][o][x]
*   | Your order:           |
*   | Text                  |
*   | HINTS                 |
*   _   _   _   _   _   _   _
*/

; ---------------------------------- GUI SETTINGS ---------------------------
Gui +AlwaysOnTop
Gui, Font, s10
Gui, Add, Text, x5 y0, Your order:
Gui, Add, Text, x5 y15 w150 vOrderVar, %order%
Gui, Show, x0 y450 w200 h100, GTH
; ---------------------------------------------------------------------------


; __init__() <!> DEPRECATED, DONT HAVE REALISATION. I KEEP THIS FOR A FUTURE FEATURES <!>

; __init__() {} <!> DEPRECATED, DONT HAVE REALISATION. I KEEP THIS FOR A FUTURE FEATURES <!>


; -----------------------------------------
;         [CTRL+1 HOTKEY] Open orders menu
^1::
    Send, T
        Sleep 100
    Send, {Text}/orders
        Sleep 100
    Send, {Enter}
        Sleep 850
    
    CheckArray()
Return
; -----------------------------------------


; -----------------------------------------
;        [CTRL+2 HOTKEY] Open trucker chat
^2::
    Send, T
        Sleep 100
    Send, {Text}/t . " "
        Sleep 100
Return
; ----------------------------------------

; ----------------------------------------
;           [CTRL+3 HOTKEY] Open OOS chat
^3::
    Send, T
        Sleep 100
    Send, {Text}/b . " "
        Sleep 100
Return
;-----------------------------------------


; ---------------------------------------------
;           [ALT+1 HOTKEY] /findtrailer command
!1::
    Send, T
        Sleep 100
    Send, {Text}/findtrailer
        Sleep 100
    Send, {Enter}
Return
; ---------------------------------------------


; --------------------------------------------
;           [ALT+2 HOTKEY] Leave the truck and
;            enter him, if point didn't appear
!2::
    Send, F
        Sleep 500
    Send, F
Return
; -------------------------------------------

^x::ExitApp
Return

DoNothing:
Return

; -----------------------------------------------------------------------------------
;                                       FUNCTION THAT CHECK IMAGES ARRAY
    CheckArray() {
        global img_array
        for index in img_array {
            CoordMode, Pixel, Relative
            image := img_array[index]

            file = %A_ScriptDir%\images\%image%.png
            ImageSearch fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight, %file%
            if (ErrorLevel = 0) {
                SplitPath, file,,,, noext
                GuiControl,, Ordervar, %noext%
                Break
            }
            else
                GuiControl,, Ordervar, Undefined
        }
        return 
    }
; -----------------------------------------------------------------------------------
