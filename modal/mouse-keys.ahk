#Include %A_ScriptDir%\modal\mousejump.ahk

global moveMouseThreads := 0
global slowSpeed := 12
global midSpeed := 67
global fastSpeed := 400
global Cursor := A_ScriptDir . "\modal\red.cur"
global mousejump := 0

VarSetCapacity(FILTERKEYS, 24)
NumPut(24, FILTERKEYS, 0, "UInt") ;cbSize
NumPut(1, FILTERKEYS, 4, "UInt") ;dwFlag
NumPut(300, FILTERKEYS, 12, "UInt") ;iDelayMSec
NumPut(50, FILTERKEYS, 16, "UInt") ;RepeatMSec
DllCall("SystemParametersInfo", "UInt", 0x0033, "UInt", 0, "Ptr", &FILTERKEYS, "Uint", 0)

SPI_SETCURSORS := 0x57
DllCall( "SystemParametersInfo", UInt,SPI_SETCURSORS, UInt,0, UInt,0, UInt,0 )

ActivateMouse() {
    mousejumpActivate()
    nonmousejumpActivate()
} 

DeactivateMouse() {
    mousejumpDeactivate()
    nonmousejumpDeactivate()
}

nonmousejumpActivate() {
    Hotkey, f, RightMouseDown
    Hotkey, f Up, RightMouseUp
    Hotkey, t, MiddleMouseDown
    Hotkey, t Up, MiddleMouseUp

    Hotkey, s, GoInsert
    Hotkey, !s, GoInsert
    Hotkey, q, GoVim
    Hotkey, !q, GoVim

    Hotkey, r, SendScrollUp
    Hotkey, v, SendScrollDown
    Hotkey, d, SendScrollLeft
    Hotkey, g, SendScrollRight
    Hotkey, Space, MouseDown
    Hotkey, Space Up, MouseUp

    Hotkey, !r, SendScrollUp
    Hotkey, !v, SendScrollDown
    Hotkey, !d, SendScrollLeft
    Hotkey, !g, SendScrollRight
    Hotkey, !Space, MouseDown
    Hotkey, !Space Up, MouseUp

    Hotkey, +r, SendScrollUp
    Hotkey, +v, SendScrollDown
    Hotkey, +d, SendScrollLeft
    Hotkey, +g, SendScrollRight
    Hotkey, +Space, MouseDown
    Hotkey, +Space Up, MouseUp

    Hotkey, ^r, SendScrollUp
    Hotkey, ^v, SendScrollDown
    Hotkey, ^d, SendScrollLeft
    Hotkey, ^g, SendScrollRight
    Hotkey, ^Space, MouseDown
    Hotkey, ^Space Up, MouseUp

    Hotkey, n, SlowLeftMove
    Hotkey, m, SlowDownMove
    Hotkey, `,, SlowUpMove
    Hotkey, `., SlowRightMove
    Hotkey, h, MidLeftMove
    Hotkey, j, MidDownMove
    Hotkey, k, MidUpMove
    Hotkey, l, MidRightMove
    Hotkey, y, FastLeftMove
    Hotkey, u, FastDownMove
    Hotkey, i, FastUpMove
    Hotkey, o, FastRightMove

    Hotkey, !n, SlowLeftMove
    Hotkey, !m, SlowDownMove
    Hotkey, !`,, SlowUpMove
    Hotkey, !`., SlowRightMove
    Hotkey, !h, MidLeftMove
    Hotkey, !j, MidDownMove
    Hotkey, !k, MidUpMove
    Hotkey, !l, MidRightMove
    Hotkey, !y, FastLeftMove
    Hotkey, !u, FastDownMove
    Hotkey, !i, FastUpMove
    Hotkey, !o, FastRightMove

    Hotkey, ^n, SlowLeftMove
    Hotkey, ^m, SlowDownMove
    Hotkey, ^`,, SlowUpMove
    Hotkey, ^`., SlowRightMove
    Hotkey, ^h, MidLeftMove
    Hotkey, ^j, MidDownMove
    Hotkey, ^k, MidUpMove
    Hotkey, ^l, MidRightMove
    Hotkey, ^y, FastLeftMove
    Hotkey, ^u, FastDownMove
    Hotkey, ^i, FastUpMove
    Hotkey, ^o, FastRightMove

    Hotkey, 2, SendTilde
    Hotkey, 3, SendHash
    Hotkey, 4, SendDash
    Hotkey, 5, Something
    hotkey, 9, CtrlShiftTab
    hotkey, 0, CtrlTab

    hotkey, _, AltTab
    hotkey, =, ShiftAltTab

    Hotkey, w, CtrlA

    nonmousejumpOn()
}

nonmousejumpOn() {
    Hotkey, f, On
    Hotkey, f Up, On
    Hotkey, t, On
    Hotkey, t Up, On

    Hotkey, s, On
    Hotkey, !s, On
    Hotkey, q, On
    Hotkey, !q, On

    Hotkey, !r, On
    Hotkey, !v, On
    Hotkey, !d, On
    Hotkey, !g, On
    Hotkey, !Space, On
    Hotkey, !Space Up, On
    Hotkey, !`,, On
    Hotkey, !`., On

    Hotkey, +r, On
    Hotkey, +v, On
    Hotkey, +d, On
    Hotkey, +g, On
    Hotkey, +Space, On
    Hotkey, +Space Up, On
    Hotkey, +`,, On
    Hotkey, +`., On

    Hotkey, ^r, On
    Hotkey, ^v, On
    Hotkey, ^d, On
    Hotkey, ^g, On
    Hotkey, ^Space, On
    Hotkey, ^Space Up, On
    Hotkey, ^`,, On
    Hotkey, ^`., On

    Hotkey, r, On
    Hotkey, v, On
    Hotkey, d, On
    Hotkey, g, On
    Hotkey, Space, On
    Hotkey, Space Up, On
    Hotkey, `,, On
    Hotkey, `., On
    Hotkey, !y, On
    Hotkey, !u, On
    Hotkey, !i, On
    Hotkey, !o, On
    Hotkey, !h, On
    Hotkey, !j, On
    Hotkey, !k, On
    Hotkey, !l, On
    Hotkey, !n, On
    Hotkey, !m, On

    Hotkey, ^y, On
    Hotkey, ^u, On
    Hotkey, ^i, On
    Hotkey, ^o, On
    Hotkey, ^h, On
    Hotkey, ^j, On
    Hotkey, ^k, On
    Hotkey, ^l, On
    Hotkey, ^n, On
    Hotkey, ^m, On

    Hotkey, y, On
    Hotkey, u, On
    Hotkey, i, On
    Hotkey, o, On
    Hotkey, h, On
    Hotkey, j, On
    Hotkey, k, On
    Hotkey, l, On
    Hotkey, n, On
    Hotkey, m, On

    Hotkey, 2, On
    Hotkey, 3, On
    Hotkey, 4, On
    Hotkey, 5, On
    hotkey, 9, On
    hotkey, 0, On

    hotkey, _, on
    hotkey, =, on

    hotkey, w, on
}

nonmousejumpDeactivate() {
    Hotkey, f, Off
    Hotkey, f Up, Off
    Hotkey, t, Off
    Hotkey, t Up, Off

    Hotkey, s, Off
    Hotkey, !s, Off
    Hotkey, q, Off
    Hotkey, !q, Off

    Hotkey, +r, Off
    Hotkey, +v, Off
    Hotkey, +d, Off
    Hotkey, +g, Off
    Hotkey, +Space, Off
    Hotkey, +Space Up, Off
    Hotkey, +`,, Off
    Hotkey, +`., Off

    Hotkey, !r, Off
    Hotkey, !v, Off
    Hotkey, !d, Off
    Hotkey, !g, Off
    Hotkey, !Space, Off
    Hotkey, !Space Up, Off
    Hotkey, !`,, Off
    Hotkey, !`., Off

    Hotkey, !y, Off
    Hotkey, !u, Off
    Hotkey, !i, Off
    Hotkey, !o, Off
    Hotkey, !h, Off
    Hotkey, !j, Off
    Hotkey, !k, Off
    Hotkey, !l, Off
    Hotkey, !n, Off
    Hotkey, !m, Off
    Hotkey, ^r, Off
    Hotkey, ^v, Off
    Hotkey, ^d, Off
    Hotkey, ^g, Off
    Hotkey, ^Space, Off
    Hotkey, ^Space Up, Off
    Hotkey, ^y, Off
    Hotkey, ^u, Off
    Hotkey, ^i, Off
    Hotkey, ^o, Off
    Hotkey, ^h, Off
    Hotkey, ^j, Off
    Hotkey, ^k, Off
    Hotkey, ^l, Off
    Hotkey, ^n, Off
    Hotkey, ^m, Off
    Hotkey, ^`,, Off
    Hotkey, ^`., Off

    Hotkey, r, Off
    Hotkey, v, Off
    Hotkey, d, Off
    Hotkey, g, Off
    Hotkey, Space, Off
    Hotkey, Space Up, Off
    Hotkey, y, Off
    Hotkey, u, Off
    Hotkey, i, Off
    Hotkey, o, Off
    Hotkey, h, Off
    Hotkey, j, Off
    Hotkey, k, Off
    Hotkey, l, Off
    Hotkey, n, Off
    Hotkey, m, Off
    Hotkey, `,, Off
    Hotkey, `., Off

    Hotkey, 2, Off
    Hotkey, 3, Off
    Hotkey, 4, Off
    Hotkey, 5, Off
    hotkey, 9, Off
    hotkey, 0, Off

    hotkey, _, off
    hotkey, =, off

    hotkey, w, off
}

MouseDown() {
    Click down
}


MouseUp() {
    Click up
}

MiddleMouseDown() {
    Click down middle
}

MiddleMouseUp() {
    Click up middle
}

RightMouseDown() {
    Click down right
}

RightMouseUp() {
    Click up right
}

SlowLeftMove() {
    global slowSpeed
    MouseMove, -%slowSpeed%, 0, 0,R
}

SlowUpMove() {
    global slowSpeed
    MouseMove, 0, -%slowSpeed%, 0,R
}

SlowDownMove() {
    global slowSpeed
    MouseMove, 0, %slowSpeed%, 0,R
}

SlowRightMove() {
    global slowSpeed
    MouseMove, %slowSpeed%, 0, 0,R
}

MidLeftMove() {
    global midSpeed
    MouseMove, -%midSpeed%, 0, 0,R
}

MidUpMove() {
    global midSpeed
    MouseMove, 0, -%midSpeed%, 0,R
}

MidDownMove() {
    global midSpeed
    MouseMove, 0, %midSpeed%, 0,R
}

MidRightMove() {
    global midSpeed
    MouseMove, %midSpeed%, 0, 0,R
}

FastLeftMove() {
    global fastSpeed
    MouseMove, -%fastSpeed%, 0, 0,R
}

FastUpMove() {
    global fastSpeed
    MouseMove, 0, -%fastSpeed%, 0,R
}

FastDownMove() {
    global fastSpeed
    MouseMove, 0, %fastSpeed%, 0,R
}

FastRightMove() {
    global fastSpeed
    MouseMove, %fastSpeed%, 0, 0,R
}

SendScrollUp() {
    click WheelUp
}

SendScrollDown() {
    click WheelDown
}

SendScrollLeft() {
    click WheelLeft
}

SendScrollRight() {
    click WheelRight
}

GoInsert() {
    changeMode("insert")
}

GoVim() {
    changeMode("vim")
}

GoMouseMove() {
    changeMode("mouse")
}

SendTabChar() {
    Send, {tab}
}

RestoreCursors()
{
    SPI_SETCURSORS := 0x57
    DllCall( "SystemParametersInfo", UInt,SPI_SETCURSORS, UInt,0, UInt,0, UInt,0 )
}

SetSystemCursor( Cursor = "", cx = 0, cy = 0 )
{
    BlankCursor := 0, SystemCursor := 0, FileCursor := 0 ; init
    
    SystemCursors = 32512IDC_ARROW,32513IDC_IBEAM,32514IDC_WAIT,32515IDC_CROSS
    ,32516IDC_UPARROW,32640IDC_SIZE,32641IDC_ICON,32642IDC_SIZENWSE
    ,32643IDC_SIZENESW,32644IDC_SIZEWE,32645IDC_SIZENS,32646IDC_SIZEALL
    ,32648IDC_NO,32649IDC_HAND,32650IDC_APPSTARTING,32651IDC_HELP
    
    If Cursor = ; empty, so create blank cursor 
    {
        VarSetCapacity( AndMask, 32*4, 0xFF ), VarSetCapacity( XorMask, 32*4, 0 )
        BlankCursor = 1 ; flag for later
    }
    Else If SubStr( Cursor,1,4 ) = "IDC_" ; load system cursor
    {
        Loop, Parse, SystemCursors, `,
        {
            CursorName := SubStr( A_Loopfield, 6, 15 ) ; get the cursor name, no trailing space with substr
            CursorID := SubStr( A_Loopfield, 1, 5 ) ; get the cursor id
            SystemCursor = 1
            If ( CursorName = Cursor )
            {
                CursorHandle := DllCall( "LoadCursor", Uint,0, Int,CursorID )   
                Break                   
            }
        }   
        If CursorHandle = ; invalid cursor name given
        {
            Msgbox,, SetCursor, Error: Invalid cursor name
            CursorHandle = Error
        }
    }   
    Else If FileExist( Cursor )
    {
        SplitPath, Cursor,,, Ext ; auto-detect type
        If Ext = ico 
            uType := 0x1    
        Else If Ext in cur,ani
            uType := 0x2        
        Else ; invalid file ext
        {
            Msgbox,, SetCursor, Error: Invalid file type
            CursorHandle = Error
        }       
        FileCursor = 1
    }
    Else
    {   
        Msgbox,, SetCursor, Error: Invalid file path or cursor name
        CursorHandle = Error ; raise for later
    }
    If CursorHandle != Error 
    {
        Loop, Parse, SystemCursors, `,
        {
            If BlankCursor = 1 
            {
                Type = BlankCursor
                %Type%%A_Index% := DllCall( "CreateCursor"
                , Uint,0, Int,0, Int,0, Int,32, Int,32, Uint,&AndMask, Uint,&XorMask )
                CursorHandle := DllCall( "CopyImage", Uint,%Type%%A_Index%, Uint,0x2, Int,0, Int,0, Int,0 )
                DllCall( "SetSystemCursor", Uint,CursorHandle, Int,SubStr( A_Loopfield, 1, 5 ) )
            }           
            Else If SystemCursor = 1
            {
                Type = SystemCursor
                CursorHandle := DllCall( "LoadCursor", Uint,0, Int,CursorID )   
                %Type%%A_Index% := DllCall( "CopyImage"
                , Uint,CursorHandle, Uint,0x2, Int,cx, Int,cy, Uint,0 )     
                CursorHandle := DllCall( "CopyImage", Uint,%Type%%A_Index%, Uint,0x2, Int,0, Int,0, Int,0 )
                DllCall( "SetSystemCursor", Uint,CursorHandle, Int,SubStr( A_Loopfield, 1, 5 ) )
            }
            Else If FileCursor = 1
            {
                Type = FileCursor
                %Type%%A_Index% := DllCall( "LoadImageW"
                , UInt,0, Str,Cursor, UInt,uType, Int,cx, Int,cy, UInt,0x10 ) 
                DllCall( "SetSystemCursor", Uint,%Type%%A_Index%, Int,SubStr( A_Loopfield, 1, 5 ) )         
            }          
        }
    }   
}

SendTilde() {
  Send |
  GoToInsert()
}

SendDash() {
  Send, {Raw}-
  GoToInsert()
}

SendHash() {
  Send, {Raw}#
  GoToInsert()
}

Something() {
  WinSet, Style, ^0xC00000, A
  WinSet, Style, ^0x840000, A
  WinSet, Style, ^0xC40000, A
  WinMaximize, A
}

AltTab() {
;    Send {Alt Down}
;    Send, {tab}
    Hotkey, !Enter, ExitAltTab
    Hotkey, !Enter, on
    Send {Alt Down}
    Send {tab}
} 

ShiftAltTab() {
    Send {tab}
}

ExitAltTab() {
    Send {Alt Up}
    Hotkey, !Enter, off
}
