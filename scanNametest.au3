#include <MsgBoxConstants.au3>
#Include <Array.au3>

while true
   FileChangeDir("C:\scans\")
   Global $newTxt[2] = ["g", "l"]

   $file = FileFindFirstFile("C:\scans\k*.pdf")
   $file = FileFindNextFile($file)
   $testLen = StringLen($file)

   if $testLen > 24 Then
	  Local $sAnswer = InputBox("Quickbooks", "Please enter the invoice or company name", "", "", - 1, -1, 0, 0)
	  $newTxt = StringSplit($file, "")
	  $newName = "INVSCAN_" & $sAnswer & "_T" & $newTxt[25] & $newTxt[26] & $newTxt[30] & $newTxt[31] & $newTxt[35] & $newTxt[36]
	  ConsoleWrite("Trying:  " & $file & "    " & $newName)
	  FileMove( "C:\scans\" & $file , "C:\scans\" & $newName & ".pdf" )
   endif
   Sleep(1500)
WEnd
