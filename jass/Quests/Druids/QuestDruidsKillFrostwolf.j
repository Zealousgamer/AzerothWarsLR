library DruidsKillFrostwolf initializer OnInit requires DruidsConfig, LegendFrostwolf, Display

  globals
    private QuestItemData QUESTITEM_THUNDERBLUFF
    private QuestItemData QUESTITEM_ORGRIMMAR
    private constant integer RESEARCH_ID = 'R044'
    private constant integer ELEMENTAL_GUARDIAN_ID = 'e00X'
  endglobals

  private function TryComplete takes nothing returns nothing
    if FACTION_DRUIDS.getQuestItemProgress(QUESTITEM_THUNDERBLUFF) == QUEST_PROGRESS_COMPLETE and FACTION_DRUIDS.getQuestItemProgress(QUESTITEM_ORGRIMMAR) == QUEST_PROGRESS_COMPLETE then
      call SetPlayerTechResearched(FACTION_DRUIDS.Person.p, RESEARCH_ID, 1)
      call DisplayUnitTypeAcquired(FACTION_DRUIDS.Person.p, ELEMENTAL_GUARDIAN_ID, "You can now train Elemental Guardians from upgraded Trees of Life and from your capitals.")
    endif
  endfunction

  private function ThunderBluffDies takes nothing returns nothing
    call FACTION_DRUIDS.setQuestItemStatus(QUESTITEM_THUNDERBLUFF, QUEST_PROGRESS_COMPLETE, true)
    call TryComplete()
  endfunction

  private function OrgrimmarDies takes nothing returns nothing
    call FACTION_DRUIDS.setQuestItemStatus(QUESTITEM_ORGRIMMAR, QUEST_PROGRESS_COMPLETE, true)
    call TryComplete()
  endfunction

  private function OnInit takes nothing returns nothing
    local QuestData tempQuest
    local trigger trig

    set trig = CreateTrigger()
    call TriggerRegisterUnitEvent( trig, LEGEND_THUNDERBLUFF.Unit, EVENT_UNIT_DEATH )
    call TriggerAddAction(trig, function ThunderBluffDies)

    set trig = CreateTrigger()
    call TriggerRegisterUnitEvent( trig, LEGEND_ORGRIMMAR.Unit, EVENT_UNIT_DEATH )
    call TriggerAddAction(trig, function OrgrimmarDies)

    set tempQuest = QuestData.create("Natural Contest", "The Frostwolf Clan has arrived on the shores of Kalimdor. Though their respect of the wild spirits is to be admired, their presence cannot be tolerated.", "The Frostwolves have been driven from Kalimdor. Their departure reveals the existence of powerful nature spirits that now heed the call of the Druids.","ReplaceableTextures\\CommandButtons\\BTNHeroTaurenChieftain.blp")
    set QUESTITEM_THUNDERBLUFF = tempQuest.addItem("Thunderbluff is destroyed")
    set QUESTITEM_ORGRIMMAR = tempQuest.addItem("Orgrimmar is destroyed")
    call FACTION_DRUIDS.registerObjectLimit(ELEMENTAL_GUARDIAN_ID, 1)
    call FACTION_DRUIDS.registerObjectLimit(RESEARCH_ID, UNLIMITED)
    call FACTION_DRUIDS.addQuest(tempQuest)
  endfunction

endlibrary