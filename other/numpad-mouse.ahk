global scriptIsActive = false
global moving = false
global Increment = 1 ; number of pixels to move mouse....gets multiplied depending on keypress length
global MouseDelay = 0
global extraSpeedHalfLife = 15

SetBatchLines -1
makeGui()



RETURN

!P::SetScriptActive(!scriptIsActive)



; functions /////////////////////////////////////

SetScriptActive(isActive) {
    if (isActive) {
        ActivateScript()
    } else {
        DeactivateScript()
    }
    scriptIsActive = isActive
}

ActivateScript(void) {
  !'::RButton

  !`;::LButton
  Send {LButton Down}
  KeyWait `;
  Send {LButton Up}
  Return

  !\::Click

  !y::Click WheelUp

  !h::Click WheelDown

  !i::
  !j::
  !k::
  !l::
  incThreads()
  xVal=
  yVal=
  If GetKeyState("LAlt","D")
    {
    if checkMoving()
      return
    leanX := 0
    leanY := 0
    momX := 0
    momY := 0
    offsetX := 0
    offsetY := 0
    extraSpeed := 0
  	
    ; Infinite loop....breaks when key not pressed anymore
    Loop,
      {
  	setMoving(true)
  	extraSpeed := extraSpeed + 3
  	halfLife := getHalfLife()
      leanX := modifyX(leanX)
      leanY := modifyY(leanY)
  	momX := cap(leanX, 10)
  	momY := cap(leanY, 10)
  	offsetX := offsetX + momX
  	offsetY := offsetY + momY
  	xMov := Floor(offsetX)
  	yMov := Floor(offsetY)
  	offsetX := offsetX - xMov
  	offsetY := offsetY - yMov
  	xMov := xMov * (extraSpeed + halfLife) / halfLife
  	yMov := yMov * (extraSpeed + halfLife) / halfLife
  	if (xMov = 0 and yMov = 0)
  	  extraSpeed := 0
  	
      If GetKeyState("LAlt", "P") ; Make sure we are still pressing the key
      {
  	  threadCount := getThreads()
        MouseMove, %xMov%, %yMov%,%MouseDelay%,R
        ControlSetText Static1 , %threadCount% `r`n leanX `r`n %leanX% `r`n momX `r`n %momX% `r`n offsetX `r`n %offsetX% `r`n xMov `r`n %xMov% `r`n offsetX `r`n %offsetX% , AlwaysOnTop
      }
      Else ; we're not pressing the key...break the loop
  	  {
  	  moving := false
        Break
  	  }
      }
    }
  Else
     Send % "{" . A_ThisHotKey . "}"
  return

  SetDefaults(void)
  {
    global
    moving := false
    threads := 0
    return
  }

  modifyX(x)
    {
    return modifyDir(x, GetKeyState("l", "P"), GetKeyState("j", "P"))
    }

  modifyY(y)
    {
    return modifyDir(y, GetKeyState("k", "P"), GetKeyState("i", "P"))
    }
    
  modifyDir(n,inc,dec)
    {
    if inc
      n := n + 1
    if dec
      n := n - 1
    n := moveToZero(n, 0.5)
    n := 0.8 * n
    n := cap(n, 60)
    return n
    }
    
  moveToZero(n, amount)
    {
    If (n > 0)
      n := n - amount
    If (n < 0)
      n := n + amount
    If (n > -amount and n < amount)
      return 0
    return n
    }
    
  makeGui()
    {
    Gui,+AlwaysOnTop

    Gui, Add, Text, x0 y300 w100 h600 Center cBlack, I'M ALWAYS ON TOP

    Gui,Show,w100 h600 Center,AlwaysOnTop Window 

    return 



    GuiEscape: 

    GuiClose: 

    exitapp 
  }

  setMoving(bool)
    {
    global
    moving := bool
    }

  checkMoving()
    {
    global
    return moving
    }

  incThreads()
    {
    global
    threads := threads + 1
    }
    
  getThreads()
    {
    global
    return threads
    }

  cap(n, max) {
    if (n > max)
      return max
    if (n < 0-max)
      return -max
    return n
  }

  getHalfLife() {
    global
    return extraSpeedHalfLife
  }
}