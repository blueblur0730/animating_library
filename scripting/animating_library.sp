#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <sdktools>
#include <gamedata_wrapper>
#include <entity_prop_stocks>

#define GAMEDATA_FILE  "animating_library"
#define PLUGIN_VERSION "1.4.1"

Handle
	// these two is to get and delete a new CStudioHdr instance.
	g_hSDKCall_ModelSoundCache_LoadModel   = null,
	g_hSDKCall_ModelSoundCache_FinishModel = null,

	g_hSDKCall_GetBaseAnimating		  	= null,
	g_hSDKCall_FindBodyGroupByName	  	= null,
	g_hSDKCall_SetBodyGroup			  	= null,
	g_hSDKCall_GetBodyGroup			  	= null,
	g_hSDKCall_GetBodyGroupCount	  	= null,
	g_hSDKCall_GetBodyGroupName		  	= null,
	g_hSDKCall_GetBodyGroupPartName	  	= null,
	g_hSDKCall_GetNumBodyGroups		  	= null,
	g_hSDKCall_FindBodyGroupVariant	  	= null,
	g_hSDKCall_CountBodyGroupVariant  	= null,

	g_hSDKCall_CanBecomeRagdoll		  	= null,
	g_hSDKCall_BecomeRagdollOnClient  	= null,

	g_hSDKCall_SetSequence			  	= null,
	g_hSDKCall_GetSequenceName			= null,
	g_hSDKCall_GetSequenceActivity		= null,
	g_hSDKCall_GetSequenceActivityName 	= null,
	g_hSDKCall_GetSequenceKeyValues		= null,
	g_hSDKCall_GetSequenceLinearMotion	= null,
	g_hSDKCall_GetSequenceMoveYaw		= null,
	g_hSDKCall_GetSequenceMovement		= null,
	g_hSDKCall_SequenceDuration			= null,
	g_hSDKCall_LookupSequence			= null,
	g_hSDKCall_IsValidSequence			= null;

#include "animating_library/call_wrapper.sp"
CBaseAnimating pWrapper;

public Plugin myinfo =
{
	name = "[L4D2/ANY?] Library for CBaseAnimating",
	author = "blueblur",
	description = "Just a library for CBaseAnimating.",
	version	= PLUGIN_VERSION,
	url	= "https://github.com/blueblur0730/modified-plugins"
}

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	EngineVersion engine = GetEngineVersion();

	if (engine != Engine_Left4Dead2)
	{
		strcopy(error, err_max, "This plugin only supports Left 4 Dead 2.");	// for now?
		return APLRes_SilentFailure;
	}

	RegPluginLibrary("animating_library");
	CreateNatives();

	return APLRes_Success;
}

public void OnPluginStart()
{
	CreateConVar("animating_library_version", PLUGIN_VERSION, "Animating Library version.", FCVAR_NOTIFY | FCVAR_DONTRECORD);

	CreateSDKCalls();
}

bool ValidateAddress(CBaseAnimating wrapper)
{
	return wrapper.Pointer != Address_Null ? true : false;
}

bool HasModel(int entity)
{
	char buffer[PLATFORM_MAX_PATH];
	GetEntPropString(entity, Prop_Data, "m_ModelName", buffer, sizeof(buffer));
	return buffer[0] != '\0' ? true : false;
}

any Native_CBaseAnimating(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);

	if (!HasModel(entity))
	{
		ThrowNativeError(SP_ERROR_PARAM, "Entity has no model.");
		return 0;
	}

	pWrapper = CBaseAnimating(entity);
	return pWrapper.Pointer;
}

int Native_FindBodyGroupByName(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int maxlength;
	GetNativeStringLength(2, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(2, name, maxlength);

	return pWrapper.FindBodyGroupByName(name);
}

int Native_SetBodyGroup(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);
	int iValue = GetNativeCell(3);

	if (iValue != 0 && iValue != 1)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid value for iValue.");

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	pWrapper.SetBodyGroup(iGroup, iValue);

	return 0;
}

int Native_GetBodyGroup(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	return pWrapper.GetBodyGroup(iGroup);
}

int Native_GetBodyGroupCount(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	return pWrapper.GetBodyGroupCount(iGroup);
}

int Native_GetBodyGroupName(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	int maxlength;
	GetNativeStringLength(3, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(3, name, maxlength + 1);

	pWrapper.GetBodyGroupName(iGroup, name, maxlength);
	SetNativeString(3, name, maxlength + 1);

	return 0;
}

int Native_GetBodyGroupPartName(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
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

	pWrapper.GetBodyGroupPartName(iGroup, iPart, name, maxlength);
	SetNativeString(4, name, maxlength + 1);

	return 0;
}

int Native_GetNumBodyGroups(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	return pWrapper.GetNumBodyGroups();
}

int Native_FindBodyGroupVariant(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);
	int iVariant = GetNativeCell(3);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	return pWrapper.FindBodyGroupVariant(iGroup, iVariant);
}

int Native_CountBodyGroupVarirant(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iGroup = GetNativeCell(2);

	if (iGroup < 0)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid iGroup. Starting from 0.");

	return pWrapper.CountBodyGroupVariant(iGroup);
}

any Native_IsRagdoll(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	return pWrapper.IsRagdoll();
}

any Native_CanBecomeRagdoll(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	return pWrapper.CanBecomeRagdoll();
}

any Native_BecomeRagdollOnClient(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	float force[3];
	GetNativeArray(2, force, sizeof(force));

	return pWrapper.BecomeRagdollOnClient(force);
}

int Native_GetSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	return pWrapper.m_nSequence;
}

int Native_SetSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	pWrapper.m_nSequence = iSequence;

	return 0;
}

int Native_GetSequenceName(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);

	int maxlength;
	GetNativeStringLength(3, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(3, name, maxlength + 1);

	pWrapper.GetSequenceName(iSequence, name, maxlength);
	SetNativeString(3, name, maxlength + 1);

	return 0;
}

int Native_GetSequenceActivity(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);

	return pWrapper.GetSequenceActivity(iSequence);
}

int Native_GetSequenceActivityName(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);

	int maxlength;
	GetNativeStringLength(3, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(3, name, maxlength + 1);

	pWrapper.GetSequenceActivityName(iSequence, name, maxlength);
	SetNativeString(3, name, maxlength + 1);

	return 0;
}

any Native_GetSequenceKeyValues(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return pWrapper.GetSequenceKeyValues(iSequence);
}

int Native_GetSequenceLinearMotion(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	float vec[3];

	pWrapper.GetSequenceLinearMotion(iSequence, vec);
	SetNativeArray(3, vec, sizeof(vec));
	return 0;
}

any Native_GetSequenceMoveYaw(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return pWrapper.GetSequenceMoveYaw(iSequence);
}

any Native_GetSequenceMoveDist(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return pWrapper.GetSequenceMoveDist(iSequence);
}

any Native_GetSequenceMovement(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	float fromCycle = GetNativeCell(3);
	float toCycle = GetNativeCell(4);
	
	float deltaVector[3];
	float deltaAngles[3];

	bool bFound = view_as<bool>(pWrapper.GetSequenceMovement(iSequence, fromCycle, toCycle, deltaVector, deltaAngles));
	SetNativeArray(5, deltaVector, sizeof(deltaVector));
	SetNativeArray(6, deltaAngles, sizeof(deltaAngles));

	return bFound;
}

any Native_SequenceDuration(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return pWrapper.SequenceDuration(iSequence);
}

any Native_GetSequenceCycleRate(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return pWrapper.GetSequenceCycleRate(iSequence);
}

any Native_GetSequenceGroundSpeed(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return pWrapper.GetSequenceGroundSpeed(iSequence);
}

int Native_LookupSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int maxlength;
	GetNativeStringLength(2, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(2, name, maxlength + 1);

	return pWrapper.LookupSequence(name);
}

any Native_IsValidSequence(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return pWrapper.IsValidSequence(iSequence);
}

any Native_IsSequenceFinished(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	int iSequence = GetNativeCell(2);
	return pWrapper.IsSequenceFinished(iSequence);
}