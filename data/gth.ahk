FileEncoding, UTF-8
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

/*
*   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *
*                                                                                                               *
*                                                                                                               *
*                                   DEVELOPED BY YAROSLAV YEVDOKIMOV                                            *
*                                            aka 1xrem 1psum                                                    *
*                                   GitHub:   https://github.com/katharosMelancholin/GTH-Macro                  *
*                                   Telegram: t.me/asasdasqwerty                                                *
*                                                                                                               *
*                                                                                                               *
*                                                                                                               *
*   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *

*/



;                                                       ARRAYS THAT CONTAINS IMAGES
; ------------------------------------------------------------------------------------------------------------------------------------------- ;
  img_array := ["Blade", "Bullets", "Burger", "Beer", "BullpupShotgun", "Chino", "Chips", "CombatPDW", "CombatPistol",                        
                    , "eCola", "Faction", "Faction2", "Faggio2", "Flashlight", "Petrol", "GasolineCan", "Gauntlet2", "Hammer", "HeavyPistol", 
                    , "Hermes", "HotDog", "Issi3", "Keys", "LotteryTicket", "MachinePistol", "Masks", "MountTool", "Pariah", "Pistol",          
                    , "Pizza", "Sandwich", "SIM", "Sprunk", "Tornado", "Tornado2", "Tornado5", "Wrench"]                                      
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
Gui +AlwaysOnTop -Border -SysMenu +Owner -Caption +ToolWindow
Gui, Font, s9
Gui, Add, Text, x5 y0, Your order:
Gui, Add, Text, x5 y15 w150 vOrderVar, %order%
Gui, Add, Text, x5 y30, Help:
Gui, Add, Text, x5 y50,   Ctrl+1  -  Open orders menu
Gui, Add, Text, x5 y70,   Ctrl+2  -  Open truckers chat (/t)
Gui, Add, Text, x5 y90,   Ctrl+3  -  Open OOS chat (/b)
Gui, Add, Text, x5 y110,   Alt+1  -  /findtrailer command
Gui, Add, Text, x5 y130,   Alt+2  -  Re-enter the truck
Gui, Add, Text, x5 y150,   Alt+G  -  Open github repository
Gui, Add, Text, x5 y170,   Alt+R  -  Open RegAge Forum
Gui, Show, x1180 y890 w200 h195, GTH
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

!3::
    CheckArray()
Return

; -----------------------------------------
;        [CTRL+2 HOTKEY] Open trucker chat
^2::
    Send, T
        Sleep 100
    Send, {Text}/t
        Sleep 100
Return
; ----------------------------------------

; ----------------------------------------
;           [CTRL+3 HOTKEY] Open OOS chat
^3::
    Send, T
        Sleep 100
    Send, {Text}/b
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

; --------------------------------------------------------
;         [ALT+G HOTKEY] Open mu github rep
!g::Run, https://github.com/katharosMelancholin/GTH-Macro
; --------------------------------------------------------

; --------------------------------------------------------
;        [ALT+R HOTKEY] Open RedAge Forum
!r::Run, https://forum.redage.net/
; --------------------------------------------------------


^x::ExitApp
Return

DoNothing:
Return

; -----------------------------------------------------------------------------------
;                                       FUNCTION THAT CHECK IMAGES ARRAY
    CheckArray() {
        global img_array
        for index in img_array {
            image := img_array[index]

            CoordMode, ToolTip, Screen
            file = %A_ScriptDir%\images\%image%.png
            ImageSearch, fx, fy, 1600, 446, 1890, 1009, %file%
            if (ErrorLevel = 0) {
                SplitPath, file,,,, noext
                GuiControl,, Ordervar, %noext%
                Break
            }
            else {
                GuiControl,, Ordervar, Undefined
            }
        }
        return 
    }
; -----------------------------------------------------------------------------------
