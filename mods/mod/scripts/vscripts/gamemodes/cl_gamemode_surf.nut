
global function Surf_GameMode_NetworkRegistration

// ======================================================================
// Setup Remote functions
// ======================================================================
void function Surf_GameMode_NetworkRegistration()
{
    AddCallback_OnRegisteringCustomNetworkVars( RegisterRemoteFunctions )
}

void function RegisterRemoteFunctions()
{
    Remote_RegisterFunction( "Client_EnableWallrun" )
}

void function Client_EnableWallrun()
{
    ClientCommand("wallrun_enable 1")
}