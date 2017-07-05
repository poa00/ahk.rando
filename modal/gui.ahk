; Set up the initial state
SetWinDelay, -1
global mode := ""
buttonWidth := 300
buttonHeight := 3

; Create the gui
Gui, MyGui11:New,, MyGui11
Gui, MyGui12:New,, MyGui12
Gui, MyGui13:New,, MyGui13
Gui, MyGui14:New,, MyGui14
Gui, MyGui21:New,, MyGui21
Gui, MyGui22:New,, MyGui22
Gui, MyGui23:New,, MyGui23
Gui, MyGui24:New,, MyGui24
Gui, MyGui31:New,, MyGui31
Gui, MyGui32:New,, MyGui32
Gui, MyGui33:New,, MyGui33
Gui, MyGui34:New,, MyGui34

Gui, MyGui11:Margin, 0, 0
Gui, MyGui12:Margin, 0, 0
Gui, MyGui13:Margin, 0, 0
Gui, MyGui14:Margin, 0, 0
Gui, MyGui21:Margin, 0, 0
Gui, MyGui22:Margin, 0, 0
Gui, MyGui23:Margin, 0, 0
Gui, MyGui24:Margin, 0, 0
Gui, MyGui31:Margin, 0, 0
Gui, MyGui32:Margin, 0, 0
Gui, MyGui33:Margin, 0, 0
Gui, MyGui34:Margin, 0, 0
                                                                                                                                                                                                                                                                                                                                                                                                                                                  
Gui, MyGui11:Add, Edit, vVisibleText  -E0x200, %mode%
Gui, MyGui12:Add, Edit, vVisibleText  -E0x200, %mode%
Gui, MyGui13:Add, Edit, vVisibleText  -E0x200, %mode%
Gui, MyGui14:Add, Edit, vVisibleText  -E0x200, %mode%
Gui, MyGui21:Add, Edit, vVisibleText  -E0x200, %mode%
Gui, MyGui22:Add, Edit, vVisibleText  -E0x200, %mode%
Gui, MyGui23:Add, Edit, vVisibleText  -E0x200, %mode%
Gui, MyGui24:Add, Edit, vVisibleText  -E0x200, %mode%
Gui, MyGui31:Add, Edit, vVisibleText  -E0x200, %mode%
Gui, MyGui32:Add, Edit, vVisibleText  -E0x200, %mode%
Gui, MyGui33:Add, Edit, vVisibleText  -E0x200, %mode%
Gui, MyGui34:Add, Edit, vVisibleText  -E0x200, %mode%

Gui, MyGui11:+E0x08000000
Gui, MyGui12:+E0x08000000
Gui, MyGui13:+E0x08000000
Gui, MyGui14:+E0x08000000
Gui, MyGui21:+E0x08000000
Gui, MyGui22:+E0x08000000
Gui, MyGui23:+E0x08000000
Gui, MyGui24:+E0x08000000
Gui, MyGui31:+E0x08000000
Gui, MyGui32:+E0x08000000
Gui, MyGui33:+E0x08000000
Gui, MyGui34:+E0x08000000

Gui, MyGui11:+AlwaysOnTop
Gui, MyGui12:+AlwaysOnTop
Gui, MyGui13:+AlwaysOnTop
Gui, MyGui14:+AlwaysOnTop
Gui, MyGui21:+AlwaysOnTop
Gui, MyGui22:+AlwaysOnTop
Gui, MyGui23:+AlwaysOnTop
Gui, MyGui24:+AlwaysOnTop
Gui, MyGui31:+AlwaysOnTop
Gui, MyGui32:+AlwaysOnTop
Gui, MyGui33:+AlwaysOnTop
Gui, MyGui34:+AlwaysOnTop

Gui, MyGui11:+ToolWindow
Gui, MyGui12:+ToolWindow
Gui, MyGui13:+ToolWindow
Gui, MyGui14:+ToolWindow
Gui, MyGui21:+ToolWindow
Gui, MyGui22:+ToolWindow
Gui, MyGui23:+ToolWindow
Gui, MyGui24:+ToolWindow
Gui, MyGui31:+ToolWindow
Gui, MyGui32:+ToolWindow
Gui, MyGui33:+ToolWindow
Gui, MyGui34:+ToolWindow

Gui, MyGui11:-Caption
Gui, MyGui12:-Caption
Gui, MyGui13:-Caption
Gui, MyGui14:-Caption
Gui, MyGui21:-Caption
Gui, MyGui22:-Caption
Gui, MyGui23:-Caption
Gui, MyGui24:-Caption
Gui, MyGui31:-Caption
Gui, MyGui32:-Caption
Gui, MyGui33:-Caption
Gui, MyGui34:-Caption

Gui, MyGui11:+Owner
Gui, MyGui12:+Owner
Gui, MyGui13:+Owner
Gui, MyGui14:+Owner
Gui, MyGui21:+Owner
Gui, MyGui22:+Owner
Gui, MyGui23:+Owner
Gui, MyGui24:+Owner
Gui, MyGui31:+Owner
Gui, MyGui32:+Owner
Gui, MyGui33:+Owner
Gui, MyGui34:+Owner

; Get monitor measurements
SysGet, Mon1, Monitor, 2
s1w := Mon1Right - Mon1Left ; 1920
s1h := Mon1Bottom - Mon1Top ; 1079
s2w := 1920
s2h := 1079
s3w := 1439
s3h := 899

SysGet, MonCount, MonitorCount
if MonCount > 1
{
    SysGet, Mon2, Monitor, 1
    s2w := Mon2Right - Mon2Left ; 1920
    s2h := Mon2Bottom - Mon2Top ; 1079
    SysGet, Mon3, Monitor, 3
    s3w := Mon3Right - Mon3Left ; 1920
    s3h := Mon3Bottom - Mon3Top ; 1079
}

x1 := s1w - buttonWidth - 1
x2 := s1w + 1
x3 := s1w + s2w - buttonWidth - 1
x4 := s1w + s2w + 1
x5 := s1w + s2w + s3w - buttonWidth - 1
y1 := s1h - buttonHeight - 3
y2 := s2h - buttonHeight - 3
y3 := s3h - buttonHeight - 3

Gui, MyGui11:Show, x1 y1 w%buttonWidth% h%buttonHeight%
Gui, MyGui12:Show, x%x1% y1 w%buttonWidth% h%buttonHeight%
Gui, MyGui13:Show, x1 y%y1% w%buttonWidth% h%buttonHeight%
Gui, MyGui14:Show, x%x1% y%y1% w%buttonWidth% h%buttonHeight%
Gui, MyGui21:Show, x%x2% y1 w%buttonWidth% h%buttonHeight%
Gui, MyGui22:Show, x%x3% y1 w%buttonWidth% h%buttonHeight%
Gui, MyGui23:Show, x%x2% y%y2% w%buttonWidth% h%buttonHeight%
Gui, MyGui24:Show, x%x3% y%y2% w%buttonWidth% h%buttonHeight%
Gui, MyGui31:Show, x%x4% y1 w%buttonWidth% h%buttonHeight%
Gui, MyGui32:Show, x%x5% y1 w%buttonWidth% h%buttonHeight%
Gui, MyGui33:Show, x%x4% y%y3% w%buttonWidth% h%buttonHeight%
Gui, MyGui34:Show, x%x5% y%y3% w%buttonWidth% h%buttonHeight%

WM_MOUSEACTIVATE(wParam, lParam)
{
       Return 4 ;MA_NOACTIVATEANDEAT
       
}

UpdateGui(mode, colour) {
    Gui, MyGui11:Color, %colour%, %colour%
    Gui, MyGui12:Color, %colour%, %colour%
    Gui, MyGui13:Color, %colour%, %colour%
    Gui, MyGui14:Color, %colour%, %colour%
    Gui, MyGui21:Color, %colour%, %colour%
    Gui, MyGui22:Color, %colour%, %colour%
    Gui, MyGui23:Color, %colour%, %colour%
    Gui, MyGui24:Color, %colour%, %colour%
    Gui, MyGui31:Color, %colour%, %colour%
    Gui, MyGui32:Color, %colour%, %colour%
    Gui, MyGui33:Color, %colour%, %colour%
    Gui, MyGui34:Color, %colour%, %colour%

    if ("" . colour = "white")
    {
        WinMove, MyGui11,, 0, -99
        WinMove, MyGui12,, 0, -99
        WinMove, MyGui13,, 0, -99
        WinMove, MyGui14,, 0, -99
        WinMove, MyGui21,, 0, -99
        WinMove, MyGui22,, 0, -99
        WinMove, MyGui23,, 0, -99
        WinMove, MyGui24,, 0, -99
        WinMove, MyGui31,, 0, -99
        WinMove, MyGui32,, 0, -99
        WinMove, MyGui33,, 0, -99
        WinMove, MyGui34,, 0, -99
    }
    else
    {
;        ; Get monitor measurements
;        SysGet, Mon1, Monitor, 1
;        s1w := Mon1Right - Mon1Left ; 1920
;        s1h := Mon1Bottom - Mon1Top ; 1079
;        s2w := 1920
;        s2h := 1079
;        s3w := 1439
;        s3h := 899
;
;        SysGet, MonCount, MonitorCount
;        if MonCount > 1
;        {
;            SysGet, Mon2, Monitor, 2
;            s2w := Mon2Right - Mon2Left ; 1920
;            s2h := Mon2Bottom - Mon2Top ; 1079
;            SysGet, Mon3, Monitor, 3
;            s3w := Mon3Right - Mon3Left ; 1920
;            s3h := Mon3Bottom - Mon3Top ; 1079
;        }
;
;        buttonWidth := 600
;        buttonHeight := 7
;
;        x1 := s1w - 2 * buttonWidth - 1
;        x2 := s1w
;        x3 := s1w + s2w - 2 * buttonWidth - 1
;        x4 := s1w + s2w
;        x5 := s1w + s2w + s3w - 2 * buttonWidth - 1
;        y1 := s1h - 3 * buttonHeight
;        y2 := s2h - buttonHeight
;        y3 := s3h - buttonHeight


        global buttonWidth
        global buttonHeight
        global x1
        global x2
        global x3
        global x4
        global x5
        global y1
        global y2
        global y3

        WinMove, MyGui11,, 1, 1, %buttonWidth%, %buttonHeight%
        WinMove, MyGui12,, %x1%, 1, %buttonWidth%, %buttonHeight%
        WinMove, MyGui13,, 1, %y1%, %buttonWidth%, %buttonHeight%
        WinMove, MyGui14,, %x1%, %y1%, %buttonWidth%, %buttonHeight%
        WinMove, MyGui21,, %x2%, 1, %buttonWidth%, %buttonHeight%
        WinMove, MyGui22,, %x3%, 1, %buttonWidth%, %buttonHeight%
        WinMove, MyGui23,, %x2%, %y2%, %buttonWidth%, %buttonHeight%
        WinMove, MyGui24,, %x3%, %y2%, %buttonWidth%, %buttonHeight%
        WinMove, MyGui31,, %x4%, 1, %buttonWidth%, %buttonHeight%
        WinMove, MyGui32,, %x5%, 1, %buttonWidth%, %buttonHeight%
        WinMove, MyGui33,, %x4%, %y3%, %buttonWidth%, %buttonHeight%
        WinMove, MyGui34,, %x5%, %y3%, %buttonWidth%, %buttonHeight%
    }
}
