#MaxThreads 1
SetTitleMatchMode, 2
TrayTip, ahk load, ahk scripts loaded
; Run %A_ScriptDir%\monitor.ahk, , , monitorPID
Send {Alt up}{Shift up}{Ctrl up}
#Include %A_ScriptDir%\modal\main.ahk
#Include %A_ScriptDir%\modal\hotkeys.ahk
; #Include %A_ScriptDir%\remap.ahk
