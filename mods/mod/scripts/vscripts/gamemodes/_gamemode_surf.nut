untyped
#if SERVER
global function _SURF_Init

global function SURF_OnPlayerConnected


void function _SURF_Init() {
	ClassicMP_SetCustomIntro( ClassicMP_DefaultNoIntro_Setup, 10 )
	ClassicMP_ForceDisableEpilogue( true )
	SetLoadoutGracePeriodEnabled( false )
	SetTimeoutWinnerDecisionFunc( SurfDecideWinner )


	// Disable titans and boosts
	Riff_ForceTitanAvailability( eTitanAvailability.Never )
	Riff_ForceBoostAvailability( eBoostAvailability.Disabled )

	// Turn Off wallruning
	ServerCommand("wallrun_enable 0\n");

    // Add callbacks
	AddCallback_OnClientConnected( SURF_OnPlayerConnected )
	AddCallback_OnPlayerRespawned( SURF_OnPlayerRespawned)
}


void function SURF_OnPlayerConnected(entity player)
{

	// Put all players in the same team
	SetTeam( player, TEAM_IMC )

	EntFireByHandle( player, "AddOutput", "airacceleration 9000", 0.0, null, null )

	thread disarm_player(player)
}

void function SURF_OnPlayerRespawned(entity player) {
	EntFireByHandle( player, "AddOutput", "airacceleration 9000", 0.0, null, null )

	thread disarm_player(player)
}

int function SurfDecideWinner()
{
	return TEAM_IMC //TEAM_MILITIA
}

void function disarm_player(entity player) {
    if (!IsAlive(player) || player == null)
    {
        return
    }

    // Remove all Main Weapons (Primary, Secondary, and Anti-Titan weapons)
    foreach ( entity weapon in player.GetMainWeapons() )
    {
        player.TakeWeaponNow( weapon.GetWeaponClassName() )
    }

    // Remove all Offhand Weapons (Tactical Ability and Grenade)
    foreach ( entity weapon in player.GetOffhandWeapons() )
    {
        player.TakeWeaponNow( weapon.GetWeaponClassName() )
    }

    // Puts player into "unarmed" state
    if (player.GetActiveWeapon() != null)
    {
        player.ClearActiveWeapon()
    }
    
	WaitFrame()
	ClearDroppedWeapons()
    //print( "Player " + player.GetPlayerName() + " has been completely stripped of weapons, abilities, and grenades." )
}
    #endif