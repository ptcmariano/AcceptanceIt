#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Paulo Tiago Castanho Mariano

 Script Function:
	Interpreter user stories and send action on internet explorer

#ce ----------------------------------------------------------------------------
#include <File.au3>
#include <WinAPI.au3>
#include <Actions.au3>
#include <IE.au3>
#include <Debug.au3>


$arquivo = _WinAPI_GetOpenFileName("","All Files (*.*)",".","text-us.acc")

;$arquivo = $CmdLine[1]

Dim $array
Dim $oIE

_FileReadToArray($arquivo[1]&"\"&$arquivo[2],$array)

_DebugSetup ("AcceptanceIt: "&$arquivo[2], False, 1)

;read lines of internacionalization
Dim $who,$what,$why
Dim $scenario,$given,$when,$then
Dim $type,$find,$click,$selectRadio,$inputtxt,$button,$navigate,$submit,$option,$selectCombo
Local $aRecords

If Not _FileReadToArray("I18N-en.lng", $aRecords) Then
    MsgBox(4096, "Error", " Error reading log to Array  >> error:" & @error)
    Exit
EndIf

For $x = 1 To $aRecords[0]
    ;MsgBox(0, 'Record:' & $x, $aRecords[$x])
	Internationalization($aRecords[$x])
Next

;read lines of acceptance criteria
For $c = 1 To UBound($array)-1

	AnalyseLine($array[$c])
	
Next


Func AnalyseLine($line)
	
	;See if have the user for story
   If StringInStr( $line , $who ,0) <> 0 Then
		;here found info for create Log
		_DebugReport($line)
	
	;See if have the propose for story
   ElseIf StringInStr($line, $scenario, 0) <> 0 Then
	
		_DebugReport(">> " & $line)
	
	;See if need open browser
   ElseIf StringInStr($line, $given, 0) <> 0 Then
		$oIE = _IECreate()
		
	;See if need navigate
   ElseIf StringInStr($line, $navigate, 0) <> 0 Then
		Local $arr
		$arr = StringSplit($line, " ",1)
		
		_IENavigate($oIE, $arr[$arr[0]])
		_IELoadWait($oIE)
	
	;See if have text to fill
   ElseIf StringInStr( $line , $type ,0) <> 0 Then
		
		;
		If StringInStr($line, $inputtxt, 0) <> 0 Then
			Local $arr 
			$arr = StringSplit($line, '"',1)
			
			Action_TextboxType($oIE, "0", $arr[2], $arr[4])
		EndIf
		
   ElseIf StringInStr( $line , $click,0) <> 0 Then
		
		If StringInStr($line, $button, 0) <> 0 Then
			Local $arr 
			$arr = StringSplit($line, '"',1)
			
			Action_ButtonClick($oIE, $arr[2])
			
		EndIf
		
   ElseIf StringInStr( $line , $then ,0) <> 0 Then
		
		If StringInStr($line, $find, 0) <> 0 Then
			Local $arr 
			$arr = StringSplit($line, '"',1)
			_DebugReport( "Result: " & Action_SearchText($oIE, $arr[2]))
			
		EndIf
		
   ElseIf StringInStr( $line , $selectRadio , 0 ) <> 0 Then
		
		If StringInStr($line, $option, 0) <> 0 Then
			Local $arr 
			$arr = StringSplit($line, " ",1)
			
			Action_Option($oIE,$arr[$arr[0]])
		 EndIf
		 
   ElseIf StringInStr($line, $selectCombo, 0) <> 0 Then
	  
	  If StringInStr($line, $option, 0) <> 0 Then
			Local $arr 
			$arr = StringSplit($line, " ",1)
			
			Action_Option($oIE,$arr[$arr[0]])
		 EndIf
	  
   ElseIf StringInStr($line, $submit, 0) <> 0 Then
	  Action_FormSubmit($oIE, 0)
	  
   ElseIf StringInStr($line, "/", 0) Then
		If IsObj($oIE) Then
			_IEQuit($oIE)
		EndIf
	EndIf
	
	
EndFunc

Func Internationalization($lineI18N)
   Local $arr
   $arr = StringSplit($lineI18N,":")
   
   Switch $arr[1]
	  Case "who"
		 $who = $arr[2]
		 
	  Case "why"
		 $why = $arr[2]
		 
	  Case "what"
		 $what = $arr[2]
		 
	  Case "scenario"
		 $scenario = $arr[2]
		 
	  Case "given"
		 $given = $arr[2]
		 
	  Case "when"
		 $when = $arr[2]
		 
	  Case "then"
		 $then = $arr[2]
		 
	  Case "type"
		 $type = $arr[2]
		 
	  Case "find"
		 $find = $arr[2]
		 
	  Case "click"
		 $click = $arr[2]
		 
	  Case "selectRadio"
		 $selectRadio = $arr[2]
		 
	  Case "inputtxt"
		 $inputtxt = $arr[2]
		 
	  Case "button"
		 $button = $arr[2]
		 
	  Case "navigate"
		 $navigate = $arr[2]
		 
	  Case "submit"
		 $submit = $arr[2]
		 
	  Case "option"
		 $option = $arr[2]
   EndSwitch

EndFunc
