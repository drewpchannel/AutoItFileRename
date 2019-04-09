#include <MsgBoxConstants.au3>
#Include <Array.au3>
#include <Date.au3>

Func askDelPage()
   $adpResults = MsgBox (4, "If there are additional pages..." ,"Would you like to delete everything but the first page?")
   If $adpResults = 6 Then
	  Return $adpResults
   ElseIf $adpResults = 7 Then
      ConsoleWrite("no")
   EndIf
EndFunc

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
	  $askPageNumber = askDelPage()
	  if $askPageNumber = 6 Then
		 ConsoleWrite("pages test runs")
		 $CMD = "pdftk " & $newName & ".pdf" & " cat 1 output " & $newName & "_C.pdf"
		 ConsoleWrite(@LF & "trying to run " & $CMD)
		 RunWait(@ComSpec & " /c " & $CMD)
		 Sleep(90)
		 FileDelete($newName & ".pdf")
	  EndIf
   endif
   Sleep(1500)
WEnd