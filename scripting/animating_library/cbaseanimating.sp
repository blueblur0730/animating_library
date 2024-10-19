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
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int entity = EntRefToEntIndex(GetNativeCell(1));
	return GetEntProp(entity, Prop_Send, "m_nBody");
}

int Native_SetBodyGroupProperty(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");
	
	int entity = EntRefToEntIndex(GetNativeCell(1));
	int value = GetNativeCell(2);

	SetEntProp(entity, Prop_Send, "m_nBody", value);

	return 0;
}

int Native_FindBodyGroupByName(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

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
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);
	int iValue = GetNativeCell(3);

	if (iValue != 0 && iValue != 1)
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid value for iValue.");

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid iGroup. Starting from 0.");

	SDKCall(g_hSDKCall_SetBodyGroup, GetNativeCell(1), iGroup, iValue);

	return 0;
}

int Native_GetBodyGroup(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid iGroup. Starting from 0.");

	return SDKCall(g_hSDKCall_GetBodyGroup, GetNativeCell(1), iGroup);
}

int Native_GetBodyGroupCount(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid iGroup. Starting from 0.");

	return SDKCall(g_hSDKCall_GetBodyGroupCount, GetNativeCell(1), iGroup);
}

int Native_GetBodyGroupName(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid iGroup. Starting from 0.");

	int maxlength;
	GetNativeStringLength(3, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(3, name, maxlength);

	switch (g_iOS)
	{
		case OS_Windows:
		{
			// calling GetBodygroupName(CStudioHdr *a1, int a2)
			Address pStudioHdr = GetModelPtr(view_as<Address>(GetNativeCell(1)));
			SDKCall(g_hSDKCall_GetBodyGroupName, pStudioHdr, name, maxlength, iGroup);
		}

		case OS_Linux:
		{
			// calling CBaseAnimating::GetBodygroupName(CBaseAnimating *this, int a2)
			SDKCall(g_hSDKCall_GetBodyGroupName, GetNativeCell(1), name, maxlength, iGroup);	// third param must be string, fouth must be size.
		}

		case OS_Unknown:
		{
			ThrowNativeError(SP_ERROR_ABORTED, "Faild to retrieve operating system offsets when calling function.");
		}
	}

	SetNativeString(3, name, maxlength);

	return 0;
}

int Native_GetBodyGroupPartName(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);
	int iPart  = GetNativeCell(3);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid iGroup. Starting from 0.");

	int maxlength;
	GetNativeStringLength(4, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(4, name, maxlength + 1);

	SDKCall(g_hSDKCall_GetBodyGroupPartName, GetNativeCell(1), name, maxlength, iGroup, iPart);
	SetNativeString(4, name, maxlength);

	return 0;
}

int Native_GetNumBodyGroups(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	return SDKCall(g_hSDKCall_GetNumBodyGroups, GetNativeCell(1));
}

int Native_FindBodyGroupVariant(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iGroup	 = GetNativeCell(2);
	int iVariant = GetNativeCell(3);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid iGroup. Starting from 0.");

	return SDKCall(g_hSDKCall_FindBodyGroupVariant, GetNativeCell(1), iGroup, iVariant);
}

int Native_CountBodyGroupVarirant(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid iGroup. Starting from 0.");

	return SDKCall(g_hSDKCall_CountBodyGroupVariant, GetNativeCell(1), iGroup);
}

any Native_IsRagdoll(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int entity = EntRefToEntIndex(GetNativeCell(1));
	return view_as<bool>((view_as<RenderFx>(GetEntProp(entity, Prop_Send, "m_nRenderFX", 1)) == RENDERFX_RAGDOLL));
}

any Native_CanBecomeRagdoll(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	return SDKCall(g_hSDKCall_CanBecomeRagdoll, GetNativeCell(1));
}

any Native_BecomeRagdollOnClient(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	float force[3];
	GetNativeArray(2, force, sizeof(force));

	return SDKCall(g_hSDKCall_BecomeRagdollOnClient, GetNativeCell(1), force);
}

int Native_GetSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int entity = EntRefToEntIndex(GetNativeCell(1));
	return GetEntProp(entity, Prop_Send, "m_nSequence");
}

int Native_SetSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	SDKCall(g_hSDKCall_SetSequence, GetNativeCell(1), iSequence);

	return 0;
}

any Native_GetCycle(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int entity = EntRefToEntIndex(GetNativeCell(1));
	return GetEntPropFloat(entity, Prop_Send, "m_flCycle");
}

int Native_SetCycle(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	float flCycle = GetNativeCell(2);
	int entity = EntRefToEntIndex(GetNativeCell(1));
	SetEntPropFloat(entity, Prop_Send, "m_flCycle", flCycle);

	return 0;
}

any Native_GetPlaybackRate(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int entity = EntRefToEntIndex(GetNativeCell(1));
	return GetEntPropFloat(entity, Prop_Send, "m_flPlaybackRate");
}

int Native_SetPlaybackRate(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	float flPlaybackRate = GetNativeCell(2);
	int entity = EntRefToEntIndex(GetNativeCell(1));
	SetEntPropFloat(entity, Prop_Send, "m_flPlaybackRate", flPlaybackRate);

	return 0;
}

int Native_GetSequenceName(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);

	int maxlength;
	GetNativeStringLength(3, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(3, name, maxlength + 1);

	SDKCall(g_hSDKCall_GetSequenceName, GetNativeCell(1), name, maxlength, iSequence);
	SetNativeString(3, name, maxlength);

	return 0;
}

int Native_GetSequenceActivity(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);

	return SDKCall(g_hSDKCall_GetSequenceActivity, GetNativeCell(1), iSequence);
}

int Native_GetSequenceActivityName(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);

	int maxlength;
	GetNativeStringLength(3, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(3, name, maxlength + 1);

	SDKCall(g_hSDKCall_GetSequenceActivityName, GetNativeCell(1), name, maxlength, iSequence);
	SetNativeString(3, name, maxlength);

	return 0;
}

any Native_GetSequenceKeyValues(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return view_as<Address>(SDKCall(g_hSDKCall_GetSequenceKeyValues, GetNativeCell(1), iSequence));
}

int Native_GetSequenceLinearMotion(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int	  iSequence = GetNativeCell(2);
	float vec[3];

	SDKCall(g_hSDKCall_GetSequenceLinearMotion, GetNativeCell(1), iSequence, vec);
	SetNativeArray(3, vec, sizeof(vec));
	return 0;
}

any Native_GetSequenceMoveYaw(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return SDKCall(g_hSDKCall_GetSequenceMoveYaw, GetNativeCell(1), iSequence);
}

any Native_GetSequenceMoveDist(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int	  iSequence = GetNativeCell(2);

	float vec[3];
	SDKCall(g_hSDKCall_GetSequenceLinearMotion, GetNativeCell(1), iSequence, vec);

	return GetVectorLength(vec);
}

any Native_GetSequenceMovement(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

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
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int		iSequence  = GetNativeCell(2);

	// no need to check this since nullptr will pass a result back.
	Address pStudioHdr = GetModelPtr(view_as<Address>(GetNativeCell(1)));
	float	flDuration = SDKCall(g_hSDKCall_SequenceDuration, GetNativeCell(1), pStudioHdr, iSequence);

	return flDuration;
}

any Native_GetSequenceCycleRate(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int		iSequence  = GetNativeCell(2);

	Address pStudioHdr = GetModelPtr(view_as<Address>(GetNativeCell(1)));
	float	flDuration = SDKCall(g_hSDKCall_SequenceDuration, GetNativeCell(1), pStudioHdr, iSequence);

	if (flDuration > 0.0)
		return 1.0 / flDuration;

	return 10.0;	// 1.0f / 0.1f;
}

any Native_LastVisibleCycle(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int		iSequence  = GetNativeCell(2);

	Address pStudioHdr = GetModelPtr(view_as<Address>(GetNativeCell(1)));
	float flCycle = SDKCall(g_hSDKCall_LastVisibleCycle, GetNativeCell(1), pStudioHdr, iSequence);

	return flCycle;
}

any Native_GetSequenceGroundSpeed(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int		iSequence  = GetNativeCell(2);

	Address pStudioHdr = GetModelPtr(view_as<Address>(GetNativeCell(1)));
	float	flDuration = SDKCall(g_hSDKCall_SequenceDuration, GetNativeCell(1), pStudioHdr, iSequence);

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
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int maxlength;
	GetNativeStringLength(2, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(2, name, maxlength);

	return SDKCall(g_hSDKCall_LookupSequence, GetNativeCell(1), name);
}

any Native_IsValidSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return SDKCall(g_hSDKCall_IsValidSequence, GetNativeCell(1), iSequence);
}

any Native_IsSequenceFinished(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int entity = EntRefToEntIndex(GetNativeCell(1));
	return view_as<bool>(GetEntProp(entity, Prop_Send, "m_bSequenceFinished"));
}

any Native_IsSequenceLooping(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int entity	  = EntRefToEntIndex(GetNativeCell(1));
	int iSequence = GetNativeCell(2);

	if (!IsValidEntity(entity))
	{
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid entity index.");
		return 0;
	}

	if (!HasModel(entity))
	{
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Entity has no model.");
		return 0;
	}

	Address pStudioHdr = GetModelPtr(view_as<Address>(GetNativeCell(1)));
	int		flags	   = SDKCall(g_hSDKCall_GetSequenceFlags, pStudioHdr, iSequence);

	return (flags & 1) != 0;	// STUDIO_LOOPING
}

int Native_ResetSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	SDKCall(g_hSDKCall_ResetSequence, GetNativeCell(1), iSequence);

	return 0;
}

int Native_ResetSequenceInfo(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	SDKCall(g_hSDKCall_ResetSequenceInfo, GetNativeCell(1));
	return 0;
}

int Native_FindTransitionSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iCurrentSequence = GetNativeCell(2);
	int iGoalSequence	 = GetNativeCell(3);
	int piDir			 = 0;	// passing null.

	return SDKCall(g_hSDKCall_FindTransitionSequence, GetNativeCell(1), iCurrentSequence, iGoalSequence, piDir);
}

any Native_GoToSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

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
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iActivity = GetNativeCell(2);

	return SDKCall(g_hSDKCall_SelectWeightedSequence, GetNativeCell(1), iActivity);
}

any Native_GetModelScale(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int entity = EntRefToEntIndex(GetNativeCell(1));
	return GetEntPropFloat(entity, Prop_Send, "m_flModelScale");
}

int Native_SetModelScale(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	float scale = GetNativeCell(2);
	SDKCall(g_hSDKCall_SetModelScale, GetNativeCell(1), scale, 0.0);

	return 0;
}

int Native_SetModel(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int maxlength;
	GetNativeStringLength(2, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(2, name, maxlength + 1);

	SDKCall(g_hSDKCall_SetModel, GetNativeCell(1), name);

	return 0;
}

any Native_GetModelPtr(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	return GetModelPtr(view_as<Address>(GetNativeCell(1)));
}

int Native_LookupBone(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int maxlength;
	GetNativeStringLength(2, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(2, name, maxlength);

	return SDKCall(g_hSDKCall_LookupBone, GetNativeCell(1), name);
}

// you can call CBaseAnimating::GetNumBones, but you may only find linux signature since there's no function calls this function,
// and it's not a virtual function so you know it windows is dead. (or you can try to find it yourself)
// so we just load this value from studiohdr_t->numbones.
// https://github.com/ValveSoftware/source-sdk-2013/tree/master/mp/src/public/studio.h#L2383
// https://github.com/ValveSoftware/source-sdk-2013/tree/master/mp/src/public/studio.h#L2087
int Native_GetNumBones(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	// CBaseAnimating -> m_pStudioHdr -> numbones.
	Address pStudioHdr = GetModelPtr(view_as<Address>(GetNativeCell(1)));
	if (!ValidateAddress(pStudioHdr))
		return -1;

	return view_as<int>(LoadFromAddress(pStudioHdr + view_as<Address>(g_iOffset_numbones), NumberType_Int8));
}

any Native_GetBonePosition(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iBone = GetNativeCell(2);
	float vec[3]; float ang[3];
	GetNativeArray(3, vec, sizeof(vec));
	GetNativeArray(4, ang, sizeof(ang));

	SDKCall(g_hSDKCall_GetBonePosition, GetNativeCell(1), iBone, vec, ang);
	SetNativeArray(3, vec, sizeof(vec));
	SetNativeArray(4, ang, sizeof(ang));

	return 0;
}

int Native_GetAttachmentBone(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iAttachment = GetNativeCell(2);

	return SDKCall(g_hSDKCall_GetAttachmentBone, GetNativeCell(1), iAttachment);
}

any Native_GetBoneCache(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	return view_as<Address>(SDKCall(g_hSDKCall_GetBoneCache, view_as<Address>(GetNativeCell(1))));
}

int Native_GetPhysicsBone(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iBone = GetNativeCell(2);

	return SDKCall(g_hSDKCall_GetPhysicsBone, GetNativeCell(1), iBone);
}

int Native_GetHitboxBone(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iHitbox = GetNativeCell(2);

	return SDKCall(g_hSDKCall_GetHitboxBone, GetNativeCell(1), iHitbox);
}

int Native_LookupAttachment(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int maxlength;
	GetNativeStringLength(2, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(2, name, maxlength);

	return SDKCall(g_hSDKCall_LookupAttachment, GetNativeCell(1), name);
}

any Native_GetAttachment(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iAttachment = GetNativeCell(2);
	float vec[3]; float ang[3];
	GetNativeArray(3, vec, sizeof(vec));
	GetNativeArray(4, ang, sizeof(ang));

	SDKCall(g_hSDKCall_GetAttachment, GetNativeCell(1), iAttachment, vec, ang);
	SetNativeArray(3, vec, sizeof(vec));
	SetNativeArray(4, ang, sizeof(ang));

	return 0;
}

int Native_LookupPoseParameter(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int maxlength;
	GetNativeStringLength(2, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(2, name, maxlength);

	return SDKCall(g_hSDKCall_LookupPoseParameter, GetNativeCell(1), name);	
}

any Native_GetPoseParameter(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iPoseParameter = GetNativeCell(2);

	return SDKCall(g_hSDKCall_GetPoseParameter, GetNativeCell(1), iPoseParameter);
}

any Native_SetPoseParameter(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iPoseParameter = GetNativeCell(2);
	float flValue = GetNativeCell(3);

	return SDKCall(g_hSDKCall_SetPoseParameter, GetNativeCell(1), iPoseParameter, flValue);
}

any Native_GetPoseParameterRange(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iPoseParameter = GetNativeCell(2);
	float flMin = GetNativeCellRef(3);
	float flMax = GetNativeCellRef(4);

	bool bSuccess = SDKCall(g_hSDKCall_GetPoseParameterRange, GetNativeCell(1), iPoseParameter, flMin, flMax);
	SetNativeCellRef(3, flMin);
	SetNativeCellRef(4, flMax);

	return bSuccess;
}

int Native_GetHitboxSet(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int entity = EntRefToEntIndex(GetNativeCell(1));

	return GetEntProp(entity, Prop_Send, "m_nHitboxSet");
}

any Native_SetHitboxSet(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int entity = EntRefToEntIndex(GetNativeCell(1));

	SetEntProp(entity, Prop_Send, "m_nHitboxSet", GetNativeCell(2));

	return 0;
}

int Native_GetNumHitboxSets(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	Address pStudioHdr = GetModelPtr(view_as<Address>(GetNativeCell(1)));
	if (!ValidateAddress(pStudioHdr))
		return -1;

	return view_as<int>(LoadFromAddress(pStudioHdr + view_as<Address>(g_iOffset_numhitboxsets), NumberType_Int8));
}

any Native_ComputeHitboxSurroundingBox(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	float pVecWorldMins[3], pVecWorldMaxs[3];
	GetNativeArray(2, pVecWorldMins, sizeof(pVecWorldMins));
	GetNativeArray(3, pVecWorldMaxs, sizeof(pVecWorldMaxs));

	bool bSuccess = SDKCall(g_hSDKCall_ComputeHitboxSurroundingBox, GetNativeCell(1), pVecWorldMins, pVecWorldMaxs);
	SetNativeArray(2, pVecWorldMins, sizeof(pVecWorldMins));
	SetNativeArray(3, pVecWorldMaxs, sizeof(pVecWorldMaxs));

	return bSuccess;
}

int Native_GetHitboxesFrontside(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int boxList = GetNativeCell(2);
	int boxMax = GetNativeCell(3);
	float normal[3];
	GetNativeArray(4, normal, sizeof(normal));
	float dist = GetNativeCell(5);

	int count = SDKCall(g_hSDKCall_GetHitboxesFrontside, GetNativeCell(1), boxList, boxMax, normal, dist);
	SetNativeArray(4, normal, sizeof(normal));

	return count;
}

any Native_DispatchAnimEvents(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	// must not be nullptr. this function dose not check it.
	// otherwise eventHandler->HandleAnimEvent() will crash.
	Address pBaseAnimating = view_as<Address>(GetNativeCell(2));
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid Target CBaseAnimating object.");

	SDKCall(g_hSDKCall_DispatchAnimEvents, GetNativeCell(1), pBaseAnimating);

	return 0;
}

any Native_HasAnimEvent(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	int iEvent = GetNativeCell(3);

	return view_as<bool>(SDKCall(g_hSDKCall_HasAnimEvent, GetNativeCell(1), iSequence, iEvent));
}

any Native_CopyAnimationDataFrom(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	// same as above.
	Address pBaseAnimating = view_as<Address>(GetNativeCell(2));
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid Target CBaseAnimating object.");

	SDKCall(g_hSDKCall_CopyAnimationDataFrom, GetNativeCell(1), pBaseAnimating);

	return 0;
}

any Native_ExtractBbox(Handle plugin, int numParams)
{
	if (!ValidateAddress(GetNativeCell(1)))
		ThrowNativeError(SP_ERROR_INVALID_ADDRESS, "Invalid CBaseAnimating object.");

	int iSequence;
	float vecMins[3], vecMaxs[3];
	GetNativeArray(3, vecMins, sizeof(vecMins));
	GetNativeArray(4, vecMaxs, sizeof(vecMaxs));

	bool bSuccess = view_as<bool>(SDKCall(g_hSDKCall_ExtractBbox, GetNativeCell(1), iSequence, vecMins, vecMaxs));
	SetNativeArray(3, vecMins, sizeof(vecMins));
	SetNativeArray(4, vecMaxs, sizeof(vecMaxs));

	return bSuccess;
}