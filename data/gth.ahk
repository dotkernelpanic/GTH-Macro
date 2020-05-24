FileEncoding, UTF-8
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

SysGet, VirtualScreenWidth, 78
SysGet, VirtualScreenHeight, 79

SysGet, VirtualScreenLeft, 76
SysGet, VirtualScreenTop, 77

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
; ------------------------------------------------------------------------------------------------------------------------------------------------------ ;
  img_array := ["Blade", "Bullets", "Burger", "Blista2", "Beer", "BullpupShotgun", "Chino", "Chips", "Clothes", "CombatPDW", "CombatPistol", "Detergent"                       
                    , "Dukes", "eCola", "Emperor" "Faction", "Faction2", "Faggio2", "Flashlight", "Petrol", "GasolineCan", 
                    , "Gauntlet2", "Hammer", "HeavyPistol",  "Hermes", "HotDog", "Issi3", "Ingot" "Keys", "LotteryTicket", "MachinePistol", "Masks", 
                    , "MountTool", "Pariah", "Pistol", "Pizza", "Ruiner" "Sandwich", "SIM", "Sprunk", "Tornado", "Tornado2", 
                    , "Tornado5", "Vamos", "Wrench"]                                      
;------------------------------------------------------------------------------------------------------------------------------------------------------- ;

mousePosX := 0
mousePosY := 0
Order := ""

ALL_RESOLUTIONS_GUI_XPOS := A_ScreenWidth   - 600
ALL_RESOLUTIONS_GUI_YPOS := A_ScreenHeight  - 250


/*
*   GUI LAYOUT
*   [i] TITLE       [-][o][x]
*   | Your order:           |
*   | Text                  |
*   | HINTS                 |
*   _   _   _   _   _   _   _
*/

; ---------------------------------- GUI SETTINGS ---------------------------
Gui +AlwaysOnTop  +Owner +ToolWindow
Gui, Font, s9
Gui, Add, Text, x5 y0, Your order:
Gui, Font, s12 cRed bold
Gui, Add, Text, x5 y15 w150 vOrderVar, %Order%
Gui, Font, s9 cBlack Normal
Gui, Add, Text, x5 y40, Help:
Gui, Add, Text, x5 y60,   Ctrl+1  -  Open orders menu
Gui, Add, Text, x5 y80,   Ctrl+2  -  Open truckers chat (/t)
Gui, Add, Text, x5 y100,   Ctrl+3  -  Open OOS chat (/b)
Gui, Add, Text, x5 y120,   Alt+1  -  /findtrailer command
Gui, Add, Text, x5 y140,   Alt+3  -  Manual ImageSearch
Gui, Add, Text, x5 y160,   Alt+G  -  Open github repository
Gui, Add, Text, x5 y180,   Alt+R  -  Open RegAge Forum
Gui, Show, x%ALL_RESOLUTIONS_GUI_XPOS% y%ALL_RESOLUTIONS_GUI_YPOS% w200 h200, GTH
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

; ---------------------------------------
;       [ALT+3 HOTKEY] Manual ImageSearch
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
;         [ALT+G HOTKEY] Open my github rep
!g::Run, https://github.com/katharosMelancholin/GTH-Macro
; --------------------------------------------------------

; --------------------------------------------------------
;        [ALT+R HOTKEY] Open RedAge Forum
!r::Run, https://forum.redage.net/
; --------------------------------------------------------

; --------------------------------------------------------
;       [ALT+F HOTKEY] Finish job (/fjob)
!f::
    Send, T
        Sleep 100
    Send, {Text}/fjob
        Sleep 100
    Send, {Enter}
Return
; --------------------------------------------------------

~LButton::
    getMousePos()


        if (mousePosX > 1838 AND mousePosX < 1868) {
            Sleep 100
            CheckArray()
        } else 
            if (mousePosX > 1624 AND mousePosY < 1653) {
                Sleep 100
                CheckArray()
            }
Return


^x::ExitApp
Return

DoNothing:
Return

; -----------------------------------------------------------------------------------
;                                       FUNCTION THAT CHECK IMAGES ARRAY
    CheckArray() {


        global img_array
        global Order
        global VirtualScreenLeft
        global VirtualScreenTop
        global VirtualScreenWidth
        global VirtualScreenHeight

        for index in img_array {
            image := img_array[index]

            file = %A_ScriptDir%\images\%image%.png
        ;   ImageSearch, fx, fy, 0, 0, A_ScreenWidth, A_ScreenHeight, %file%
        ImageSearch, OutputVarX, OutputVarY, VirtualScreenLeft, VirtualScreenTop
		            ,VirtualScreenLeft+VirtualScreenWidth, VirtualScreenTop+VirtualScreenHeight, %file%
            if (ErrorLevel = 0) {
                SplitPath, file,,,, noext
                Order := noext
                GuiControl,, Ordervar, %Order%
                Break
            }
        }
        return 
    }
; -----------------------------------------------------------------------------------

; -----------------------------------------------------------------------------------
;                           GETTING POSITION OF MOUSE POINTER
    getMousePos() {
        global mousePosX
        global mousePosY

        CoordMode, Mouse, Screen

        MouseGetPos, mousePosX, mousePosY
        Return mousePosX, mousePosY
    }
; ------------------------------------------------------------------------------------

