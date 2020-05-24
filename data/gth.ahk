FileEncoding, UTF-8
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

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
Gui, Add, Text, x5 y15 w150 vOrderVar, %Order%
Gui, Add, Text, x5 y30, Help:
Gui, Add, Text, x5 y50,   Ctrl+1  -  Open orders menu
Gui, Add, Text, x5 y70,   Ctrl+2  -  Open truckers chat (/t)
Gui, Add, Text, x5 y90,   Ctrl+3  -  Open OOS chat (/b)
Gui, Add, Text, x5 y110,   Alt+1  -  /findtrailer command
Gui, Add, Text, x5 y130,   Alt+3  -  Manual ImageSearch
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
    CoordMode, Mouse, Screen
    getMousePos()


        if (mousePosX > 1838 AND mousePosX < 1868) {
            Sleep 50
            CheckArray()
        } else 
            if (mousePosX > 1624 AND mousePosY < 1653) {
                Sleep 50
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
		            ,VirtualScreenLeft+VirtualScreenWidth, VirtualScreenTop+VirtualScreenHeight, *20 %file%
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

