#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
#KeyHistory 0 ; Ensures user privacy when debugging is not needed
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scrilpts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


SetCapsLockState, Off
CoordMode, Mouse, Screen

; Main
SetKeyDelay, 75

;XButton1::LAlt
;XButton2::LAlt


;#Include %A_ScriptDir%\switcher\functions.ahk

VDA_PATH := A_ScriptDir . "\VirtualDesktopAccessor.dll"
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", VDA_PATH, "Ptr")

GoToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GoToDesktopNumber", "Ptr")
MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "MoveWindowToDesktopNumber", "Ptr")

MoveCurrentWindowToDesktop(desktopNumber) {
    global MoveWindowToDesktopNumberProc, GoToDesktopNumberProc
    WinGet, activeHwnd, ID, A
    DllCall(MoveWindowToDesktopNumberProc, "Ptr", activeHwnd, "Int", desktopNumber, "Int")
    DllCall(GoToDesktopNumberProc, "Int", desktopNumber)
}
GoToDesktopNumber(num) {
    global GoToDesktopNumberProc
    DllCall(GoToDesktopNumberProc, "Int", num, "Int")
    return
}
switchDesktopByNumber(num) {
    ; If user is holding down Mouse left button, move the current window also
    if (GetKeyState("LButton")) {
        MoveCurrentWindowToDesktop(num-1)
    } else {
        GoToDesktopNumber(num-1)
    }
    return
}

PrintScreen & 1::switchDesktopByNumber(1)
PrintScreen & 2::switchDesktopByNumber(2)
PrintScreen & 3::switchDesktopByNumber(3)
PrintScreen & 4::switchDesktopByNumber(4)
PrintScreen & 5::switchDesktopByNumber(5)
PrintScreen & q::switchDesktopByNumber(6)
PrintScreen & w::switchDesktopByNumber(7)
PrintScreen & e::switchDesktopByNumber(8)
PrintScreen & r::switchDesktopByNumber(9)
PrintScreen & t::switchDesktopByNumber(10)

;PrintScreen & Right::MoveCurrentWindowToRightDesktop()
;PrintScreen & Left::MoveCurrentWindowToLeftDesktop()

PrintScreen & WheelUp::Send {Volume_Up}
PrintScreen & WheelDown::Send {Volume_Down}

PrintScreen & d::Send #d

;PrintScreen & BackSpace::Send {Browser_Back}
;PrintScreen & Esc::Send {Browser_Back}

PrintScreen & c::Send {CapsLock}

PrintScreen & h::Send {Left}
PrintScreen & j::Send {Down}
PrintScreen & k::Send {Up}
PrintScreen & l::Send {Right}

PrintScreen & i::Send {Del}
PrintScreen & 0::Send {Home}
PrintScreen & `;::Send {End}

PrintScreen & f::Run wt
PrintScreen & p::Run "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory=Default
;PrintScreen & o::Run microsoft-edge:about:blank
;PrintScreen & f::Run C:\Users\mmazur\Apps\ubuntu.lnk

