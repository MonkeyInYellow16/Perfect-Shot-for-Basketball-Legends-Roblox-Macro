#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

macroKey := ""
running := false

; GUI Setup - slightly wider with radio buttons
Gui, Font, s10, Segoe UI
Gui, Add, Text, x20 y10 w200 Center, Macro Keybind:
Gui, Add, Text, vMacroKeyText x20 y30 w200 Center, None
Gui, Add, Button, x20 y60 w200 h30 gAssignKey, Assign Key

Gui, Add, Radio, vStartButton x30 y100 w80 gStartScript, Start
Gui, Add, Radio, vStopButton x130 y100 w80 gStopScript, Stop

Gui, Show, w240 h150, Simple Macro
return

AssignKey:
    InputBox, key, Assign Macro Key, Press a key to assign to the macro:
    if ErrorLevel = 0
    {
        macroKey := key
        GuiControl,, MacroKeyText, %macroKey%
        if (running)
            Hotkey, %macroKey%, RunMacro, On
        MsgBox, 64, Assigned, Macro Key assigned to: %macroKey%
    }
return

StartScript:
if (!running)
{
    running := true
    GuiControl,, StartButton, 1
    GuiControl,, StopButton, 0
    if (macroKey != "")
        Hotkey, %macroKey%, RunMacro, On
}
return

StopScript:
if (running)
{
    running := false
    GuiControl,, StartButton, 0
    GuiControl,, StopButton, 1
    if (macroKey != "")
        Hotkey, %macroKey%, Off
}
return

; === Custom Macro Sequence: Perfect Shot ===
RunMacro:
    ToolTip, Macro Triggered!
    SetTimer, RemoveToolTip, -1000

   Send, {e down}     ; Hold E
Sleep, 340         ; Wait 0.34 seconds (340 milliseconds)
Send, {e up}       ; Release E

return

RemoveToolTip:
    ToolTip
return

GuiClose:
ExitApp
