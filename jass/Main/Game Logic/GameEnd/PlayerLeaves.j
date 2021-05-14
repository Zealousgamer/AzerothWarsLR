library PlayerLeaves initializer OnInit requires Persons

  private function PlayerLeaves takes nothing returns nothing
    local player p = GetTriggerPlayer()
    local integer pId = GetPlayerId(p)
    local Person triggerPerson = Person.ByHandle(GetTriggerPlayer())

    if triggerPerson != 0 and triggerPerson.Faction != 0 and triggerPerson.Faction.ScoreStatus == SCORESTATUS_NORMAL then
      call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, triggerPerson.Faction.ColoredName + " has left the game.")
      set triggerPerson.Faction.ScoreStatus = SCORESTATUS_DEFEATED
    endif
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = CreateTrigger(  )
    local integer i = 0
    loop
    exitwhen i > 24
      call TriggerRegisterPlayerEvent(trig, Player(i), EVENT_PLAYER_LEAVE)
      set i = i + 1
    endloop
    call TriggerAddCondition( trig, Condition(function PlayerLeaves) )    
  endfunction

endlibrary