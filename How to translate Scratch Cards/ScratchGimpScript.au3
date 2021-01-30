#include <Constants.au3>

;
; AutoIt Version: 3.0
; Language:       English
; Platform:       Win10
; Author:         Hans de Jong

AutoItSetOption("SendKeyDelay",50)
; Run Notepad
;Run("notepad.exe")

;Local $iAnswer = MsgBox(BitOR($MB_YESNO, $MB_SYSTEMMODAL), "AutoIt Example", "def?")

#Region INCLUDE
#include <AVIConstants.au3>
#include <GuiConstantsEx.au3>
#include <TreeViewConstants.au3>
#EndRegion INCLUDE

#Region GUI
GUICreate("Sample GUI", 400, 400)
GUISetIcon(@SystemDir & "\mspaint.exe", 0)
#EndRegion GUI

#Region BUTTON
$Button1=GUICtrlCreateButton("Reset", 10, 10, 380, 30)
GUICtrlSetTip(-1, '#Region BUTTON')
#EndRegion BUTTON

#Region EDIT
$EditBox=GUICtrlCreateEdit(@CRLF & "  Sample Edit Control", 10, 50, 380, 120)
GUICtrlSetTip(-1, '#Region EDIT')
#EndRegion EDIT


HotKeySet("+^d", "HotKeyPressed") ; Shift-Ctrl-d

Global $State=1


Global $X
Global $Y
Global $a

FillInitialText()

#Region GUI MESSAGE LOOP
GUISetState(@SW_SHOW)
While 1
	Switch GUIGetMsg()
	    Case $GUI_EVENT_CLOSE
		  ExitLoop
	   Case $Button1
		 FillInitialText()
		 $State=1

	EndSwitch
WEnd

GUIDelete()
#EndRegion GUI MESSAGE LOOP

sleep(5000)
exit


Func HotKeyPressed()
   WinActivate("[Class:gdkWindowToplevel]")
   WinWaitActive("[Class:gdkWindowToplevel]")
   sleep(500)
   Switch $State
   Case 1

		 Send("^w")		; drop a potentially previous image
		 Sleep(500)
		 Send("^v")		; paste from clipboard
		 Sleep(500)
		 Send("!t")		; tools
		 Sleep(50)
		 Send("s")		; selection tools
		 Sleep(50)
		 Send("z")		; fuzzy select
		 GUICtrlSetData($EditBox, _
			"1. Click just outside the area you need (where the border will come)." & @CRLF & _
			"2. Then press CTRL-SHIFT-D.")
		 $State=2
	  Case 2

		 ;Send("!sm")	; remove holes
		 ;Sleep(500)
		 ;Send("!si")	; invert

		 $a = MouseGetPos()		; remember where the mouse is
		 Sleep(500)
		 $X = $a[0]
		 $Y = $a[1]

		 Send("{DEL}")	; delete
		 Sleep(500)

		 Send("!tsr")
		 ;Send("+")

		 GUICtrlSetData($EditBox, _
			"1. Select at least one rectangle to be deleted" & @CRLF & _
			"2. To select multiple areas, hold down the Shift key" & @CRLF & _
			"3. Then press CTRL-SHIFT-D.")
		 $State=3

Case 3


		 Sleep(500)
		 Send("{DEL}")	; delete
		 Sleep(500)
		 Send("!sn")	; select none
		 Sleep(500)
		 Send("!t")		; tools
		 Sleep(500)
		 Send("s")		; selection tools
		 Sleep(500)
		 Send("z")		; fuzzy select
		 Sleep(500)
		 MouseMove($X, $Y)
		 Sleep(500)
		 MouseClick($MOUSE_CLICK_LEFT)
		 Sleep(500)
		 Send("!si")	; invert
		 Sleep(500)
		 Send("!sg")	; grow
		 Sleep(500)
		 Send("9{TAB}{TAB}{TAB}{ENTER}")	; invert
		 Sleep(500)
		 Send("!sr")	; select border
		 Sleep(500)
		 Send("9{TAB 5}{ENTER}")	; set border width
		 Sleep(500)
		 Send("B")	; bucket fill
		 Sleep(500)
		 MouseClick($MOUSE_CLICK_LEFT)
		 Sleep(500)
		 Send("!ii")	; fit to canvas to selection
		 Sleep(500)
		 Send("^+s")

		 GUICtrlSetData($EditBox, _
			"1. Save the file at the location you want" & @CRLF & _
			"2. Then press CTRL-SHIFT-D.")



		 $State=4

	  Case 4
		 Sleep(500)
		 Send("+^E")	; export As
		 Sleep(1000)
		 Send("+{TAB}+{TAB}{ENTER}")
		 Sleep(1000)
		 Send("{TAB 10}0{TAB 9}{ENTER}")
		 Sleep(2000)


		 $State=1

		 GUICtrlSetData($EditBox, _
			"READY")

		 Sleep(3000)

		 FillInitialText()

  EndSwitch

EndFunc

Func FillInitialText()
   GUICtrlSetData($EditBox, _
   "1. Make sure that GIMP is started." & @CRLF & _
   "2. Make sure that the background fill color is white." & @CRLF & _
   "3. Make sure that the Bucket Fill (B) is set on BG colour fill." & @CRLF & _
   "4. Make a screen shot of the Scratch area using Windows+Shift+S." & @crlf & _
   "5. Then press CTRL-SHIFT-D.")
EndFunc


