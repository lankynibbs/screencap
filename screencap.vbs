' screencap.vbs
' Starts Windows screen-snip overlay (same as Win+Shift+S)
' so you can drag a rectangle. Image goes to the clipboard.
' No console window. Double-click or use the desktop shortcut.

Option Explicit
Dim sh
Set sh = CreateObject("WScript.Shell")
' explorer.exe handles the ms-screenclip protocol on Windows 10/11
sh.Run "explorer.exe ms-screenclip:", 0, False
Set sh = Nothing
