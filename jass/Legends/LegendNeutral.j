library LegendNeutral initializer OnInit requires Legend

  globals
    Legend LEGEND_RAGNAROS

    Legend LEGEND_AUCHINDOUN
    Legend LEGEND_DRAKTHARONKEEP
    Legend LEGEND_OSHUGUN
    Legend LEGEND_JINTHAALOR
    Legend LEGEND_SHRINEOFULATEK
    Legend LEGEND_SERADANE
    Legend LEGEND_ZULGURUB
    Legend LEGEND_DAZARALOR
    Legend LEGEND_GUNDRAK
    Legend LEGEND_DUSKWOODGRAVEYARD
    Legend LEGEND_GRIMBATOL
    Legend LEGEND_ETHELRETHOR
    Legend LEGEND_NEXUS
    Legend LEGEND_KARAZHAN
    Legend LEGEND_ZULFARRAK
  endglobals

  private function OnInit takes nothing returns nothing
    set LEGEND_RAGNAROS = Legend.create()
    set LEGEND_RAGNAROS.Unit = gg_unit_N00D_1457

    set LEGEND_AUCHINDOUN = Legend.create()
    set LEGEND_AUCHINDOUN.Capturable = true
    set LEGEND_AUCHINDOUN.Unit = gg_unit_h026_1207

    set LEGEND_DRAKTHARONKEEP = Legend.create()
    set LEGEND_DRAKTHARONKEEP.Capturable = true
    set LEGEND_DRAKTHARONKEEP.Unit = gg_unit_o016_0771

    set LEGEND_OSHUGUN = Legend.create()
    set LEGEND_OSHUGUN.Capturable = true
    set LEGEND_OSHUGUN.Unit = gg_unit_h02Z_0726

    set LEGEND_JINTHAALOR = Legend.create()
    set LEGEND_JINTHAALOR.Capturable = true

    set LEGEND_SHRINEOFULATEK = Legend.create()
    set LEGEND_SHRINEOFULATEK.Capturable = true
    set LEGEND_SHRINEOFULATEK.Unit = gg_unit_o00Q_0989

    set LEGEND_SERADANE = Legend.create()
    set LEGEND_SERADANE.Capturable = true
    set LEGEND_SERADANE.Unit = gg_unit_e014_3083

    set LEGEND_ZULGURUB = Legend.create()
    set LEGEND_ZULGURUB.Capturable = true
    set LEGEND_ZULGURUB.Unit = gg_unit_o018_0017

    set LEGEND_DAZARALOR = Legend.create()
    set LEGEND_DAZARALOR.Capturable = true
    set LEGEND_DAZARALOR.Unit = gg_unit_o00V_2194

    set LEGEND_GUNDRAK = Legend.create()
    set LEGEND_GUNDRAK.Capturable = true
    set LEGEND_GUNDRAK.Unit = gg_unit_o00N_0704

    set LEGEND_DUSKWOODGRAVEYARD = Legend.create()
    set LEGEND_DUSKWOODGRAVEYARD.Capturable = true
    set LEGEND_DUSKWOODGRAVEYARD.Unit = gg_unit_h01F_1161

    set LEGEND_GRIMBATOL = Legend.create()
    set LEGEND_GRIMBATOL.Capturable = true
    set LEGEND_GRIMBATOL.Unit = gg_unit_h01Z_0618

    set LEGEND_ETHELRETHOR = Legend.create()
    set LEGEND_ETHELRETHOR.Capturable = true
    set LEGEND_ETHELRETHOR.Unit = gg_unit_h05I_0313

    set LEGEND_NEXUS = Legend.create()
    set LEGEND_NEXUS.Unit = gg_unit_h04P_1732
    set LEGEND_NEXUS.Capturable = true

    set LEGEND_KARAZHAN = Legend.create()
    set LEGEND_KARAZHAN.Unit = gg_unit_h001_0180
    set LEGEND_KARAZHAN.Capturable = true

    set LEGEND_ZULFARRAK = Legend.create()
    set LEGEND_ZULFARRAK.Capturable = true
    set LEGEND_ZULFARRAK.Unit = gg_unit_o00K_0150
  endfunction

endlibrary