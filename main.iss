// © _McClayn, 2020-2023 LITE EU region demo \\

#ifdef IS_ENHANCED
  #if (Pos('ee', IS_Ver_Str) >= 1)
    #define IS_Version_ee
  #endif
#else
  #error Enhanced edition of Inno Setup (restools) is required to compile this script
#endif

#define GameVersion "1.22"                                   ;   1.21.1   1.21
#define Patch "1.22.0.0"                                     ;  1.21.1.0  1.16.1.0  1.16.0.0  1.15.0.3  1.15.0.3  1.15.0.2  1.15.0.1   1.15.0.0  1.14.1.4  1.14.1.3  1.14.1.2  1.14.1.1   1.14.1.0  1.12.1.1   1.14.0.1    1.14.0.2    1.14.0.3  1.14.0.4  1.14.0.5                   1.11.0.0
#define SPatch "1.10.1.4"
#define CPatch "1.22.0.0"                                    ; dlya rapotosposobnsti ozvuchek
#define Version "2"                                          ;     2.0  1.0   8.0   7.0  6.0  5.0  4.0  3.0  2.0  1.0  4.0  3.0  2.0  1.0  1.0  2.0  8.0  7.0  6.0  5.0  4.0  3.0  2.0  1.0  2.0

 #if FindFirst("mods\updater", faDirectory) == 0
#define TESTING
#endif

#define Compress
#define CheckForGameFiles
#define CheckForGameRun

#include "defines.iss"
#include "setup.iss"
#include "src\l10n\cm.iss"
#include "src\utils.iss"
#include "src\botva2\botva2.iss"
#include "src\xml.iss"


#include "src\vcl\vcl.iss"                                  ; стиль установщика Windows10Dark


#include "src\window.iss"                                   ; окно установщика
#include "src\widgets.iss"                                  ; внизу слева установщика иконки с ссылками на сайт
#include "src\paramsRememberer.iss"
#include "src\customPages\welcome.iss"                      ; страница приветствия

#include "src\customPages\selectDir\selectDir.iss"          ; страница выбора папки с игрой
#include "src\configEditor.iss"

#include "src\checkListBoxSrc.iss"                          ; preview images pos
#include "src\customPages\itemsBase.iss"                    ; основные модификации
//
//
#include "src\customPages\itemsTweaker.iss"
//

//
#include "src\customPages\ready\ready.iss"                  ;
#include "src\customPages\preparing.iss"
#include "src\customPages\installing.iss"

#include "src\customPages\finished.iss"
#include "src\folderOperations.iss"

// OpenWGUtils Mixaill XVM
//#define OPENWGUTILS_DIR_SRC    "bin"
//#define OPENWGUTILS_DIR_UNINST AppFullName
//#include "innosetup\openwg.utils.iss"


[Files]
Source: "files\console\*"; DestDir: "{app}\{#AppFullName}"; Flags: ignoreversion;
// cursor
Source: "files\wot_cursor\wot_kden_arrow.cur"; Flags: dontcopy noencryption;
// font
Source: "files\Russo_One.ttf"; Flags: dontcopy noencryption;
Source: "files\Warhelios-Bold_Web.ttf"; Flags: dontcopy noencryption;
// reklama     Splash.png
Source: "files\JshMp.png"; Flags: dontcopy noencryption nocompression;
// reklama
Source: "src\isgsg.dll"; Flags: dontcopy noencryption nocompression;


[InstallDelete]
Type: filesandordirs; Name: "{app}\{#AppFullName}";
Type: filesandordirs; Name: "{app}\win32\Reports_XFW";
Type: filesandordirs; Name: "{app}\replays\replays_manager";
//

Type: files; Name: "{app}\*.log";

[UninstallDelete]
Type: filesandordirs; Name: "{app}\{#AppFullName}";

Type: files; Name: "{app}\*.log";
Type: filesandordirs; Name: "{app}\win32\Reports_XFW";
Type: filesandordirs; Name: "{app}\mods\temp";
Type: filesandordirs; Name: "{app}\mods\configs";
Type: filesandordirs; Name: "{app}\mods\{#Patch}\com.modxvm.xfw";
Type: filesandordirs; Name: "{app}\res_mods\mods\{#Patch}";
Type: filesandordirs; Name: "{app}\res_mods\configs";
Type: filesandordirs; Name: "{app}\res_mods\{#Patch}\audioww";
Type: filesandordirs; Name: "{app}\res_mods\{#Patch}\scripts";
Type: filesandordirs; Name: "{app}\replays\replays_manager";

//[RUN]



[Code]

const
FR_PRIVATE = $10;

function AddFontResource(lpszFilename: String; fl, pdv: DWORD): Integer; external 'AddFontResourceEx{#A}@gdi32.dll stdcall';
function RemoveFontResource(lpFilename: String; fl, pdv: DWORD): BOOL; external 'RemoveFontResourceEx{#A}@gdi32.dll stdcall';

// splash screen
procedure ShowSplashScreen(p1:HWND;p2:AnsiString;p3,p4,p5,p6,p7:integer;p8:boolean;p9:Cardinal;p10:integer);
external 'ShowSplashScreen@files:isgsg.dll stdcall delayload';

// cursor
#ifdef IS_Version_ee
function LoadCursorFromFile(FileName: String): Cardinal; external 'LoadCursorFromFile{#A}@user32 stdcall';
function DeleteObject(p1: Longword): BOOL; external 'DeleteObject@gdi32.dll stdcall';

const
  MyCursor = 101;
#endif

const
  RT_RCDATA = 10;
var
  hcur: Cardinal;


Function InitializeSetup(): Boolean;
begin

 if ActiveLanguage() = 'en' then
  MsgBoxEx(0, CustomMessage('languageIsNotFullySupports'), SetupMessage(msgInformationTitle), MB_ICONINFORMATION or MB_OK, 0, 0);

 Result := True;
  #ifdef VCL
 InitializeVCL();
 #endif
 // cursor
 //if not FileExists(ExpandConstant('{tmp}\wot_kden_arrow.cur')) then ExtractTemporaryFile('wot_kden_arrow.cur');
 Result := True;
end;


procedure Splash();
begin
  // всплывающее окно рекламы
  ExtractTemporaryFile('JshMp.png');
  ShowSplashScreen(WizardForm.Handle,ExpandConstant('{tmp}\JshMp.png'),1000,3000,1000,0,255,True,$FFFFFF,10);
end;

Procedure InitializeWizard();
var
  ResStream: TResourceStream;
begin

  //                                          //  _IS_MYCURSOR
  #ifdef IS_Version_ee
  ResStream := TResourceStream.Create(HInstance, '_IS_MYCURSOR', RT_RCDATA);
  try
    ResStream.SaveToFile(ExpandConstant('{tmp}\wot_kden_arrow.cur'));
    hcur := LoadCursorFromFile(ExpandConstant('{tmp}\wot_kden_arrow.cur'));
    Screen.Cursors[MyCursor] := hcur;
  finally
    ResStream.Free;
  end;
  #endif

  #ifdef IS_Version_ee
    WizardForm.Cursor := MyCursor;;
  #endif

  // font russo one
  if FontExists('Russo One') then
  begin
    ExtractTemporaryFile('Russo_One.ttf');
    AddFontResource(ExpandConstant('{tmp}\Russo_One.ttf'), FR_PRIVATE, 0);
  end;
  // font Warhelios-Bold_Web
  if FontExists('Warhelios-Bold_Web') then
  begin
    ExtractTemporaryFile('Warhelios-Bold_Web.ttf');
    AddFontResource(ExpandConstant('{tmp}\Warhelios-Bold_Web.ttf'), FR_PRIVATE, 0);
  end;
  WizardForm.Font.Name := 'Warhelios-Bold_Web';


 if not CMDCheckParams(CMD_NoCheckForMutex) then
  CreateMutex('{#AppMutex}');
 InitializeWindow();
 InitializeWidgets();
 InitializeWelcomePage();
  #ifdef Updater
 InitializeUpdaterPage();
 #endif
 InitializeSelectDirPage();
 InitializeComponentsInfo();

 InitializeComponentsPage();
 //
 //
 InitializeTweakerPage();
 //
////////////////////////////////////////////////////////////////
 //
 InitializeReadyPage();
 InitializeInstallingPage();
 InitializeFinishedPage();
 // cursor
 //with WizardForm do begin
 // Cursor := MyCursor;
 // end;
 // hcur := LoadCursorFromFile(ExpandConstant('{tmp}\wot_kden_arrow.cur'));
 // Screen.Cursors[MyCursor] := hcur;

 // with WizardForm.CancelButton do
 // begin
  //  Cursor := MyCursor;
 // end;
 // with WizardForm.NextButton do
 // begin
 //   Cursor := MyCursor;
 // end;
 // with WizardForm.BackButton do
 // begin
 //   Cursor := MyCursor;
 // end;

  // splash screen
  Splash();

end;


Function ShouldSkipPage(CurPageID: Integer): Boolean;
begin
 Result := False;
 case CurPageID of
  wpSelectDir: Result := SelectDirShouldSkipPage();
  wpPreparing: Result := PreparingShouldSkipPage();
 end;
end;

Procedure CurPageChanged(CurPageID: Integer);
begin
 case CurPageID of
  wpInstalling: ShowInstallingPage();
 end;
 ImgApplyChanges(WizardForm.Handle);
end;

Procedure CurStepChanged(CurStep: TSetupStep);
begin
 ClientFolderOperations(CurStep);
  //#ifndef TESTING
 StartConfigurator(CurStep);
 //#endif
 RememberComponentItems(CurStep);
 //
 RememberTweakerItems(CurStep);
 SaveReadyMemoToLog(CurStep);
end;

Procedure DeinitializeSetup();
begin
 LaunchGame();


 gdipShutdown();
  #ifdef VCL
 UnLoadVCLStyles();
 #endif
 DelTree(ExpandConstant('{tmp}'), True, True, True);
 // cursor
 #ifdef IS_Version_ee
 DeleteObject(hcur);
 #endif
end;

Function InitializeUninstall(): Boolean;
begin
 Result := True;
  #ifdef CheckForGameRun
 Result := CheckForGameRun(0);
 #endif
end;

Procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
 RestoreDirectories(CurUninstallStep);
end;

