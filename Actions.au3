#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Paulo.Mariano

 Script Function:
	Actions on the object

#ce ----------------------------------------------------------------------------
#include <IE.au3>
#include <Debug.au3>

; #FUNCTION# ====================================================================================================================
; Name...........: 
; Description ...: 
; Syntax.........: 
; Parameters ....: 
; Return values .: 
; Author ........: Paulo.Mariano
; Modified.......: 
; Remarks .......: 
; Related .......: 
; Link ..........:
; Example .......:
; 
; * 
; 
; ===============================================================================================================================
Func Action_FormSubmit($oIE, $idForm)
	
	$oForm = _IEFormGetCollection($oIE, $idForm)
	
	_IEFormSubmit($oForm)
	
EndFunc
; #FUNCTION# ====================================================================================================================
; Name...........: 
; Description ...: 
; Syntax.........: 
; Parameters ....: 
; Return values .: 
; Author ........: Paulo.Mariano
; Modified.......: 
; Remarks .......: 
; Related .......: 
; Link ..........:
; Example .......:
; 
; * 
; 
; ===============================================================================================================================
Func Action_ButtonClick($oIE, $nObj)
	
	$vObj = _IEGetObjByName($oIE, $nObj)
	_IEAction($vObj, "click")
	_IELoadWait ($oIE)
EndFunc
; #FUNCTION# ====================================================================================================================
; Name...........: 
; Description ...: 
; Syntax.........: 
; Parameters ....: 
; Return values .: 
; Author ........: Paulo.Mariano
; Modified.......: 
; Remarks .......: 
; Related .......: 
; Link ..........:
; Example .......:
; 
; * 
; 
; ===============================================================================================================================
Func Action_SearchText($oIE, $text)
	
	$oElements = _IETagNameAllGetCollection($oIE)
	
	For $oElement In $oElements
		
		
	If StringInStr( $oElement.outerText, $text, 0 ) <>0 Then
		Return "Find text: " & $text
	EndIf
	
	Next
	Return "Not find: " & $text
EndFunc
; #FUNCTION# ====================================================================================================================
; Name...........: 
; Description ...: 
; Syntax.........: 
; Parameters ....: 
; Return values .: 
; Author ........: Paulo.Mariano
; Modified.......: 
; Remarks .......: 
; Related .......: 
; Link ..........:
; Example .......:
; 
; * 
; 
; ===============================================================================================================================
Func Action_Option($oIE,$opt)
	
	$oForm = _IEFormGetCollection($oIE,0)
		
	_IEFormElementRadioSelect($oForm, $opt,"level")
	
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: Action_TextboxType
; Description ...: Click on button
; Syntax.........: Action_TextboxType($text)
; Parameters ....: $text  - string with text to type
; Return values .: 
; Author ........: Paulo.Mariano
; Modified.......: 
; Remarks .......: 
; Related .......: Send
; Link ..........:
; Example .......:
; 
; *
; 
; ===============================================================================================================================
Func Action_TextboxType($oIE, $idForm, $id, $text = "texto")
	
	$oForm = _IEFormGetCollection($oIE, $idForm)
	
	$oQuery = _IEFormElementGetObjByName ($oForm, $id)
	
	_IEFormElementSetValue ($oQuery, $text)
	
EndFunc
