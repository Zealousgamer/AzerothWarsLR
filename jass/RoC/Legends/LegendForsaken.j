library LegendForsaken initializer OnInit requires Legend

  globals
    Legend LEGEND_SYLVANASV
    Legend LEGEND_SCHOLOMANCE
    Legend LEGEND_VARIMATHRAS
  endglobals

  private function OnInit takes nothing returns nothing
    set LEGEND_SYLVANASV = Legend.create()
    set LEGEND_SYLVANASV.UnitType = 'Usyl'

    set LEGEND_VARIMATHRAS = Legend.create()
    set LEGEND_VARIMATHRAS.UnitType = 'Uvar'
    set LEGEND_VARIMATHRAS.PlayerColor = PLAYER_COLOR_RED

    set LEGEND_SCHOLOMANCE = Legend.create()
    set LEGEND_SCHOLOMANCE.Unit = gg_unit_u012_1149
    set LEGEND_SCHOLOMANCE.DeathMessage = "Scholomance, the center of the Scourge's operations in Lordaeron, has been destroyed."
endfunction

endlibrary