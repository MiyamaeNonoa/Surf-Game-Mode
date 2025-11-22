global function SURFMode_Init

global const GAMEMODE_SURF = "surf"

void function SURFMode_Init() {
    AddCallback_OnCustomGamemodesInit( CreateGamemode )
	AddCallback_OnRegisteringCustomNetworkVars( SURFRegisterNetworkVars )
}

void function CreateGamemode() {
    GameMode_Create( GAMEMODE_SURF )
    GameMode_SetName( GAMEMODE_SURF, "#GAMEMODE_SURF" )
    GameMode_SetDesc( GAMEMODE_SURF, "#SURF_DESC" )
    GameMode_SetDefaultTimeLimits( GAMEMODE_SURF, 10, 0.0 )

    // Game statistics
    GameMode_AddScoreboardColumnData( GAMEMODE_SURF, "#SCOREBOARD_TOTAL_RUNS", PGS_PILOT_KILLS, 2)
    GameMode_AddScoreboardColumnData( GAMEMODE_SURF, "#SCOREBOARD_FINISHED_RUNS", PGS_ASSAULT_SCORE, 2)
    //GameMode_AddScoreboardColumnData( GAMEMODE_SURF, "#SCOREBOARD_RESETS", PGS_DEFENSE_SCORE, 2)
    //GameMode_AddScoreboardColumnData( GAMEMODE_SURF, "#SCOREBOARD_TOP_THREE", PGS_TITAN_KILLS, 2 )

	GameMode_SetEvacEnabled( GAMEMODE_SURF, false )
    GameMode_SetGameModeAnnouncement( GAMEMODE_SURF, "gnrc_modeDesc" )

    AddPrivateMatchMode( GAMEMODE_SURF )

    #if SERVER
    GameMode_AddServerInit( GAMEMODE_SURF, _SURF_Init )
    GameMode_SetPilotSpawnpointsRatingFunc( GAMEMODE_SURF, RateSpawnpoints_Generic )
    #elseif CLIENT
    #endif
}

void function SURFRegisterNetworkVars()
{
	if ( GAMETYPE != GAMEMODE_SURF )
		return

     Remote_RegisterFunction("Client_EnableWallrun")
}
