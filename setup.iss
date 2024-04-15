// © _McClayn, 2020-2023 LITE EU region demo \\

[Setup]
AppId={{#AppID}
AppMutex={#AppMutex}
AppName={#AppFullName} ({#Version})
AppVersion={#GameShortName} ({#Patch})
AppPublisher={#Author}

//====={ Ссылки }=====\\
AppPublisherURL={#URL_WOTForum}
AppSupportURL={#URL_WOTForum}
AppUpdatesURL={#URL_WOTForum}

//====={ Папка устанвки }=====\\
DefaultDirName={pf}\World_of_Tanks_EU
AppendDefaultDirName=no
DirExistsWarning=no
DefaultGroupName={#AppFullName} (v{#Version})

DisableWelcomePage=yes
DisableProgramGroupPage=yes
DisableDirPage=yes
DisableReadyPage=yes
DisableFinishedPage=yes

//====={ Папка создания и название сетапа }=====\\
OutputDir=release

OutPutBaseFilename=wotmodpack_demo

// cursor
RawDataResource=MyCursor:files\wot_cursor\wot_kden_arrow.cur

//====={ Картинки }=====\\
//SetupIconFile=files\logo_lesta.ico
SetupIconFile=files\logo-lesta.ico

AppComments={#Author}
VersionInfoVersion={#Version}
VersionInfoTextVersion={#Version}   
VersionInfoDescription={#AppFullName} for {#GameFullName}
AppCopyright=© {#Author} 2023
UninstallLogMode=new
UninstallDisplayIcon={app}\{#AppFullName}\Uninstall\unins000.exe
UninstallFilesDir={app}\{#AppFullName}\Uninstall
UninstallDisplayName={#AppFullName} ({#Version})
UsePreviousSetupType=no
PrivilegesRequired=poweruser
 #ifdef Compress
//====={ Сжатие сетапа }=====\\  
Compression=lzma2

SolidCompression=no

#endif

[Languages]
Name: "en"; MessagesFile: "src\l10n\setup_en.isl";
Name: "ru"; MessagesFile: "src\l10n\setup_ru.isl";
