;------------------------------------------------原神下才有效果 ↓↓↓
SysGet, VirtualWidth, 16
SysGet, VirtualHeight, 17
CoordMode, ToolTip, Screen
CoordMode, ToolTip, Screen

;-------------------------------------------------定义变量 ↓↓↓
GetColor(x,y)
{
    PixelGetColor, color, x, y, RGB
    StringRight color,color,10 ;
    return color
}
;-------------------------------------------------随机需要的勾子 ↓↓↓
sleep(duration) ; duration：持续时间
{
    SleepDuration:= duration ;这里有时可以根据下面的值进行细微调整(例如 2 与 3 的区别).
    DllCall("Sleep", UInt, SleepDuration) ; 必须使用 DllCall 而不是 Sleep 命令.
    DllCall("Winmm\timeEndPeriod", UInt, TimePeriod) ; 应该进行调用来让系统恢复正常.
}

RUNYUANSHEN()
;--------------------------------------------------F键 自动拾取  ↓↓↓
#Persistent
#SingleInstance

;--------------------------------------------------切换开关
$CapsLock:: ;切换开关
KeyWait , CapsLock , t1
if ErrorLevel 	
{
    KeyWait, CapsLock
    if (A_PriorKey == "CapsLock")
    {
        SetCapsLockState, % GetKeyState("CapsLock", "T") ? "Off" : "On"
        } 
    }
    Else
    {
        g_Enable:=!g_Enable
        if g_Enable
        {
            SetTimer, Label, Off
            ToolTip
            SoundPlay, %A_WinDir%\Media\Speech Off.wav
        }
        else
        {
            SetTimer, Label, On
            ToolTip on ,74, 1021
            SoundPlay, %A_WinDir%\Media\Windows Ding.wav
        }
    }	
    Return

;--------------------------------------------------关闭游戏

F10::
    KeyWait , F10 , t1
    If Errorlevel
    {
        If WinActive("ahk_exe YuanShen.exe")
        {
            SoundPlay, %A_WinDir%\Media\Ring06.wav
            WinClose ahk_exe YuanShen.exe
            Sleep 6000
            ExitApp
        }
        Else
        {
            run %APPDATA%\Microsoft\Windows\Start Menu\Programs\YuanShen.lnk 	;找到原神安装目录\Genshin Impact Game\YuanShen.exe，右键exe固定到开始菜单即可正常启动，也可直接替换成游戏目录
            SoundPlay, %A_WinDir%\Media\Alarm02.wav 	;声音提示已启动游戏
            Sleep 20000
            g_Enable=0
            SetTimer, Label, On ;已启动自动拾取
            SoundPlay, %A_WinDir%\Media\Speech On.wav
        }			
    }
return

;--------------------------------------------------Always On
Label: ;自动拾取，点击坐标，挣脱
SetTimer, Label, 50
{
    if WinActive("ahk_exe YuanShen.exe") ;只在游戏中生效
    {
        If ( GetColor(66,30)=="0xE9C48F") ; 有派蒙图标，在主界面
        {
            if ( GetColor(1132,537)=="0xFFFFFF" or GetColor(1061,552)=="0xFFFFFF")
            {
                If (GetColor(1184,546)!="0xFFFFFF") ;特殊点,可以排除交互按钮
                {
                    PickingFunc()
                }
            }
        }

        if GetColor(1477,1012)=="0xFFCB32" ;自动点击传送
        {
            Click 1655,1005
            Sleep 300
            MouseMove, 960, 540
        }

        if GetColor(1435,595)=="0x323232" ;自动挣脱
        {
            loop 9
            {
                Send {Space}
                Sleep 141
            }
        }
    }
}
return

;--------------------------------------------------F8连点

F8:: 
    while GetKeyState("F8", "P") ;如果鼠标右键为按下的状态则进入循环
    {
        Click Left
        Sleep 20
    }
return

;--------------------------------------------------捡东西  ↓↓↓
PickingFunc()
{
    SendInput {f}
    loop 4
    {
        Send {WheelDown} ;下滑滚轮
        Sleep 30
        SendInput {f}
        Sleep 20
        SendInput {f}
        Sleep 50
    }
}

;--------------------------------------------------自动委托  ↓↓↓
F9::
	keydizi:=[]
	dizi:="1,2,3,4,5,6,7"
	aaa:=0
	loop, Parse, dizi, `,
	{
		keydizi[A_Index] := A_LoopField
	}
	for key,value in keydizi
	{

		if value=1
		{
			MouseClick , L , 131,231, , 0   ;璃月
			Sleep 200
			continue
		}
		if value=5
		{
			MouseClick , L , 173,158, , 0   ;蒙德
			Sleep 200
			continue
		}
		if value=2
			MouseClick , L , 725,325, , 0   ;荻花洲
		if value=3
			MouseClick , L , 959,448, , 0   ;瑶光滩
		if value=4
			MouseClick , L , 558,558, , 0   ;绝云间
		if value=6
			MouseClick , L , 1052,335, , 0  ;低语森林
		if value=7
			MouseClick , L , 1170,655, , 0  ;达达乌帕谷
		{
			Sleep 200
			MouseClick , L , 1725,1022, , 0  ;领取
			Sleep 100
			MouseClick , L , 1725,1022, , 0  ;点击继续
			Sleep 200
			if aaa=0
			{
				MouseClick , L , 1798,677, , 0  ;20个
				aaa:=1
				Sleep 250
			}
			MouseClick , L , 1725,1022, , 0  ;选择
			Sleep 250
			if value=2
				MouseClick , L , 317,165, , 0   ;重云
			if value=3
				MouseClick , L , 145,419, , 0   ;凯亚
			if value=4
				MouseClick , L , 210,539, , 0   ;丽莎
			if value=6
				MouseClick , L , 353,158, , 0   ;班尼特
			if value=7
				MouseClick , L , 341,306, , 0   ;皇女
			Sleep 200
		}
	}
    Send, {Esc}
return

;--------------------------------------------------自动启动原神  ↓↓↓
RUNYUANSHEN()
{
    run %APPDATA%\Microsoft\Windows\Start Menu\Programs\YuanShen.lnk  
    g_Enable=0
    SetTimer, Label, On ;已启动自动拾取
    ToolTip on ,74, 1021
    SoundPlay, %A_WinDir%\Media\Windows Ding.wav
}


;关键点：GetColor(1181,541)!="0xFFFFFF" GetColor(1184,546)=="0xFFFFFF"
;"C:\Users\test\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\YuanShen.lnk"
;"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\原神\原神.lnk"
;%PROGRAMDATA%
; if ( (GetColor(1130,566)=="0xFFFFFF" or GetColor(1130,529)=="0xFFFFFF" or GetColor(1130,492)=="0xFFFFFF" or GetColor(1130,457)=="0xFFFFFF" or GetColor(1130,421)=="0xFFFFFF" or GetColor(1130,385)=="0xFFFFFF" or GetColor(1130,360)=="0xFFFFFF") and GetColor(1184,546)!="0xFFFFFF" and GetColor(1193,493)!="0xFFFFFF" and GetColor(1193,522)!="0xFFFFFF" and GetColor(1193,502)!="0xFFFFFF") ;1080p的小伙伴应该可以直接使用，不用重新取色