Send, {CTRLDOWN}{CTRLUP}{ALTDOWN}{ALTUP}{WINDOWN}{WINUP}{SHIFTDOWN}{SHIFTUP}

; Windows to mac remapping

; double quote to at
+2::@

; alt-3 to hash 
!3::
  Send, {Raw}#
Return

; at to double quote
+'::"

; hash to backslash
#::\

; tilde to pipe
~::\

; pipe to tilde
|::~

; backslash to backtick
\::`

; Reload this script
^+r::
  Reload
  Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
  MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
  IfMsgBox, Yes, Edit
Return