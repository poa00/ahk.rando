#SingleInstance force
#Persistent
DetectHiddenText, On

SetTimer, BuildBotCheck, 4000, On
SetTimer, RuntimeErrorCheck, 200, On
SetTimer, GameClosedCheck, 200, On
SetTimer, UpdateFinishedCheck, 200, On

global g_build_bot_finished := 2
global g_runtime_error := 0
global g_game_closed := 0
global g_update_finished := 0

UpdateFinishedCheck() {
  global g_update_finished
  update_finished = 0
  IfWinExist, Update Finished!
  {
    update_finished = 1
  }
  if (update_finished = 1 and g_update_finished = 0)
  {
    TrayTip, update finished, starting build
    ControlSend,, {ctrl down}{shift down}b{shift up}{ctrl up}, EliteDangerous
    ControlSend, Button15, {f7}, BuildTool
    ControlSend,, {Escape}, Update Finished!
  }
  g_update_finished := update_finished
}

GameClosedCheck() {
  global g_game_closed
  game_closed = 0
  IfWinExist, Elite - Dangerous (CLIENT)
  {
    game_closed = 1
  }
  if (game_closed = 0 and g_game_closed = 1)
  {
    TrayTip, game closed, all tests passed
  }
  g_game_closed := game_closed
}

RuntimeErrorCheck() {
  global g_runtime_error
  runtime_error := GetRuntimeError()

  if (g_runtime_error = 0 and runtime_error != 0)
  {
    TrayTip, runtime error detected, something has gone wrong!
  }

  g_runtime_error := runtime_error
}

BuildBotCheck() {
  global g_has_build_bot_finished
  outputId := GetOutputID()
  ControlGet, buildOutput, List, , %outputId%, BuildTool

  IfInString, buildOutput, Finished
  {
    finished := 1
  } else {
    finished := 0
  }

  If (finished = 0 and g_has_build_bot_finished = 1)
  {
    ControlSend,, {Shift down}{f5}{Shift up}, EliteDangerous
  }

  If (finished = 1 and g_has_build_bot_finished = 0)
  {
    ControlSend,, {Shift down}{f5}{Shift up}, EliteDangerous
    Sleep, 500
    ControlSend,, {f5}, EliteDangerous
    Sleep, 500
    ControlSend,, n, Microsoft Visual Studio

    TrayTip, build completed, starting game
  }

  g_has_build_bot_finished := finished
}

GetOutputId() {
  WinGet, buildToolControls, ControlList, BuildTool
  Loop, Parse, buildToolControls, `n
  {
    ControlGetText, text, %A_LoopField%, BuildTool
    IfInString, text, Output
    {
      return %A_LoopField%
    }
  }
}

GetRuntimeError() {
  WinGet, buildToolControls, ControlList, Runtime Error
  Loop, Parse, buildToolControls, `n
  {
    ControlGetText, text, %A_LoopField%, Runtime Error
    IfInString, text, Error
    {
      return %text%
    }
  }
  return 0
}
