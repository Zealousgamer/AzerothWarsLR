library TierKnowledgeOfHonorHold initializer OnInit requires StormwindConfig

  globals
    private constant integer UNITTYPE_PORTAL = 'n09P'
    private constant real WAYGATE_OFFSET = 100.
  endglobals

  private function EnablePortals takes nothing returns nothing
    local unit waygateA = CreateUnit(FACTION_STORMWIND.Person.p, UNITTYPE_PORTAL, GetDestructableX(gg_dest_B017_11954), GetDestructableY(gg_dest_B017_11954), 0)
    local unit waygateB = CreateUnit(FACTION_STORMWIND.Person.p, UNITTYPE_PORTAL, GetDestructableX(gg_dest_B017_8950), GetDestructableY(gg_dest_B017_8950), 130.80)
    call SetUnitPathing(waygateA, false)
    call SetUnitPathing(waygateB, false)
    call SetUnitPosition(waygateA, GetDestructableX(gg_dest_B017_11954), GetDestructableY(gg_dest_B017_11954))
    call SetUnitPosition(waygateB, GetDestructableX(gg_dest_B017_8950), GetDestructableY(gg_dest_B017_8950))
    call WaygateActivate(waygateA, true)
    call WaygateActivate(waygateB, true)
    call WaygateSetDestination(waygateA, GetPolarOffsetY(GetUnitX(waygateB), WAYGATE_OFFSET, GetUnitFacing(waygateB)), GetPolarOffsetY(GetUnitY(waygateB), WAYGATE_OFFSET, GetUnitFacing(waygateB)))
    call WaygateSetDestination(waygateB, GetPolarOffsetX(GetUnitX(waygateA), WAYGATE_OFFSET, GetUnitFacing(waygateA)), GetPolarOffsetY(GetUnitY(waygateA), WAYGATE_OFFSET, GetUnitFacing(waygateA)))
    call QueueUnitAnimation(waygateA, "birth")
    call QueueUnitAnimation(waygateB, "birth")
    call QueueUnitAnimation(waygateA, "stand")
    call QueueUnitAnimation(waygateB, "stand")
  endfunction

  private function Research takes nothing returns nothing
    if GetResearched() == 'R03W' then
      call FACTION_STORMWIND.modObjectLimit('R03X', UNLIMITED)       //High Sorcerer Andromath
      call FACTION_STORMWIND.modObjectLimit('R03Y', UNLIMITED)       //Katrana Prestor    
      call EnablePortals()
    endif
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_RESEARCH_FINISH  )
    call TriggerAddCondition(trig, Condition(function Research))    
  endfunction

endlibrary