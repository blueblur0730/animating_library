#if defined _animating_libarary_setup_
    #endinput
#endif
#define _animating_libarary_setup_

void CreateSDKCalls()
{
	GameDataWrapper	gd = new GameDataWrapper(GAMEDATA_FILE);
	CreateCStuidoHdrSDKCalls(gd);

	// weird sourcemod shit
	// https://forums.alliedmods.net/showthread.php?t=344325
	SDKCallParamsWrapper ret 			= { SDKType_PlainOldData, SDKPass_Plain };
	g_hSDKCall_GetBaseAnimating	  		= gd.CreateSDKCallOrFail(SDKCall_Entity, SDKConf_Virtual, "CBaseAnimating::GetBaseAnimating", _, _, true, ret);
		
	SDKCallParamsWrapper params2[] 		= {{ SDKType_PlainOldData, SDKPass_Plain }, { SDKType_PlainOldData, SDKPass_Plain }};
	g_hSDKCall_SetBodyGroup				= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::SetBodyGroup", params2, sizeof(params2), false, _);

	SDKCallParamsWrapper params3[] 		= {{ SDKType_PlainOldData, SDKPass_Plain }};
	SDKCallParamsWrapper ret4 			= { SDKType_PlainOldData, SDKPass_Plain };
	g_hSDKCall_GetBodyGroup				= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::GetBodyGroup", params3, sizeof(params3), true, ret4);

	SDKCallParamsWrapper params4[] 		= {{ SDKType_PlainOldData, SDKPass_Plain }, { SDKType_PlainOldData, SDKPass_Plain }};
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

	SDKCallParamsWrapper params10[] 	= {{ SDKType_PlainOldData, SDKPass_Plain }};
	g_hSDKCall_SetSequence				= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::SetSequence", params10, sizeof(params10), false, _);

	SDKCallParamsWrapper params12[] 	= {{ SDKType_PlainOldData, SDKPass_Plain }};
	SDKCallParamsWrapper ret14 			= { SDKType_PlainOldData, SDKPass_Plain };
	g_hSDKCall_GetSequenceActivity		= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::GetSequenceActivity", params12, sizeof(params12), true, ret14);

	SDKCallParamsWrapper params14[] 	= {{ SDKType_PlainOldData, SDKPass_Plain }};
	SDKCallParamsWrapper ret16 			= { SDKType_PlainOldData, SDKPass_Plain };
	g_hSDKCall_GetSequenceKeyValues		= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::GetSequenceKeyValues", params14, sizeof(params14), true, ret16);

	SDKCallParamsWrapper params15[] 	= {{ SDKType_PlainOldData, SDKPass_Plain }};
	SDKCallParamsWrapper ret17 			= { SDKType_Float, SDKPass_Plain };
	g_hSDKCall_GetSequenceMoveYaw		= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::GetSequenceMoveYaw", params15, sizeof(params15), true, ret17);

	SDKCallParamsWrapper params16[] 	= {{ SDKType_PlainOldData, SDKPass_Plain }, { SDKType_Vector, SDKPass_Pointer }};
	g_hSDKCall_GetSequenceLinearMotion	= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::GetSequenceLinearMotion", params16, sizeof(params16), false, _);

	SDKCallParamsWrapper params17[] 	= {{ SDKType_PlainOldData, SDKPass_Plain }, { SDKType_Float, SDKPass_Plain }, { SDKType_Float, SDKPass_Plain }, { SDKType_Vector, SDKPass_ByRef }, { SDKType_QAngle, SDKPass_ByRef }};
	SDKCallParamsWrapper ret18 			= { SDKType_Bool, SDKPass_Plain };
	g_hSDKCall_GetSequenceMovement		= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::GetSequenceMovement", params17, sizeof(params17), true, ret18);

	SDKCallParamsWrapper params18[] 	= {{ SDKType_PlainOldData, SDKPass_Pointer, VDECODE_FLAG_ALLOWNULL}, {SDKType_PlainOldData, SDKPass_Plain}};
	SDKCallParamsWrapper ret19 			= { SDKType_Float, SDKPass_Plain };
	g_hSDKCall_SequenceDuration			= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::SequenceDuration", params18, sizeof(params18), true, ret19);

	SDKCallParamsWrapper params20[] 	= {{ SDKType_PlainOldData, SDKPass_Plain }};
	SDKCallParamsWrapper ret21 			= { SDKType_Bool, SDKPass_Plain };
	g_hSDKCall_IsValidSequence			= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::IsValidSequence", params20, sizeof(params20), true, ret21);

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

			SDKCallParamsWrapper params11[] 	= {{ SDKType_PlainOldData, SDKPass_Plain }};
			SDKCallParamsWrapper ret13 			= { SDKType_String, SDKPass_Pointer };
			g_hSDKCall_GetSequenceName			= gd.CreateSDKCallOrFailEx(SDKCall_Raw, "CBaseAnimating::GetSequenceName", params11, sizeof(params11), true, ret13);

			SDKCallParamsWrapper params13[] 	= {{ SDKType_PlainOldData, SDKPass_Plain }};
			SDKCallParamsWrapper ret15 			= { SDKType_String, SDKPass_Pointer };
			g_hSDKCall_GetSequenceActivityName	= gd.CreateSDKCallOrFailEx(SDKCall_Raw, "CBaseAnimating::GetSequenceActivityName", params13, sizeof(params13), true, ret15);

			SDKCallParamsWrapper params19[] 	= {{ SDKType_PlainOldData, SDKPass_Plain }};
			SDKCallParamsWrapper ret20 			= { SDKType_Float, SDKPass_Plain };
			g_hSDKCall_SequenceDuration			= gd.CreateSDKCallOrFailEx(SDKCall_Raw, "CBaseAnimating::LookupSequence", params19, sizeof(params19), true, ret20);
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

			SDKCallParamsWrapper params11[] 	= {{ SDKType_PlainOldData, SDKPass_Plain }};
			SDKCallParamsWrapper ret13 			= { SDKType_String, SDKPass_Pointer };
			g_hSDKCall_GetSequenceName			= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::GetSequenceName", params11, sizeof(params11), true, ret13);

			SDKCallParamsWrapper params13[] 	= {{ SDKType_PlainOldData, SDKPass_Plain }};
			SDKCallParamsWrapper ret15 			= { SDKType_String, SDKPass_Pointer };
			g_hSDKCall_GetSequenceActivityName	= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::GetSequenceActivityName", params13, sizeof(params13), true, ret15);

			SDKCallParamsWrapper params19[] 	= {{ SDKType_PlainOldData, SDKPass_Plain }};
			SDKCallParamsWrapper ret20 			= { SDKType_Float, SDKPass_Plain };
			g_hSDKCall_SequenceDuration			= gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "CBaseAnimating::LookupSequence", params19, sizeof(params19), true, ret20);
		}
	}

	delete gd;
}

void CreateCStuidoHdrSDKCalls(GameDataWrapper gd)
{
	SDKCallParamsWrapper params[] 			= {{ SDKType_String, SDKPass_Pointer }};
	SDKCallParamsWrapper ret 				= { SDKType_PlainOldData, SDKPass_Plain };
	g_hSDKCall_ModelSoundCache_LoadModel 	= gd.CreateSDKCallOrFail(SDKCall_Static, SDKConf_Signature, "ModelSoundsCache_LoadModel", params, sizeof(params), true, ret);

	SDKCallParamsWrapper params1[] 			= {{ SDKType_PlainOldData, SDKPass_Pointer }};
	g_hSDKCall_ModelSoundCache_FinishModel = gd.CreateSDKCallOrFail(SDKCall_Raw, SDKConf_Signature, "ModelSoundsCache_FinishModel", params1, sizeof(params1), false, _);
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

	CreateNative("CBaseAnimating.m_nSequence.get", Native_GetSequence);
	CreateNative("CBaseAnimating.m_nSequence.set", Native_SetSequence);
	CreateNative("CBaseAnimating.GetSequenceName", Native_GetSequenceName);
	CreateNative("CBaseAnimating.GetSequenceActivity", Native_GetSequenceActivity);
	CreateNative("CBaseAnimating.GetSequenceActivityName", Native_GetSequenceActivityName);
	CreateNative("CBaseAnimating.GetSequenceKeyValues", Native_GetSequenceKeyValues);
	CreateNative("CBaseAnimating.GetSequenceLinearMotion", Native_GetSequenceLinearMotion);
	CreateNative("CBaseAnimating.GetSequenceMoveYaw", Native_GetSequenceMoveYaw);
	CreateNative("CBaseAnimating.GetSequenceMoveDist", Native_GetSequenceMoveDist);
	CreateNative("CBaseAnimating.GetSequenceMovement", Native_GetSequenceMovement);
	CreateNative("CBaseAnimating.SequenceDuration", Native_SequenceDuration);
	CreateNative("CBaseAnimating.GetSequenceCycleRate", Native_GetSequenceCycleRate);
	CreateNative("CBaseAnimating.GetSequenceGroundSpeed", Native_GetSequenceGroundSpeed);
	CreateNative("CBaseAnimating.LookupSequence", Native_LookupSequence);
	CreateNative("CBaseAnimating.IsValidSequence", Native_IsValidSequence);
	CreateNative("CBaseAnimating.IsSequenceFinished", Native_IsSequenceFinished);

	CreateNative("CStudioHdr.CStudioHdr", Native_CStudioHdr);
	CreateNative("CStudioHdr.deleteThis", Native_CStudioHdr_DeleteThis);
}