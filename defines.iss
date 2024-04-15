// © _McClayn, 2020-2023   LITE EU region demo \\

 #ifndef UNICODE
  #error Just Unicode!
  // cursor
  #define A "W"
  #else
  #define A "A"
#endif
 #ifndef IS_ENHANCED
  #error You must have the enhanced revision of Inno Setup Compiler to build this project
#endif

#define Author "_McClayn"

#define AppID "{19063B54-E237-4703-A1A9-98B9BABB8577}"    ;


#define AppMutex "Demo ModPackMutex"     ;
#define AppFullName "Demo ModPack LITE"      ;
#define AppShortName "DemoMod"
#define GameFullName "World of Tanks"               ; 
#define GameShortName "WoT"                ; 


#define CreateDate GetDateTimeString('dd/mm/yyyy hh:nn:ss', '.', ':')

#define URL_Youtube "https://www.youtube.com/"
#define URL_Wgmods "https://wgmods.net/"

#define URL_WOTForum "http://forum.worldoftanks.eu/"

#define URL_Donate "https://www.donationalerts.com/r/"

#define UpdatesURL "/#download"

                 