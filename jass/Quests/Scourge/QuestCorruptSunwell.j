library QuestCorruptSunwell initializer OnInit requires ScourgeConfig, LegendQuelthalas

  globals
    private QuestItemData QUESTITEM_CAPTURE
    private constant integer CORRUPTED_SUNWELL_ID = 'n029'
  endglobals

  private function LegendOwnerChanges takes nothing returns nothing
    if GetTriggerLegend() == LEGEND_SUNWELL and FACTION_SCOURGE.Person.p == GetOwningPlayer(LEGEND_SUNWELL.Unit) and FACTION_SCOURGE.getQuestItemProgress(QUESTITEM_CAPTURE) == QUEST_PROGRESS_INCOMPLETE then
      set LEGEND_SUNWELL.UnitType = CORRUPTED_SUNWELL_ID
      call FACTION_SCOURGE.setQuestItemStatus(QUESTITEM_CAPTURE, QUEST_PROGRESS_COMPLETE, true)
    endif
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = CreateTrigger(  )
    local QuestData tempQuest
    set trig = CreateTrigger()
    call OnLegendChangeOwner.register(trig)
    call TriggerAddCondition(trig, Condition(function LegendOwnerChanges))

    set tempQuest = QuestData.create("Fall of Silvermoon", "The Sunwell is the source of the High Elves' immortality and magical prowess. Under control of the Scourge, it would be the source of immense necromantic power.", "The Sunwell has been captured by the Scourge. It now writhes with necromantic energy." , "ReplaceableTextures\\CommandButtons\\BTNOrbOfCorruption.blp")
    set QUESTITEM_CAPTURE = tempQuest.addItem("Capture the Sunwell")
    call FACTION_SCOURGE.addQuest(tempQuest) 
  endfunction

endlibrary