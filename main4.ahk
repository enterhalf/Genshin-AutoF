;------------------------------------------------原神下才有效果 ↓↓↓
;IfWinActive ahk_exe YuanShen.exe
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

;--------------------------------------------------开启即自动启动原神  ↓↓↓
;/*
run %APPDATA%\Microsoft\Windows\Start Menu\Programs\YuanShen.lnk  
SoundPlay, %A_WinDir%\Media\Alarm02.wav 	;声音提示已启动游戏
Sleep 20000
SetTimer, Label, On ;已启动自动拾取
SoundPlay, %A_WinDir%\Media\Speech On.wav
;*/
;--------------------------------------------------F键 自动拾取  ↓↓↓
;#IfWinActive ahk_exe YuanShen.exe
#Persistent
#SingleInstance
g_Enable=0

;--------------------------------------------------切换开关
$CapsLock:: ;切换开关
KeyWait , CapsLock , t1
if ErrorLevel
{
    KeyWait, CapsLock
    if (A_PriorKey == "CapsLock")
    {
        SetCapsLockState, % GetKeyState("CapsLock", "T") ? "Off" : "On"
            ToolTip, % "大写锁定: " . (GetKeyState("CapsLock", "T") ? "开启" : "关闭"), , , 13
            SetTimer, RemoveToolTip, 1000
        } 
    }
    Else
    {
        g_Enable:=!g_Enable
        if g_Enable
        {
            SetTimer, Label, Off
            SoundPlay, %A_WinDir%\Media\Speech Off.wav
        }
        else
        {
            SetTimer, Label, On
            SoundPlay, %A_WinDir%\Media\Speech On.wav
        }
    }	
Return

;--------------------------------------------------关闭游戏
F10::   ;长按F10关闭游戏
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
        Sleep 5000
        g_Enable=0
        SetTimer, Label, On ;已启动自动拾取
        SoundPlay, %A_WinDir%\Media\Speech On.wav
    }			
}
return

;--------------------------------------------------Always On
Label: ;自动拾取，点击坐标
SetTimer, Label, 0
{
    if WinActive("ahk_exe YuanShen.exe") ;只在游戏中生效
    {
        if ( (GetColor(1130,566)=="0xFFFFFF" or GetColor(1130,529)=="0xFFFFFF" or GetColor(1130,492)=="0xFFFFFF" or GetColor(1130,457)=="0xFFFFFF" or GetColor(1130,421)=="0xFFFFFF" or GetColor(1130,385)=="0xFFFFFF" or GetColor(1130,360)=="0xFFFFFF") and GetColor(1184,546)!="0xFFFFFF" and GetColor(1193,493)!="0xFFFFFF" and GetColor(1193,522)!="0xFFFFFF" and GetColor(1193,502)!="0xFFFFFF") ;1080p的小伙伴应该可以直接使用，不用重新取色
        {
            loop 8
            {
                Send f
                Sleep 12
                Send {WheelDown} ;下滑滚轮
                Sleep 24
            }
        }
        if GetColor(1480,1012)=="0xFFCC33" ;自动点击传送
        {
            Click 1655,1005
            Sleep 300
            MouseMove, 960, 540
        }
    }
}
return

RemoveToolTip:
    ToolTip, , , , 13
    SetTimer, RemoveToolTip, Off
return
