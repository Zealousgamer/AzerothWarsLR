library WarsongSetup requires Faction, TeamSetup
  globals
    LiegeFaction FACTION_WARSONG
  endglobals

  public function OnInit takes nothing returns nothing
    local Faction f

    set FACTION_WARSONG = LiegeFaction.create("Warsong", PLAYER_COLOR_ORANGE, "|c00ff8000","ReplaceableTextures\\CommandButtons\\BTNHellScream.blp", 3)
    set f = FACTION_WARSONG
    set f.VictoryMusic = "OrcVictory"
    set f.Team = TEAM_HORDE
    set f.PresenceResearch = 'R05W'

    call f.registerObjectLimit('o00C', UNLIMITED)   //Great Hall
    call f.registerObjectLimit('o02R', UNLIMITED)   //Stronghold
    call f.registerObjectLimit('o02S', UNLIMITED)   //Fortress
    call f.registerObjectLimit('o020', UNLIMITED)   //Altar of Storms
    call f.registerObjectLimit('o01S', UNLIMITED)   //Barracks
    call f.registerObjectLimit('o009', UNLIMITED)   //War Mill
    call f.registerObjectLimit('o006', UNLIMITED)   //Ogre Barrack
    call f.registerObjectLimit('o02Q', UNLIMITED)   //Bestiary
    call f.registerObjectLimit('o028', UNLIMITED)   //Orc Burrow
    call f.registerObjectLimit('n03E', UNLIMITED)   //Watch Tower
    call f.registerObjectLimit('n0AL', UNLIMITED)   //Improved Watch Tower
    call f.registerObjectLimit('o01T', UNLIMITED)   //Goblin Hardware Shop
    call f.registerObjectLimit('o02T', UNLIMITED)   //Shipyard
    call f.registerObjectLimit('o01M', UNLIMITED)   //Goblin Laboratory

    call f.registerObjectLimit('opeo', UNLIMITED)   //Peon
    call f.registerObjectLimit('ogru', UNLIMITED)   //Grunt
    call f.registerObjectLimit('orai', UNLIMITED)   //Raider
    call f.registerObjectLimit('nw2w', -UNLIMITED)  //Orc Warlock
    call f.registerObjectLimit('n08E', UNLIMITED)   //Hexbinder
    call f.registerObjectLimit('nftk', 12)          //Darkspear Warlord
    call f.registerObjectLimit('otbk', UNLIMITED)   //Troll Berseker
    call f.registerObjectLimit('nogo', UNLIMITED)   //Stonemaul SOldier
    call f.registerObjectLimit('nogn', UNLIMITED)   //Stonemaul Ogre Magi
    call f.registerObjectLimit('o00I', 6)           //Horde War Machine
    call f.registerObjectLimit('n061', 12)          //Goblin Sapper
    call f.registerObjectLimit('n062', 8)           //Goblin Shredder
    call f.registerObjectLimit('obot', UNLIMITED)   //Transport Ship
    call f.registerObjectLimit('odes', UNLIMITED)   //Orc Frigate
    call f.registerObjectLimit('ojgn', 12)          //Juggernaught
    call f.registerObjectLimit('o00G', 6)           //Blademaster
    call f.registerObjectLimit('n03F', 6)           //Ogre Lord

    call f.registerObjectLimit('o01R', 1)           //Nazgrel
    call f.registerObjectLimit('h04E', 1)           //Chen

    call f.registerObjectLimit('Robs', UNLIMITED)   //Berserker Strength
    call f.registerObjectLimit('Rotr', UNLIMITED)   //Troll Regeneration
    call f.registerObjectLimit('R023', UNLIMITED)   //Spiritual Infusion
    call f.registerObjectLimit('R01J', UNLIMITED)   //Ensnare
    call f.registerObjectLimit('R02I', UNLIMITED)   //Ogre Magi Adept Training
    call f.registerObjectLimit('R03Q', UNLIMITED)   //Warlock Adept Training
    call f.registerObjectLimit('Rorb', UNLIMITED)   //Reinforced Defenses
    call f.registerObjectLimit('Rosp', UNLIMITED)   //Spiked Barricades
    call f.registerObjectLimit('R015', UNLIMITED)   //Spell Resistance
    call f.registerObjectLimit('R016', UNLIMITED)   //Warlords
    call f.registerObjectLimit('R019', UNLIMITED)   //Improved Shockwave
  endfunction

endlibrary