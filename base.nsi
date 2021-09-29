; NSIS Modern User Interface
; Reese

;--------------------------------
; Include Modern UI

!include "MUI2.nsh"

;--------------------------------
; General

  ; Installer name
  Name "ModernUI"

  ; Output file
  OutFile "setup.exe"

  ; Request application privileges for Windows Vista
  RequestExecutionLevel admin
  
  ; Build unicode installer
  Unicode True

  ; Default installation folder
  InstallDir "$PROGRAMFILES64\ModernUI"
  
  ; Registry key to check for directory (so if you install again, it will 
  ; overwrite the old one automatically)
  InstallDirRegKey HKLM "Software\ModernUI" "Install_Dir"

;--------------------------------
; Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
; Pages

  !insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\Modern UI\License.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  
;--------------------------------
; Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
; Installer Sections

Section "ModernUI" SecProduct

  ; Set output directory
  SetOutPath "$INSTDIR"

  ; Store installation folder
  WriteRegStr HKLM "Software\ModernUI" "" $INSTDIR
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ModernUI" "DisplayName" "ModernUI"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ModernUI" "UninstallString" '"$INSTDIR\Uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ModernUI" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ModernUI" "NoRepair" 1
  WriteUninstaller "$INSTDIR\Uninstall.exe"
  
  ; Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  ; Put file there
  File "modern.nsi"

SectionEnd
;--------------------------------
; Installer Sections

Section "Start Menu Shortcut" SecStartMenu

  CreateDirectory "$SMPROGRAMS\ModernUI"
  CreateShortcut "$SMPROGRAMS\ModernUI\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
  CreateShortcut "$SMPROGRAMS\ModernUI\ModernUI (MakeNSISW).lnk" "$INSTDIR\ModernUI.nsi"

SectionEnd

;--------------------------------
; Descriptions

  ;Language strings
  LangString DESC_SecProduct ${LANG_ENGLISH} "A test section."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
; Uninstaller Section

Section "Uninstall"

  ; Remove registy keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ModernUI"
  DeleteRegKey HKLM SOFTWARE\ModernUI

  ; Remove files and uninstaller
  Delete $INSTDIR\modern.nsi
  Delete "$INSTDIR\Uninstall.exe"
  
  ; Remove shortcuts
  Delete "$SMPROGRAMS\ModernUI\*.lnk"

  ; Remove directories
  RMDir "$SMPROGRAMS\ModernUI"
  RMDir "$INSTDIR"

SectionEnd