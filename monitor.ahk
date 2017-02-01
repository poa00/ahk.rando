#SingleInstance force
#Persistent
DetectHiddenText, On

SetTimer, Check, 1000, On
global hasFinished := 2

Check() {
  global hasFinished
  ControlGet, buildOutput, List, , SysListView323, BuildTool

  IfInString, buildOutput, Finished
  {
    finished := 1
  } else {
    finished := 0
  }

  If (finished = 0 and hasFinished = 1)
  {
    TrayTip, build started, monitor.ahk has detected that build bot has begun a build
  }

  If (finished = 1 and hasFinished = 0)
  {
    ControlSend,, {Shift down}{f5}{Shift up}, EliteDangerous
    Sleep, 500
    ControlSend,, {f5}, EliteDangerous
    Sleep, 500
    ControlSend,, n, Microsoft Visual Studio

    TrayTip, build completed, monitor.ahk has detected that build bot has completed a build
  }

  hasFinished := finished
}
