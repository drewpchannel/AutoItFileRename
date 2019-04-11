#include <MsgBoxConstants.au3>
#Include <Array.au3>
#include <Date.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

while true
   FileChangeDir("C:\scans\")
   Global $newTxt[2] = ["g", "l"]
   $file = FileFindFirstFile("C:\scans\k*.pdf")
   $file = FileFindNextFile($file)
   $testLen = StringLen($file)
   if $testLen <> 0 Then
	  ConsoleWrite("Found K PDF")
	  $inputInfo = Null
	  $ifFirstOnly = Null
	  		$Form1 = GUICreate("Enter Invoice Number", 306, 132, 192, 124)
		$Input1 = GUICtrlCreateInput("", 24, 24, 257, 21)
		$Checkbox1 = GUICtrlCreateCheckbox("Check to only keep the first page", 32, 56, 241, 25)
		$Button1 = GUICtrlCreateButton("Ok", 104, 88, 75, 25)
	  While $inputInfo == Null
		GUISetState(@SW_SHOW)
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				#might be an issue
				Exit
			Case $Button1
				$inputInfo = GUICtrlRead($Input1)
				$ifFirstOnly = GUICtrlRead($Checkbox1)
				GUIDelete($Form1)
		EndSwitch
      WEnd
	  ConsoleWrite(@LF & "input: " & $inputInfo & " box: " & $ifFirstOnly)
	  $newTxt = StringSplit($file, "")
	  $curTime = _NowTime()
	  $curTime = StringSplit($curTime, "")
	  if $curTime[2] == ":" then
		 $newName = "INVSCAN_" & $inputInfo & "_T_" & $curTime[1] & $curTime[3] & $curTime[4] & $curTime[6] & $curTime[7]
	  Else
		 $newName = "INVSCAN_" & $inputInfo & "_T_" & $curTime[1] & $curTime[2] & $curTime[4] & $curTime[5] & $curTime[7] & $curTime[8]
	  EndIf
	  ConsoleWrite(@LF & "Trying:  " & $file & "    " & $newName & $curTime[1] & $curTime[2] & $curTime[4] & $curTime[5] & $curTime[7] & $curTime[8])
	  FileMove( "C:\scans\" & $file , "C:\scans\" & $newName & ".pdf" )
	  if $ifFirstOnly = 1 Then
		 ConsoleWrite(@LF & "pages test runs")
		 $CMD = "pdftk " & $newName & ".pdf" & " cat 1 output " & $newName & "_C.pdf"
		 ConsoleWrite(@LF & "trying to run " & $CMD)
		 RunWait(@ComSpec & " /c " & $CMD)
		 Sleep(90)
		 FileDelete($newName & ".pdf")
	  EndIf
   endif
   Sleep(1500)
WEnd