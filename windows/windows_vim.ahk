
CapsLock::Esc

^!Down::Send {Volume_Down}
^!Up::Send {Volume_Up}
^!Left::Send        {Media_Prev}
^!Right::Send       {Media_Next}
^!j::Send {Volume_Down}
^!k::Send {Volume_Up}
^!h::Send        {Media_Prev}
^!l::Send       {Media_Next}
^!Space::Send       {Media_Play_Pause}
^!m::Send  {Volume_Mute}
^j::Send {Down}
^k::Send {Up}
^h::Send {Left}
^l::Send {Right}
^#h::Send ^#{Left}
^#l::Send ^#{Right}
; #l::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
scrollAmount := 3

#IfWinActive ahk_class AcrobatSDIWindow
j::Send {WheelDown %scrollAmount%}
Return

#IfWinActive ahk_class AcrobatSDIWindow
k::Send {WheelUp %scrollAmount%}
Return
