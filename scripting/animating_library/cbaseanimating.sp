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

int Native_GetBodyGroupProperty(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int entity = EntRefToEntIndex(GetNativeCell(1));
	return GetEntProp(entity, Prop_Send, "m_nBody");
}

int Native_SetBodyGroupProperty(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");
	
	int entity = EntRefToEntIndex(GetNativeCell(1));
	int value = GetNativeCell(2);

	SetEntProp(entity, Prop_Send, "m_nBody", value);

	return 0;
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
	int iPart  = GetNativeCell(3);

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

	int iGroup	 = GetNativeCell(2);
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

any Native_GetCycle(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int entity = EntRefToEntIndex(GetNativeCell(1));
	return GetEntPropFloat(entity, Prop_Send, "m_flCycle");
}

int Native_SetCycle(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	float flCycle = GetNativeCell(2);
	int entity = EntRefToEntIndex(GetNativeCell(1));
	SetEntPropFloat(entity, Prop_Send, "m_flCycle", flCycle);

	return 0;
}

any Native_GetPlaybackRate(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int entity = EntRefToEntIndex(GetNativeCell(1));
	return GetEntPropFloat(entity, Prop_Send, "m_flPlaybackRate");
}

int Native_SetPlaybackRate(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	float flPlaybackRate = GetNativeCell(2);
	int entity = EntRefToEntIndex(GetNativeCell(1));
	SetEntPropFloat(entity, Prop_Send, "m_flPlaybackRate", flPlaybackRate);

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

	int	  iSequence = GetNativeCell(2);
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

	int	  iSequence = GetNativeCell(2);

	float vec[3];
	SDKCall(g_hSDKCall_GetSequenceLinearMotion, GetNativeCell(1), iSequence, vec);

	return GetVectorLength(vec);
}

any Native_GetSequenceMovement(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int	  iSequence = GetNativeCell(2);
	float fromCycle = GetNativeCell(3);
	float toCycle	= GetNativeCell(4);

	float deltaVector[3];
	float deltaAngles[3];

	bool  bFound = view_as<bool>(SDKCall(g_hSDKCall_GetSequenceMovement, GetNativeCell(1), iSequence, fromCycle, toCycle, deltaVector, deltaAngles));
	SetNativeArray(5, deltaVector, sizeof(deltaVector));
	SetNativeArray(6, deltaAngles, sizeof(deltaAngles));

	return bFound;
}

any Native_SequenceDuration(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int		iSequence  = GetNativeCell(2);
	int		entity	   = EntRefToEntIndex(GetNativeCell(1));

	Address pStudioHdr = GetEntityCStudioHdr(entity);
	float	flDuration = SDKCall(g_hSDKCall_SequenceDuration, GetNativeCell(1), pStudioHdr, iSequence);
	SDKCall(g_hSDKCall_ModelSoundCache_FinishModel, pStudioHdr);
	return flDuration;
}

any Native_GetSequenceCycleRate(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int		iSequence  = GetNativeCell(2);
	int		entity	   = EntRefToEntIndex(GetNativeCell(1));

	Address pStudioHdr = GetEntityCStudioHdr(entity);
	float	flDuration = SDKCall(g_hSDKCall_SequenceDuration, GetNativeCell(1), pStudioHdr, iSequence);
	SDKCall(g_hSDKCall_ModelSoundCache_FinishModel, pStudioHdr);

	if (flDuration > 0.0)
		return 1.0 / flDuration;

	return 10.0;	// 1.0f / 0.1f;
}

any Native_LastVisibleCycle(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int		iSequence  = GetNativeCell(2);
	int		entity	   = EntRefToEntIndex(GetNativeCell(1));

	Address pStudioHdr = GetEntityCStudioHdr(entity);
	float flCycle = SDKCall(g_hSDKCall_LastVisibleCycle, GetNativeCell(1), pStudioHdr, iSequence);
	SDKCall(g_hSDKCall_ModelSoundCache_FinishModel, pStudioHdr);

	return flCycle;
}

any Native_GetSequenceGroundSpeed(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int		iSequence  = GetNativeCell(2);
	int		entity	   = EntRefToEntIndex(GetNativeCell(1));

	Address pStudioHdr = GetEntityCStudioHdr(entity);
	float	flDuration = SDKCall(g_hSDKCall_SequenceDuration, GetNativeCell(1), pStudioHdr, iSequence);
	SDKCall(g_hSDKCall_ModelSoundCache_FinishModel, pStudioHdr);

	float vec[3];
	SDKCall(g_hSDKCall_GetSequenceLinearMotion, GetNativeCell(1), iSequence, vec);
	float flMoveDist = GetVectorLength(vec);

	if (flDuration > 0.0)
		return flMoveDist / flDuration;

	return 0.0;	   // 0
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

any Native_IsSequenceLooping(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int entity	  = EntRefToEntIndex(GetNativeCell(1));
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

	Address pStudioHdr = GetEntityCStudioHdr(entity);
	int		flags	   = SDKCall(g_hSDKCall_GetSequenceFlags, pStudioHdr, iSequence);
	SDKCall(g_hSDKCall_ModelSoundCache_FinishModel, pStudioHdr);

	return (flags & 1) != 0;	// STUDIO_LOOPING
}

int Native_ResetSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	SDKCall(g_hSDKCall_ResetSequence, GetNativeCell(1), iSequence);

	return 0;
}

int Native_ResetSequenceInfo(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	SDKCall(g_hSDKCall_ResetSequenceInfo, GetNativeCell(1));
	return 0;
}

int Native_FindTransitionSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iCurrentSequence = GetNativeCell(2);
	int iGoalSequence	 = GetNativeCell(3);
	int piDir			 = 0;	// passing null.

	return SDKCall(g_hSDKCall_FindTransitionSequence, GetNativeCell(1), iCurrentSequence, iGoalSequence, piDir);
}

any Native_GoToSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	float flCurrentCycle = GetNativeCell(3);
	float flCurrentRate = GetNativeCell(4);
	int iGoalSequence = GetNativeCell(5);
	int nNextSequence = GetNativeCellRef(6);
	float flNextCycle = GetNativeCellRef(7);
	float iNextDir = GetNativeCellRef(8);

	bool bFound = view_as<bool>(SDKCall(g_hSDKCall_GoToSequence, GetNativeCell(1), iSequence, flCurrentCycle, flCurrentRate, iGoalSequence, nNextSequence, flNextCycle, iNextDir));

	SetNativeCellRef(6, nNextSequence);
	SetNativeCellRef(7, flNextCycle);
	SetNativeCellRef(8, iNextDir);

	return bFound;
}

int Native_SelectWeightedSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iActivity = GetNativeCell(2);

	return SDKCall(g_hSDKCall_SelectWeightedSequence, GetNativeCell(1), iActivity);
}

any Native_GetModelScale(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int entity = EntRefToEntIndex(GetNativeCell(1));
	return GetEntPropFloat(entity, Prop_Send, "m_flModelScale");
}

int Native_SetModelScale(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	float scale = GetNativeCell(2);
	SDKCall(g_hSDKCall_SetModelScale, GetNativeCell(1), scale, 0.0);

	return 0;
}

int Native_SetModel(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int maxlength;
	GetNativeStringLength(2, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(2, name, maxlength + 1);

	SDKCall(g_hSDKCall_SetModel, GetNativeCell(1), name);

	return 0;
}