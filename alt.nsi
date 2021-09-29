; alt.nsi
;
; This script is based on example1.nsi, but it remember the directory, 
; has uninstall support and (optionally) installs start menu shortcuts.
;
; It will install alt.nsi into a directory that the user selects.
;
; See install-shared.nsi for a more robust way of checking for administrator rights.
; See install-per-user.nsi for a file association example.

;--------------------------------

; The name of the installer
Name "AppName"

; The file to write
OutFile "AppName.exe"

; Request application privileges for Windows Vista and higher
RequestExecutionLevel admin

; Build Unicode installer
Unicode True

; The default installation directory
InstallDir $PROGRAMFILES64\AppName

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\Krome\AppName" "Install_Dir"

;--------------------------------

; Pages

Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

; The stuff to install
Section "AppName (required)"

  SectionIn RO
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File "alt.nsi"
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\Krome\AppName "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\AppName" "DisplayName" "AppName"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\AppName" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\AppName" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\AppName" "NoRepair" 1
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"

  CreateDirectory "$SMPROGRAMS\AppName"
  CreateShortcut "$SMPROGRAMS\AppName\Uninstall.lnk" "$INSTDIR\uninstall.exe"
  CreateShortcut "$SMPROGRAMS\AppName\AppName (MakeNSISW).lnk" "$INSTDIR\AppName.nsi"

SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\AppName"
  DeleteRegKey HKLM SOFTWARE\Krome

  ; Remove files and uninstaller
  Delete $INSTDIR\alt.nsi
  Delete $INSTDIR\uninstall.exe

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\AppName\*.lnk"

  ; Remove directories
  RMDir "$SMPROGRAMS\AppName"
  RMDir "$INSTDIR"

SectionEnd
