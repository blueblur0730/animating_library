#if defined _animating_libarary_cstudiohdr_
	#endinput
#endif
#define _animating_libarary_cstudiohdr_

any	Native_CStudioHdr(Handle plugin, int numParams)
{
	return CreateCStudioHdrOfEntity(GetNativeCell(1));
}

int Native_CStudioHdr_DeleteThis(Handle plugin, int numParams)
{
	SDKCall(g_hSDKCall_ModelSoundCache_FinishModel, view_as<Address>(GetNativeCell(1)));

	return 0;
}

int Native_CStudioHdr_GetNumAttachments(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CStudioHdr object.");

	return SDKCall(g_hSDKCall_CStudioHdr_GetNumAttachments, view_as<Address>(GetNativeCell(1)));
}