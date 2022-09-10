#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; This is the setting that runs smoothest on my
; system. Depending on your video card and cpu
; power, you may want to raise or lower this value.
SetWinDelay,2

CoordMode,Mouse
return

!MButton::
MouseGetPos,KDE_X1,KDE_Y1,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
WinClose,ahk_id %KDE_id%
return


!RButton::
MouseGetPos,KDE_X1,KDE_Y1,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
    WinRestore,ahk_id %KDE_id%
If 0
{
    WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW1,KDE_WinH1,ahk_id %KDE_id%
    KDE_WinX2 := (KDE_WinX1 + 29) ; those cords make no sense, so wing it
    KDE_WinY2 := (KDE_WinY1 + 29) ; those cords make no sense, so wing it
    KDE_WinH2 := (KDE_WinH1 - 60)
    KDE_WinW2 := (KDE_WinW1 - 60)
    ;msgbox,%KDE_WinY1%
    ;WinRestore,ahk_id %KDE_id%
    ;WinMove,ahk_id %KDE_id%,,50,50
    ;WinMove,ahk_id %KDE_id%,,%KDE_WinX2%,%KDE_WinY2%,1920,1080
    ;WinMove,ahk_id %KDE_id%,,%KDE_WinX2%,%KDE_WinY2%,%KDE_WinW2%,%KDE_WinH2%
    WinRestore,ahk_id %KDE_id%
    WinMove,ahk_id %KDE_id%,,%KDE_WinX2%,%KDE_WinY2%,%KDE_WinW2%,%KDE_WinH2%
}
; Get the initial window position.
WinGetPos,KDE_WinX1,KDE_WinY1,,,ahk_id %KDE_id%
Loop
{
    GetKeyState,KDE_Button,RButton,P ; Break if button has been released.
    If KDE_Button = U
        break
    MouseGetPos,KDE_X2,KDE_Y2 ; Get the current mouse position.
    KDE_X2 -= KDE_X1 ; Obtain an offset from the initial mouse position.
    KDE_Y2 -= KDE_Y1
    KDE_WinX2 := (KDE_WinX1 + KDE_X2) ; Apply this offset to the window position.
    KDE_WinY2 := (KDE_WinY1 + KDE_Y2)
    WinMove,ahk_id %KDE_id%,,%KDE_WinX2%,%KDE_WinY2% ; Move the window to the new position.
}
If KDE_Win
    WinMaximize,ahk_id %KDE_id%
return

