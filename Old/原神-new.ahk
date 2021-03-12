;------------------------------------------------原神下才有效果 ↓↓↓
#IfWinActive ahk_exe YuanShen.exe
SysGet, VirtualWidth, 16
SysGet, VirtualHeight, 17
CoordMode, ToolTip, Screen
CoordMode, ToolTip, Screen

;-------------------------------------------------定义变量 ↓↓↓
GetColor(x,y)
{
	PixelGetColor, color, x, y,  RGB
	StringRight color,color,10 ;
	return color
}
;-------------------------------------------------随机需要的勾子 ↓↓↓
sleep(duration)  ; duration：持续时间
{
	SleepDuration:= duration ;这里有时可以根据下面的值进行细微调整(例如 2 与 3 的区别).
	DllCall("Sleep", UInt, SleepDuration)  ; 必须使用 DllCall 而不是 Sleep 命令.
	DllCall("Winmm\timeEndPeriod", UInt, TimePeriod)  ; 应该进行调用来让系统恢复正常.
}



;-------------------------------------------------远离手的侧键 自动蓄力或者左键E循环
XButton2::
	loop
	{
		GetKeyState,State,XButton2,P
		if (State="U") ;
		{
			break
		}
		if GetColor(1587,1036)=="0xFFFFFF"  ;白色的R(瞄准) ，实现按住侧键自动左键自动E，适合像温迪这样秒E的角色
		{
			Send {LButton}
			Random, OutputVar,10,20
			Sleep(OutputVar)
			Send e
			Random, OutputVar,10,20
			Sleep(OutputVar)
		}
		else    ; 否则 凝光的一键卡刀
		{
			loop 2
			{
				Send {LButton}
				Sleep 25
			}
			{
				Send {LButton down}
				Sleep 250
				Send {LButton up}
				Sleep 20
			}
	}

	}
return

;-------------------------------------------------靠近手的侧键 模拟ALT，方便放大招 ↓↓↓
XButton1::LAlt

;--------------------------------------------------F键 自动拾取  ↓↓↓
#IfWinActive ahk_exe YuanShen.exe
#Persistent
#SingleInstance
v_Enable=true
f::    ;f键 开关
	{
		v_Enable:=!v_Enable
		if (v_Enable=true ) ;
		{
			SetTimer, Label, Off
			ToolTip
		}
		else
		{
			SetTimer, Label,
			ToolTip on ,74, 1021 ;On显示的位置坐标
		}
	}
return
Label:
	SetTimer, Label, 0
	{
		if ( GetColor(1105,533)=="0xFFFFFF" or GetColor(1061,519)=="0xFFFFFF" ) and WinActive("ahk_exe YuanShen.exe") ;1080p的小伙伴应该可以直接使用，不用重新取色
			loop 6
			{
				Send f
				Sleep 20
				Send {WheelDown}   ;下滑滚轮
				Sleep 20
			}
		if  GetColor(1480,1012)=="0xFFCC33"  ;自动点击传送
		{
			Click 1655,1005
		}
	}
return



