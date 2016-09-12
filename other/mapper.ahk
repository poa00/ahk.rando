#SingleInstance,Force
#Persistent
DetectHiddenWindows,On
SetBatchLines,-1
CoordMode,Mouse,Screen
global settings,program,v:=[]
settings:=new xml("settings"),v.gui:=[]
new xbox(0)
xbox.edit()
Gui()
Add_Alternate_Commands(info:=""){
    if(info){
        if(ssn(program,"descendant::Alt[@name='" info.1 "']"))
            return m("Alternate already assigned.")
        Deselect()
        return ea:=xml.ea(program),settings.under(program,"Alt",{name:info.1,select:1}),program:=settings.ssn("//game[@name='" ea.name "']"),lv(1)
    }else
        xbox.edit("Press either a Button or Trigger",A_ThisFunc,"Buttons","Triggers")
}
Add_Game(){
    KeyWait,%A_ThisHotkey%,U
    InputBox,name,New Game,Enter the name for the new game.
    if (ErrorLevel||name="")
        return
    select:=settings.sn("//*[@select='1']"),game:=settings.Add("game",{name:name,expand:1,select:1},,1),settings.under({under:game,node:"DirectInput",att:{name:"Direct Input",on:1}}),settings.under({under:game,node:"Alt",att:{name:"Main",main:1}}),settings.add("last",{game:name}),LV_Update()
    return
}
Add_XBox_Assignment(info:=""){
    v.current:=settings.ssn("//*[@tv='" TV_GetSelection() "']/ancestor-or-self::KeyPress")
    if !v.current
        return m("Please Select a KeyPress Assignment")
    xbox.edit("Press either a Button or Trigger or Axis","Set_Info","Buttons","Triggers","Axis")
}
Add_Keypress(info){
    deselect()
    hotkey:=v.hotkey
    StringUpper,Hotkey,Hotkey
    parent:=Top()
    top:=settings.under(parent,"KeyPress",{Key:hotkey,select:1,Expand:1})
    if(info.3="axis")
        next:=settings.under(top,"Axis",{Axis:info.1}),settings.under(next,"Direction",{Direction:info.2})
    else if(info.3="Buttons")
        settings.under(top,"Button",{Button:info.1})
    else if(info.3="Triggers")
        settings.under(top,"Trigger",{Trigger:info.1})
    SetTimer,updateprog,-1
    lv(2)
}
class xbox{
    static mousekeys:={LButton:"left",RButton:"right",MButton:"Middle",WheelDown:"WheelDown",WheelUp:"WheelUp"}
    ,Buttons:={Up:1,Down:2,Left:4,Right:8,Start:16,Back:32,LeftThumb:64,RightThumb:128,LeftShoulder:256,RightShoulder:512,A:0x1000,B:0x2000,X:0x4000,Y:0x8000}
    ,axis:={LThumbX:8,LThumbY:10,RThumbX:12,RThumbY:14},triggers:={LTrigger:6,RTrigger:7},mode:="",keys:=[],this:=[],ad:={x:["Right","Left"],y:["Up","Down"]}
    ,keystroke:={22528:"A",22529:"B",22549:"Back",22545:"Down",22546:"Left",22547:"Right",22544:"Up",22533:"LeftShoulder",22561:"LThumbY_Down",22563:"LThumbX_Left",22550:"LeftThumb",22562:"LThumbX_Right",22560:"LThumbY_Up",22534:"LTrigger",22532:"RightShoulder",22577:"RThumbY_Down",22579:"RThumbX_Left",22551:"RightThumb",22578:"RThumbX_Right",22576:"RThumbY_Up",22535:"RTrigger",22548:"Start",22530:"X",22531:"Y"}
    ,flip:={up:"Down",down:"Up",left:"Right",right:"Left"}
    ,data:=[],all:=[]
    __New(count:=0){
        static
        for a,b in xbox.buttons
            xbox.All[a]:="Buttons"
        for a,b in xbox.triggers
            xbox.all[a]:="Triggers"
        for a,b in xbox.axis
            xbox.All[a]:="Axis"
        xbox.delta:=[],xbox.delta.x:=0,xbox.delta.y:=0
        this.library:=DllCall("LoadLibrary","str",InStr(A_OSVersion,8)?"Xinput1_4":"Xinput1_3"),this.ctrl:=[],VarSetCapacity(move,28,0),this.count:=count,main:=this,xbox.move:=&move,VarSetCapacity(State,16),xbox.state:=&state
        main.ctrl:=[],NumPut(1,move,16)
        if !(this.library){
            m("Error loading the DLL")
            ExitApp
        }
        for a,b in {xGetState:"XInputGetState",xBattery:"XInputGetBatteryInformation",xSetState:"XInputSetState",xkeystroke:"XInputGetKeystroke"}
            this[a]:=DllCall("GetProcAddress","ptr",this.library,"astr",b)
        xbox.main:=this,down:=hold:=value:=[]
        gosub,updateprog
        Return this
        updateprog:
        rel:=sn(program,"descendant::*[@pressed='1']")
        while,rl:=rel.item[A_Index-1]
            xbox.send(rl,"Up"),rl.RemoveAttribute("pressed")
        xbox.input:=ssn(program,"descendant::DirectInput/@on").text,mn:=ssn(program,"Alt[@main='1']"),alts:=sn(program,"Alt[@name!='Main']"),alt:=[]
        while,aa:=alts.item[A_Index-1],ea:=xml.ea(aa)
            Alt[ea.name]:=aa
        return
        getstate:
        DllCall(main.xGetState,"uint",0,uptr,&State),buttons:=NumGet(state,4)
        xbox.currentstate:=&state,xbox.buttonstate:=buttons,alts:=xbox.ks(sn(program,"Alt[@name!='Main']")),current:=alts?ssn(program,"Alt[@name='" alts "']"):mn
        if(current.xml!=last.xml){
            rel:=sn(last,"descendant::*[@pressed='1']")
            while,rl:=rel.item[A_Index-1]
                xbox.send(rl,"Up"),rl.RemoveAttribute("pressed")
        }
        last:=current,list:=sn(current,"descendant::KeyPress|descendant::Mouse|descendant::Radius")
        while,ll:=list.item[A_Index-1],ea:=xml.ea(ll){
            if(ll.nodename="radius"),value:=[]{
                for c,d in ["x","y"]
                    value[d]:=Floor(NumGet(state,xbox.axis[ea.read d],"short")/3276*10)
                if(xbox.ks(sn(ll,"descendant-or-self::*"))&&ea.pressed!=1){
                    MouseGetPos,x,y
                    for a,b in {X:x,Y:y}
                        ll.SetAttribute(a,b)
                    ll.SetAttribute("pressed",1)
                    while,child:=TV_GetChild(ea.tv)
                        TV_Delete(child)
                    for a,b in ["Center","Dead","Distance","Read","X","Y"]
                        TV_Add(b " = " ea[b],ea.tv)
                    return
                }
                centerx:=ea.x?ea.x:A_ScreenWidth/2,centery:=ea.y?ea.y:A_ScreenHeight/2
                if(Abs(value.x)>ea.dead*15||Abs(value.y)>ea.dead*15)
                    MouseMove,% (centerx+(value.x*(ea.distance/5))),% (centery-(value.y*(ea.distance/5)))
            }
            if(ll.nodename="keypress"){
                if(xbox.gs(sn(ll,"*"))){
                    if(ea.pressed!=1)
                        ll.SetAttribute("pressed",1),xbox.send(ll,"Down")
                }else if(ea.pressed)
                    xbox.send(ll,"Up"),ll.RemoveAttribute("pressed")
            }
            if(ll.nodename="mouse"){
                value:=xbox.gs(sn(ll,"descendant::Read")),dead:=ssn(ll,"descendant::Dead/@Dead").text
                if(Abs(value.x)>dead||Abs(value.y)>dead){
                    if(ea.pressed!=1)
                        ll.SetAttribute("pressed",1),xbox.send(ll,"Down")
                    value.y:=a.invert?value.y:value.y*-1,NumPut(value.x,xbox.move,4),NumPut(value.y,xbox.move,8),speed:=Abs(value.x)>Abs(value.y)?Abs(value.x):Abs(value.y),speed:=speed?speed:1,movey:=a.yinvert?movey:movey*-1,speed1:=ssn(ll,"descendant::Speed/@Speed").text
                    Loop,% Abs(speed/(speed1/2))
                        DllCall("User32\SendInput",uint,1,uptr,xbox.move,uint,28)
                }else if(ea.pressed)
                    xbox.send(ll,"Up"),ll.RemoveAttribute("pressed")
            }
        }
        return
    }
    ks(info){ ;#[Class XBox]
        while,ii:=info.item[A_Index-1],ea:=xml.ea(ii){
            name:=ea.center?ea.center:ea.name
            if(value:=xbox.buttonstate&xbox.buttons[name])
                return xbox.buttonstate&value?name:""
            if(number:=xbox.triggers[name])
                if(NumGet(xbox.currentstate,xbox.triggers[name],"uchar")/255*10>2?1:0)
                    return NumGet(xbox.currentstate,value,"uchar")/255*10>2?name:0
        }
    }
    edit(msg,func,type*){
        static
        SplashTextOn,200,100,Input Required,%msg%`nOr press Escape to cancel
        Hotkey,IfWinActive,% hwnd([1])
        Hotkey,Escape,stop,On
        type1:=type,function:=func
        VarSetCapacity(state,4)
        SetTimer,edit,50
        return
        stop:
        SplashTextOff
        SetTimer,Edit,Off
        return
        edit:
        DllCall(xbox.main.xkeystroke,int,0,int,0,"ptr",&state)
        if(NumGet(state,4)=1){
            pressed:=StrSplit(xbox.keystroke[NumGet(state)],"_")
            for a,b in type1{
                if(xbox[b,pressed.1]){
                    SetTimer,Edit,off
                    SplashTextOff
                    %function%([pressed.1,pressed.2,b])
                }
            }
        }
        return
    }
    Send(key,state){
        keys:=sn(key,"descendant-or-self::*/@Hold|@Key")
        while,kk:=keys.Item[A_Index=keys.length?0:A_Index]{
            if this.mousekeys[kk.text]{
                if InStr(kk.text,"wheel")&&state="Down"
                    MouseClick,% this.mousekeys[kk.text]
                Else if !InStr(kk.text,"wheel")
                    MouseClick,% this.mousekeys[kk.text],,,,,%state%
            }
            else{
                if(xbox.input){
                    DllCall("keybd_event","int",GetKeyVK(kk.text),"int",0,"int",state="down"?0:2,"int",0)
                }else{
                    key:=kk.text
                    ControlSend,,{%key% %state%},A
                }
            }
        }
    }
    gs(info){
        obj:=[]
        while,ii:=info.item[A_Index-1]{
            if(ii.nodename="hold")
                Continue
            all:=sn(ii,"descendant-or-self::*/@*")
            while,aa:=all.item[A_Index-1]
                obj[aa.NodeName]:=aa.text
            if(obj.button)
                if(!check:=xbox.buttonstate&xbox.Buttons[obj.button])
                    return
            if(obj.axis&&obj.direction){
                val:=Round(NumGet(xbox.currentstate,xbox.axis[obj.axis],"short")/32767*10)
                if(!check:=Abs(val)>3&&xbox.ad[SubStr(obj.axis,0),val>=0?1:2]=obj.direction?1:0)
                    return
            }else if(obj.trigger){
                if(!check:=NumGet(xbox.currentstate,xbox.triggers[obj.trigger],"uchar")/255*10>3?1:0)
                    return
            }
            if(obj.read){
                p:=[]
                for a,b in ["x","y"]
                    p[b]:=Round(NumGet(xbox.currentstate,xbox.axis[obj.read b],"short")/32767*10)
                return p
            }
        }
        if(check)
            return check
    }
}
Deselect(){
    rem:=sn(program,"descendant::*[@select='1']")
    while,rr:=rem.item[A_Index-1]
        rr.RemoveAttribute("select")
}
Exit(){
    GuiClose:
    LV_GetText(text,LV_GetNext()),next:=0
    if(LV_GetNext())
        settings.add("last",{game:text})
    while,next:=TV_GetNext(next,"F"){
        node:=ssn(program,"descendant::*[@tv='" next "']")
        if(TV_Get(next,"Expand"))
            node.SetAttribute("expand",1)
        else
            node.RemoveAttribute("expand")
    }
    select:=sn(program,"descendant::*[@select='1']")
    while,ss:=select.item[A_Index-1]
        ss.RemoveAttribute("select")
    if(!select:=ssn(program,"descendant::*[@tv='" TV_GetSelection() "']"))
        select:=ssn(program,"descendant::*[@tv='" TV_GetParent(TV_GetSelection()) "']")
    select.SetAttribute("select",1),tv:=settings.sn("//*[@tv!='']")
    while,tt:=tv.item[A_Index-1]
        tt.RemoveAttribute("tv")
    WinGetPos,x,y,,,% hwnd([1])
    pos:=winpos()
    if(pos.w&&pos.h)
        settings.Add("gui",{pos:"x" x " y" y " w" pos.w " h" pos.h})
    settings.save(1)
    ExitApp
    return
}
Export(){
    info:=program
    FileSelectFile,filename,S
    if ErrorLevel
        return
    filename:=SubStr(filename,-3)=".xml"?filename:filename ".xml"
    temp:=new xml("temp",filename),temp.xml.loadxml(info.xml),remtv:=temp.sn("//*[@tv]")
    while,rem:=remtv.Item[A_Index-1]
        rem.removeattribute("tv")
    temp.save(1)
}
Gui(){
    static
    Gui,Color,0xCCCCCC,0xCCCCCC
    Gui,+hwndmain +Resize
    hwnd(1,main),OnMessage(5,"Resize")
    Hotkey,IfWinActive,% hwnd([1])
    for a,b in {"+Escape":"Exit",Delete:"Delete","+Delete":"Delete","^Up":"move","^Down":"move","^Left":"move","^Right":"move"}
        Hotkey,%a%,%b%,On
    newwin:=new GuiKeep(1,["ListView,w200 h500 glv AltSubmit,Profile,h","TreeView,x+5 w250 h500 gtv AltSubmit,,wh","Hotkey,xm vhotkey gadd,,y","Edit,x+5 guphot w200 vuphot,,wy","Button,xm w455 gadd Default,Add,wy","Button,w455 gstart,&Start,wy"],"main")
    LV_Update(),lv(1)
    Gui,Show,% settings.ssn("//gui/@pos").text
    return
    start:
    if(A_GuiControl="&start"){
        SetTimer,updateprog,-1
        SetTimer,getstate,30
        ControlSetText,%A_GuiControl%,&Stop,% hwnd([1])
    }else if(A_GuiControl="&Stop"){
        ControlSetText,%A_GuiControl%,&Start,% hwnd([1])
        SetTimer,updateprog,Off
        SetTimer,getstate,Off
    }
    return
    add:
    var:=newwin[]
    ControlGetFocus,Focus,% hwnd([1])
    if(Focus="Edit1"||focus="msctls_hotkey321"){
        if !RegExMatch(var.hotkey,"\w")
            return
        v.hotkey:=var.hotkey
        xbox.edit("Press a Button, Trigger, or Axis","add_keypress","Buttons","Axis","Triggers")
    }
    return
    uphot:
    Gui,Submit,Nohide
    GuiControl,,msctls_hotkey321,% newwin[].uphot
    return
}
hwnd(win,hwnd=""){
    static window:=[]
    if win=get
        return window
    if (win.rem){
        if !window[win.rem]
            Gui,% win.rem ":Destroy"
        Else
            DllCall("DestroyWindow",uptr,window[win.rem])
        window[win.rem]:=""
    }
    if IsObject(win)
        return "ahk_id" window[win.1]
    if !hwnd
        return window[win]
    window[win]:=hwnd
}
Import(filename:=""){
    if !filename
        FileSelectFile,filename,,,,*.xml
    FileRead,file,%filename%
    temp:=new xml("temp")
    temp.xml.loadxml(file)
    if !game:=temp.ssn("//game")
        return m("Incompatible file.  Sorry.")
    name:=ssn(game,"@name").text
    if(settings.ssn("//game[@name='" name "']")){
        InputBox,name,Game Exists,Please enter a new name for this game,,,,,,,,%name%
        if(ErrorLevel)
            return
        if settings.ssn("//game[@name='" name "']")
            return m("game exists")
        ssn(game,"@name").text:=name
    }
    settings.ssn("//Settings").AppendChild(game),LV_Update()
    return
    GuiDropFiles:
    for a,b in StrSplit(A_GuiEvent,"`n")
        Import(b)
    return
}
lv(lv){
    if(lv=2){
        while,next:=TV_GetNext(next,"F"){
            node:=ssn(program,"descendant::*[@tv='" next "']")
            if(TV_Get(next,"Expand"))
                node.SetAttribute("expand",1)
            else
                node.RemoveAttribute("expand")
        }
    }
    if(A_GuiEvent="I"||lv=2||lv=1){
        GuiControl,1:-Redraw,SysTreeView321
        TV_Delete(),LV_GetText(text,LV_GetNext()),program:=settings.ssn("//game[@name='" text "']"),list:=sn(program,"descendant-or-self::*")
        while,ll:=list.item[A_Index-1],ea:=xml.ea(ll){
            if(ll.nodename="directinput")
                text:=ea.name " - " (ea.on?"On":"Off")
            if(ll.nodename="Alt")
                text:=ea.main?"Main Assignment":"Alt Assignment: " ea.name
            if(ll.nodename="Group")
                text:=ea.name
            if(ll.nodename="Mouse")
                text:="Mouse"
            if(ll.nodename="keypress")
                text:=ll.nodename " = " ea.key
            if(ll.nodename~="i)Button|Axis|Direction|Read|Dead|Speed|Trigger|Hold")
                text:=ll.nodename " = " ea[ll.nodename]
            if(ll.nodename="Radius"){
                ll.SetAttribute("tv",(tv:=TV_Add("Radius",ssn(ll.ParentNode,"@tv").text,(ea.expand?"Expand":""))))
                for a,b in ["Center","Dead","Distance","Read","X","Y"]
                    TV_Add(b " = " ea[b],tv)
                tv:=""
            }
            if(ll.nodename="Group")
                text:=ea.name
            if(text)
                ll.SetAttribute("tv",TV_Add(text,ssn(ll.ParentNode,"@tv").text,(ea.expand?"Expand":"")))
            text:=""
        }
        GuiControl,1:+Redraw,SysTreeView321
        TV_Modify(ssn(program,"descendant::*[@select='1']/@tv").text,"Select Vis Focus")
        SetTimer,updateprog,-1
    }
    return
}
LV_Update(){
    LV_Delete()
    pro:=settings.sn("//game"),last:=settings.ea("//last")
    while,pp:=pro.item[A_Index-1],ea:=xml.ea(pp)
        LV_Add(ea.name==last.game?"Select Vis Focus":"",ea.name)
    return
}
Menu(name){
    static menu:={Main:[{"&File":["Rena&me Current Game","&Export","&Import","E&xit"]},{"&Add":["Add &Game","Add &Alternate Commands","Add &XBox Assignment","Add Gr&oup","Add &Held Key","Add &Mouse Assignment","Add &Radius Constraint"]},{"&Edit":["&Collapse All Assignments","&Expand All Assignments"]},{"A&bout":["Show Available Assignments","Version"]}]}
    for a,b in Menu[name]{
        for c,d in b{
            for e,f in d
                Menu,%c%,Add,%f%,menu
            Menu,%name%,Add,%c%,:%c%
        }
    }
    return name
    menu:
    menu:=RegExReplace(RegExReplace(A_ThisMenuItem," ","_"),"&")
    %menu%()
    return
}
t(x*){
    for a,b in x
        list.=b "`n"
    Tooltip,% list
}
m(x*){
    for a,b in x
        list.=b "`n"
    MsgBox,,AHK Studio,% list
}
Rename_Current_Game(){
    if !LV_GetNext()
        return m("Please select a game to rename")
    LV_GetText(current,LV_GetNext())
    InputBox,new,New Game Name,Please enter a new name for this game,,,,,,,,%current%
    if(ErrorLevel||new="")
        return
    if (new==current)
        return m("Please enter a different name")
    if settings.ssn("//game[@name='" new "']")
        return m("Game name already exists")
    name:=ssn(program,"@name"),name.text:=new,LV_Delete()
    while,nn:=settings.sn("//game/@name").Item[A_Index-1]
        LV_Add(_:=nn.text=new?"Select Vis Focus":"",nn.text)
    if !LV_GetNext()
        LV_Modify(1,"Select Vis Focus")
    filename:="",LV_GetText(profile,LV_GetNext()),settings.add("last",{game:profile}),lv_update()
}
Set_Info(info){
    static switch:={Buttons:"Button",Axis:"Axis",Triggers:"Trigger"}
    Deselect()
    att:=[],node:=switch[info.3]
    att[node]:=info.1
    if(info.2)
        att["expand"]:=1
    v.current.SetAttribute("select",1)
    top:=settings.under(v.current,node,att)
    if(info.2)
        settings.under(top,"Direction",{Direction:info.2,expand:1})
    lv(2)
    return
}
class xml{
    keep:=[]
    __New(param*){
        if !FileExist(A_ScriptDir "\lib")
            FileCreateDir,%A_ScriptDir%\lib
        root:=param.1,file:=param.2
        file:=file?file:root ".xml"
        temp:=ComObjCreate("MSXML2.DOMDocument"),temp.setProperty("SelectionLanguage","XPath")
        this.xml:=temp
        if FileExist(file){
            FileRead,info,%file%
            if(info=""){
                this.xml:=this.CreateElement(temp,root)
                FileDelete,%file%
            }else
                temp.loadxml(info),this.xml:=temp
        }else
            this.xml:=this.CreateElement(temp,root)
        this.file:=file
        xml.keep[root]:=this
    }
    CreateElement(doc,root){
        return doc.AppendChild(this.xml.CreateElement(root)).parentnode
    }
    add(path,att:="",text:="",dup:=0,list:=""){
        p:="/",dup1:=this.ssn("//" path)?1:0,next:=this.ssn("//" path),last:=SubStr(path,InStr(path,"/",0,0)+1)
        if !next.xml{
            next:=this.ssn("//*")
            Loop,Parse,path,/
                last:=A_LoopField,p.="/" last,next:=this.ssn(p)?this.ssn(p):next.appendchild(this.xml.CreateElement(last))
        }
        if(dup&&dup1)
            next:=next.parentnode.appendchild(this.xml.CreateElement(last))
        for a,b in att
            next.SetAttribute(a,b)
        for a,b in StrSplit(list,",")
            next.SetAttribute(b,att[b])
        if(text!="")
            next.text:=text
        return next
    }
    under(under,node:="",att:="",text:="",list:=""){
        if(node="")
            node:=under.node,att:=under.att,list:=under.list,under:=under.under
        new:=under.appendchild(this.xml.createelement(node))
        for a,b in att
            new.SetAttribute(a,b)
        for a,b in StrSplit(list,",")
            new.SetAttribute(b,att[b])
        if text
            new.text:=text
        return new
    }
    ssn(path){
        return this.xml.SelectSingleNode(path)
    }
    sn(path){
        return this.xml.SelectNodes(path)
    }
    __Get(x=""){
        return this.xml.xml
    }
    transform(){
        static
        if !IsObject(xsl){
            xsl:=ComObjCreate("MSXML2.DOMDocument")
            style=
            (
            <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
            <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
            <xsl:template match="@*|node()">
            <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
            <xsl:for-each select="@*">
            <xsl:text></xsl:text>       
            </xsl:for-each>
            </xsl:copy>
            </xsl:template>
            </xsl:stylesheet>
            )
            xsl.loadXML(style),style:=null
        }
        this.xml.transformNodeToObject(xsl,this.xml)
    }
    save(x*){
        if x.1=1
            this.Transform()
        filename:=this.file?this.file:x.1.1,encoding:=ffff.pos=3?"UTF-8":ffff.pos=2?"UTF-16":"CP0",enc:=RegExMatch(this[],"[^\x00-\x7F]")?"utf-16":"utf-8"
        if(encoding!=enc)
            FileDelete,%filename%
        file:=fileopen(filename,"rw",encoding),file.seek(0),file.write(this[]),file.length(file.position)
    }
    ea(path){
        list:=[]
        if nodes:=path.nodename
            nodes:=path.SelectNodes("@*")
        else if path.text
            nodes:=this.sn("//*[text()='" path.text "']/@*")
        else if !IsObject(path)
            nodes:=this.sn(path "/@*")
        else
            for a,b in path
                nodes:=this.sn("//*[@" a "='" b "']/@*")
        while,n:=nodes.item(A_Index-1)
            list[n.nodename]:=n.text
        return list
    }
}
ssn(node,path){
    return node.SelectSingleNode(path)
}
sn(node,path){
    return node.SelectNodes(path)
}
Delete(){
    node:=ssn(program,"//*[@tv='" TV_GetSelection() "']"),ea:=xml.ea(node),deselect()
    if(node.nodename~="i)game|directinput")
        return
    if(ea.main)
        return m("Can not delete the main section")
    if(A_ThisHotkey="Delete"){
        MsgBox,52,Are you sure?,Can not be undone. (Press Shift+Delete to bypass this)
        IfMsgBox,No
            return
    }
    if(sel:=node.nextsibling)
        sel.SetAttribute("select",1)
    else if(sel:=node.previoussibling)
        sel.SetAttribute("select",1)
    else
        node.ParentNode.SetAttribute("select",1)
    node.ParentNode.RemoveChild(node)
    lv(2)
}
Add_Held_Key(){
    node:=settings.ssn("//*[@tv='" TV_GetSelection() "']")
    if(!node)
        node:=settings.ssn("//*[@tv='" TV_GetParent(TV_GetSelection()) "']")
    v.current:=ssn(node,"ancestor-or-self::KeyPress|ancestor-or-self::Mouse|ancestor-or-self::Radius")
    InputBox,key,Enter the name of the key to be held,Key name
    if(ErrorLevel||key="")
        return
    deselect()
    v.current.SetAttribute("select",1)
    settings.under(v.current,"Hold",{Hold:key})
    lv(2)
}
Add_Mouse_Assignment(info:=""){
    static current
    if(info){
        top:=Top(),deselect()
        next:=settings.under(top,"Mouse",{select:1,expand:1})
        head:=settings.under(next,"Read",{Read:SubStr(info.1,1,-1),expand:1})
        for a,b in {Dead:3,Speed:3}
            att:=[],att[a]:=b,settings.under(head,a,att)
        lv(2)
        return
    }
    xbox.edit("Move an analog stick","Add_Mouse_Assignment","Axis")
}
Add_Group(){
    current:=Top(),deselect()
    InputBox,name,Add Group,Enter a group name
    if(ErrorLevel||name="")
        return
    settings.under(current,"Group",{name:name,select:1}),lv(2)
}
Top(){
    node:=ssn(program,"descendant::*[@tv='" TV_GetSelection() "']")
    for a,b in ["ancestor-or-self::Group","ancestor-or-self::Alt"]
        if((test:=ssn(node,b)).xml)
            break
    return parent:=(test.nodename~="Group|Alt")?test:ssn(program,"descendant::*[@main='1']")
}
tv(info){
    static switch:={RThumb:"LThumb",LThumb:"RThumb"},node
    if(info.1){
        deselect(),node.SetAttribute("select",1)
        if(node.nodename="radius")
            node.SetAttribute("Center",info.1)
        else if(node.nodename="alt"){
            node.SetAttribute("name",info.1)
        }else{
            top:=node.ParentNode,node.ParentNode.RemoveChild(node)
            if(info.3="axis")
                next:=settings.under(top,"Axis",{Axis:info.1}),settings.under(next,"Direction",{Direction:info.2})
            else if(info.3="Buttons")
                settings.under(top,"Button",{Button:info.1})
            else if(info.3="Triggers")
                settings.under(top,"Trigger",{Trigger:info.1})
        }
        SetTimer,updateprog,-1
        lv(2)
        return
    }
    if(A_GuiEvent="RightClick"){
        node:=settings.ssn("//*[@tv='" A_EventInfo "']"),ea:=xml.ea(node)
        if(node.nodename="read"){
            node.SetAttribute("Read",switch[ea.read]?switch[ea.read]:"LThumb")
        }else if(node.nodename~="i)dead|speed"){
            InputBox,new,Enter a new value,Enter a new value,,,,,,,,% ea[node.nodename]
            if(ErrorLevel||new="")
                return
            node.SetAttribute(node.nodename,new)
        }else if(node.nodename~="i)button|axis|trigger"){
            xbox.edit("Press a Button, Axis, or Trigger","tv","Buttons","Triggers","Axis")
        }else if(node.nodename="Alt"&&ea.main!=1){
            xbox.edit("Press a Button or Trigger","tv","Buttons","Triggers")
        }else if(!node){
            node:=settings.ssn("//*[@tv='" TV_GetParent(A_EventInfo) "']"),TV_GetText(value,A_EventInfo),ea:=xml.ea(node)
            if(InStr(value,"read"))
                node.SetAttribute("Read",switch[ea.read]?switch[ea.read]:"LThumb")
            else if(RegExMatch(value,"Oi)(X|Y|Dead|Distance)",found)){
                InputBox,new,Enter a new value,Enter a new value for %found1%,,,,,,,,% ea[found.1]
                if(ErrorLevel||new="")
                    return
                if new is not number
                    return m("Must be an integer")
                node.SetAttribute(found.1,new)
            }else if(InStr(value,"Center"))
                xbox.edit("Press a Button or Trigger","tv","Buttons","Triggers")
        }
        deselect(),node.SetAttribute("select",1),lv(2)
    }
}

;add { with text after it and { is at the begining of the line
;-make {`n`toldtext`n}
Class GuiKeep{
    static keep:=[]
    __New(win,info="",menu=""){
        static
        con:=[]
        for a,b in {border:32,caption:4}{
            SysGet,%a%,%b%
            this[a]:=%a%
        }
        for a,b in info{
            opt:=StrSplit(b,","),RegExMatch(opt.2,"iO)\bv(\w+)",found)
            if(found.1)
                this.var[found.1]:=1
            hwnd:=this.add(opt)
            if(opt.4){
                ControlGetPos,x,y,w,h,,ahk_id%hwnd%
                for a,b in {x:x,y:y,w:w,h:h}
                    con[hwnd,a]:=b-(a="x"?this.border*2:a="y"?(this.caption+this.border):a="h"?this.border:0)
                con[hwnd,"pos"]:=opt.4
            }
        }
        Gui,%win%:Menu,% Menu(menu)
        Gui,Show,Hide
        this.win:=win,pos:=winpos()
        WinGetPos,xx,yy,,,% hwnd([1])
        VarSetCapacity(size,16,0),DllCall("GetClientRect","uint",hwnd(win),"uint",&size),w:=NumGet(size,8),h:=NumGet(size,12)
        flip:={x:"w",y:"h"}
        for control,b in con{
            obj:=this.gui[control]:=[]
            for c,d in StrSplit(b.pos){
                if(d~="w|h")
                    obj[d]:=b[d]-%d%
                if(d~="x|y")
                    val:=flip[d],obj[d]:=b[d]-%val%
            }
        }
        GuiKeep.keep[win]:=this
    }
    add(opt:=""){
        static
        if(!opt){
            var:=[]
            Gui,% this.win ":Submit",Nohide
            for a,b in this.var
                var[a]:=%a%
            return var
        }
        Gui,Add,% opt.1,% opt.2 " hwndhwnd",% opt.3
        return hwnd
    }
    __Get(){
        return this.add()
    }
    current(win){
        return GuiKeep.keep[win]
    }
}
Resize(a,b){
    static width,height
    info:=GuiKeep.current(A_Gui)
    if(b>>16)
        height:=b>>16?b>>16:height,width:=b&0xffff?b&0xffff:width
    static flip:={x:"w",y:"h"}
    for a,b in info.gui{
        for c,d in b{
            if(c~="y|h")
                GuiControl,MoveDraw,%a%,% c height+d
            else
                GuiControl,MoveDraw,%a%,% c width+d
        }
    }
}
Winpos(){
    VarSetCapacity(rect,16),DllCall("GetClientRect",ptr,hwnd(1),ptr,&rect)
    return {w:NumGet(rect,8),h:NumGet(rect,12)}
}
Add_Radius_Constraint(){
    top:=Top(),Deselect(),settings.under(top,"Radius",{Center:"RightThumb",Dead:1,Distance:5,Read:"RThumb",select:1,X:A_ScreenWidth/2,Y:A_ScreenHeight/2}),lv(2)
}
Move(){
    current:=ssn(program,"descendant::*[@tv='" TV_GetSelection() "']")
    if(A_ThisHotkey="^Right"){
        if(current.nodename~="i)KeyPress|Mouse|Radius"=0)
            while,current:=current.ParentNode
                if(current.nodename~="i)KeyPress|Mouse|Radius")
                    break
        if(group:=sn(current,"following-sibling::Group").item[0])
            deselect(),current.SetAttribute("select",1),group.AppendChild(current),lv(2)
    }if(A_ThisHotkey="^Left"){
        if(current.nodename~="i)KeyPress|Mouse|Radius"=0)
            while,current:=current.ParentNode
                if(current.nodename~="i)KeyPress|Mouse|Radius")
                    break
        if(current.ParentNode.nodename!="Group")
            return
        parent:=current.ParentNode
        if(parent.ParentNode.nodename="Alt")
            deselect(),current.SetAttribute("select",1),parent.ParentNode.AppendChild(current),lv(2)
    }if(A_ThisHotkey="^Up"){
        if(!prev:=current.previoussibling)
            return
        deselect(),current.SetAttribute("select",1),prev.ParentNode.InsertBefore(current,prev),lv(2)
    }if(A_ThisHotkey="^Down"){
        if(!next:=current.nextsibling)
            return
        deselect(),current.SetAttribute("select",1),next.ParentNode.InsertBefore(next,current),lv(2)
    }
}
