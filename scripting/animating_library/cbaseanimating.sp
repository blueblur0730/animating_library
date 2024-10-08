#if defined _animating_libarary_cbaseanimating_
    #endinput
#endif
#define _animating_libarary_cbaseanimating_

CBaseAnimating pBaseAnimating;

any Native_CBaseAnimating(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);

	if (!HasModel(entity))
	{
		ThrowNativeError(SP_ERROR_PARAM, "Entity has no model.");
		return 0;
	}

	pBaseAnimating = CBaseAnimating(entity);
	return pBaseAnimating.Pointer;
}

int Native_FindBodyGroupByName(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int maxlength;
	GetNativeStringLength(2, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(2, name, maxlength);

	return pBaseAnimating.FindBodyGroupByName(name);
}

int Native_SetBodyGroup(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);
	int iValue = GetNativeCell(3);

	if (iValue != 0 && iValue != 1)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid value for iValue.");

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	pBaseAnimating.SetBodyGroup(iGroup, iValue);

	return 0;
}

int Native_GetBodyGroup(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	return pBaseAnimating.GetBodyGroup(iGroup);
}

int Native_GetBodyGroupCount(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	return pBaseAnimating.GetBodyGroupCount(iGroup);
}

int Native_GetBodyGroupName(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	int maxlength;
	GetNativeStringLength(3, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(3, name, maxlength + 1);

	pBaseAnimating.GetBodyGroupName(iGroup, name, maxlength);
	SetNativeString(3, name, maxlength + 1);

	return 0;
}

int Native_GetBodyGroupPartName(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
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

	pBaseAnimating.GetBodyGroupPartName(iGroup, iPart, name, maxlength);
	SetNativeString(4, name, maxlength + 1);

	return 0;
}

int Native_GetNumBodyGroups(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	return pBaseAnimating.GetNumBodyGroups();
}

int Native_FindBodyGroupVariant(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);
	int iVariant = GetNativeCell(3);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	return pBaseAnimating.FindBodyGroupVariant(iGroup, iVariant);
}

int Native_CountBodyGroupVarirant(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	return pBaseAnimating.CountBodyGroupVariant(iGroup);
}

any Native_IsRagdoll(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	return pBaseAnimating.IsRagdoll();
}

any Native_CanBecomeRagdoll(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	return pBaseAnimating.CanBecomeRagdoll();
}

any Native_BecomeRagdollOnClient(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	float force[3];
	GetNativeArray(2, force, sizeof(force));

	return pBaseAnimating.BecomeRagdollOnClient(force);
}

int Native_GetSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	return pBaseAnimating.m_nSequence;
}

int Native_SetSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	pBaseAnimating.m_nSequence = iSequence;

	return 0;
}

int Native_GetSequenceName(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);

	int maxlength;
	GetNativeStringLength(3, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(3, name, maxlength + 1);

	pBaseAnimating.GetSequenceName(iSequence, name, maxlength);
	SetNativeString(3, name, maxlength + 1);

	return 0;
}

int Native_GetSequenceActivity(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);

	return pBaseAnimating.GetSequenceActivity(iSequence);
}

int Native_GetSequenceActivityName(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);

	int maxlength;
	GetNativeStringLength(3, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(3, name, maxlength + 1);

	pBaseAnimating.GetSequenceActivityName(iSequence, name, maxlength);
	SetNativeString(3, name, maxlength + 1);

	return 0;
}

any Native_GetSequenceKeyValues(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return pBaseAnimating.GetSequenceKeyValues(iSequence);
}

int Native_GetSequenceLinearMotion(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	float vec[3];

	pBaseAnimating.GetSequenceLinearMotion(iSequence, vec);
	SetNativeArray(3, vec, sizeof(vec));
	return 0;
}

any Native_GetSequenceMoveYaw(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return pBaseAnimating.GetSequenceMoveYaw(iSequence);
}

any Native_GetSequenceMoveDist(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return pBaseAnimating.GetSequenceMoveDist(iSequence);
}

any Native_GetSequenceMovement(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	float fromCycle = GetNativeCell(3);
	float toCycle = GetNativeCell(4);
	
	float deltaVector[3];
	float deltaAngles[3];

	bool bFound = view_as<bool>(pBaseAnimating.GetSequenceMovement(iSequence, fromCycle, toCycle, deltaVector, deltaAngles));
	SetNativeArray(5, deltaVector, sizeof(deltaVector));
	SetNativeArray(6, deltaAngles, sizeof(deltaAngles));

	return bFound;
}

any Native_SequenceDuration(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return pBaseAnimating.SequenceDuration(iSequence);
}

any Native_GetSequenceCycleRate(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return pBaseAnimating.GetSequenceCycleRate(iSequence);
}

any Native_GetSequenceGroundSpeed(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return pBaseAnimating.GetSequenceGroundSpeed(iSequence);
}

int Native_LookupSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int maxlength;
	GetNativeStringLength(2, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(2, name, maxlength + 1);

	return pBaseAnimating.LookupSequence(name);
}

any Native_IsValidSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return pBaseAnimating.IsValidSequence(iSequence);
}

any Native_IsSequenceFinished(Handle plugin, int numParams)
{
	if (!ValidateAddress(pBaseAnimating))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return pBaseAnimating.IsSequenceFinished(iSequence);
}