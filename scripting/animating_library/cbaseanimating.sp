#if defined _animating_libarary_cbaseanimating_
    #endinput
#endif
#define _animating_libarary_cbaseanimating_

any Native_CBaseAnimating(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);
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

	return view_as<Address>(SDKCall(g_hSDKCall_GetBaseAnimating, entity));
}

int Native_FindBodyGroupByName(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int maxlength;
	GetNativeStringLength(2, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(2, name, maxlength);

	return SDKCall(g_hSDKCall_FindBodyGroupByName, GetNativeCell(1), name);
}

int Native_SetBodyGroup(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);
	int iValue = GetNativeCell(3);

	if (iValue != 0 && iValue != 1)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid value for iValue.");

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	SDKCall(g_hSDKCall_SetBodyGroup, GetNativeCell(1), iGroup, iValue);

	return 0;
}

int Native_GetBodyGroup(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	return SDKCall(g_hSDKCall_GetBodyGroup, GetNativeCell(1), iGroup);
}

int Native_GetBodyGroupCount(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	return SDKCall(g_hSDKCall_GetBodyGroupCount, GetNativeCell(1), iGroup);
}

int Native_GetBodyGroupName(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	int maxlength;
	GetNativeStringLength(3, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(3, name, maxlength + 1);

	SDKCall(g_hSDKCall_GetBodyGroupName, GetNativeCell(1), iGroup, name, maxlength);
	SetNativeString(3, name, maxlength);

	return 0;
}

int Native_GetBodyGroupPartName(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);
	int iPart = GetNativeCell(3);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	int maxlength;
	GetNativeStringLength(4, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(4, name, maxlength + 1);

	SDKCall(g_hSDKCall_GetBodyGroupPartName, GetNativeCell(1), iGroup, iPart, name, maxlength);
	SetNativeString(4, name, maxlength);

	return 0;
}

int Native_GetNumBodyGroups(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	return SDKCall(g_hSDKCall_GetNumBodyGroups, GetNativeCell(1));
}

int Native_FindBodyGroupVariant(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);
	int iVariant = GetNativeCell(3);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	return SDKCall(g_hSDKCall_FindBodyGroupVariant, GetNativeCell(1), iGroup, iVariant);
}

int Native_CountBodyGroupVarirant(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	return SDKCall(g_hSDKCall_CountBodyGroupVariant, GetNativeCell(1), iGroup);
}

any Native_IsRagdoll(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int entity = EntRefToEntIndex(GetNativeCell(1));
	return view_as<bool>((view_as<RenderFx>(GetEntProp(entity, Prop_Send, "m_nRenderFX", 1)) == RENDERFX_RAGDOLL));
}

any Native_CanBecomeRagdoll(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	return SDKCall(g_hSDKCall_CanBecomeRagdoll, GetNativeCell(1));
}

any Native_BecomeRagdollOnClient(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	float force[3];
	GetNativeArray(2, force, sizeof(force));

	return SDKCall(g_hSDKCall_BecomeRagdollOnClient, GetNativeCell(1), force);
}

int Native_GetSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int entity = EntRefToEntIndex(GetNativeCell(1));
	return GetEntProp(entity, Prop_Send, "m_nSequence");
}

int Native_SetSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	SDKCall(g_hSDKCall_SetSequence, GetNativeCell(1), iSequence);

	return 0;
}

int Native_GetSequenceName(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);

	int maxlength;
	GetNativeStringLength(3, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(3, name, maxlength + 1);

	SDKCall(g_hSDKCall_GetSequenceName, GetNativeCell(1), iSequence, name, maxlength);
	SetNativeString(3, name, maxlength);

	return 0;
}

int Native_GetSequenceActivity(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);

	return SDKCall(g_hSDKCall_GetSequenceActivity, GetNativeCell(1), iSequence);
}

int Native_GetSequenceActivityName(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);

	int maxlength;
	GetNativeStringLength(3, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(3, name, maxlength + 1);

	SDKCall(g_hSDKCall_GetSequenceActivityName, GetNativeCell(1), iSequence, name, maxlength);
	SetNativeString(3, name, maxlength);

	return 0;
}

any Native_GetSequenceKeyValues(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return view_as<Address>(SDKCall(g_hSDKCall_GetSequenceKeyValues, GetNativeCell(1), iSequence));
}

int Native_GetSequenceLinearMotion(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	float vec[3];

	SDKCall(g_hSDKCall_GetSequenceLinearMotion, GetNativeCell(1), iSequence, vec);
	SetNativeArray(3, vec, sizeof(vec));
	return 0;
}

any Native_GetSequenceMoveYaw(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return SDKCall(g_hSDKCall_GetSequenceMoveYaw, GetNativeCell(1), iSequence);
}

any Native_GetSequenceMoveDist(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);

	float vec[3];
	SDKCall(g_hSDKCall_GetSequenceLinearMotion, GetNativeCell(1), iSequence, vec);
	
	return GetVectorLength(vec);
}

any Native_GetSequenceMovement(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	float fromCycle = GetNativeCell(3);
	float toCycle = GetNativeCell(4);
	
	float deltaVector[3];
	float deltaAngles[3];

	bool bFound = view_as<bool>(SDKCall(g_hSDKCall_GetSequenceMovement, GetNativeCell(1), iSequence, fromCycle, toCycle, deltaVector, deltaAngles));
	SetNativeArray(5, deltaVector, sizeof(deltaVector));
	SetNativeArray(6, deltaAngles, sizeof(deltaAngles));

	return bFound;
}

any Native_SequenceDuration(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	int entity = EntRefToEntIndex(GetNativeCell(1));

	Address pStudioHdr = GetEntityCStudioHdr(entity);
	float flDuration = SDKCall(g_hSDKCall_SequenceDuration, GetNativeCell(1), pStudioHdr, iSequence);
	SDKCall(g_hSDKCall_ModelSoundCache_FinishModel, pStudioHdr);
	return flDuration;
}

any Native_GetSequenceCycleRate(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	int entity = EntRefToEntIndex(GetNativeCell(1));

	Address pStudioHdr = GetEntityCStudioHdr(entity);
	float flDuration = SDKCall(g_hSDKCall_SequenceDuration, GetNativeCell(1), pStudioHdr, iSequence);
	SDKCall(g_hSDKCall_ModelSoundCache_FinishModel, pStudioHdr);

	if (flDuration > 0.0) 
		return 1.0 / flDuration;

	return 10.0;	// 1.0f / 0.1f;
}

any Native_GetSequenceGroundSpeed(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	int entity = EntRefToEntIndex(GetNativeCell(1));

	Address pStudioHdr = GetEntityCStudioHdr(entity);
	float flDuration = SDKCall(g_hSDKCall_SequenceDuration, GetNativeCell(1), pStudioHdr, iSequence);
	SDKCall(g_hSDKCall_ModelSoundCache_FinishModel, pStudioHdr);

	float vec[3];
	SDKCall(g_hSDKCall_GetSequenceLinearMotion, GetNativeCell(1), iSequence, vec);
	float flMoveDist = GetVectorLength(vec);

	if (flDuration > 0.0)
		return flMoveDist / flDuration;

	return 0.0;	// 0
}

int Native_LookupSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int maxlength;
	GetNativeStringLength(2, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(2, name, maxlength + 1);

	return SDKCall(g_hSDKCall_LookupSequence, GetNativeCell(1), name);
}

any Native_IsValidSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return SDKCall(g_hSDKCall_IsValidSequence, GetNativeCell(1), iSequence);
}

any Native_IsSequenceFinished(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int entity = EntRefToEntIndex(GetNativeCell(1));
	return view_as<bool>(GetEntProp(entity, Prop_Send, "m_bSequenceFinished"));
}