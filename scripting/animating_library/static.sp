#if defined _animating_libarary_static_
	#endinput
#endif
#define _animating_libarary_static_

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

	int Ref	= EntIndexToEntRef(entity);

	Address pStudioHdr = GetModelPtr(view_as<Address>(Ref));
	int flags = SDKCall(g_hSDKCall_GetSequenceFlags, pStudioHdr, iSequence);

	return flags;
}

any Native_ActivityList_RegisterSharedActivity(Handle plugin, int numParams)
{
	int maxlength;
	GetNativeStringLength(1, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(1, name, maxlength);

	int activityIndex = GetNativeCell(2);

	return view_as<bool>(SDKCall(g_hSDKCall_ActivityList_RegisterSharedActivity, name, activityIndex));
}

int Native_ActivityList_RegisterPrivateActivity(Handle plugin, int numParams)
{
	int maxlength;
	GetNativeStringLength(1, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(1, name, maxlength);

	return SDKCall(g_hSDKCall_ActivityList_RegisterPrivateActivity, name);
}

int Native_ActivityList_IndexForName(Handle plugin, int numParams)
{
	int maxlength;
	GetNativeStringLength(1, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(1, name, maxlength);

	return SDKCall(g_hSDKCall_ActivityList_IndexForName, name);
}

any Native_ActivityList_NameForIndex(Handle plugin, int numParams)
{
	int activityIndex = GetNativeCell(1);

	int maxlength;
	GetNativeStringLength(2, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(2, name, maxlength);

	SDKCall(g_hSDKCall_ActivityList_NameForIndex, activityIndex, name, maxlength);
	SetNativeString(2, name, maxlength);

	return 0;
}

int Native_ActivityList_HighestIndex(Handle plugin, int numParams)
{
	if (!ValidateAddress(g_HighestActivity))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid address for g_HighestActivity.");

	return view_as<int>(LoadFromAddress(g_HighestActivity, NumberType_Int8));
}

int Native_FindHitboxSetByName(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);

	if (!HasModel(entity))
		return -1;

	int maxlength;
	GetNativeStringLength(2, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(2, name, maxlength);

	Address pStudioHdr = GetModelPtr(view_as<Address>(SDKCall(g_hSDKCall_GetBaseAnimating, entity)));
	int		hitboxSet  = SDKCall(g_hSDKCall_FindHitboxSetByName, pStudioHdr, name);

	return hitboxSet;
}