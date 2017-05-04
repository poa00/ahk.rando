; Switch mode
global mode
$tab::
  ChangeMode("mouse")
Return
CapsLock::
  SendEscape()
Return

^!i::
WinGet Style, Style, A
if(Style & 0xC00000) {
    WinSet, Style, -0xC00000, A
} else {
    WinSet, Style, +0xC00000, A
}
return
;
