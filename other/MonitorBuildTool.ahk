#Persistent
DetectHiddenText, On

SetTimer, Check, 1000, On
global hasFinished := 0

Check() {
  global hasFinished
  counter := counter + 1
  ControlGet, buildOutput, List, , SysListView323, BuildTool

  IfInString, buildOutput, Finished
  {
    finished := 1
  } else {
    finished := 0
  }

  If (finished = 1 and hasFinished = 0)
  {
    ControlSend,, {Shift down}{f5}{Shift up}, EliteDangerous
    Sleep, 500
    ControlSend,, {f5}, EliteDangerous
    Sleep, 500
    ControlSend,, n, Microsoft Visual Studio

    MsgBox, finished
  }

  hasFinished := finished
}
