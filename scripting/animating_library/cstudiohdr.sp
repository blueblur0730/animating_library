#if defined _animating_libarary_cstudiohdr_
    #endinput
#endif
#define _animating_libarary_cstudiohdr_

#define MAX_ENTITIES 2048

CStudioHdr pStudioHdr[MAX_ENTITIES + 1];

any Native_CStudioHdr(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);

    pStudioHdr[entity] = CStudioHdr(entity);
    return pStudioHdr[entity].Pointer;
}

int Native_CStudioHdr_DeleteThis(Handle plugin, int numParams)
{
    int entity = GetNativeCell(2);

    pStudioHdr[entity].deleteThis();
    return 0;
}