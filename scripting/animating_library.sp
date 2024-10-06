#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <sdktools>
#include <gamedata_wrapper>
#include <entity_prop_stocks>

#define GAMEDATA_FILE  "animating_library"
#define PLUGIN_VERSION "1.2"

Handle
	g_hSDKCall_GetBaseAnimating		  = null,
	g_hSDKCall_FindBodyGroupByName	  = null,
	g_hSDKCall_SetBodyGroup			  = null,
	g_hSDKCall_GetBodyGroup			  = null,
	g_hSDKCall_GetBodyGroupCount	  = null,
	g_hSDKCall_GetBodyGroupName		  = null,
	g_hSDKCall_GetBodyGroupPartName	  = null,
	g_hSDKCall_GetNumBodyGroups		  = null,
	g_hSDKCall_FindBodyGroupVariant	  = null,
	g_hSDKCall_CountBodyGroupVariant  = null,

	g_hSDKCall_CanBecomeRagdoll		  = null,
	g_hSDKCall_BecomeRagdollOnClient  = null;

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

any Native_CBaseAnimating(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);
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

	return pWrapper.FindBodyGroupByName(name, maxlength);
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

int Native_IsRagdoll(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	return pWrapper.IsRagdoll();
}

int Native_CanBecomeRagdoll(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	return pWrapper.CanBecomeRagdoll();
}

int Native_BecomeRagdollOnClient(Handle plugin, int numParams)
{
	if (!ValidateAddress(pWrapper))
		ThrowNativeError(SP_ERROR_PARAM, "Invalid CBaseAnimating object.");

	float force[3];
	GetNativeArray(2, force, sizeof(force));

	return pWrapper.BecomeRagdollOnClient(force);
}

bool ValidateAddress(CBaseAnimating wrapper)
{
	return wrapper.Pointer != Address_Null ? true : false;
}