[Setup]
AppName=HushSnap AutoOCR
AppVersion=1.6.2
AppPublisher=henryshuen
DefaultDirName={autopf}\HushSnap AutoOCR
DefaultGroupName=HushSnap AutoOCR
UninstallDisplayIcon={app}\HushSnap.exe
OutputDir=..\dist-installer-exe
OutputBaseFilename=HushSnap-1.6.2-AutoOCR-Setup
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
PrivilegesRequired=lowest
LicenseFile=..\LICENSE.md

[Files]
Source: "..\dist\HushSnap\HushSnap.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\dist\HushSnap\_internal\*"; DestDir: "{app}\_internal"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\HushSnap AutoOCR"; Filename: "{app}\HushSnap.exe"
Name: "{userdesktop}\HushSnap AutoOCR"; Filename: "{app}\HushSnap.exe"; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional shortcuts:"; Flags: unchecked

[Run]
Filename: "{app}\HushSnap.exe"; Description: "Launch HushSnap"; Flags: nowait postinstall skipifsilent