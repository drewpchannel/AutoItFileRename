#include <MsgBoxConstants.au3>
#Include <Array.au3>
#include <Date.au3>

while true
   FileChangeDir("C:\scans\")
   Global $newTxt[2] = ["g", "l"]

   $file = FileFindFirstFile("C:\scans\k*.pdf")
   $file = FileFindNextFile($file)
   $testLen = StringLen($file)

   if $testLen <> 0 Then
	  Local $sAnswer = InputBox("Quickbooks", "Please enter the invoice or company name", "", "", - 1, -1, 0, 0)
	  $newTxt = StringSplit($file, "")
	  $curTime = _NowTime()
	  $curTime = StringSplit($curTime, "")
	  if $curTime[2] == ":" then
		 $newName = "INVSCAN_" & $sAnswer & "_T_" & $curTime[1] & $curTime[3] & $curTime[4] & $curTime[6] & $curTime[7]
	  Else
		 $newName = "INVSCAN_" & $sAnswer & "_T_" & $curTime[1] & $curTime[2] & $curTime[4] & $curTime[5] & $curTime[7] & $curTime[8]
	  EndIf
	  ConsoleWrite("Trying:  " & $file & "    " & $newName & $curTime[1] & $curTime[2] & $curTime[4] & $curTime[5] & $curTime[7] & $curTime[8])
	  FileMove( "C:\scans\" & $file , "C:\scans\" & $newName & ".pdf" )
   endif
   Sleep(1500)
WEnd
