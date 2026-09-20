# screencap

A tiny Windows desktop launcher. Double-click the icon, drag a rectangle, screenshot goes to the clipboard.

Built for gaming setups where the **Start button / Windows key is disabled** in Logitech Options / Options+ so Win+Shift+S is not available mid-game.

No extra capture app. It just fires the built-in Windows snip overlay (`ms-screenclip:`), the same UI as Win+Shift+S.

## You do not need this repo

Fastest path with no clone:

1. Right-click the desktop → **New → Shortcut**
2. Location:
   ```
   explorer.exe ms-screenclip:
   ```
3. Name it `ScreenCap`
4. Optional: Properties → Change Icon → `C:\Windows\System32\SnippingTool.exe`

Double-click → drag → Ctrl+V to paste. Esc cancels.

On some Windows 11 builds you can also use a URL shortcut whose target is simply:

```
ms-screenclip:
```

If `/clip` still works on your build, this is equivalent:

```
C:\Windows\System32\SnippingTool.exe /clip
```

(`snippingtool.exe /clip` is unreliable on current Windows 11; `ms-screenclip:` is the reliable protocol.)

## If you want the repo anyway

```bat
git clone https://github.com/lankynibbs/screencap.git
cd screencap
powershell -ExecutionPolicy Bypass -File .\install-shortcut.ps1
```

That drops **ScreenCap.lnk** on your Desktop. The shortcut runs `screencap.vbs` so no console flashes.

Keep the cloned folder where you put it. The `.lnk` points at `screencap.vbs` by absolute path.

## What happens after capture

- Image is on the **clipboard**
- Windows may toast a Snipping Tool notification; you can ignore it while gaming
- Paste into Discord, Paint, Slack, etc.
- Nothing is written to disk unless you open the notification and save

## Why not just Win+Shift+S?

You disabled the Start / Windows key in Logi Options so a stray press does not yank you out of a game. This icon never uses the Windows key.

You can still bind a mouse side button in Logi Options to this same action if you want zero desktop clicking:

- Action: Open application / Open file
- Target: `wscript.exe`
- Args: full path to `screencap.vbs`

Or bind the button to run `explorer.exe ms-screenclip:`.

## Files

| File | Purpose |
| --- | --- |
| `screencap.vbs` | Silent launcher |
| `screencap.cmd` | Same thing with a brief console |
| `install-shortcut.ps1` | Creates Desktop `ScreenCap.lnk` |

## Requirements

Windows 10 (Creators Update+) or Windows 11 with the Screen Snipping / Snipping Tool protocol handler (`ms-screenclip`). That is the default OS feature, not a download.
