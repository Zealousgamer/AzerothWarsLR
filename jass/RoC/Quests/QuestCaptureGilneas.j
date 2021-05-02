library QuestCaptureGilneas requires QuestData, ScourgeSetup, LordaeronSetup, StormwindSetup, QuestItemKillUnit

  struct QuestCaptureGilneas extends QuestData
    private boolean doBlight = false

    private method operator CompletionPopup takes nothing returns string
      return "Gilneas now falls under the dominion of the " + this.Holder.Team.Name + "."
    endmethod

    private method operator CompletionDescription takes nothing returns string
      return "Control of all structures and Control Points in Gilneas and the artifact Scythe of Elune"
    endmethod

    private method OnComplete takes nothing returns nothing
      local group tempGroup = CreateGroup()
      local unit u = null
      call GroupEnumUnitsInRect(tempGroup, gg_rct_Gilneas, null)
      loop
        set u = FirstOfGroup(tempGroup)
        exitwhen u == null

        if GetOwningPlayer(u) == Player(PLAYER_NEUTRAL_AGGRESSIVE) then
          //Set Black Citadel unit skin on town halls
          if IsUnitType(u, UNIT_TYPE_TOWNHALL) == true and this.doBlight then
            call BlzSetUnitSkin(u, 'unp2')
          endif
          //Kill and remove normal units
          if IsUnitType(u, UNIT_TYPE_STRUCTURE) == false and ControlPoint.ByUnitType(GetUnitTypeId(u)) == 0 then
            call KillUnit(u)
            call RemoveUnit(u)
          else
            call SetUnitOwner(u, this.Holder.Player, true)
          endif
          //Replace structures for which the quest owners faction has a structure in the same category
          if UnitType.ById(GetUnitTypeId(u)).UnitCategory != 0 and this.Holder.GetUnitTypeByCategory(UnitType.ById(GetUnitTypeId(u)).UnitCategory) != 0 then
            if this.doBlight then
              call SetBlight(this.Holder.Player, GetUnitX(u), GetUnitY(u), 450, true)
            endif
            call ReplaceUnitBJ(u, this.Holder.GetUnitTypeByCategory(UnitType.ById(GetUnitTypeId(u)).UnitCategory), bj_UNIT_STATE_METHOD_RELATIVE)
          endif
        endif
        call GroupRemoveUnit(tempGroup, u)
      endloop
    endmethod

    public static method create takes string name, string desc, boolean doBlight returns thistype
      local thistype this = thistype.allocate(name, desc, "ReplaceableTextures\\CommandButtons\\BTNDireWolf.blp")
      set this.doBlight = doBlight
      call this.AddQuestItem(QuestItemKillUnit.create(gg_unit_H05B_0308))
      return this
    endmethod
  endstruct

endlibrary