// Tumbleweed Verbs
// Version: 1.0
//
// Author: 
//   abstauber
//
// Legacy authors:
//   Proskrito, Rulaman, Lucasfan, Khris
//
// Abstract: 
//   This template adds a 9 Verb GUI to AGS,  
//   heavily inspired by Thimbleweed Park(tm) by Terrible Toybox, Inc.
//   It supersedes the 9-Verb MI-Style template.
//   The graphics included may be freely used and altered in any way.
//
// Assets:
//  Fonts UI: TomThumb, Xpaider pixel explosion 2, Adventure 2
//  Fonts Buttons: Unscii, Sinister Small
//  Backgrounds, objects and verb graphics by abstauber
//  Option GUI graphics based on Buch's UI https://opengameart.org/users/buch
//  Character Art by Shane 'ProgZmax' Stevens
//
//
// Translators:
//   Spanish - Josemarg, Unai, Poplamanopla, Cireja
//   German  - Abstauber
//   French  - Monsieur OUXX
//   Italian - Paolo, Bicilotti
//   Portuguese - Miguel
//   Dutch   - arj0n
//
//
// Contact and Support: 
//   Please visit the AGS-Forums at: http://adventuregamestudio.co.uk/forums
//
// Dependencies:
//   AGS 3.4 or later 
//
//
// Revision History / Changelog
// 1.0  initial release
//        
//
// Licence:
//
// The MIT License (MIT)
// 
// Copyright (c) 2017 The AGS-Community
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


//----------------------------------------------------------------------------

#define ACT_COUNT 10  // Action Button Count (gMain)
#define MAX_DOORS 99 // How many doors accessed by door script

        
enum eGlobCond {
  eGlob_MouseInvWalk,
  eGlob_MouseInvPickup, 
  eGlob_InvOnInv,
  eGlob_GiveTalkNoChar, 
  eGlob_GiveNoInv, 
  eGlob_InvTalk
};

enum Action {
  eGA_LookAt,
  eGA_TalkTo,
  eGA_GiveTo,
  eGA_PickUp,
  eGA_Use,
  eGA_Open,
  eGA_Close,
  eGA_Push,
  eGA_Pull,
  eGA_UseInv,
  eGA_Default,
  eGA_WalkTo
};

enum eLanguage {
  eLangEN, 
  eLangDE,
  eLangES, 
  eLangIT, 
  eLangFR, 
  eLangPT, 
  eLangNL
};


// ============================= door script functions =========================================
struct Doors {
  import static void   SetDoorState(int door_id, int value);
  import static int    GetDoorState(int door_id);
  import static void   InitObject (int door_id, int obj);
  import static void   SetDoorStrings(String lookat =false, String islocked =false, String wrongitem =false, String closefirst =false, String unlock =false, String relock =false);
  import static String GetDoorStrings(String what_type);
  import static int    AnyClick(int door_id, int act_object, int x, int y, CharacterDirection dir, int nr_room, int nr_x, int nr_y, CharacterDirection nr_dir);
  import static int    AnyClickSpecial (int door_id, int act_object, int x, int y, CharacterDirection dir, int nr_room, int nr_x, int nr_y, CharacterDirection nr_dir, AudioClip *opensound, AudioClip *closesound, int key, int closevalue);
};

// ============================= Extender function(s) =========================================
import void EnterRoom(this Character*, int newRoom, int x, int y, CharacterDirection dir);


// ============================= Verb GUI functions ============================================
struct Verbs {
// ============================= Helper functions ==============================================
  import static float Distance(int x1, int y1, int x2, int y2);
  import static int  Offset(int point1, int point2);
  import static int  GetButtonAction(int action);
  import static void DisableGui();
  import static void EnableGui();
  import static bool IsGuiDisabled();
  import static int  GlobalCondition(eGlobCond condition);
  import static void SetDoubleClickSpeed(int speed);
  import static void InitGuiLanguage();  
  import static void HandleInvArrows();  
  
  // ============================= Verb Action functions ===========================================
  import static bool UsedAction (Action test_action);
  import static bool IsAction(Action test_action);
  import static void SetActionButtons(Action action, int btn_ID, int sprite, int sprite_highlight, char key);
  import static void SetDefaultAction(Action def_action);
  import static void SetAction(Action new_action);
  import static void SetAlternativeAction(char extension, Action alt_action);
  import static void CheckDefaultAction();
  import static void UpdateActionBar();
  import static void AdjustActionBarPosition();
  import static void ToogleGuiStyle(int enable_new);

  // ============================= Player/character functions =======================================
  import static void FreezePlayer();
  import static void UnfreezePlayer();
  import static void SetPlayer(Character*ch);
  import static int  GoTo(int blocking=2);
  import static void SetApproachingChar(bool enable);
  import static void WalkOffScreen();


  // ================ Cancelable, semi-blocking move-player-character functions =====================
  import static int MovePlayer(int x, int y);
  import static int GoToCharacter(Character*charid, CharacterDirection dir, bool NPCfacesplayer, int blocking);
  import static int NPCGoToCharacter(Character*charidwhogoes, Character*charidtogoto, CharacterDirection dir, bool NPCfacesplayer, int blocking);
  import static int MovePlayerEx(int x, int y, WalkWhere direct);
  import static int GoToCharacterEx(Character*chwhogoes, Character*ch, CharacterDirection dir, int xoffset, int yoffset, bool NPCfacesplayer, int blocking);
  import static int AnyClickMove(int x, int y, CharacterDirection dir);
  import static int AnyClickWalk(int x, int y, CharacterDirection dir);
  import static int AnyClickWalkLook(int x, int y, CharacterDirection dir, String lookat);
  import static int AnyClickWalkLookPick(int x, int y, CharacterDirection dir, String lookat, int objectID, InventoryItem*item, AudioClip *sound=false);
  import static int AnyClickUseInv (InventoryItem*item, int x, int y, CharacterDirection dir);
  
  // ============================= Unhandled Events =================================================
  import static void Unhandled(int door_script=0);

  // ============================= translation ====================================================
  import static void TranslateAction(int action, int tr_lang=eLangEN);
  import static void AdjustLanguage();
  import static void AdjustGUIText();

  // ============================= Extensions  ==========================================
  import static int  RemoveExtension();
  import static void AddExtension(char extension);
  import static char ExtensionEx(int index, String name);
  import static char Extension();
  import static void OpenCloseExtension(int door_id);
  import static void VariableExtensions();  
};


