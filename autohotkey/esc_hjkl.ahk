#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory


; >! 是 right alt (ralt) 的縮寫
; 這邊把基本常用的對應過去

>!h::Send {left}
>!j::Send {down}
>!k::Send {up}
>!l::Send {right}

>!n::Send {home}
>!m::Send {pgdn}
>!,::Send {pgup}
>!.::Send {end}

>!o::Send {backspace}
>!i::Send {delete}

>![::Send {Browser_Back}
>!]::Send {Browser_Forward}


; + 這個會把其他組合鍵也帶過去
;  ex. shift + ralt + h 就會變成 shift + left
+>!h::Send +{left}
+>!j::Send +{down}
+>!k::Send +{up}
+>!l::Send +{right}

+>!n::Send +{home}
+>!m::Send +{pgdn}
+>!,::Send +{pgup}
+>!.::Send +{end}

+>!o::Send +{backspace}
+>!i::Send +{delete}

+>![::Send {Browser_Back}
+>!]::Send {Browser_Forward}

; 有時候 ralt 還沒放開會 按太快 空白會出不來的 workaround
>!Space::Send {Space}
+>!Space::Send +{Space}

>!Tab::Send {Tab}
+>!Tab::Send +{Tab}

; 點擊 ctrl 送出 esc
*LControl::
    Send {Blind}{LControl down}
    return

*LControl up::
    Send {Blind}{LControl up}
    ; Tooltip, %A_PRIORKEY%
    ; SetTimer, RemoveTooltip, 1000
    if A_PRIORKEY = LControl
    {
        Send {Esc}
    }
    return

RemoveTooltip(){
    SetTimer, RemoveTooltip, Off
    Tooltip
    return
}

; 雙按 shift 送出 capslock
ToggleCaps(){
    ; this is needed because by default, AHK turns CapsLock off before doing Send
    SetStoreCapsLockMode, Off
    Send {CapsLock}
    SetStoreCapsLockMode, On
    return
}
LShift & RShift::ToggleCaps()
RShift & LShift::ToggleCaps()

; ^!r::Reload


return

