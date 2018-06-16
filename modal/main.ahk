#Include %A_ScriptDir%\modal\change.ahk
#Include %A_ScriptDir%\modal\vim-keys.ahk
#Include %A_ScriptDir%\modal\mouse-keys.ahk
#Include %A_ScriptDir%\other\fancy_ex.ahk

ChangeMode(newMode) {
    global mode
    if (mode == newMode) {
        return newMode
    }

    try {
        DeactivateVimKeys()
        ActivateMouse()
        DeactivateMouse()
        ActivateChange()
        DeactivateChange()
    }
    catch ex {
       FancyEx.Throw(ex)
    }

    if (newMode == "vim") {
        global Cursor := A_ScriptDir . "\modal\red.cur"
        ActivateVimKeys()
    } else if (newMode == "mouse") {
        global Cursor := A_ScriptDir . "\modal\green.cur"
        ActivateMouse()
    } else if (newMode == "change") {
        global Cursor := A_ScriptDir . "\modal\blue.cur"
        ActivateChange()
    } else if (newMode == "insert") {
        global Cursor := A_ScriptDir . "\modal\blue.cur"
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
