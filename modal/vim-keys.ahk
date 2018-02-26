global selecting = false

ActivateVimKeys() {
    hotkey, +{, LastParagraph
    hotkey, +}, NextParagraph
    hotkey, +I, InsertStartOfLineFunc
    hotkey, +A, InsertEndOfLineFunc
    hotkey, +O, InsertLineFunc

    hotkey, 0, CtrlTab
    hotkey, 8, CtrlShiftT
    hotkey, 9, CtrlShiftTab
    hotkey, a, InsertAfterFunc
    hotkey, b, LeftWordFunc
    hotkey, d, CtrlW
    hotkey, e, RightWordFunc
    hotkey, h, LeftFunc
    hotkey, i, InsertFunc
    hotkey, j, DownFunc
    hotkey, k, UpFunc
    hotkey, l, RightFunc
    hotkey, n, CtrlF
    hotkey, m, Minimize
    hotkey, o, InsertAfterLineFunc
    hotkey, p, Paste
    hotkey, r, CtrlR
    hotkey, s, InsertFunc
    hotkey, t, CtrlT
    hotkey, v, ShiftToggle
    hotkey, w, CtrlA
    hotkey, x, DeleteFunc
    hotkey, y, Copy

    hotkey, +h, LeftFunc
    hotkey, +j, DownFunc
    hotkey, +k, UpFunc
    hotkey, +l, RightFunc
    hotkey, +w, RightWordFunc
    hotkey, +b, LeftWordFunc
    hotkey, +x, DeleteFunc
    hotkey, +i, InsertFunc
    hotkey, +a, InsertAfterFunc
    hotkey, +o, InsertAfterLineFunc
    hotkey, +v, ShiftToggle

    hotkey, [, GoToInsert

    VimKeysOn()
}

VimKeysOn() {
    hotkey, +{, on
    hotkey, +}, on
    hotkey, +I, on
    hotkey, +A, on
    hotkey, +O, on

    hotkey, 0, on
    hotkey, 8, on
    hotkey, 9, on
    hotkey, a, on
    hotkey, b, on
    hotkey, d, on
    hotkey, e, on
    hotkey, h, on
    hotkey, i, on
    hotkey, j, on
    hotkey, k, on
    hotkey, l, on
    hotkey, n, on
    hotkey, m, on
    hotkey, o, on
    hotkey, p, on
    hotkey, r, on
    hotkey, s, on
    hotkey, t, on
    hotkey, v, on
    hotkey, w, on
    hotkey, x, on
    hotkey, y, on

    hotkey, +h, on
    hotkey, +j, on
    hotkey, +k, on
    hotkey, +l, on
    hotkey, +w, on
    hotkey, +b, on
    hotkey, +x, on
    hotkey, +i, on
    hotkey, +a, on
    hotkey, +o, on
    hotkey, +v, on

    hotkey, [, on
}

DeactivateVimKeys() {
    hotkey, +{, off
    hotkey, +}, off
    hotkey, +I, off
    hotkey, +A, off
    hotkey, +O, off

    hotkey, 0, off
    hotkey, 8, off
    hotkey, 9, off
    hotkey, a, off
    hotkey, b, off
    hotkey, d, off
    hotkey, e, off
    hotkey, h, off
    hotkey, i, off
    hotkey, j, off
    hotkey, k, off
    hotkey, l, off
    hotkey, n, off
    hotkey, m, off
    hotkey, o, off
    hotkey, p, off
    hotkey, r, off
    hotkey, s, off
    hotkey, t, off
    hotkey, u, off
    hotkey, v, off
    hotkey, w, off
    hotkey, x, off
    hotkey, y, off

    hotkey, +h, off
    hotkey, +j, off
    hotkey, +k, off
    hotkey, +l, off
    hotkey, +w, off
    hotkey, +b, off
    hotkey, +x, off
    hotkey, +i, off
    hotkey, +a, off
    hotkey, +o, off
    hotkey, +v, off

    hotkey, [, off
}

LeftFunc() {
    send {left}
}

DownFunc() {
    send {down}
}

UpFunc() {
    send {up}
}

RightFunc() {
    send {right}
}

LeftWordFunc() {
    send {LCtrl down}
    send {left}
    send {LCtrl up}
}

RightWordFunc() {
    send {LCtrl down}
    send {right}
    send {LCtrl up}
}

LastParagraph() {
    MsgBox last paragraph not implemented
}

NextParagraph() {
    MsgBox next paragraph not implemented
}

DeleteFunc() {
    send {Delete}
}

InsertLineFunc() {
    changeMode("insert")
    send {home}
    send {return}
    send {up}
}

InsertAfterLineFunc() {
    changeMode("insert")
    send {end}
    send {return}
}

InsertAfterFunc() {
    changeMode("insert")
    send {right}
}

InsertFunc() {
    changeMode("insert")
}

InsertStartOfLineFunc() {
	changeMode("insert")
	send {home}
}

InsertEndOfLineFunc() {
	changeMode("insert")
	send {end}
}

ShiftToggle() {
    global selecting
    if (selecting) {
        send {shift up}
        selecting := false
    } else {
        send {shift down}
        selecting := true
    }
}

Copy() {
    Send ^c
}

Paste() {
    Send ^v
}

CtrlA() {
    Send ^a
    GoToInsert()
}

CtrlR() {
    Send ^{f5}
}

CtrlF() {
    Send ^f
    GoToInsert()
}

ReloadTab() {
    Send !^t
}

CtrlW() {
    Send ^w
}

CtrlTab() {
    SetTitleMatchMode, 2
    if WinActive("Visual Studio")
    {
        Send ^!{PgDn}
    }
    else
    {
        Send ^`t
    }
}

CtrlShiftTab() {
    SetTitleMatchMode, 2
    if WinActive("Visual Studio")
    {
        Send ^!{PgUp}
    }
    else
    {
        Send ^+`t
    }
}

CtrlShiftT() {
    Send ^+t
}

Minimize() {
    WinMinimize, A
}

CtrlT() {
    Send ^t
    GoToInsert()
}
