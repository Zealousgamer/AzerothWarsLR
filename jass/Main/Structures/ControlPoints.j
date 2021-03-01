library ControlPoint initializer OnInit requires AIDS

  //*CONFIG*
  globals
    private constant integer    CP_BUFF_A = 'B025'
    private constant integer    CP_BUFF_B = 'B050'
    private constant integer    CP_BUFF_C = 'B051'
    private constant integer    CP_BUFF_D = 'B052'
    private constant integer    CP_BUFF_E = 'B053'
    private constant integer    CP_BUFF_F = 'B054'
    
    private constant real       CP_VALUE_A = 10
    private constant real       CP_VALUE_B = 15
    private constant real       CP_VALUE_C = 20
    private constant real       CP_VALUE_D = 25
    private constant real       CP_VALUE_E = 30
    private constant real       CP_VALUE_F = 50

    Event OnControlPointLoss    
    Event OnControlPointOwnerChange    
  endglobals
  //*ENDCONFIG*

  globals 
    group ControlPoints = CreateGroup()
    ControlPoint array CPData
  endglobals
  
  struct ControlPoint
    private static thistype array byIndex
    private static Table byUnitType
    private static Table byHandle
    private static integer count = 0
    static thistype triggerControlPoint = 0

    static boolean initialized = false
    static integer array cpBuffs[6]
    static real array cpValues[6]
    
    real x
    real y
    real value = 0
    unit u
    player owner

    method operator UnitType takes nothing returns integer
      return GetUnitTypeId(this.u)
    endmethod

    method operator Name takes nothing returns string
      return GetUnitName(this.u)
    endmethod

    method operator X takes nothing returns real
      return GetUnitX(this.u)
    endmethod

    method operator Y takes nothing returns real
      return GetUnitY(this.u)
    endmethod

    method operator Unit takes nothing returns unit
      return this.u
    endmethod

    method operator OwningPerson takes nothing returns Person
      return Person.ByHandle(this.owner)
    endmethod

    method changeOwner takes player p returns nothing
      local Person person = Person.ByHandle(this.owner)
  
      if person != 0 then
        set person.ControlPointValue = person.ControlPointValue - value
        set person.ControlPointCount = person.ControlPointCount - 1
        call GroupRemoveUnit(person.cpGroup, this.u)
      endif
  
      set thistype.triggerControlPoint = this
      call OnControlPointLoss.fire()

      set this.owner = p
      set person = Person.ByHandle(this.owner)
      
      if person != 0 then
        set person.ControlPointValue = person.ControlPointValue + value
        set person.ControlPointCount = person.ControlPointCount + 1
        call GroupAddUnit(person.cpGroup, this.u)
      endif

      set thistype.triggerControlPoint = this
      call OnControlPointOwnerChange.fire()
    endmethod
    
    static method ByHandle takes unit whichUnit returns thistype
      return thistype.byHandle[GetHandleId(whichUnit)]
    endmethod

    static method ByUnitType takes integer unitType returns thistype
      return thistype.byUnitType[unitType]
    endmethod

    static method GetHighestValueCP takes Person person returns thistype
      local integer i = 0
      local ControlPoint highestValueCP = 0
      loop
      exitwhen i == thistype.count
        if thistype.byIndex[i].OwningPerson == person and thistype.byIndex[i].value > highestValueCP.value then
          set highestValueCP = thistype.byIndex[i]
        endif
        set i = i + 1
      endloop
      return highestValueCP
    endmethod

    static method initializeCP takes nothing returns nothing
      local unit u = GetEnumUnit()
      local integer i = 0
      loop
      exitwhen i > 5
        if GetUnitAbilityLevel(GetEnumUnit(), cpBuffs[i]) > 0 then
          call ControlPoint.create(GetEnumUnit(), cpValues[i])
        endif
      set i = i + 1
      endloop   
    endmethod
    
    static method initializeSystem takes nothing returns nothing  
      local group g          
      set cpBuffs[0] = CP_BUFF_A
      set cpBuffs[1] = CP_BUFF_B
      set cpBuffs[2] = CP_BUFF_C
      set cpBuffs[3] = CP_BUFF_D
      set cpBuffs[4] = CP_BUFF_E
      set cpBuffs[5] = CP_BUFF_F
      
      set cpValues[0] = CP_VALUE_A
      set cpValues[1] = CP_VALUE_B   
      set cpValues[2] = CP_VALUE_C   
      set cpValues[3] = CP_VALUE_D  
      set cpValues[4] = CP_VALUE_E      
      set cpValues[5] = CP_VALUE_F
      
      set g = CreateGroup()
      call GroupEnumUnitsInRect(g, bj_mapInitialPlayableArea, null)
      call ForGroup(g, function ControlPoint.initializeCP)    
      
      set initialized = true           
    endmethod

    static method create takes unit u, real value returns ControlPoint
      local ControlPoint this = ControlPoint.allocate()
      local Person person = Person.ByHandle(GetOwningPlayer(u))
      
      set this.x = GetUnitX(u)
      set this.y = GetUnitY(u)
      set this.u = u
      set this.owner = GetOwningPlayer(u)
      set this.value = value
      
      set CPData[GetUnitId(u)] = this 
      
      call GroupAddUnit(ControlPoints,u)
      call GroupAddUnit(person.cpGroup, u)

      set OwningPerson.ControlPointValue = OwningPerson.ControlPointValue + this.value
      set OwningPerson.ControlPointCount = OwningPerson.ControlPointCount + 1

      set thistype.byUnitType[GetUnitTypeId(u)] = this
      set thistype.byHandle[GetHandleId(u)] = this
      set thistype.byIndex[thistype.count] = this
      set thistype.count = count + 1
      
      return this           
    endmethod        
    
    private static method onInit takes nothing returns nothing
      set thistype.byUnitType = Table.create()
      set thistype.byHandle = Table.create()
    endmethod

    method destroy takes nothing returns nothing
      call RemoveUnit(this.u)
      set OwningPerson.ControlPointValue = OwningPerson.ControlPointValue - this.value*-1
      set OwningPerson.ControlPointCount = OwningPerson.ControlPointCount - 1
      call this.deallocate()
    endmethod  
  endstruct

  function GetTriggerControlPoint takes nothing returns ControlPoint
    return ControlPoint.triggerControlPoint
  endfunction

  //Only provides an event response; internal logic is handled by ControlPoint struct    
  private function CPChangesOwner takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local integer ui = GetUnitUserData(u)
    local player p = GetTriggerPlayer()
    
    if CPData[ui] != 0 then
      call CPData[ui].changeOwner(p)
    endif

    set u = null
    set p = null
  endfunction
  
  //Note that the Init function currently enumerates across every single unit on the map, then checks them for a Control Point buff before initializing them as a CP
  //This is not a good way to do this, considering that we know which units are CPs before the map is even compiled
  private function OnInit takes nothing returns nothing
    local group g
    local trigger trig = CreateTrigger()
    
    call TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_CHANGE_OWNER)
    call TriggerAddCondition(trig, Condition(function CPChangesOwner))
    
    set OnControlPointLoss = Event.create()
    set OnControlPointOwnerChange = Event.create()

    call ControlPoint.initializeSystem()
  endfunction
    
endlibrary
