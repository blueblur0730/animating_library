#if defined _animating_libarary_
    #endinput
#endif
#define _animating_libarary_

/**
 * CBaseAnimating library for l4d2.
 * 
 * Every entity that has a model uses CBaseAnimating. Classes derived from CBaseAnimating can set a model and animate.
 * It also enables entities to display a studio model.
 * For most of their original functions, please see here:
 * https://github.com/ValveSoftware/source-sdk-2013/blob/master/mp/src/game/server/baseanimating.cpp
 * 
 * Garry's Mod Wiki as reference:
 * https://wiki.facepunch.com/gmod/Entity
 * 
 * For weapons, specifies the world model(w_model) and the view model(v_model) when using the natives.
 * 
 * We will use the decriptings from Garry's Mod Wiki as reference.
*/

methodmap CBaseAnimating
{
    /*<---------------------------->*/
    /* CBaseAnimating Constructor */

    /**
     * Creates a new CBaseAnimating instance. Use this before use any of the native functions below.
     * 
     * @param entity    The entity index of the instance.
     * 
     * @return          A CBaseAnimating pointer address.
     */
    public native CBaseAnimating(int entity);

    /*<------------------>*/
    /* BodyGroup Related */

    // For bodygroup documentations see here:
    // https://developer.valvesoftware.com/wiki/$bodygroup

    /**
     * Returns the Body Group ID of a speciifc class name.
     * 
     * @param name      The name of the Body Group class.
     * 
     * @return          The ID of the specified group class name. 
     *                  -1 if dynamic model is loading (m_bDynamicModelPending).
    */
    public native int FindBodyGroupByName(const char[] name);

    /**
     * Sets the given Body Group ID to the given value.
     * 
     * @note            From the SDK: "// SetBodygroup is not supported on pending dynamic models. Wait for it to load!"
     * @note            iValue is actually a boolean arugument. only 0 or 1 is allowed.
     * 
     * @param iGroup    The Body Group ID to set. Starting from 0.
     * @param iValue    The value to set to.
     * 
     * @noreturn
    */
    public native void SetBodyGroup(int iGroup, int iValue);

    /**
     * Returns the Sub Model ID for the currently active Sub Model of the Body Group corresponding to the given Body Group ID.
     * 
     * @param iGroup    The Body Group ID to get. Starting from 0.
     * 
     * @return          The value of the specified Body Group.
     *                  0 if dynamic model is loading (m_bDynamicModelPending).
    */
    public native int GetBodyGroup(int iGroup);

    /**
     * Returns the number of Sub Models in a given Body Group ID of the Entity's model.
     * 
     * @note This is not the maximum value, as Body Group IDs start with 0.
     * @note Subtract 1 from the value returned by this function to get the maximum Body Group ID for the entity.
     * 
     * @param iGroup    The Body Group ID to get. Starting from 0.
     * 
     * @return          The number of Sub Models in the Body Group.
     *                  0 if dynamic model is loading (m_bDynamicModelPending).
    */
    public native int GetBodyGroupCount(int iGroup);

    /**
     * Retrieve the string value of a specific Body Group ID.
     * 
     * @param iGroup    The Body Group ID to get. Starting from 0.
     * @param name      The buffer to store the name of the Body Group.
     * 
     * @noreturn
    */
    public native void GetBodyGroupName(int iGroup, char[] name);

    /**
     * Retrieve the string value of a part name with the given Body Group ID and part number.
     * 
     * @param iGroup    The Body Group ID to get. Starting from 0.
     * @param iPart     The part number to get. Starting from 0.
     * @param name      The buffer to store the name of the part.
     * 
     * @noreturn
    */
    // L4D2 / Alien Swarm: Reactive Drop / TF2 vscript function.
    public native void GetBodyPartName(int iGroup, int iPart, char[] name);

    /**
     * Returns the body group count of the entity.
     * 
     * @return          The number of Body Groups in the entity's model.
     *                  0 if dynamic model is loading (m_bDynamicModelPending).
    */
    property int BodyGroupNum {
        public native get();
    }

/*
    Take a example: "infected/common_test.mdl".

    $bodygroup "Head"
    {
	    studio "H01_Head_male_01.smd"
	    studio "H01_Head_male_02.smd"
	    studio "H01_Head_male_03.smd"
	    studio "H01_Head_male_suit_01.smd"
	    studio "D1_H01_Head_male_02.smd"
    }

    the function will return the part index excpet the one with "D" started in the name. (which refered as 'damaged')
*/
    /**
     * Find undamaged bodygroup part index
     * 
     * @note            See from: https://github.com/ReactiveDrop/reactivedrop_public_src/blob/0b3a6dcd74dce45e35ca6c0d823fd19ccc610b91/src/game/server/baseanimating.cpp#L2343
     * @note            Used by CBaseAnimating::RandomizeBodygroups, assumming that this is a randomizer for CI Models.
     * 
     * @param iGroup    The Body Group ID to get. Starting from 0.
     * @param iVariant  The variant part to find.
     * 
     * @return          The index of the undamaged part.
     *                  -1 on failure.
    */
    public native int FindBodyGroupVariant(int iGroup, int iVariant);
    
    /**
     * Count total undamaged bodygroup parts
     * 
     * @note            See from: https://github.com/ReactiveDrop/reactivedrop_public_src/blob/0b3a6dcd74dce45e35ca6c0d823fd19ccc610b91/src/game/server/baseanimating.cpp#L2313
     * @note            Used by CBaseAnimating::RandomizeBodygroups, assumming that this is a randomizer for CI Models.
     * 
     * @param iGroup    The Body Group ID to get. Starting from 0.
     * 
     * @return          The total number of undamaged parts.
    */
    public native int CountBodyGroupVariants(int iGroup);

    /*<---------------->*/
    /* RagDoll Related */

    /**
     * Is an entity a ragdoll?
     * 
     * @return          True if the entity is a ragdoll, false otherwise.
    */
    public native bool IsRagdoll();

    /**
     * Can an entity become a ragdoll?
     * 
     * @return          False if an entity dose not have a ragdoll sequence, or entity flag involves FL_TRANSRAGDOLL. 
     *                  True otherwise.
    */
    public native bool CanBecomeRagdoll();

    // const Vector vec3_origin(0,0,0)
    // https://developer.valvesoftware.com/wiki/Vec3_origin

    /**
     * Makes an entity a ragdoll, which kills it immediately.
     * 
     * @note            Same as AcceptEntityInput(enitty, "BecomeRagdoll"), except this time the force vector is up to you. (default: vec3_origin(0,0,0), none force)
     * @note            From SDK: "Make this (target) a client-side (OnClient) simulated entity (ragdoll)".
     * 
     * @param force     Vector of force to be exerted in the physics simulation.
     * 
     * @return          True if the entity is successfully made a ragdoll, false otherwise.
    */
    public native bool BecomeRagdollOnClient(float force[3] = {0,0,0});
}

public SharedPlugin __pl_animating_library = 
{
	name = "animating_library",
	file = "animating_library.smx",
#if defined REQUIRE_PLUGIN
	required = 1,
#else
	required = 0,
#endif
};

#if !defined REQUIRE_PLUGIN
public void __pl_animating_library_SetNTVOptional()
{
    MarkNativeAsOptional("CBaseAnimating.CBaseAnimating");
    MarkNativeAsOptional("CBaseAnimating.FindBodyGroupByName");
    MarkNativeAsOptional("CBaseAnimating.SetBodyGroup");
    MarkNativeAsOptional("CBaseAnimating.GetBodyGroup");
    MarkNativeAsOptional("CBaseAnimating.GetBodyGroupCount");
    MarkNativeAsOptional("CBaseAnimating.GetBodyGroupName");
    MarkNativeAsOptional("CBaseAnimating.GetBodyPartName");
    MarkNativeAsOptional("CBaseAnimating.BodyGroupNum.get");
    MarkNativeAsOptional("CBaseAnimating.FindBodyGroupVariant");
    MarkNativeAsOptional("CBaseAnimating.CountBodyGroupVariants");

    MarkNativeAsOptional("CBaseAnimating.IsRagdoll");
    MarkNativeAsOptional("CBaseAnimating.CanBecomeRagdoll");
    MarkNativeAsOptional("CBaseAnimating.BecomeRagdollOnClient");
}
#endif