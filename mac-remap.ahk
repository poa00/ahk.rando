Send, {CTRLDOWN}{CTRLUP}{ALTDOWN}{ALTUP}{WINDOWN}{WINUP}{SHIFTDOWN}{SHIFTUP}

; Windows to mac remapping

; double quote to at
!2::@

; alt-3 to hash 
!3::
  Send, {Raw}#
Return

; right-alt to tab
LControl & RAlt::Send, {tab}
; LControl & Alt::Send, {tab}

; at to double quote
; +'::"

; hash to backslash
#::\

; tilde to pipe
~::\

; pipe to tilde
|::~

; backslash to backtick
$\::Send ``

; swap hyphen and underscore
+-::Send -
-::_

; swap colon and semicolon
$`;::Send `:
$+`;::Send `;

; Reload this script
^+r::
  Reload
  Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
  MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
  IfMsgBox, Yes, Edit
Return

!t::
  WinSet, Style, ^0xC00000, A
  WinSet, Style, ^0x840000, A
  WinSet, Style, ^0xC40000, A
Return
