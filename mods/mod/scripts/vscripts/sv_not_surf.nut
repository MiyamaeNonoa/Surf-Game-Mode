#if SERVER
global function Check_Map_For_Surf

void function Check_Map_For_Surf() {
    string mapName = GetMapName()
    if ( mapName.find("surf") == null  )
    {
        thread Set_Wallrun_On()
    }
}

void function Set_Wallrun_On() {
    wait(1)
    ServerCommand("wallrun_enable 1");
}

#endif