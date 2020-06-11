library PathDuoLordaeron initializer OnInit requires LordaeronConfig, LegendLordaeron, Display

  globals
    private constant integer RESEARCH_SCARLET = 'R01F'
    private constant integer RESEARCH_SILVER = 'R01G'
  endglobals

  private function Research takes nothing returns nothing
    local player tempPlayer
    if GetResearched() == RESEARCH_SCARLET or GetResearched() == RESEARCH_SILVER then
      set tempPlayer = FACTION_LORDAERON.Person.p
      call LEGEND_MOGRAINE.Spawn(tempPlayer, 12186, 10967, 322)
      call FACTION_LORDAERON.modWeight(1)
      if GetResearched() == RESEARCH_SCARLET then
        call DisplaySoloPath(FACTION_LORDAERON, "The Scarlet Crusade was granted the power of the Lordaeron military.")
        call FACTION_LORDAERON.modObjectLimit('h06C', UNLIMITED)       //Halls of Glory 
        call FACTION_LORDAERON.modObjectLimit('h066', UNLIMITED)       //Scarlet Zealot
        call FACTION_LORDAERON.modObjectLimit('h069', UNLIMITED)       //Scarlet Battlemage
        call FACTION_LORDAERON.modObjectLimit('h065', UNLIMITED)       //Scarlet Crusader Knight
        call FACTION_LORDAERON.modObjectLimit('h067', 8)               //Scarlet Paladin
        call FACTION_LORDAERON.modObjectLimit('h00T', UNLIMITED)       //Scarlet Monastery
        call FACTION_LORDAERON.modObjectLimit('h06A', UNLIMITED)       //Inquisitor
        call FACTION_LORDAERON.modObjectLimit('h06B', UNLIMITED+6)     //Grand Crusader
        call FACTION_LORDAERON.modObjectLimit('R04F', UNLIMITED)       //Scarlet Mage Initiate Training
        call FACTION_LORDAERON.modObjectLimit('e011', 8)               //Gryphon Knight
        call FACTION_LORDAERON.modObjectLimit('hkni', -UNLIMITED)      //Knight
        call FACTION_LORDAERON.modObjectLimit('h00F', -UNLIMITED)      //Lordaeron Paladin
        call SetPlayerTechResearched(tempPlayer, 'R01F', 1)            //Scarlet Crusade
        call SetPlayerAbilityAvailable(tempPlayer, 'A0TL', true)
      else
        call DisplaySoloPath(FACTION_LORDAERON, "The Silver Hand was granted the power of the Lordaeron military.")
        call FACTION_LORDAERON.modObjectLimit('h06C', UNLIMITED)       //Halls of Glory 
        call FACTION_LORDAERON.modObjectLimit('n09R', 6)               //Bishop of the Silver Hand
        call FACTION_LORDAERON.modObjectLimit('h063', UNLIMITED)       //Knight of the Silver Hand
        call FACTION_LORDAERON.modObjectLimit('R04C', UNLIMITED)       //Silver Hand Initiate Training
        call FACTION_LORDAERON.modObjectLimit('h06E', UNLIMITED)       //Silver Hand Cleric
        call FACTION_LORDAERON.modObjectLimit('h06D', UNLIMITED+6)     //Silver Hand Veteran Paladin
        call FACTION_LORDAERON.modObjectLimit('h068', 8)               //Silver Hand Cleric
        call FACTION_LORDAERON.modObjectLimit('e011', 8)               //Gryphon Knight
        call FACTION_LORDAERON.modObjectLimit('hkni', -UNLIMITED)      //Knight
        call FACTION_LORDAERON.modObjectLimit('h00F', -UNLIMITED)      //Lordaeron Paladin 
        call SetPlayerTechResearched(tempPlayer, 'R01G', 1)            //Silver Hand
        call SetPlayerAbilityAvailable(tempPlayer, 'A0TE', true)
      endif
      call DisableTrigger( gg_trg_Lordaeron_East )
      call DisableTrigger( gg_trg_Lordaeron_West )
      call EnableTrigger( gg_trg_Lordaeron_West_post_tier )
      call EnableTrigger( gg_trg_Lordaeron_East_post_tier )
    endif
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_RESEARCH_FINISH  )
    call TriggerAddCondition(trig, Condition(function Research))    
  endfunction

endlibrary