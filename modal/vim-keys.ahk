global selecting = false

ActivateVimKeys() {
    hotkey, +{, LastParagraph
    hotkey, +}, NextParagraph
    hotkey, +I, InsertStartOfLineFunc
    hotkey, +A, InsertEndOfLineFunc
    hotkey, +O, InsertLineFunc

    hotkey, h, LeftFunc
    hotkey, j, DownFunc
    hotkey, k, UpFunc
    hotkey, l, RightFunc
    hotkey, w, RightWordFunc
    hotkey, b, LeftWordFunc
    hotkey, x, DeleteFunc
    hotkey, i, InsertFunc
    hotkey, s, InsertFunc
    hotkey, a, InsertAfterFunc
    hotkey, o, InsertAfterLineFunc
    hotkey, v, ShiftToggle
    hotkey, p, Paste
    hotkey, y, Copy
    hotkey, g, CtrlA
    hotkey, d, CtrlW
    hotkey, 8, CtrlShiftT
    hotkey, 9, CtrlShiftTab
    hotkey, 0, CtrlTab
    hotkey, n, CtrlF

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

    hotkey, h, on
    hotkey, j, on
    hotkey, k, on
    hotkey, l, on
    hotkey, w, on
    hotkey, b, on
    hotkey, x, on
    hotkey, i, on
    hotkey, y, on
    hotkey, g, on
    hotkey, d, on
    hotkey, 8, on
    hotkey, 9, on
    hotkey, 0, on
    hotkey, n, on
    hotkey, s, on
    hotkey, a, on
    hotkey, o, on
    hotkey, v, on
    hotkey, p, on

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

    hotkey, h, off
    hotkey, j, off
    hotkey, k, off
    hotkey, l, off
    hotkey, w, off
    hotkey, b, off
    hotkey, x, off
    hotkey, i, off
    hotkey, y, off

    hotkey, g, off
    hotkey, d, off
    hotkey, 8, off
    hotkey, 9, off
    hotkey, 0, off

    hotkey, u, off
    hotkey, n, off
    hotkey, s, off
    hotkey, a, off
    hotkey, o, off
    hotkey, v, off
    hotkey, p, off

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

CtrlF() {
    Send ^f
    GoToInsert()
}

CtrlW() {
    Send ^w
}

CtrlTab() {
    Send ^`t
}

CtrlShiftTab() {
    Send ^+`t
}

CtrlShiftT() {
    Send ^+t
}
