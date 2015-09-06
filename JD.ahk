#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

;FileCopy,% gameConfig, % userConfig, 1
Run, C:\P-ROC\Visual Pinball\vpinballx.exe -play "C:\P-ROC\Visual Pinball\Tables\JD.vpx"

WinWaitActive, Microsoft Visual C++ Runtime Library ahk_class #32770
Send, {Enter Down}{Enter Up}

Winactivate,Visual Pinball
ExitApp
