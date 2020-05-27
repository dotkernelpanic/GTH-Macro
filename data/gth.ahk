#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

SysGet, VirtualScreenWidth, 78
SysGet, VirtualScreenHeight, 79

SysGet, VirtualScreenLeft, 76
SysGet, VirtualScreenTop, 77

ico     = %A_ScriptDir%\ico.png
helpPic = %A_ScriptDir%\helpgui.jpg

Menu, Tray, Icon, %ico%,, 1

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

;                                               ======= DEFINITIONS SECTION ===========

;                                                       ARRAYS THAT CONTAINS IMAGES
; ------------------------------------------------------------------------------------------------------------------------------------------------------ ;
  img_array := ["Blade", "Bullets", "Burger", "Blista2", "Beer", "BullpupShotgun", "Chino", "Chips", "Clothes", "CombatPDW", "CombatPistol", "Detergent"                       
                    , "Dukes", "eCola", "Emperor" "Faction", "Faction2", "Faggio2", "Flashlight", "Petrol", "GasolineCan", 
                    , "Gauntlet2", "Hammer", "HeavyPistol",  "Hermes", "HotDog", "Issi3", "Ingot" "Bunch Of Keys", "LotteryTicket", "MachinePistol", "Masks", 
                    , "MountTool", "Pariah", "Pistol", "Pizza", "Ruiner" "Sandwich", "SIM", "Sprunk", "Tornado", "Tornado2", 
                    , "Tornado5", "Vamos", "Wrench", "Buffalo2", "Emperor2", "Revolver", "Tampa", "Virgo", "Voodoo2", "Consumables"]                                      
;------------------------------------------------------------------------------------------------------------------------------------------------------- ;

OpenOrders              := "^sc002"             ; Hotkey for function that opens orders menu
ManualSearch            := "!sc004"             ; Hotkey for function that do manual image search
OpenTChat               := "^sc003"             ; Hotkey for function that opens trucker chat
OpenOChat               := "^sc004"             ; Hotkey for function that opens OOS chat
FindTrailerCommand      := "!sc001"             ; Hotkey for function that insert in chat /findtrailer command
OpenGitHubCommand       := "!sc022"             ; Hotkey for function that opens My Github Repo
OpenRedAgeCommand       := "^sc013"             ; Hotkey for function that opens RedAge Forum
ReEnterTruck            := "!sc003"             ; Hotkey for functioin that allow to re-enter truck and insert /mypoint command in chat
                                                ; in case of losing order point
Finish                  := "!sc021"             ; Hotkey for function that insert in chat /fjob command
Sos1                    := "!sc005"             ; Hotkey for function that calls SOS #1
Sos2                    := "!sc006"             ; Hotkey for function that calls SOS #2
RotateMyTrailer         := "!sc013"             ; Hotkeyfor function that insert ig chat /report Перевернулся прицеп
Call112                 := "!sc019"             ; Hotkey for function that calls to police 
HelpMenu                := "+sc03B"             ; Hotkey for function that opens script help menu
TgChannel               := "!sc014"             ; Hotkey for function then allow to join My Telegram Channel

Hotkey, %OpenOrders%, OpenOrdersMenu
Hotkey, %ManualSearch%, ManualImageSearch
Hotkey, %OpenTChat%, OpenTruckChat
Hotkey, %OpenOChat%, OpenOOSChat
Hotkey, %FindTrailerCommand%, FindTrailer
Hotkey, %OpenGitHubCommand%, OpenGitHub
HotKey, %OpenRedAgeCommand%, OpenRedAge
Hotkey, %ReEnterTruck%, ReEnter
Hotkey, %Finish%, FinishJob
Hotkey, %Sos1%, SendSosMessage1
Hotkey, %Sos2%, SendSosMessage2
Hotkey, %RotateMyTrailer%, SendTrailerRotateReport
Hotkey, %Call112%, CallToPolice
Hotkey, %HelpMenu%, OpenHelpGui
Hotkey, %TgChannel%, JoinTG


mousePosX       := 0
mousePosY       := 0
Order           := ""


ALL_RESOLUTIONS_GUI_XPOS := A_ScreenWidth   - 250
ALL_RESOLUTIONS_GUI_YPOS := A_ScreenHeight  - 270

/*
*   GUI LAYOUT
*   | TITLE             [x]
*   | Your order:           |
*   | TextBOX               |
*   | HINTS                 |
*   _   _   _   _   _   _   _
*/

;                                           ====== END OF DEFINITIONS SECTION

; ---------------------------------- GUI SETTINGS ---------------------------
Gui +AlwaysOnTop +Owner +ToolWindow
Gui, 1:Font, s10 Bold Consolas
Gui, 1:Add, Text, x5 y0, Your order:
Gui, 1:Font, s10 cRed bold italic
Gui, 1:Add, Edit, x5 y20 w100 vOrderVar, %Order%
Gui, 1:Font, s9 cBlack Consolas Normal
Gui, 1:Add, Text, x5 y50, Press Shift+F1 to open help menu
Gui 1:Add, Text, x5 y70, Press Ctrl+X to exit the script
Gui, 1:Show, NoActivate x%ALL_RESOLUTIONS_GUI_XPOS% y%ALL_RESOLUTIONS_GUI_YPOS% w200 h90, Truck Helper by 1xrem1psum
Return
; ---------------------------------------------------------------------------

; __init__() <!> DEPRECATED, DONT HAVE REALISATION. I KEEP THIS FOR A FUTURE FEATURES <!>

; __init__() {} <!> DEPRECATED, DONT HAVE REALISATION. I KEEP THIS FOR A FUTURE FEATURES <!>


;                                                       =========    HOTKEYS CODE SECTION     =======


; -----------------------------------------
;         [CTRL+1 HOTKEY] Open orders menu
OpenOrdersMenu:
    Send {sc014 down}   ; {T} key down
        Sleep 30
    Send {sc014 up}     ; {T} key up
        Sleep 50
    Send {Raw}/orders
        Sleep 50
    Send {Enter down}   ; {Enter} down
    Send {Enter up}     ; {Enter} up
        Sleep 300

    CheckArray()        ; Checking image
Return
; -----------------------------------------

; ---------------------------------------
;       [ALT+3 HOTKEY] Manual ImageSearch
ManualImageSearch:
    CheckArray()
Return

; -----------------------------------------
;        [CTRL+2 HOTKEY] Open trucker chat
OpenTruckChat:
    Send {sc014 down}   ; {T} key down
    Send {sc014 up}     ; {T} key up
        Sleep 50
    Send {Raw}/t        ; !RAW! /t command
Return
; ----------------------------------------

; ----------------------------------------
;           [CTRL+3 HOTKEY] Open OOS chat
OpenOOSChat:
    Send {sc014 down}   ; {T} key down
    Send {sc014 up}     ; {T} key up
        Sleep 50
    Send {Raw}/b        ; !RAW! /b command
Return
;-----------------------------------------


; ---------------------------------------------
;           [ALT+1 HOTKEY] /findtrailer command
FindTrailer:
    Send {sc014 down}       ; {T} key down
    Send {sc014 up}         ; {T} key up
        Sleep 50
    Send {Raw}/findtrailer  ; !RAW! /findtrailer command
        Sleep 50
    Send {Enter down}       ; {Enter} key down
    Send {Enter up}         ; {Enter} key up
Return
; ---------------------------------------------


; --------------------------------------------
;           [ALT+2 HOTKEY] Re-Enter the truck
ReEnter:

    Send {sc021 down}       ; {F} key down
        Sleep 50            ; Keyboard key press emulation
    Send {sc021 up}         ; {F} key up

        Sleep 4000          ; Waiting 4s for exit the truck

    Send {sc021 down}       ; {F} key down
        Sleep 50            ; Keyboard key press emulation
    Send {sc021 up}         ; {F} key up

        Sleep 5000          ; Waiting 5s for enter the truck

    Send {sc014 down}       ; {T} key down
    Send {sc014 up}         ; {T} key up
    
        Sleep 50

    Send {Raw}/mypoint      ; !RAW! /mypoint command

        Sleep 50

    Send {Enter down}       ; {Enter} key down
    Send {Enter up}         ; {Enter} key up
Return
; -------------------------------------------

; --------------------------------------------------------
;         [ALT+G HOTKEY] Open my github rep
OpenGitHub:
    Run, https://github.com/katharosMelancholin/GTH-Macro
; --------------------------------------------------------

; --------------------------------------------------------
;        [Ctrl+R HOTKEY] Open RedAge Forum
OpenRedAge:
    Run, https://forum.redage.net/
; --------------------------------------------------------

; --------------------------------------------------------
;       [ALT+F HOTKEY] Finish job (/fjob)
FinishJob:
    Send {sc014 down}       ; {T} key down
    Send {sc014 up}         ; {T} key up
        Sleep 50
    Send, {Raw}/fjob        ; !RAW! /fjob command
        Sleep 50
    Send {Enter down}       ; {Enter} key down
    Send {Enter up}         ; {Enter} key up
Return
; --------------------------------------------------------

; --------------------------------------------------------
;               [ALT+R HOTKEY] Send /report
SendTrailerRotateReport:
    Send {sc014 down}       ; {T} key down
    Send {sc014 up}         ; {T} key up
        Sleep 50
    Send {Raw}/report Перевернулся прицеп
        Sleep 50
    Send {Enter down}       ; {Enter} key down
    Send {Enter up}         ; {Enter} key up
Return
; --------------------------------------------------------

; -----------------------------------------------------------------
;       [ALT+P] Insert in chat /call 112 Грабители на [YOUR TEXT]
CallToPolice:
    SendMode, Input
    Send {sc014 down}       ; {T} key down
    Send {sc014 up}         ; {T} key up
        Sleep 50
    Send {Raw}/call 112 Грабители на
Return
; -----------------------------------------------------------------


; ----------------------------------------------------------
;               [ALT+T] Open TG
JoinTG:
    Run, https://t.me/joinchat/AAAAAEntc5qp82k32x69SA
Return
; ----------------------------------------------------------

; ---------------------------------------------------------------
;       [SHIFT+F1] Open Help menu
OpenHelpGui:
    ShowHelpGui() 
Return
; ---------------------------------------------------------------

~LButton::
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


; ---------------------------------------------------------
;               [ALT+4] Send SOS1 Message
SendSosMessage1:
    SOS1Message()
Return
; --------------------------------------------------------

; --------------------------------------------------------
;               [ALT+5] Send SOS2 Message
SendSosMessage2:
    SOS2Message()
Return
; -------------------------------------------------------

^x::ExitApp
Return

DoNothing:
Return

GuiClose:
    ExitApp

;                                                       ======== END OF HOTKEYS CODE SECTION ==========
;                                                       ========    FUNCTIONS CODE SECTION   ==========

; -----------------------------------------------------------------------------------
;                                       FUNCTION THAT CHECK IMAGES ARRAY
    CheckArray() {


        global img_array
        global Order
        global VirtualScreenLeft
        global VirtualScreenTop
        global VirtualScreenWidth
        global VirtualScreenHeight
        global WhereIsImageSearcgHasBeenCalled

        if (WhereIsImageSearcgHasBeenCalled = 2) {
            MsgBox, %WhereIsImageSearcgHasBeenCalled% - ImageSearch manual called
        }

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



    SOS1Message() {
  
            Send {sc014 down}       ; {T} key down
            Send {sc014 up}         ; {T} key up
                Sleep 30
            Send {Raw}/t Грабители на Шоссе Сенора!
                Sleep 30
            Send {Enter down}       ; {Enter} down
            Send {Enter up}         ; {Enter} up
    }

    SOS2Message() {

            Send, {sc014 down}      ; {T} key down
            Send, {sc014 up}        ; {T} key up
                Sleep 30
            Send {Raw}/t Грабители на Шоссе Грейт-Оушен! 
                Sleep 30
            Send {Enter down}       ; {Enter} key down
            Send {Enter up}         ; {Enter} key up

    }

    ShowHelpGui() {
        Run %A_ScriptDir%\help.ahk
        Return
    }

;                                                               ====== ENF OF FUNCTIONS CODE SECTION =======
;                                                                               END OF SCRIPT
;    -----------------------------------------------------------------------------------------------------------------------------------------------------