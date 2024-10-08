#if defined _animating_libarary_cstudiohdr_
	#endinput
#endif
#define _animating_libarary_cstudiohdr_

any	Native_CStudioHdr(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);
	return GetEntityCStudioHdr(entity);
}

int Native_CStudioHdr_DeleteThis(Handle plugin, int numParams)
{
	Address pStudioHdrAdr = GetNativeCell(1);
	SDKCall(g_hSDKCall_ModelSoundCache_FinishModel, pStudioHdrAdr);

	return 0;
}

// Big thanks to LuqS
// https://forums.alliedmods.net/showthread.php?t=333857
Address GetEntityCStudioHdr(int entity)
{
	if (!IsValidEntity(entity))
		return Address_Null;

	char sModel[PLATFORM_MAX_PATH];
	GetEntPropString(entity, Prop_Data, "m_ModelName", sModel, sizeof(sModel));

	if (!sModel[0])
		return Address_Null;

	// Create a new CStudioHdr instance based on the model path.
	return view_as<Address>(SDKCall(g_hSDKCall_ModelSoundCache_LoadModel, sModel));
}