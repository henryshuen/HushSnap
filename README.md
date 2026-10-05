<div align="center">
  <img src="assets/logo.png" alt="HushSnap" width="120">
  <h1>HushSnap</h1>
</div>

> [!IMPORTANT]
> **Unofficial modified build based on HushSnap v1.6.2 by [tcita](https://github.com/tcita/HushSnap).**
>
> This branch intentionally remains based on **v1.6.2** because that release includes **Auto OCR After Capture**.  
> Auto OCR is an existing upstream v1.6.2 feature and is **not introduced by this fork**.
>
> Changes in this fork:
> - Uses the Windows **Screenshots** known folder as the default image save location.
> - Adds a configurable **Image Save Location** in Settings.
> - Uses the selected save location for both thumbnail saving and pinned-image saving.
> - Updates save-related UI text for English, Simplified Chinese, Traditional Chinese, and Japanese.
> - Adds a conventional Windows installer using **Inno Setup**.
>
> Licensed under **GPL-3.0**, consistent with the upstream project.

### Upstream project

- [Original HushSnap repository](https://github.com/tcita/HushSnap)
- [HushSnap Website](https://tcita.github.io/HushSnap/)
- [Microsoft Store (official upstream build)](https://apps.microsoft.com/detail/9p0qzv5z8njz)
- [Demo Video](https://youtu.be/untWW6_Ea3M)
- [爱发电 / Support upstream](https://afdian.com/a/tcita)

<br>

<table align="center" width="600">
<tr>
<td align="left">

HushSnap bridges screenshots and OCR into one fluid flow. Press a hotkey and a crosshair overlay appears instantly - select a region (or click for the full screen) and the shot lands on your clipboard right away. A thumbnail fades in at the bottom-right corner; left-click it and the recognized text pops up, already reformatted into a clean, readable layout you can edit on the spot. Everything runs locally - your screenshots and recognized text never leave your device. It lives quietly in the system tray, so there are no windows or menus to pre-launch: the UI surfaces only when you need it, then fades away.

</td>
</tr>
</table>

<table>
  <tr>
    <td align="center"><b>Click thumbnail → OCR</b></td>
    <td align="center"><b>Drag thumbnail → Save</b></td>
    <td align="center"><b>Edit → Redact</b></td>
  </tr>
  <tr>
    <td><img src="assets/demo-ocr.gif" alt="OCR demo" width="280"></td>
    <td><img src="assets/demo-drag-save.gif" alt="Drag and save demo" width="280"></td>
    <td><img src="assets/demo-editor-redact.gif" alt="Editor redaction demo" width="280"></td>
  </tr>
</table>

After capture, a thumbnail fades in at the bottom-right corner of your screen. This thumbnail is the heart of HushSnap's post-capture flow:

- **Hover** to pause auto-hide and reveal an action pill with **Edit**, **Pin**, and **Close** buttons.
- **Drag and drop** the thumbnail anywhere to save the image - into a chat, an email, a folder, or another app.
- **Left-click** the thumbnail to run **OCR**. Recognized text opens in a floating popup where you can edit, copy, resize, or pin the window to keep it visible. By default the text is also auto-copied to your clipboard.
- **Edit** (the brush button on the action pill) opens the built-in **image editor** - see [Image Editor](#image-editor) below for the full toolset.
- **Right-click** the thumbnail for **Copy Text from Image** (silent OCR - text straight to the clipboard, no popup) or **Save Image**.
- Optionally overlay a decorative **vine ornament** on the thumbnail’s top-left corner (enable it in Settings - Capture). It is purely cosmetic; it does not change the thumbnail’s hit area or any behavior.
- Enable **Auto OCR After Capture** in Settings to have text recognized and copied to the clipboard automatically right after capture — no thumbnail click needed.

## Fork-specific save behavior

By default, this fork saves screenshots to the Windows **Screenshots** known folder rather than Desktop.

You can change the location from:

**Settings → General → Image Save Location**

<img src="assets/image-save-location.png" alt="HushSnap Image Save Location setting" width="720">

The selected folder is shared by:
- Thumbnail **Save Image**
- Pinned-image **Save Image**

Choosing **Use Default** returns to the Windows Screenshots known folder.

## Release Notes

See [**what's new.txt**](what's%20new.txt) for the upstream changelog (Simplified Chinese, Traditional Chinese, English, Japanese — newest first).

Fork-specific changes are documented in this README and in the Git history for the `auto-ocr-v1.6.2` branch.

As the project continues to evolve, some parts of this README may occasionally lag behind the latest behavior or features.

## Image Editor

The built-in image editor opens from the thumbnail's **Edit** button, or from the right-click menu on a pinned image. It's a lightweight, dark-themed window for touching up a capture before sharing - annotate, redact, crop, rotate, resize, then copy to clipboard or save. The window opens centered on the cursor's screen and remembers its size across sessions.

**Tools:** rectangle / ellipse / line (color, size, fill, optional arrowhead), text (font, size, color), brush, highlighter, mosaic (pixelate/redact), eraser, pan, and the crop / rotate / resize transforms. Plus undo/redo (`Ctrl+Z` / `Ctrl+Y`), fit-to-viewport (`Ctrl+0`), copy, and Save As… (`Ctrl+S`, PNG / JPEG / BMP). Transforms run as atomic sessions - **Esc** cancels - so the state stays unambiguous mid-edit.

## OCR Engine

HushSnap uses [**PP-OCRv6**](https://github.com/PaddlePaddle/PaddleOCR) as its sole OCR engine:

- **PP-OCRv6 (via RapidOCR):** Runs PP-OCRv6 small ONNX models in-process via the [`rapidocr`](https://github.com/RapidAI/RapidOCR) Python package (Apache 2.0). No external dependencies or language packs needed. Works offline. Uses a unified multilingual model covering **50 languages** in a single 7.7M-parameter model - surpassing the accuracy of the previous-generation v5 server model at a fraction of the size.

The engine supports the following 50 languages out of the box:

**Core:** Simplified Chinese, Traditional Chinese, English, Japanese

**Latin-script (46):** French, German, Italian, Spanish, Portuguese, Dutch, Polish, Romanian, Czech, Swedish, Norwegian, Danish, Finnish, Hungarian, Turkish, Vietnamese, Indonesian, Malay, Azerbaijani, Afrikaans, Bosnian, Croatian, Welsh, Estonian, Irish, Icelandic, Kurdish, Lithuanian, Latvian, Maltese, Māori, Occitan, Slovak, Slovenian, Albanian, Swahili, Tagalog, Uzbek, Latin, Serbian (Latin), Catalan, Basque, Galician, Luxembourgish, Romansh, Quechua

### Minimal cv2 build

The shipped MSIX is slimmed down: HushSnap uses a purpose-built **24.8 MB static `cv2.pyd`** instead of the official 82 MB `opencv-python` wheel — 70% smaller, OCR output byte-identical (this is a size optimization only; the standard pip wheel works too). The trimmed package is committed in the repo (`third_party/` binary + the `cv2/` package at repo root, which dev and tests import directly). Rebuild when OpenCV or Python changes:

```powershell
pwsh scripts/build/build_minimal_opencv.ps1 -NoIPP -ForceClean
```

## Third-Party Acknowledgment

Design references: [Text-Grab](https://github.com/TheJoeFin/Text-Grab) (MIT,
OCR workflow), [Pinta](https://github.com/PintaProject/Pinta) (MIT, image editor
toolset), [ShareX](https://github.com/ShareX/ShareX) (GPL-3.0, capture workflow).
Built with [PyQt6](https://www.riverbankcomputing.com/software/pyqt/) (GPL-3.0-only,
© Riverbank Computing Limited) — see `THIRD_PARTY_NOTICES.md` for all attributions.

## License

HushSnap is distributed under the **GNU General Public License v3.0**
([LICENSE.md](LICENSE.md)). See `THIRD_PARTY_NOTICES.md` for third-party
attribution.

This fork preserves the upstream GPL-3.0 license and clearly marks its modifications.

Copyright © 2026 HushSnap.

## Development & Debugging

Install dependencies:

```powershell
pip install -r requirements.txt
```

Run from source:

```powershell
python HushSnap.py
```

To enable debug mode, set `debug = true` in `hushsnap_config.toml` (the `--debug` CLI flag was removed because MSIX packages cannot receive command-line arguments).

**Key Features of Debug Mode:**

- **Isolation:** Running from source uses `%LOCALAPPDATA%\HushSnap_Dev`, ensuring your production settings remain untouched.
- **Traceability:** Sets log level to `DEBUG` and opens the log folder immediately upon startup.
- **Live Output:** Real-time logs are streamed to the terminal via the logging console handler (`StreamHandler`).
- **OCR Inspection:** Debug mode saves detection-box images to the data directory. Right-click the tray icon → "Config Folder" to open this location directly.
  - `ocr_debug_words.png` - raw PP-OCR detector word boxes (red)
  - `ocr_debug_lines.png` - post-clustering line boxes (green, L0/L1/… badges)
  - Source run: `%LOCALAPPDATA%\HushSnap_Dev\`
  - Packaged run (MSIX): `%LOCALAPPDATA%\Packages\<PackageFamilyName>\LocalState\`
  - Packaged run (PyInstaller standalone): `%LOCALAPPDATA%\HushSnap\`

## Building this fork (Windows EXE installer)

This fork includes an Inno Setup script at:

```text
installer/installer_custom.iss
```

Build the PyInstaller application first so the following directory exists:

```text
dist/HushSnap/
```

Then compile `installer/installer_custom.iss` with Inno Setup. The installer output is written to:

```text
dist-installer-exe/HushSnap-1.6.2-AutoOCR-Setup.exe
```

The installer is currently unsigned, so Windows SmartScreen may display a warning on first launch or installation.

## Building upstream-style MSIX

The upstream MSIX build workflow is still present:

```powershell
build_msix.bat              # build unsigned MSIX; version auto-resolved from git tag
sign_for_local_test.bat     # self-sign the package for local install testing
```

The build requires HEAD at a git tag (e.g. `v0.3.0`). For local testing, `sign_for_local_test.bat` auto-creates a self-signed certificate and trusts it - run as Administrator.

Release notes (four languages, newest first) are in [`what's new.txt`](what's%20new.txt).

---

## Installation

### This fork

Download the latest installer from the **Releases** page of this fork and run:

```text
HushSnap-1.6.2-AutoOCR-Setup.exe
```

No Python or Conda installation is required for the packaged build.

Because the installer is unsigned, Windows SmartScreen may warn that the publisher is unknown.

### Official upstream build

For the official upstream version, use the [Microsoft Store](https://apps.microsoft.com/detail/9p0qzv5z8njz) or visit the [upstream repository](https://github.com/tcita/HushSnap).
