'Last Updated in VBS v3.16

Option Explicit
LoadCore
Private Sub LoadCore
	On Error Resume Next
	If VPBuildVersion < 0 Or Err Then
		Dim fso : Set fso = CreateObject("Scripting.FileSystemObject") : Err.Clear
		ExecuteGlobal fso.OpenTextFile("core.vbs", 1).ReadAll    : If Err Then MsgBox "Can't open ""core.vbs""" : Exit Sub
		ExecuteGlobal fso.OpenTextFile("VPMKeys.vbs", 1).ReadAll : If Err Then MsgBox "Can't open ""vpmkeys.vbs""" : Exit Sub
	Else
		ExecuteGlobal GetTextFile("core.vbs")    : If Err Then MsgBox "Can't open ""core.vbs"""    : Exit Sub
		ExecuteGlobal GetTextFile("VPMKeys.vbs") : If Err Then MsgBox "Can't open ""vpmkeys.vbs""" : Exit Sub
	End If
End Sub

'-------------------------
' WPC Data
'-------------------------
' Cabinet switches
Const swCoin1  = 1
Const swCoin2  = 2
Const swCoin3  = 3
Const swCoin4  = 4
Const swCancel = 5
Const swDown   = 6
Const swUp     = 7
Const swEnter  = 8
' Forgot these in earlier vbs files
Private swStartButtonX,swCoinDoorX,swSlamTiltX
On Error Resume Next
If swStartButton = 13 Or Err Then swStartButtonX = 13 Else swStartButtonX = swStartButton
If swCoinDoor    = 22 Or Err Then swCoinDoorX    = 22 Else swCoinDoorX    = swCoinDoor
If swSlamTilt    = 21 Or Err Then swSlamTiltX    = 21 Else swSlamTiltX    = swSlamTilt
On Error Goto 0

Const swLRFlip = 112
Const swLLFlip = 114
Const swURFlip = 116
Const swULFlip = 118

' Help window
vpmSystemHelp = "Williams WPC keys:" & vbNewLine &_
  vpmKeyName(keyInsertCoin1)  & vbTab & "Insert Coin #1" & vbNewLine &_
  vpmKeyName(keyInsertCoin2)  & vbTab & "Insert Coin #2" & vbNewLine &_
  vpmKeyName(keyInsertCoin3)  & vbTab & "Insert Coin #3" & vbNewLine &_
  vpmKeyName(keyInsertCoin4)  & vbTab & "Insert Coin #4" & vbNewLine &_
  vpmKeyName(keyCancel) & vbTab & "Escape (Coin Door)" & vbNewLine &_
  vpmKeyName(keyDown)  & vbTab & "Down (Coin Door)" & vbNewLine &_
  vpmKeyName(keyUp)  & vbTab & "Up (Coin Door)" & vbNewLine &_
  vpmKeyName(keyEnter)  & vbTab & "Enter (Coin Door)" & vbNewLine &_
  vpmKeyName(keySlamDoorHit) & vbTab & "Slam Tilt" & vbNewLine &_
  vpmKeyName(keyCoinDoor) & vbTab & "Open/Close Coin Door"

' Dips Switch / Options Menu
Private Sub wpcShowDips
	If Not IsObject(vpmDips) Then ' First time
		Set vpmDips = New cvpmDips
	With vpmDips
		.AddForm 100, 240, "DIP Switches"
		.AddFrame 0,190, 80, "Misc", 0, Array("W20",&H04,"W19",&H08)
		.AddFrame 0, 0, 80, "Country", &Hf0,_
			Array("USA", &H00, "USA", &Hf0, "European", &Hd0,_
			      "Export", &Ha0, "Export Alt", &H80, "France", &Hb0,_
			      "France 1", &H10, "France 2", &H30, "France 3", &H90,_
			      "Germany", &H20, "Spain",     &He0, "UK", &Hc0)
	End With
	End If
	vpmDips.ViewDips
End Sub
Set vpmShowDips = GetRef("wpcShowDips")
Private vpmDips

' Keyboard handlers
Function vpmKeyDown(ByVal keycode)
	On Error Resume Next
	vpmKeyDown = True ' assume we handle the key
	With Controller
		If keycode = RightFlipperKey Then .Switch(swLRFlip) = True : If cSingleRFlip Or Err Then .Switch(swURFlip) = True
		If keycode = LeftFlipperKey  Then .Switch(swLLFlip) = True : If cSingleLFlip Or Err Then .Switch(swULFlip) = True
		Select Case keycode
			Case keyInsertCoin1  vpmTimer.AddTimer 750,"vpmTimer.PulseSw swCoin1'" : Playsound SCoin
			Case keyInsertCoin2  vpmTimer.AddTimer 750,"vpmTimer.PulseSw swCoin2'" : Playsound SCoin
			Case keyInsertCoin3  vpmTimer.AddTimer 750,"vpmTimer.PulseSw swCoin3'" : Playsound SCoin
			Case keyInsertCoin4  vpmTimer.AddTimer 750,"vpmTimer.PulseSw swCoin4'" : Playsound SCoin
			Case StartGameKey    .Switch(swStartButtonX) = True
			Case keyCancel       .Switch(swCancel)       = True
			Case keyDown         .Switch(swDown)         = True
			Case keyUp           .Switch(swUp)           = True
			Case keyEnter        .Switch(swEnter)        = True
			Case keySlamDoorHit  .Switch(swSlamTiltX)    = True
			Case keyCoinDoor     .Switch(swCoinDoorX)    = Not .Switch(swCoinDoorX)
			Case keyBangBack     vpmNudge.DoNudge   0,6
			Case LeftTiltKey     vpmNudge.DoNudge  75,2
			Case RightTiltKey    vpmNudge.DoNudge 285,2
			Case CenterTiltKey   vpmNudge.DoNudge   0,2
			Case Else            vpmKeyDown = False
		End Select
	End With
	On Error Goto 0
End Function

Function vpmKeyUp(ByVal keycode)
	On Error Resume Next
	vpmKeyUp = True ' assume we handle the key
	With Controller
		If keycode = RightFlipperKey Then .Switch(swLRFlip) = False : If cSingleRFlip Or Err Then .Switch(swURFlip) = False
		If keycode = LeftFlipperKey  Then .Switch(swLLFlip) = False : If cSingleLFlip Or Err Then .Switch(swULFlip) = False
		Select Case keycode
			Case keyCancel       .Switch(swCancel)       = False
			Case keyDown         .Switch(swDown)         = False
			Case keyUp           .Switch(swUp)           = False
			Case keyEnter        .Switch(swEnter)        = False
			Case keySlamDoorHit  .Switch(swSlamTiltX)    = False
			Case StartGameKey    .Switch(swStartButtonX) = False
			Case keyShowOpts     .Pause = True : .ShowOptsDialog GetPlayerHWnd : .Pause = False
			Case keyShowKeys     .Pause = True : vpmShowHelp : .Pause = False
			Case keyShowDips     If IsObject(vpmShowDips) Then .Pause = True : vpmShowDips : .Pause = False
			Case keyAddBall      .Pause = True : vpmAddBall  : .Pause = False
			Case keyReset        .Stop : BeginModal : .Run : vpmTimer.Reset : EndModal
			Case keyFrame        .LockDisplay = Not .LockDisplay
			Case keyDoubleSize   .DoubleSize  = Not .DoubleSize
			Case Else            vpmKeyUp = False
		End Select
	End With
	On Error Goto 0
End Function


