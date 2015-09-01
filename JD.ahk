#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

;gameConfig = C:\P-ROC\games\KnightRider\config.yaml
;userConfig = C:\Users\Admin\.pyprocgame\config.yaml

;CHANGE THIS TO MOVE THE DMD DISPLAY
dmd_posX = 0
dmd_posY = 0

;FileCopy,% gameConfig, % userConfig, 1
Run, C:\P-ROC\Visual Pinball\vpinballx.exe -play "C:\P-ROC\Visual Pinball\Tables\JD.vpx"

WinWaitActive, Microsoft Visual C++ Runtime Library ahk_class #32770
Send, {Enter Down}{Enter Up}

WinWaitActive, ahk_class pygame
WinMove, %dmd_posX%,%dmd_posY%
WinSet, AlwaysOnTop, On, ahk_class pygame
WinSet, Top,, ahk_class pygame

Winactivate,Visual Pinball
ExitApp
