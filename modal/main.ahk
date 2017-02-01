#Include %A_ScriptDir%\modal\gui.ahk
#Include %A_ScriptDir%\modal\change.ahk
#Include %A_ScriptDir%\modal\vim-keys.ahk
#Include %A_ScriptDir%\modal\mouse-keys.ahk

ChangeMode(newMode) {
    global mode
    if (mode == "vim") {
        DeactivateVimKeys()
    } else if (mode == "mouse") {
        DeactivateMouse()
    } else if (mode == "change") {
        DeactivateChange()
    }

    if (newMode == "vim") {
        global Cursor := A_ScriptDir . "\modal\red.cur"
        UpdateGui("", "red")
        ActivateVimKeys()
    } else if (newMode == "mouse") {
        global Cursor := A_ScriptDir . "\modal\green.cur"
        UpdateGui("", "green")
        ActivateMouse()
    } else if (newMode == "change") {
        global Cursor := A_ScriptDir . "\modal\blue.cur"
        UpdateGui("", "black")
        ActivateChange()
    } else if (newMode == "insert") {
        global Cursor := A_ScriptDir . "\modal\blue.cur"
        UpdateGui("", "white")
    }

    UpdateCursor()
    global mode := newMode
    return newMode
}

UpdateCursor()
{
    global Cursor
    CursorHandle := DllCall( "LoadCursor", Uint,0, Int,IDC_SIZEALL )
    CursorHandle := DllCall( "LoadCursorFromFile", Str,Cursor )
    SetSystemCursor(Cursor)
}

SendEscape() {
    send {escape down}{escape up}
}

Shift & CapsLock::goMouse()
Control & CapsLock::goMouse()

GoMouse() {
    changeMode("mouse")
}
