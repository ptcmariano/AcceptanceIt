#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Paulo Tiago Castanho Mariano

 Script Function:
	Ler linhas do arquivo passado como parametro
	Exibir as linhas em MsgBox

#ce ----------------------------------------------------------------------------
#include <File.au3>
#include <WinAPI.au3>
#include <Actions.au3>
#include <IE.au3>
#include <Debug.au3>


$arquivo = _WinAPI_GetOpenFileName("","All Files (*.*)",".","text.acc")

;$arquivo = $CmdLine[1]

Dim $array
Dim $oIE

_FileReadToArray($arquivo[1]&"\"&$arquivo[2],$array)

_DebugSetup ("Teste de aceitação: "&$arquivo[2],True,5)

;read lines of internacionalization
Dim $who,$what,$why
Dim $scenario,$given,$when,$then
Dim $type,$find,$click,$selectRadio,$inputtxt,$button,$navigate,$submit,$option
Local $aRecords
If Not _FileReadToArray("I18N.lng", $aRecords) Then
    MsgBox(4096, "Error", " Error reading log to Array     error:" & @error)
    Exit
EndIf
For $x = 1 To $aRecords[0]
    ;MsgBox(0, 'Record:' & $x, $aRecords[$x])
	Internationalization($aRecords[$x])
Next

;read lines of acceptance criteria
For $c = 1 To UBound($array)-1

	AnalyseLine($array[$c])
	;_DebugReport("linha: " & $c)
Next


Func AnalyseLine($linha)
	
	;See if have the user for story
   If StringInStr( $linha , $who ,0) Then
		;here found info for create Log
		_DebugReport($linha)
	
	;See if have the propose for story
   ElseIf StringInStr($linha, $scenario, 0) Then
	
		;MsgBox(0, "Cenario", "Cenario: " & $linha )
		_DebugReport(">> " & $linha)
	
	
	;See if need open browser
   ElseIf StringInStr($linha, $given, 0) Then
		$oIE = _IECreate()
		
	;See if need navigate
   ElseIf StringInStr($linha, $navigate, 0) Then
		Local $arr
		$arr = StringSplit($linha, " ",1)
		
		_IENavigate($oIE, $arr[$arr[0]])
		_IELoadWait($oIE)
	
	;See if have text to fill
   ElseIf StringInStr( $linha , $type ,0) == 1 Then
		
		;
		If StringRegExp($linha, $inputtxt, 0) == 1 Then
			Local $arr 
			$arr = StringSplit($linha, '"',1)
			
			Action_TextboxType($oIE, "0", $arr[2], $arr[4]);mudar para variaveis
		EndIf
		
   ElseIf StringInStr( $linha , $click,0) == 1 Then
		
		If StringRegExp($linha, $button, 0) == 1 Then
			Local $arr 
			$arr = StringSplit($linha, '"',1)
			
			
			Action_ButtonClick($oIE, $arr[2])
			
		EndIf
		
   ElseIf StringInStr( $linha , $then ,0) == 1 Then
		
		If StringRegExp($linha, $find, 0) == 1 Then
			Local $arr 
			$arr = StringSplit($linha, '"',1)
			_DebugReport( "Result: " & Action_SearchText($oIE, $arr[2]))
			
		EndIf
		
   ElseIf StringInStr( $linha , $selectRadio , 0 ) == 1 Then
		
		If StringRegExp($linha, $option, 0) == 1 Then
			Local $arr 
			$arr = StringSplit($linha, " ",1)
			
			Action_Option($oIE,$arr[$arr[0]])
		 EndIf
		 
   ElseIf StringInStr($linha, $selectCombo, 0) Then
	  
	  If StringRegExp($linha, $option, 0) == 1 Then
			Local $arr 
			$arr = StringSplit($linha, " ",1)
			
			Action_Option($oIE,$arr[$arr[0]])
		 EndIf
	  
   ElseIf StringInStr($linha, $submit, 0) == 1 Then
	  Action_FormSubmit($oIE, 0)
	  
   ElseIf StringInStr($linha, "/", 0) Then
		If IsObj($oIE) Then
			_IEQuit($oIE)
		EndIf
	EndIf
	
	
EndFunc



Func Internationalization($line)
   Local $arr
   $arr = StringSplit($line,":")
   
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

