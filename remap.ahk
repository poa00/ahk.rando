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
; |::~
|::Send a

; hash to backslash
$#::Send, {tab}
; backslash to hyphen
; $\::Send -
$\::Send a 

; underscore to backtick
+-::Send ``

; hyphen to underscore
-::_

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

TestFunc() {
  FileDelete, %A_ScriptDir%\debug
  WinGet, buildToolControls, ControlList, A
  ; ControlGet, text, List, text, , SysListView, Update
  ; Loop, Parse, buildToolControls, `n
  ; {
  ;   ControlGetText, text, %A_LoopField%, A
  ;   FileAppend, %A_LoopField%: %text%`n, %A_ScriptDir%\debug
  ;   IfInString, text, Error
  ;   {
  ;     TrayTip, Test, %text%
  ;   }
  ; }
}
