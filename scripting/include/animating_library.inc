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
 * https://github.com/ValveSoftware/source-sdk-2013/blob/master/sp/src/game/server/baseanimating.h
 * 
 * Garry's Mod Wiki as reference:
 * https://wiki.facepunch.com/gmod/Entity
 * 
 * For weapons, specifies the world model(w_model) and the view model(v_model) when using the natives.
 * 
 * We will use the decriptions from Garry's Mod Wiki as reference.
*/

// sequence flags
// See here: https://github.com/ValveSoftware/source-sdk-2013/blob/0d8dceea4310fde5706b3ce1c70609d72a38efdf/sp/src/public/studio.h#L2936
#define STUDIO_LOOPING	    (1 << 0)		// ending frame should be the same as the starting frame
#define STUDIO_SNAP		    (1 << 1)		// do not interpolate between previous animation and this one
#define STUDIO_DELTA	    (1 << 2)		// this sequence "adds" to the base sequences, not slerp blends
#define STUDIO_AUTOPLAY	    (1 << 3)		// temporary flag that forces the sequence to always play
#define STUDIO_POST		    (1 << 4)		// 
#define STUDIO_ALLZEROS	    (1 << 5)		// this animation/sequence has no real animation data
//						    (1 << 6)
#define STUDIO_CYCLEPOSE    (1 << 7)		// cycle index is taken from a pose parameter index
#define STUDIO_REALTIME	    (1 << 8)		// cycle index is taken from a real-time clock, not the animations cycle index
#define STUDIO_LOCAL	    (1 << 9)		// sequence has a local context sequence
#define STUDIO_HIDDEN	    (1 << 10)		// don't show in default selection views
#define STUDIO_OVERRIDE	    (1 << 11)		// a forward declared sequence (empty)
#define STUDIO_ACTIVITY	    (1 << 12)		// Has been updated at runtime to activity index
#define STUDIO_EVENT	    (1 << 13)		// Has been updated at runtime to event index
#define STUDIO_WORLD	    (1 << 14)		// sequence blends in worldspace

methodmap CBaseAnimating
{
    /*<---------------------------->*/
    /* CBaseAnimating Constructor */

    /**
     * Creates a new CBaseAnimating instance. Use this before use any of the native functions below.
     * 
     * @param entity    The entity index of the instance. (must have a model)
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
     * @note            From the SDK: "SetBodygroup is not supported on pending dynamic models. Wait for it to load!"
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
    public native bool BecomeRagdollOnClient(float force[3] = {0.0, 0.0, 0.0});

    /*<---------------->*/
    /* Sequence Related */

    // see documenation here:
    // https://developer.valvesoftware.com/wiki/$sequence
    // https://developer.valvesoftware.com/wiki/CBaseAnimating
    // https://srcents.miraheze.org/wiki/CBaseAnimating
    // https://developer.valvesoftware.com/wiki/Animating_a_model

    // Any sequence number should be >= 0.
    // bad seqeunce number may cause some unknown errors.

    /**
     * Get/Set the value of m_nSequence.
     * 
     * @note            set() uses SDKCall function.
    */
    property int m_nSequence {
        public native get();
        public native set(int sequence);
    }

    /**
     * Return the name of the sequence for the index provided.
     * 
     * @note            Returns string "Not Found!" on bad sequence number.
     * @note            Returns string "No Model!" if no model is found on this enitty.
     * 
     * @param sequence  The index of the sequence to get the name of.
     * @param name      The buffer to store the name of the sequence.
     * 
     * @noreturn
    */
    public native void GetSequenceName(int sequence, char[] name);

    /**
     * Return activity id out of sequence id.
     * 
     * @note            For activity id, see left4dhooks_anim.inc
     * 
     * @param sequence  The index of the sequence to get the activity of.
     * 
     * @return          The activity id of the sequence.
    */
    public native int GetSequenceActivity(int sequence);

    /**
     * Returns the activity name for the given sequence id.
     * 
     * @note            Returns string "Not Found!" on bad sequence number.
     * @note            Returns string "No Model!" if no model is found on this enitty.
     * 
     * @param sequence  The index of the sequence to get the activity name of.
     * @param name      The buffer to store the name of the activity.
     * 
     * @noreturn
    */
    public native void GetSequenceActivityName(int sequence, char[] name);

    /**
     * Returns the internal keyvalues pointer address for the given sequence id.
     * 
     * @param sequence  The index of the sequence to get the keyvalues of.
     * 
     * @return          The internal keyvalues pointer address.
     *                  NULL on failure.
    */
    public native Address GetSequenceKeyValues(int sequence);
    // public native SourceKeyValues GetSequenceKeyValues(int sequence);
    // see l4d2_source_keyvalues by fdxx.

    /**
     * Gets a Vector which describes the sequence's extracted motion over its entire duration.
     * 
     * @note            Bad sequence number will log the error message to the console and return nothing.
     * 
     * @param sequence  The index of the sequence to get the motion of.
     * @param vec       The buffer to store the motion vector.
     * 
     * @noreturn
    */
    public native void GetSequenceLinearMotion(int sequence, float vec[3])

    /**
     * Returns the change in heading direction in between the start and the end of the sequence.
     * 
     * @note            Bad sequence number will log the error message to the console and return nothing.
     * 
     * @param sequence  The index of the sequence to get the motion of.
     * 
     * @return          A yaw angle of the vector returned by GetSequenceLinearMotion().
     *                  99999(NOMOTION) if the sequence has no motion.
    */
    public native float GetSequenceMoveYaw(int sequence);

    /**
     * Returns an entity's sequence move distance (the change in position over the course of the entire sequence).
     * 
     * @note            Bad sequence number will log the error message to the console and return nothing.
     * @note            Returns the length of the vector returned by GetSequenceLinearMotion().
     * 
     * @param sequence  The index of the sequence to get the motion of.
     * 
     * @return          The distance the entity moved over the course of the sequence.
    */
    public native float GetSequenceMoveDist(int sequence);

    /**
     * Returns the delta movement and angles of a sequence of the entity's model.
     * 
     * @param nSequence     The index of the sequence to get the motion of.
     * @param fromCycle     The starting cycle of the sequence. 0 is the start of the animation, 1 is the end.
     * @param toCycle       The ending cycle of the sequence. 0 is the start of the animation, 1 is the end. Values like 2, etc are allowed.
     * @param deltaPosition The delta vector of the animation, how much the model's origin point moved. A Vector buffer to store the delta position.
     * @param deltaAngles   The delta angle of the animation. A QAngle buffer to store the delta angles.
     * 
     * @return              True if the operation was successful, false otherwise.
    */
    public native bool GetSequenceMovement(int nSequence, float fromCycle, float toCycle, float deltaPosition[3], float deltaAngles[3]);

    /**
     * Returns length of sequence.
     * 
     * @param sequence  The index of the sequence to get the duration of.
     * 
     * @return          The duration of the sequence in seconds.
     *                  0.1 on unavailable sequence, or (x < 0 || x > Max sequence number of the model of this entity)
    */
    public native float SequenceDuration(int sequence);

    /**
     * Returns the cycle rate of the sequence.
     * 
     * @param sequence  The index of the sequence to get the cycle rate of.
     * 
     * @return          The cycle rate of the sequence in seconds per cycle.
     *                  10.0 if sequence duration <= 0.0.
    */
    public native float GetSequenceCycleRate(int sequence);

    /**
     * Returns the ground speed of the entity's sequence.
     * 
     * @note            m_flGroundSpeed = GetSequenceGroundSpeed() * m_flModelScale
     * 
     * @param sequence  The index of the sequence to get the ground speed of.
     * 
     * @return          The ground speed of the sequence in units per second.
     *                  0.0 if sequence duration <= 0.0.
    */
    public native float GetSequenceGroundSpeed(int sequence);

    /**
     * Returns sequence ID from its name.
     * 
     * @note            From SDK: "Looks up a sequence by sequence name first, then by activity name."
     * @note            Which means a failure on the sequence name lookup will call LookupActivity().
     * 
     * @param name      The name of the sequence to get the ID of.
     * 
     * @return          The index of the sequence with the given name. Or an index calls from SelectWeightedSequence() by LookupActivity().
     *                  0 if sequence is not available (notice: 0 is a valid sequence number too), -1 (ACT_INVALID) on failure for LookupActivity().
    */
    public native int LookupSequence(const char[] name);

    /**
     * Checks if a sequence number is valid or not.
     * 
     * @note            This native uses SDKCall since we need to know how many sequence this entity's model has.
     * 
     * @param sequence  The index of the sequence to check.
     * 
     * @return          True if the sequence is valid, false otherwise.
    */
    public native bool IsValidSequence(int sequence);

    /**
     * Returns whether the entity's current sequence is finished or not. (m_bSequenceFinished)
     * 
     * @note            Uses SDKCall. or you can use GetEntProp youself.
     * 
     * @return          True if the sequence is finished, false otherwise.
    */
    public native bool IsSequenceFinished();

    /**
     * Checks if a sequence has looping flag or not. (m_bSequenceLoops)
     * 
     * @note            Uses SDKCall. or you can use GetEntProp youself.
     * @note            See 'struct mstudioseqdesc_t' (sequence descriptions) here: https://github.com/ValveSoftware/source-sdk-2013/blob/0d8dceea4310fde5706b3ce1c70609d72a38efdf/mp/src/public/studio.h#L779
     * 
     * @param sequence  The index of the sequence to check.
     * 
     * @return          True if the sequence has looping flag, false otherwise.
    */
    public native bool IsSequenceLooping(int sequence);

    /**
     * Reset a sequence by sequence ID. If the ID is different than the current sequence, switch to the new sequence.
     * 
     * @note            The informations below is from Garry's Mod Wiki:
     * @note            "Plays an animation on the entity. This may not always work on engine entities."
     * @note            "This will not reset the animation on viewmodels, use (in c++) CBaseViewModel::SendViewModelMatchingSequence instead."
     * @note            "This will not work properly if called directly after calling (in c++) CBaseAnimating::SetModel. Consider waiting until the next Tick."
     * 
     * @param sequence  The index of the sequence to play.
     * 
     * @noreturn
    */
    public native void ResetSequence(int sequence);

    /**
     * Reset entity sequence info such as playback rate, ground speed, last event check, etc.
     * 
     * @note            See: https://github.com/ValveSoftware/source-sdk-2013/blob/0d8dceea4310fde5706b3ce1c70609d72a38efdf/mp/src/game/server/baseanimating.cpp#L883
     * 
     * @noreturn
    */
    public native void ResetSequenceInfo();

    /**
     * Returns a transition from the given start and end sequence.
     * 
     * @note                    From Garry's Mod Wiki: "This function was only used by HL1 entities and NPCs, before the advent of sequence blending and gestures."
     * @note                    https://github.com/ValveSoftware/source-sdk-2013/blob/0d8dceea4310fde5706b3ce1c70609d72a38efdf/mp/src/game/server/baseanimating.cpp#L2092
     * @note                    https://github.com/ValveSoftware/source-sdk-2013/blob/0d8dceea4310fde5706b3ce1c70609d72a38efdf/sp/src/game/shared/animation.cpp#L616
     * 
     * @param iCurrentSequence  The index of The currently playing sequence
     * @param iGoalSequence     The index of the goal sequence.
     * 
     * @return                  The transition sequence, -1 if not available.
    */
    public native int FindTransitionSequence(int iCurrentSequence, int iGoalSequence);

    /**
     * No description found for now. In L4D2 this is called by CDynamicProp::PropSetSequence.
     * 
     * @note                    See: https://github.com/ValveSoftware/source-sdk-2013/blob/0d8dceea4310fde5706b3ce1c70609d72a38efdf/sp/src/game/shared/animation.cpp#L701
     * 
     * @param iCurrentSequence  The index of The currently playing sequence (m_nSequence)
     * @param flCurrentCycle    The current cycle of the sequence.  (m_flCycle)
     * @param flCurrentRate     The current playback rate of the sequence. (m_flPlaybackRate)
     * @param iGoalSequence     The index of the goal sequence. (m_iGoalSequence)
     * @param nNextSequence     ?.
     * @param flNextCycle       ?.
     * @param iNextDir          ? (m_iTransitionDirection).
     * 
     * @return                  True if the operation was successful, false otherwise.
    */
    public native bool GoToSequence(int iCurrentSequence, float flCurrentCycle, float flCurrentRate, int iGoalSequence, int &nNextSequence, float &flNextCycle, int &iNextDir)
}

/**
 * Returns the flags number of the given sequence.
 * 
 * @note            See flags in the head of this file.
 * 
 * @param entity    The entity index to get the flags of its model's sequence.
 * @param sequence  The index of the sequence to get the flags of.
 * 
 * @return          The flags number of the given sequence.
*/
native int GetSequenceFlags(int entity, int sequence);


methodmap CStudioHdr
{
    /*<------------------------>*/
    /* CStudioHdr Constructor */

    /**
     * Creates a new CStudioHdr instance based on the model path.
     * 
     * @note            Calls operator new to allocate memory for the instance. Must be freed using deleteThis().
     * 
     * @param entity    The entity index to create for. (must have a model)
     * 
     * @return          A CStudioHdr pointer address.
     *                  Address_Null if the entity has no model, or SDKCall failed.
    */
    public native CStudioHdr(int entity);

    /**
     * Frees the memory allocated for the CStudioHdr instance created for an entity.
     * 
     * @note            Even if the game itself will check if the pointer is null or not, it's still a good practice to free the memory manully.
     * 
     * @noreturn
    */
    public native void deleteThis();
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

    MarkNativeAsOptional("CBaseAnimating.m_nSequence.get");
    MarkNativeAsOptional("CBaseAnimating.m_nSequence.set");
    MarkNativeAsOptional("CBaseAnimating.GetSequenceName");
    MarkNativeAsOptional("CBaseAnimating.GetSequenceActivity");
    MarkNativeAsOptional("CBaseAnimating.GetSequenceActivityName");
    MarkNativeAsOptional("CBaseAnimating.GetSequenceKeyValues");
    MarkNativeAsOptional("CBaseAnimating.GetSequenceLinearMotion");
    MarkNativeAsOptional("CBaseAnimating.GetSequenceMoveYaw");
    MarkNativeAsOptional("CBaseAnimating.GetSequenceMoveDist");
    MarkNativeAsOptional("CBaseAnimating.GetSequenceMovement");
    MarkNativeAsOptional("CBaseAnimating.SequenceDuration");
    MarkNativeAsOptional("CBaseAnimating.GetSequenceCycleRate");
    MarkNativeAsOptional("CBaseAnimating.GetSequenceGroundSpeed");
    MarkNativeAsOptional("CBaseAnimating.LookupSequence");
    MarkNativeAsOptional("CBaseAnimating.IsValidSequence");
    MarkNativeAsOptional("CBaseAnimating.IsSequenceFinished");
    MarkNativeAsOptional("CBaseAnimating.IsSequenceLooping");
    MarkNativeAsOptional("CBaseAnimating.ResetSequence");
    MarkNativeAsOptional("CBaseAnimating.ResetSequenceInfo");
    MarkNativeAsOptional("CBaseAnimating.FindTransitionSequence");
    MarkNativeAsOptional("CBaseAnimating.GoToSequence");

    MarkNativeAsOptional("GetSequenceFlags");

    MarkNativeAsOptional("CStudioHdr.CStudioHdr");
    MarkNativeAsOptional("CStudioHdr.deleteThis");
}
#endif