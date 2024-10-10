#if defined _animating_libarary_animation_
	#endinput
#endif
#define _animating_libarary_animation_

int Native_GetSequenceFlags(Handle plugin, int numParams)
{
	int entity	  = GetNativeCell(1);
	int iSequence = GetNativeCell(2);

	if (!IsValidEntity(entity))
	{
		ThrowNativeError(SP_ERROR_PARAM, "Invalid entity index.");
		return 0;
	}

	if (!HasModel(entity))
	{
		ThrowNativeError(SP_ERROR_PARAM, "Entity has no model.");
		return 0;
	}

	int Ref = EntIndexToEntRef(entity);

	Address pStudioHdr = GetModelPtr(view_as<Address>(Ref));
	int		flags	   = SDKCall(g_hSDKCall_GetSequenceFlags, pStudioHdr, iSequence);

	return flags;
}