#if defined _animating_libarary_activitylist_
	#endinput
#endif
#define _animating_libarary_activitylist_

any Native_ActivityList_RegisterSharedActivity(Handle plugin, int numParams)
{
	int maxlength;
	GetNativeStringLength(1, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(1, name, maxlength);

	int activityIndex = GetNativeCell(2);

	return view_as<bool>(SDKCall(g_hSDKCall_ActivityList_RegisterSharedActivity, name, activityIndex));
}

int Native_ActivityList_RegisterPrivateActivity(Handle plugin, int numParams)
{
	int maxlength;
	GetNativeStringLength(1, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(1, name, maxlength);

	return SDKCall(g_hSDKCall_ActivityList_RegisterPrivateActivity, name);
}

int Native_ActivityList_IndexForName(Handle plugin, int numParams)
{
	int maxlength;
	GetNativeStringLength(1, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(1, name, maxlength);

	return SDKCall(g_hSDKCall_ActivityList_IndexForName, name);
}

any Native_ActivityList_NameForIndex(Handle plugin, int numParams)
{
	int activityIndex = GetNativeCell(1);

	int maxlength;
	GetNativeStringLength(2, maxlength);
	maxlength += 1;
	char[] name = new char[maxlength];
	GetNativeString(2, name, maxlength);

	SDKCall(g_hSDKCall_ActivityList_NameForIndex, activityIndex, name, maxlength);
	SetNativeString(2, name, maxlength);

	return 0;
}

int Native_ActivityList_HighestIndex(Handle plugin, int numParams)
{
	return view_as<int>(LoadFromAddress(g_HighestActivity, NumberType_Int8));
}