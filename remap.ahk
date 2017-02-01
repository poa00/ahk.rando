; # win key
; ! alt
; ^ ctrl
; + shift

; Windows to mac remapping

; double quote to at
!2::@

; right-alt to backslash
LControl & RAlt::Send, \
; LControl & Alt::Send, {tab}

; at to double quote
; +'::"

; tilde to pipe
~::\

; pipe to tilde
|::~

; hash to backslash
$#::Send, {tab}
; backslash to hyphen
$\::Send -

; underscore to backtick
+-::Send ``

; hyphen to underscore
-::_

; alt-3 to hash 
!3::
  global Cursor := A_ScriptDir . "\modal\hidden.cur"
  Send, {Raw}#
Return

; swap colon and semicolon
$`;::Send `:
$+`;::Send `;

; Reload this script
^!r::
  Reload
  Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
  MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
  IfMsgBox, Yes, Edit
Return

#z::
  DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
Return

!t::
  WinSet, Style, ^0xC00000, A
  WinSet, Style, ^0x840000, A
  WinSet, Style, ^0xC40000, A
Return

^!t::
  FileDelete, %A_ScriptDir%\debug
  WinGet, buildToolControls, ControlList, BuildTool
  Loop, Parse, buildToolControls, `n
  {
    ControlGetText, text, %A_LoopField%, BuildTool
    FileAppend, %A_LoopField%: %text%`n, %A_ScriptDir%\debug
    IfInString, text, Output
    {
      TrayTip, Test, %A_LoopField%
    }
  }
Return
