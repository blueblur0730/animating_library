#if defined _animating_libarary_call_warpper_
    #endinput
#endif
#define _animating_libarary_call_warpper_

methodmap CBaseAnimating
{
	// this is actually a CBaseEntity pointer.
	public CBaseAnimating(int entity) {
		return view_as<CBaseAnimating>(view_as<Address>(SDKCall(g_hSDKCall_GetBaseAnimating, entity)));
	}

	property Address Pointer {
	    public get() { return view_as<Address>(this); }
	}

	// sourcemod recongnizes this pointer as ref. so you dont have to use sdkcall to convert address to index.
	property int Entity {
		public get() { return EntRefToEntIndex(view_as<int>(this)); }
	}

	public int FindBodyGroupByName(const char[] name, int maxlen) {
		return SDKCall(g_hSDKCall_FindBodyGroupByName, view_as<Address>(this), name, maxlen);
	}

	public void SetBodyGroup(int iGroup, int iValue) {
		SDKCall(g_hSDKCall_SetBodyGroup, view_as<Address>(this), iGroup, iValue);
	}

	public int GetBodyGroup(int iGroup) {
		return SDKCall(g_hSDKCall_GetBodyGroup, view_as<Address>(this), iGroup);
	}

	public int GetBodyGroupCount(int iGroup) {
		return SDKCall(g_hSDKCall_GetBodyGroupCount, view_as<Address>(this), iGroup);
	}

	public void GetBodyGroupName(int iGroup, char[] name, int mexlen) {
		SDKCall(g_hSDKCall_GetBodyGroupName, view_as<Address>(this), iGroup, name, mexlen);
	}

	public void GetBodyGroupPartName(int iGroup, int iPart, char[] name, int mexlen) {
		SDKCall(g_hSDKCall_GetBodyGroupPartName, view_as<Address>(this), iGroup, iPart, name, mexlen);
	}

	public int GetNumBodyGroups() {
		return SDKCall(g_hSDKCall_GetNumBodyGroups, view_as<Address>(this));
	}

	public int FindBodyGroupVariant(int iGroup, int iVariant) {
		return SDKCall(g_hSDKCall_FindBodyGroupVariant, view_as<Address>(this), iGroup, iVariant);
	}

	public int CountBodyGroupVariant(int iGroup) {
		return SDKCall(g_hSDKCall_CountBodyGroupVariant, view_as<Address>(this), iGroup);
	}

	// save some strenth just use this esaliy.
    public bool IsRagdoll() {
        return view_as<bool>((view_as<RenderFx>(GetEntProp(this.Entity, Prop_Send, "m_nRenderFX", 1)) == RENDERFX_RAGDOLL));
    }

	public bool CanBecomeRagdoll() {
		return SDKCall(g_hSDKCall_CanBecomeRagdoll, view_as<Address>(this));
	}

	public bool BecomeRagdollOnClient(float force[3]) {
		return SDKCall(g_hSDKCall_BecomeRagdollOnClient, view_as<Address>(this), force);
	}
}

void CreateSDKCalls()
{
	GameDataWrapper	gd = new GameDataWrapper(GAMEDATA_FILE);

	// weird sourcemod shit
	// https://forums.alliedmods.net/showthread.php?t=344325
	SDKCallParamsWrapper ret 			= { SDKType_PlainOldData, SDKPass_Plain };
	g_hSDKCall_GetBaseAnimating	  		= gd.CreateSDKCallOrFail(SDKCall_Entity, SDKConf_Virtual, "CBaseAnimating::GetBaseAnimating", _, _, true, ret);
		
	SDKCallParamsWrapper params2[] 		= {{ SDKType_PlainOldData, SDKPass_Plain }, { SDKType_PlainOldData, SDKPass_Plain }};
	SDKCallParamsWrapper ret3 			= { SDKType_PlainOldData, SDKPass_Plain };
	g_hSDKCall_SetBodyGroup				= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::SetBodyGroup", params2, sizeof(params2), true, ret3);

	SDKCallParamsWrapper params3[] 		= {{ SDKType_PlainOldData, SDKPass_Plain }};
	SDKCallParamsWrapper ret4 			= { SDKType_PlainOldData, SDKPass_Plain };
	g_hSDKCall_GetBodyGroup				= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::GetBodyGroup", params3, sizeof(params3), true, ret4);

	SDKCallParamsWrapper params4[] 		= {{ SDKType_PlainOldData, SDKPass_Plain },{  SDKType_PlainOldData, SDKPass_Plain }};
	SDKCallParamsWrapper ret5 			= { SDKType_String, SDKPass_Pointer };
	g_hSDKCall_GetBodyGroupPartName		= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::GetBodyGroupPartName", params4, sizeof(params4), true, ret5);

	SDKCallParamsWrapper ret6 			= { SDKType_PlainOldData, SDKPass_Plain };
	g_hSDKCall_GetNumBodyGroups			= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::GetNumBodyGroups", _, _, true, ret6);

	SDKCallParamsWrapper params5[] 		= {{ SDKType_PlainOldData, SDKPass_Plain }, { SDKType_PlainOldData, SDKPass_Plain }};
	SDKCallParamsWrapper ret7 			= { SDKType_PlainOldData, SDKPass_Plain };
	g_hSDKCall_FindBodyGroupVariant		= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::FindBodyGroupVariant", params5, sizeof(params5), true, ret7);

	SDKCallParamsWrapper params6[] 		= {{ SDKType_PlainOldData, SDKPass_Plain }};
	SDKCallParamsWrapper ret8 			= { SDKType_PlainOldData, SDKPass_Plain };
	g_hSDKCall_CountBodyGroupVariant	= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::CountBodyGroupVariant", params6, sizeof(params6), true, ret8);

	SDKCallParamsWrapper ret11 			= { SDKType_PlainOldData, SDKPass_Plain };
	g_hSDKCall_CanBecomeRagdoll			= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Virtual, "CBaseAnimating::CanBecomeRagdoll", _, _, true, ret11);

	SDKCallParamsWrapper params9[] 		= {{ SDKType_Vector, SDKPass_ByRef }};
	SDKCallParamsWrapper ret12 			= { SDKType_Bool, SDKPass_Plain };
	g_hSDKCall_BecomeRagdollOnClient	= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Virtual, "CBaseAnimating::BecomeRagdollOnClient", params9, sizeof(params9), true, ret12);

	switch (gd.OS)
	{
		case OS_Windows:
		{
			SDKCallParamsWrapper params[] 		= {{ SDKType_String, SDKPass_Pointer }};
			SDKCallParamsWrapper ret2 			= { SDKType_PlainOldData, SDKPass_Plain };
			g_hSDKCall_FindBodyGroupByName 		= gd.CreateSDKCallOrFailEx(SDKCall_Raw, "CBaseAnimating::FindBodyGroupByName", params, sizeof(params), true, ret2);

			SDKCallParamsWrapper params7[] 		= {{ SDKType_PlainOldData, SDKPass_Plain }};
			SDKCallParamsWrapper ret9 			= { SDKType_PlainOldData, SDKPass_Plain };
			g_hSDKCall_GetBodyGroupCount		= gd.CreateSDKCallOrFailEx(SDKCall_Raw, "CBaseAnimating::GetBodyGroupCount", params7, sizeof(params7), true, ret9);

			SDKCallParamsWrapper params8[] 		= {{ SDKType_PlainOldData, SDKPass_Plain }};
			SDKCallParamsWrapper ret10 			= { SDKType_String, SDKPass_Pointer };
			g_hSDKCall_GetBodyGroupName			= gd.CreateSDKCallOrFailEx(SDKCall_Raw, "CBaseAnimating::GetBodyGroupName", params8, sizeof(params8), true, ret10);
		}

		case OS_Linux:
		{
			SDKCallParamsWrapper params[] 		= {{ SDKType_String, SDKPass_Pointer }};
			SDKCallParamsWrapper ret2 			= { SDKType_PlainOldData, SDKPass_Plain };
			g_hSDKCall_FindBodyGroupByName 		= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::FindBodyGroupByName", params, sizeof(params), true, ret2);

			SDKCallParamsWrapper params7[] 		= {{ SDKType_PlainOldData, SDKPass_Plain }};
			SDKCallParamsWrapper ret9 			= { SDKType_PlainOldData, SDKPass_Plain };
			g_hSDKCall_GetBodyGroupCount		= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::GetBodyGroupCount", params7, sizeof(params7), true, ret9);

			SDKCallParamsWrapper params8[] 		= {{ SDKType_PlainOldData, SDKPass_Plain }};
			SDKCallParamsWrapper ret10 			= { SDKType_String, SDKPass_Pointer };
			g_hSDKCall_GetBodyGroupName			= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::GetBodyGroupName", params8, sizeof(params8), true, ret10);
		}
	}

	delete gd;
}

void CreateNatives()
{
	CreateNative("CBaseAnimating.CBaseAnimating", Native_CBaseAnimating);
	CreateNative("CBaseAnimating.FindBodyGroupByName", Native_FindBodyGroupByName);
	CreateNative("CBaseAnimating.SetBodyGroup", Native_SetBodyGroup);
	CreateNative("CBaseAnimating.GetBodyGroup", Native_GetBodyGroup);
	CreateNative("CBaseAnimating.GetBodyGroupCount", Native_GetBodyGroupCount);
	CreateNative("CBaseAnimating.GetBodyGroupName", Native_GetBodyGroupName);
	CreateNative("CBaseAnimating.GetBodyGroupPartName", Native_GetBodyGroupPartName);
	CreateNative("CBaseAnimating.BodyGroupNum.get", Native_GetNumBodyGroups);
	CreateNative("CBaseAnimating.FindBodyGroupVariant", Native_FindBodyGroupVariant);
	CreateNative("CBaseAnimating.CountBodyGroupVarirant", Native_CountBodyGroupVarirant);

	CreateNative("CBaseAnimating.IsRagdoll", Native_IsRagdoll);
	CreateNative("CBaseAnimating.CanBecomeRagdoll", Native_CanBecomeRagdoll);
	CreateNative("CBaseAnimating.BecomeRagdollOnClient", Native_BecomeRagdollOnClient);
}