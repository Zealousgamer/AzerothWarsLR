library QuestFrozenThrone requires QuestData, GeneralHelpers

  struct QuestFrozenThrone extends QuestData

    method operator Global takes nothing returns boolean
      return true
    endmethod
    private method operator CompletionPopup takes nothing returns string
      return "As a reward for his mission, Illidan and his followers have been welcomed into the ranks of the Burning Legion"
    endmethod

    private method operator CompletionDescription takes nothing returns string
      return "The Illidari team will join the Burning Legion in their team"
    endmethod

    private method OnComplete takes nothing returns nothing 
      local integer i = 0
      local Faction loopFaction
      loop
        exitwhen i == TEAM_NAGA.PlayerCount
        set loopFaction = TEAM_NAGA.GetFactionByIndex(i)
        set loopFaction.Team = TEAM_LEGION
        set i = i + 1
      endloop
      if FACTION_QUELTHALAS.Team == TEAM_LEGION then
        set SUMMON_KIL.Progress = QUEST_PROGRESS_INCOMPLETE
        set GREAT_TREACHERY.Progress = QUEST_PROGRESS_FAILED
        set STAY_LOYAL.Progress = QUEST_PROGRESS_FAILED
        call UnitRemoveAbilityBJ( 'A0IK', LEGEND_KAEL.Unit)
        call UnitRemoveAbilityBJ( 'A0IF', LEGEND_KAEL.Unit)
        call UnitAddAbility(LEGEND_KAEL.Unit, 'A0R7')
      endif
    endmethod

    public static method create takes nothing returns thistype
      local thistype this = thistype.allocate("A Symphony of Frost and Flame", "Kil'jaeden has ordered Illidan to destroy the Frozen Throne, and he shall obey", "ReplaceableTextures\\CommandButtons\\BTNMetamorphosis.blp")
      call this.AddQuestItem(QuestItemKillUnit.create(LEGEND_LICHKING.Unit))
      call this.AddQuestItem(QuestItemResearch.create('R063', 'n055'))
      return this
    endmethod
  endstruct

endlibrary