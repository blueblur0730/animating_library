#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <sdktools>
#include <gamedata_wrapper>
#include <entity_prop_stocks>

#define GAMEDATA_FILE  "animating_library"
#define PLUGIN_VERSION "1.4.4"

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

#include "animating_library/setup.sp"
#include "animating_library/cbaseanimating.sp"
#include "animating_library/cstudiohdr.sp"

public Plugin myinfo =
{
	name = "[L4D2/ANY?] Library for Animating",
	author = "blueblur",
	description = "Just a library for Animating.",
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

bool ValidateAddress(Address pAdr)
{
	return pAdr != Address_Null ? true : false;
}

bool HasModel(int entity)
{
	char buffer[PLATFORM_MAX_PATH];
	GetEntPropString(entity, Prop_Data, "m_ModelName", buffer, sizeof(buffer));
	return buffer[0] != '\0' ? true : false;
}