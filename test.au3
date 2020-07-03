#include <Constants.au3>
WinWaitActive("[CLASS:gdkWindowToplevel]")
msgbox($MB_OK,"","bla",1)
Send("u")
; Send("^i")
msgbox($MB_OK,"","bla2")