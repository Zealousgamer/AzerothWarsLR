library QuestFirstWave requires QuestData, DraeneiSetup

  struct QuestFirstWave extends QuestData

    private method operator CompletionPopup takes nothing returns string
      return "The Draenei have holded long enough and most of their civilisation had time to join the Exodar"
    endmethod

    private method operator CompletionDescription takes nothing returns string
      return "The Divine Citadel, Shipyard, Astral Sanctum and Crystal Spire will not be deleted from Azuremyst"
    endmethod

    private method OnFail takes nothing returns nothing
      call KillUnit(gg_unit_o051_3356)
      call KillUnit(gg_unit_o059_3317)
      call KillUnit(gg_unit_o055_3337)
      call KillUnit(gg_unit_o054_3338)
    endmethod

    public static method create takes nothing returns thistype
      local thistype this = thistype.allocate("The First Wave", "The forest needs healing. Regain control of it to summon it's Guardian, the Demigod Cenarius", "ReplaceableTextures\\CommandButtons\\BTNKeeperC.blp")
      call this.AddQuestItem(QuestItemTime.create(420))
      call this.AddQuestItem(QuestItemLegendAlive.create(LEGEND_EXODARSHIP))
      call this.AddQuestItem(QuestItemSelfExists.create())
      return this
    endmethod
  endstruct

endlibrary