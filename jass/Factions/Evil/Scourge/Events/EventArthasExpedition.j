library EventArthasExpedition requires Persons, GameTimer, GeneralHelpers, LegionConfig, ScourgeConfig, DetermineLevel, MalganisModConfig

  globals
    private unit UNIT_MALGANIS = null

    private constant real DELAY = 35.
    private constant integer XP_BASE = 800
    private constant integer XP_PER_SECOND = 1
    private constant integer XP_MAX = 2700
  endglobals

  function TimerEnds takes nothing returns nothing
    local Person scourge = PersonsByFaction[FACTION_SCOURGE]
    local Person legion = PersonsByFaction[FACTION_LEGION]
    local unit arthas = null
    local unit malganis = null
    local group tempGroup = null
    if scourge != 0 then
      set arthas = CreateUnit(scourge.p, 'Uear', -2796, 21842, 270)
      call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, scourge.faction.prefixCol + "Arthas|r has claimed the cursed sword of Frostmourne and become enslaved by Ner'zhul; he is now a loyal Death Knight of the " + scourge.faction.prefixCol + "Scourge|r.")   
      call UnitDetermineLevel(arthas, 1.00)
      if legion != 0 then
        set tempGroup = CreateGroup()
        call GroupEnumUnitsOfType(tempGroup, "Mal'Ganis", null)
        set malganis = GroupPickRandomUnit(tempGroup)
        call UnitTransferItems(malganis, arthas)
        call RemoveUnit(malganis)
        call legion.applyFactionMod(FACTIONMOD_MALGANIS)
        call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "With the cursed Runeblade in hand, " + scourge.faction.prefixCol + "Arthas|r's lust for vengeance swells. " + legion.faction.prefixCol + "Mal'ganis|r can no longer be revived.")  
        //cleanup
        set malganis = null
        call DestroyGroup(tempGroup)
        set tempGroup = null
      endif
      set arthas = null
    endif
    call DestroyTimer(GetExpiredTimer())
  endfunction

  function DoArthasExpedition takes nothing returns nothing
      local timer time = CreateTimer()
      call TimerStart(time, DELAY, false, function TimerEnds)
  endfunction
    
endlibrary