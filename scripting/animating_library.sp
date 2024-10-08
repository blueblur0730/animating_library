#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <sdktools>
#include <gamedata_wrapper>
#include <entity_prop_stocks>

#define GAMEDATA_FILE  "animating_library"
#define PLUGIN_VERSION "1.6.1"

Handle
	// these two is to get and delete a new CStudioHdr instance.
	g_hSDKCall_ModelSoundCache_LoadModel   = null,
	g_hSDKCall_ModelSoundCache_FinishModel = null,

	g_hSDKCall_GetSequenceFlags			= null,

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
	g_hSDKCall_LastVisibleCycle			= null,
	g_hSDKCall_LookupSequence			= null,
	g_hSDKCall_IsValidSequence			= null,
	g_hSDKCall_ResetSequence			= null,
	g_hSDKCall_ResetSequenceInfo		= null,
	g_hSDKCall_FindTransitionSequence	= null,
	g_hSDKCall_GoToSequence				= null,
	g_hSDKCall_SelectWeightedSequence	= null,

	g_hSDKCall_SetModelScale			= null,
	g_hSDKCall_SetModel					= null,

	g_hSDKCall_LookupBone				= null,
	g_hSDKCall_GetBonePosition			= null;

int 
	g_iOffset_pStudioHdr = -1,
	g_iOffset_numbones	 = -1;

#include "animating_library/setup.sp"
#include "animating_library/cbaseanimating.sp"
#include "animating_library/cstudiohdr.sp"
#include "animating_library/animation.sp"

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

	GameDataWrapper	gd = new GameDataWrapper(GAMEDATA_FILE);

	CreateSDKCalls(gd);
	RetrieveOffsets(gd);

	delete gd;
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

// this function loads an existed CStudioHdr instance of an entity's model.
Address GetModelPtr(Address pBaseAnimating)
{
	return LoadFromAddress(pBaseAnimating + view_as<Address>(g_iOffset_pStudioHdr), NumberType_Int32);
}

// Big thanks to LuqS
// https://forums.alliedmods.net/showthread.php?t=333857
// note: this function uses operator new to CREATE a new CStudioHdr instance.
Address CreateCStudioHdrOfEntity(int entity)
{
	if (!IsValidEntity(entity))
		return Address_Null;

	char sModel[PLATFORM_MAX_PATH];
	GetEntPropString(entity, Prop_Data, "m_ModelName", sModel, sizeof(sModel));

	if (!sModel[0])
		return Address_Null;

	// Create a new CStudioHdr instance based on the model path.
	return view_as<Address>(SDKCall(g_hSDKCall_ModelSoundCache_LoadModel, sModel));
}