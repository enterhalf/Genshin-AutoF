;### 用前须知
;本脚本修改自b站火er丶:https://space.bilibili.com/12586633 的脚本  
;仅仅做了下判定点的修改，相比较原版速度变慢，但误触发NPC几率减小（有时候还是会触发）
;1080P适用，若有问题需要自己修改判定点坐标，详细查看火er丶的视频：https://www.bilibili.com/video/BV1JA411s7Ud

;### 功能
;自动拾取，自动点击传送点坐标

;### 使用方法：
;1、安装ahk
;2、打开main.ahk(需要管理员权限才能正常使用)
;3、进入游戏后，按F10开关(下面代码可以自行改按键)，屏幕左下角出现on则代表已启动
;4、release的exe无需ahk即可运行

;### 若无法正常运行?
;1、是否1080P，否的话需要自己手动修改判定点坐标
;2、是否右键以管理员模式启动
;3、游戏中按F10左下角出现on才算成功运行

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
;--------------------------------------------------F键 自动拾取  ↓↓↓
#IfWinActive ahk_exe YuanShen.exe
#Persistent
#SingleInstance
v_Enable=true
F10::  ;F10开关，可自行修改
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
		if ( (GetColor(1130,566)=="0xFFFFFF" or GetColor(1130,529)=="0xFFFFFF" or GetColor(1130,492)=="0xFFFFFF" or GetColor(1130,457)=="0xFFFFFF" or GetColor(1130,421)=="0xFFFFFF" or GetColor(1130,385)=="0xFFFFFF" or GetColor(1130,360)=="0xFFFFFF") and GetColor(1181,541)!="0xFFFFFF" and GetColor(1193,493)!="0xFFFFFF" and GetColor(1193,522)!="0xFFFFFF" and GetColor(1193,503)!="0xFFFFFF") and WinActive("ahk_exe YuanShen.exe")
		;相比较原版把鼠标标识取色点取消了，新增了9个取色点（原版只有2个取色点），要更快的话鼠标标识取色点不能去掉，有能力可以来优化下这个东西，应该还能再优化
		;已知的问题，东西太多时，F键不在第一个物品的位置可能会无法触发
			loop 6 
			{
				Send f
				Sleep 23
				Send {WheelDown}   ;下滑滚轮
				Sleep 23
			}
		if  GetColor(1480,1012)=="0xFFCC33"  ;自动点击传送
		{
			Click 1655,1005
		}
;		if GetColor(1447,589)=="0xFFFFFF" ;自动挣脱(稍微有点影响游戏平衡?)
;		{
	;		loop 9
	;		{
	;			Send {Space}
	;			Sleep 123
	;		}
	;	}
	}
return
