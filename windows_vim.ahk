﻿
CapsLock::Esc

^!Down::Send {Volume_Down}
^!Up::Send {Volume_Up}
^!Space::Send       {Media_Play_Pause}
^!Left::Send        {Media_Prev}
^!Right::Send       {Media_Next}
^!m::Send  {Volume_Mute}
^j::Send {Down}
^k::Send {Up}
^h::Send {Left}
^l::Send {Right}
^#h::Send ^#{Left}
^#l::Send ^#{Right}
scrollAmount := 3

#IfWinActive ahk_class AcrobatSDIWindow
j::Send {WheelDown %scrollAmount%}
Return

#IfWinActive ahk_class AcrobatSDIWindow
k::Send {WheelUp %scrollAmount%}
Return