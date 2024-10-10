#if defined _animating_libarary_cstudiohdr_
	#endinput
#endif
#define _animating_libarary_cstudiohdr_

any	Native_CStudioHdr(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);
	return CreateCStudioHdrOfEntity(entity);
}

int Native_CStudioHdr_DeleteThis(Handle plugin, int numParams)
{
	Address pStudioHdr = view_as<Address>(GetNativeCell(1));
	SDKCall(g_hSDKCall_ModelSoundCache_FinishModel, pStudioHdr);

	return 0;
}