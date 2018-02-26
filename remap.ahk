; # win key
; ! alt
; ^ ctrl
; + shift

; double quote to at
+2::@

; at to double quote
@::+2

; right-alt to minus
; LControl & Alt::Send -

; at to double quote
; +'::"

; ctrl alt 0 to ctrl alt num-0
; ^!0::Send {LControl Down}{LAlt Down}{Numpad0}{LControl Up}{LAlt Up}
;^0::Send ``

; tilde to pipe
$~::Send |

; pipe to tilde
|::~
; |::Send a

; hash to tab
$#::Send, {tab}
; backslash to hyphen
; $\::Send -
$\::Send -

; underscore to backtick
$+-::Send ``

; backtick to forward slash
$`::Send /

; forward slash to back slash
$/::\
$+/::?

; hyphen to underscore
$-::Send _

; swap colon and semicolon
$`;::Send `:
$+`;::Send `;

; Reload this script
$^!r::
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

!Esc::Suspend, Toggle
