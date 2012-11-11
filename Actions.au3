#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Paulo.Mariano

 Script Function:
	Actions on the object

#ce ----------------------------------------------------------------------------
#include <IE.au3>
#include <Debug.au3>

Dim $formNameUsed

; #FUNCTION# ====================================================================================================================
; Name...........: Action_FormSubmit
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
Func Action_FormSubmit($oIE)
	
	$oForm = _IEFormGetObjByName($oIE, $formNameUsed)
	;MsgBox(0,"","Submitou: "& $formNameUsed)
	_IEFormSubmit($oForm)
	
EndFunc
; #FUNCTION# ====================================================================================================================
; Name...........: Action_ButtonClick
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
; Name...........: Action_SearchText
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
	_IELoadWait($oIE)
	
	$oElements = _IETagNameAllGetCollection ($oIE)
	
	For $oElement In $oElements
	
		If StringInStr( $oElement.innerText, $text, 0 ) <>0 Then
			Return "Find text: " & $text
		EndIf
	
	Next
	
	Return "Not find: " & $text
	
EndFunc
; #FUNCTION# ====================================================================================================================
; Name...........: Action_Option
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
; Parameters ....:  $oIE, object needed to handle web page
;					$idForm, form how find the inputs
;					$id, name or id of input form element to type the text
;					$text = "text", the text to type on input
; 
; Author ........: Paulo.Mariano
; Modified.......: 
; Remarks .......: Find on forms the fild selected and fill with text
; Related .......: _IEFormElementSetValue, _IEFormElementGetObjByName
; 
; Example .......:
; 
; * 
; 
; ===============================================================================================================================
Func Action_TextboxType($oIE, $id, $text = "text")
	
	$oForms = _IEFormGetCollection($oIE)
	
	For $oForm In $oForms
		If _IEFormElementGetObjByName($oForm, $id) <> 0 Then
			$oQuery = _IEFormElementGetObjByName ($oForm, $id)
			$formNameUsed = $oForm.name
		EndIf
		
	Next

	_IEFormElementSetValue ($oQuery, $text)
	
EndFunc
