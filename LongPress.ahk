; LongPress by Nicolas de Jong april 2022
;
; AutoHotkey Script to show a small popup for entering accented or other special
; characters. The popup shows when LongPressing a character, after which a related
; character can be chosen (or backspace or escape pressed)
;
; Note that AutoHotKey often doesn't know where the cursor is so this script
; defaults to center of active window if not found
;
; To find characters, use https://www.rapidtables.com/code/text/unicode-characters.html
;
#NoEnv
#SingleInstance Force

; a               à   á   æ   α
$a::  handleKey([224,225,230,945])

; A               À   Á   Æ   
$+a:: handleKey([192,193,198])

; b               β
$b::  handleKey([946])

; c               ç   ©   γ
$c::  handleKey([231,169,947])

; C               Ç
$+c:: handleKey([199])

; d               °   δ
$d::  handleKey([176,948])

; D               Δ
$+d:: handleKey([916])

; e               è   é   ê   ë   €
$e::  handleKey([232,233,234,235,8364])

; E               È   É   Ê   Ë   Ē   Ĕ   Ė   Ę   Ě
$+e:: handleKey([200,201,202,203,274,276,278,280,282])

; g               ĝ   ğ   ġ   ģ
$g::  handleKey([285,287,289,291])

; G              Ĝ    Ğ   Ġ   Ģ
$+g:: handleKey([284,286,288,290])

; i               ì   í   î   ï
$i::  handleKey([236,237,238,239])

; I               Ì   Í   Î   Ï
$+i:: handleKey([204,205,206,207])

; m               µ
$m::  handleKey([181])

; n               ñ   ¬
$n::  handleKey([241,172])

; N               Ñ     
$+n:: handleKey([209])

; o               ò   ó   ô   ø   °   ¤
$o::  handleKey([242,243,244,248,176,164])

; O               Ò   Ó   Ô   Ö   Ø   Ω
$+o:: handleKey([210,211,212,214,216,937])

; p               þ   ¶   £
$p::  handleKey([254,182,163])

; P               Þ   ¶
$+p:: handleKey([222,182])

; r               ® 
$r::  handleKey([174])

; s               ß   §
$s::  handleKey([223,167])

; S               ß   §   Σ
$+s:: handleKey([223,167,931])

; t               þ
$t::  handleKey([254])

; T               Þ
$+t:: handleKey([222])

; u               ù   ú   û   ü   µ
$u::  handleKey([249,250,251,252,181])

; U               Ù   Ú   Û   Û
$+u:: handleKey([217,218,219,220])

; x               ×   ÷
$x::  handleKey([215,247])

; X               ×   ÷
$+x:: handleKey([215,247])

; y               ý   ÿ   ¥
$y::  handleKey([253,255,165])

; Y               Ý   ¥
$+y:: handleKey([221,165])

; 0               º   °
$0::  handleKey([186,176])

; 1               ¹   ¼   ½ 
$1::  handleKey([185,188,189])

; 2               ²   ¾
$2::  handleKey([178,190])

; 3               ³   ¾
$3::  handleKey([179,190])

; !               ¡
;$!::  handleKey([161])

; ?               ¿  
$?::  handleKey([191])

; <               «
$<::  handleKey([171])

; >               »
$>::  handleKey([187])

; ,               ¸   ´
$,::  handleKey([184,180])

; .               ·   ¨
$.::  handleKey([183,168])

; -               ±   ¯   ¬
$-::  handleKey([177,175,172])

; _               ¯   ¬ 
$_::  handleKey([175,172])

; |               ¦
$|::  handleKey([166])

; Instead of characters, text can be given as well (don't mix)
; Text can be added between quotes as shown below
; AutoHotkey doesn't support unicode. So something like ツ won't work but needs chr(12484)
; AutoHotkey keys can be inserted, like {enter}
; Variables are supported in the text between ${ and }
; Supported variables are:
; - time:format where format is from https://www.autohotkey.com/docs/commands/FormatTime.htm
; - user
;
$`::  handleKey([""
  , "${user}"
  , "${time:yyyy/MMM/dd}"
  , "${time:H:mm:ss}"
  , chr(175) . "\_(" . chr(12484) . ")_/" . chr(175)
  , "Line{enter}{enter}Another line"
  , "etc"
  ,""])

; -- UP needs to be found as well to prevent repeating output
;    AutoHotkey is not particular expressive here so type it all out

~a UP::
~+a UP::
~b UP::
~+b UP::
~c UP::
~+c UP::
~d UP::
~+d UP::
~e UP::
~+e UP::
~f UP::
~+f UP::
~g UP::
~+g UP::
~h UP::
~+h UP::
~i UP::
~+i UP::
~j UP::
~+j UP::
~k UP::
~+k UP::
~l UP::
~+l UP::
~m UP::
~+m UP::
~n UP::
~+n UP::
~o UP::
~+o UP::
~p UP::
~+p UP::
~q UP::
~+q UP::
~r UP::
~+r UP::
~s UP::
~+s UP::
~t UP::
~+t UP::
~u UP::
~+u UP::
~v UP::
~+v UP::
~w UP::
~+w UP::
~x UP::
~+x UP::
~y UP::
~+y UP::
~z UP::
~+z UP::
~0 UP::
~1 UP::
~2 UP::
~3 UP::
~! UP::
~? UP::
~< UP::
~> UP::
~, UP::
~. UP::
~- UP::
~_ UP::
~| UP::
~` UP:: handleKey([])

; ----------

#IfWinExist, ahk_group longPressGroup
LButton:: hideDialog()
#IfWinExist, ahk_group longPressGroup
RButton:: hideDialog()

; ----------

init() {
  static _ := init()
  Process, Priority,, H
  setTrayIcon()
  global lpChars
}

getVar(varIn) {
  parts := StrSplit(varIn, ":", "`", 2)
  var := parts[1]
  
  if(var == "time") {
    format := parts[2] ? parts[2] : "yyyy/MM/dd H:mm:ss"
    FormatTime, timeString, format, %format%
    return timeString
  }
  if(var == "user") {
    ;EnvGet, user, "USERNAME"
    ;return user
    return %A_UserName%
  }
  return "${" . varIn . "?}"
}

showDialog(x, y, charNumbersIn) {
  numbersText := ""
  charsText := ""
  vertical := false
  popupWidth := 40
  popupHeight:= 30
  dy := 0

  ; filter out empty array elements
  charNumbers := []
  for index, element in charNumbersIn
  {
    if element
    {
      charNumbers.Push(element)
    }
    if element is not integer  ; this statement won't work with (braces)
    {
      popupHeight := 20
      dy := 13
    }
  }

  for num, v in charNumbers {
    numbersText .= (num <= 10 ? Mod(num,10) : chr(97 + (num-11))) . " "
    if v is integer  ; this statement won't work with (braces)
    {
      charsText   .= chr(v) . " "
      popupWidth += 10
    } else {
      element     := replaceVars(v)
      numbersText .= chr(13)
      charsText   .= element . chr(13)
      vertical := true
      popupHeight += 13
      popupWidth  := Max(popupWidth, strlen(element) * 10 + 30)
      charNumbers[num] := element ; with replaced var
    }
  }

  ; When no cursor location could be found, center on active window
  If not x {
    WinGetActiveStats,actTitle,actWidth,actHeight,actX,actY
    x := actX + (actWidth - popupWidth) / 2
    y := actY + (actHeight - popupHeight) / 2
  } else {
    y += dy
    y -= popupHeight
  }

  Gui, 99: +E0x08000000 ; prevent focus
  Gui +AlwaysOnTop -Caption +Border
  Gui, Font, S10, Lucida Console
  if(vertical) {
    popupHeight -= 17
    Gui, Add, Text, +cFF4500 x10 y1, %numbersText%
    Gui, Add, Text, +c000000 x30 y1, %charsText%
  } else {
    Gui, Add, Text, +cFF4500 x10 y1,  %numbersText%
    Gui, Add, Text, +c000000 x10 y15, %charsText%
  }

  Gui, Show, % "x" . x "y" . y "w" . popupWidth "h" . popupHeight "NoActivate"
  Gui, +LastFound
  popupId := WinExist()
  GroupAdd, longPressGroup, ahk_id %popupId%

  Input, num, BL1, {Esc}{Backspace}
  hideDialog()
  if(ErrorLevel = "EndKey:Esc") {
    Return
  }
  if(ErrorLevel = "EndKey:Backspace") {
    send {backspace}
    Return
  }

  charIndex := num == 0 ? 10 : (num < 10 ? num : (ord(num) - 97 + 11))
  selection := charNumbers[charIndex]

  if selection is integer ; this statement won't work with (braces)
  {
    selection := chr(charNumbers[charIndex])
  }

  if selection {
    sendInput {backspace}
    sendInput %selection%
  } else {
    sendInput %num%
  }
}

hideDialog() {
  Gui, Hide
  Gui, Destroy
}

hasDialog() {
  Return WinExist("ahk_group longPressGroup") 
}

handleKey(chars) {
  global lastKey
  upOrDown:= InStr(A_ThisHotkey,"UP") ? "UP" : "DOWN"
  isShift := InStr(A_ThisHotkey,"+")
  aKey    := Trim(RegExReplace(A_ThisHotkey, "[$~]|UP", ""))
  justKey := Trim(RegExReplace(A_ThisHotkey, "[$+~]|UP", ""))
  toSend  := (isShift ? Format("{:U}", justKey) : justKey) . " " . upOrDown

  ; Perhaps in the future add an opt-out for some apps
  ;If (WinActive("ahk_exe soffice.bin") or WinActive("ahk_exe thunderbird.exe")) {
  ;  toSend := (isShift ? Format("{:U}", justKey) : justKey) . " " . upOrDown
  ;  Send { %toSend% }
  ;  Return
  ;}
  ;
  
  if(isShift) {
    StringUpper, justKey, justKey
  }
  
  ;OutputDebug % "upOrDown=" . upOrDown . " key=" . A_ThisHotkey . " justKey=" . justKey . " lastKey=" . lastKey . " toSend=" . toSend

  if(upOrDown == "UP" || (lastKey && lastKey != justKey)) {
    ;OutputDebug % "Cancelling"
    SetTimer, longPressed, Off
    lastKey := null
    Send { %toSend% }
    Return
  }
  if(justKey == lastKey) {
    Return
  }
  SetTimer, longPressed, Off

  Send, %aKey%
  lastKey := justKey

  global lpKey := justKey
  global lpChars := chars
  SetTimer, longPressed, 500
}

longPressed() {
  global lastKey
  global lpKey
  global lpChars
  SetTimer, longPressed, Off
  
  ; sanity check (typically in high load situations): is the key still down?
  isKeyDown := GetKeyState(lpKey, "P")
  if(!isKeyDown) {
    Return
  }

  cp := getCursorPos()
  showDialog(cp.x, cp.y, lpChars)
  lastKey := null
}

getCursorPos() {
    WinGetPos, activeX, activeY,,, A

    x := A_CaretX
	  y := A_CaretY
    
    ; Many applications don't use the system cursor
    ; In case of Chrome an alternative is found
    If not x {
      ; try Chrome
      caret := Acc_ObjectFromWindow(WinExist("ahk_class Chrome_WidgetWin_1"), OBJID_CARET := 0xFFFFFFF8)
      caret := Acc_Location(caret)
      x := caret.x
      y := caret.y
      ; this is screen coords
	  } else { ; normally it is window coords
      x := x + activeX
      y := y + activeY
    }

    Return {x:x, y:y}
}

replaceVars(text) {
  pos := 0
  Loop { ; There is no regexReplace with matcher function
    varPos := InStr(text, "${",, pos)
    if(!varPos) {
      break
    }
    endVarPos := InStr(text, "}",, varPos)
    if(!endVarPos) {
      break
    }

    if(InStr(text, " ",, varPos+2) = varPos+2) {
      add := var
    } else {
      var  := SubStr(text, varPos + 2, endVarPos - varPos - 2)
      add  := getVar(var)
      text := SubStr(text, 1, varPos - 1) . add . SubStr(text, endVarPos + 1)
    }
    pos  := varPos + 1 + StrLen(add)
  }
  return text
}

setTrayIcon() {
  png16x16 := "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABlBMVEVE1Db///+YJalDAAAAAWJLR0QB/wIt3gAAAAd0SU1FB+YEHQUIDJyef3UAAAABb3JOVAHPoneaAAAAI0lEQVQI12NgYGBg/ANGPSBkCER/wKgBigwYQMj+AAgxMAAAB0sKnen8u2gAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjItMDQtMjlUMDU6MDg6MTErMDA6MDCmxsREAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIyLTA0LTI5VDA1OjA4OjExKzAwOjAw15t8+AAAAABJRU5ErkJggg=="

  hIcon := CreateIconFromBase64(png16x16, 16)
  Menu, Tray, Icon, HICON: %hIcon%
}

CreateIconFromBase64(base64, icoSize) {
   chars := StrLen(base64)
   if !DllCall("Crypt32\CryptStringToBinary", "Str", base64, "UInt", chars, "UInt", 1
                                            , "Ptr", 0, "UIntP", bytes, "UIntP", 0, "UIntP", 0)
      throw "CryptStringToBinary failed. LastError: " . A_LastError
   VarSetCapacity(icoData, bytes, 0)
   DllCall("Crypt32\CryptStringToBinary", "Str", base64, "UInt", chars, "UInt", 1
                                        , "Str", icoData, "UIntP", bytes, "UIntP", 0, "UIntP", 0)
   Return DllCall("CreateIconFromResourceEx", "Ptr", &icoData, "UInt", bytes, "UInt", true
                                            , "UInt", 0x30000, "Int", icoSize, "Int", icoSize, "UInt", 0, "Ptr")
}

; -----------------------------------
; Copied from Acc.ahk standard library for dll access
; Partial copy so there is no need to include the whole library
; This functionality is needed to find the cursor location in Chrome (see getCursorPos)
;
Acc_Init()
{
	Static	h
	If Not	h
		h:=DllCall("LoadLibrary","Str","oleacc","Ptr")
}
Acc_ObjectFromWindow(hWnd, idObject = -4)
{
	Acc_Init()
	If	DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", hWnd, "UInt", idObject&=0xFFFFFFFF, "Ptr", -VarSetCapacity(IID,16)+NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81,NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0,IID,"Int64"),"Int64"), "Ptr*", pacc)=0
	Return	ComObjEnwrap(9,pacc,1)
}
Acc_Location(Acc, ChildId=0, byref Position="") { ; adapted from Sean's code
	try Acc.accLocation(ComObj(0x4003,&x:=0), ComObj(0x4003,&y:=0), ComObj(0x4003,&w:=0), ComObj(0x4003,&h:=0), ChildId)
	catch
		return
	Position := "x" NumGet(x,0,"int") " y" NumGet(y,0,"int") " w" NumGet(w,0,"int") " h" NumGet(h,0,"int")
	return	{x:NumGet(x,0,"int"), y:NumGet(y,0,"int"), w:NumGet(w,0,"int"), h:NumGet(h,0,"int")}
}
