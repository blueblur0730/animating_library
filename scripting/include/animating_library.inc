#if defined _animating_libarary_
    #endinput
#endif
#define _animating_libarary_

/**
 * Animating library for L4D2.
 * 
 * Every entity that has a model uses CBaseAnimating. Classes derived from CBaseAnimating can set a model and animate.
 * It also enables entities to display a studio model.
 * 
 * For most of their original functions, please see here:
 * https://github.com/ValveSoftware/source-sdk-2013/blob/master/mp/src/game/server/baseanimating.cpp
 * https://github.com/ValveSoftware/source-sdk-2013/blob/master/sp/src/game/server/baseanimating.h
 * 
 * Garry's Mod Wiki as reference:
 * https://wiki.facepunch.com/gmod/Entity
 * 
 * Other References:
 * https://twhl.info/wiki/page/Entity_Programming_-_Introduction_to_Entities_with_Animated_Models
 * 
 * For bodygroup documentations, see here:
 * https://developer.valvesoftware.com/wiki/$bodygroup
 * 
 * For sequence documentations, see here:
 * https://developer.valvesoftware.com/wiki/$sequence
 * https://developer.valvesoftware.com/wiki/CBaseAnimating
 * https://srcents.miraheze.org/wiki/CBaseAnimating
 * https://developer.valvesoftware.com/wiki/Animating_a_model
 * 
 * For pose parameters, see here:
 * https://developer.valvesoftware.com/wiki/$poseparameter
 * 
 * For weapons, please specifies the world model(w_model) and the view model(v_model), which has a different entity index in the game, when using the natives.
 * 
 * We will use some decriptions from Garry's Mod Wiki as reference.
*/

// sequence flags
// See here: https://github.com/ValveSoftware/source-sdk-2013/tree/master/mp/src/public/studio.h#L2936
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
     *                  It can be used to call any function from this class, and classes inherited from it.
     */
    public native CBaseAnimating(int entity);

    /*<------------------>*/
    /* BodyGroup Related */

    /**
     * Get/Set the value of m_nBody.
     * 
     * @note            This is different from Get/SetBodyGroup(). m_nBody represents the currently active Body Group ID of this entity's model.
    */
    property int m_nBody {
        public native get();
        public native set(int value);
    }

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
     * Sets the Bodypart (iValue) of a chosen Bodygroup ID (iGroup).
     * 
     * @note            From the SDK: "SetBodygroup is not supported on pending dynamic models. Wait for it to load!"
     * 
     * @param iGroup    The Body Group ID to set. Starting from 0.
     * @param iValue    The value to set to.
     * 
     * @noreturn
    */
    public native void SetBodyGroup(int iGroup, int iValue);

    /**
     * Gets the current Bodypart ID of the given Bodygroup ID.
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
     * @note            Return an empty string if the entity has no model, or an invalid Body Group ID.
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
    public native int GetBodyGroupNum();

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
     * @note            See from: https://github.com/ReactiveDrop/reactivedrop_public_src/tree/reactivedrop_beta/src/game/server/baseanimating.cpp#L2343
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
     * @note            See from: https://github.com/ReactiveDrop/reactivedrop_public_src/tree/reactivedrop_beta/src/game/server/baseanimating.cpp#L2313
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
     * Get/Set the value of m_flCycle.
     * 
     * @note            0.0 =< m_flCycle <= 1.0
    */
    property float m_flCycle {
        public native get();
        public native set(float cycle);
    }

    /**
     * Get/Set the value of m_flPlaybackRate.
     * 
     * @note            0.0 =< m_flPlaybackRate, set to 0.0 will stop the animation. 1.0 is the normal speed.
    */
    property float m_flPlaybackRate {
        public native get();
        public native set(float rate);
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
     * Returns the last visible cycle of the sequence.
     * 
     * @note            returns pSeqdesc(iSequence).fadeouttime * GetSequenceCycleRate(iSequence) * m_flPlaybackRate.
     * 
     * @param sequence  The index of the sequence to get the last visible cycle of.
     * 
     * @return          The last visible cycle of the sequence.
     *                  1.0 if the entity has no model, or the sequence has looping flag.
    */
    public native float LastVisibleCycle(int sequence);

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
     * @note            See 'struct mstudioseqdesc_t' (sequence descriptions) here: https://github.com/ValveSoftware/source-sdk-2013/tree/master/mp/src/public/studio.h#L779
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
     * @note            See: https://github.com/ValveSoftware/source-sdk-2013/tree/master/mp/src/game/server/baseanimating.cpp#L883
     * 
     * @noreturn
    */
    public native void ResetSequenceInfo();

    /**
     * Returns a transition from the given start and end sequence.
     * 
     * @note                    From Garry's Mod Wiki: "This function was only used by HL1 entities and NPCs, before the advent of sequence blending and gestures."
     * @note                    https://github.com/ValveSoftware/source-sdk-2013/tree/master/mp/src/game/server/baseanimating.cpp#L2092
     * @note                    https://github.com/ValveSoftware/source-sdk-2013/tree/master/mp/src/game/shared/animation.cpp#L616
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
     * @note                    See: https://github.com/ValveSoftware/source-sdk-2013/tree/master/mp/src/game/shared/animation.cpp#L701
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
    public native bool GoToSequence(int iCurrentSequence, float flCurrentCycle, float flCurrentRate, int iGoalSequence, int &nNextSequence, float &flNextCycle, int &iNextDir);

    /**
     * Returns sequence ID corresponding to given activity ID.
     * 
     * @note            For activity ID, see left4dhooks_anim.inc.
     * @note            Opposite of GetSequenceActivity.
     * 
     * @param iActivity The activity ID to get the sequence of.
     * 
     * @return          The sequence ID corresponding to given activity ID.
    */
    public native int SelectWeightedSequence(int iActivity);

    /*<-------------->*/
    /* Model Related */

    /**
     * Get/Set the value of m_nModelScale.
     * 
     * @note            set() uses SDKCall function. (CBaseAnimating::SetModelScale), some info about this function is below:
     * @note            From Garry's Mod Wiki: "If the entity is a Player or an NPC the hitboxes will be scaled as well."
     * @note            From Garry's Mod Wiki: "For some entities, calling (in c++) CBaseAnimating::Activate after this will scale the collision bounds and PhysObj as well; be wary as there's no optimization being done internally and highly complex collision models might crash the server."
     * @note            From Garry's Mod Wiki: "Client-side trace detection seems to mess up if change_duration is set to anything but zero."
    */
    property float m_nModelScale {
        public native get();
        public native set(float scale /*float change_duration = 0.0f*/);
    }

    /**
     * Set this entity's model.
     * 
     * @note            Same as sourcemod native SetEntityModel().
     * @note            Once called, it will delete the original CStudioHdr instance of this entity's model.
     * @note            From Garry's Mod Wiki: "This does not update the physics of the entity."
     * @note            From Garry's Mod Wiki: "This silently fails when given an empty string. (or a string pointed to a none existed model.)"
     * 
     * @param szModelName The name of the model to set. Be sure it is corrent and not empty.
     * 
     * @noreturn
    */
    public native void SetModel(const char[] szModelName);

    /**
     * Retrieves the internal CStudioHdr pointer address of the entity's model through *m_pStudioHdr.
     * 
     * @return          The address of the pointer.
    */
    public native CStudioHdr GetModelPtr();

    /*<-------------->*/
    /* Bone Related */

    /**
     * Returns index number of a given named bone
     * 
     * @param szName    The name of the bone to get the index of.
     * 
     * @return          The index number of the given named bone.
     *                  -1 if the bone is not found.
    */
    public native int LookupBone(const char[] szName);

    /**
     * Returns the number of bones in the model.
     * 
     * @return          The number of bones in the model.
    */
    public native int GetNumBones();

    /**
     * Returns the position and angle of the given bone index, relative to the world.
     * 
     * @note            A lot notice from Garry's Mod Wiki. See here: https://wiki.facepunch.com/gmod/Entity:GetBonePosition
     * @note            Returns nothing if the entity has no model, or the bone index is invalid. (x > max bone number || x < 0)
     * 
     * @noreturn
    */
    public native void GetBonePosition(int iBone, float vBoneOrigin[3], float vBoneAngles[3]);

    /**
     * Gets the bone for an attachment
     * 
     * @param iAttachment   The index of the attachment to get the bone for.
     * 
     * @return              The bone index for the given attachment ID.
     *                      0 if iAttachment < 1 || iAttachment > GetNumAttachments() .
    */
    public native int GetAttachmentBone(int iAttachment);

    /**
     * Returns the CBoneCache pointer address of the entity's model.
     * 
     * @return          The address of the pointer.
    */
    public native Address GetBoneCache();

    /**
     * Returns the physics bone index for the given bone index. An index into physically simulated bone
     * 
     * @param iBone  The index of the bone to get the physics bone index of.
     * 
     * @return      The physics bone index for the given bone index.
     *              0 if the entity has no model, or the bone index is invalid. (x >= max bone number || x < 0)
    */
    public native int GetPhysicsBone(int iBone);

    /**
     * Gets the bone the hit box is attached to
     * 
     * @param iHitboxIndex  The index of the hit box to get the bone for.
     * 
     * @return              The bone index for the given hit box index.
     *                      0 if the entity has no model, or iHitboxIndex >= the number of hitboxes.
    */
    public native int GetHitboxBone(int iHitboxIndex);

    /*<------------------->*/
    /* Attachment Related */

    /**
     * Returns the attachment index of the given attachment name.
     * 
     * @note            Same as sourcemod native LookupAttachment().
     * 
     * @param szName    The name of the attachment to get the index of.
     * 
     * @return          The index of the given attachment name.
    */
    public native int LookupAttachment(const char[] szName);

    /**
     * Returns the world location and world angles of an attachment.
     * 
     * @note                Same as sourcemod native GetEntityAttachment().
     * @note                Returns nothing if the entity has no model, or the attachment index is invalid. 
     * 
     * @param iAttachment   The index of the attachment to get the world location and world angles of.
     * @param absOrigin     A Vector buffer to store the world location of the attachment.
     * @param absAngles     A QAngle buffer to store the world angles of the attachment.
     * 
     * @return              True if the operation was successful, false otherwise.
    */
    public native bool GetAttachment(int iAttachment, float absOrigin[3], float absAngles[3]);

    /*<----------------------->*/
    /* Pose Parameter Related */

    /**
     * Returns the element index of the given pose parameter name.
     * 
     * @param szName        The name of the pose parameter to get the element index of.
     * 
     * @return              The element index of the given pose parameter name.
     *                      0 if the entity has no model or sequence is not available, -1 on not found.
    */
    public native int LookupPoseParameter(const char[] szName);

    /**
     * Returns the value of the given pose parameter index.
     * 
     * @note                May have bug? See Garry's Mod Wiki: https://wiki.facepunch.com/gmod/Entity:GetPoseParameter
     * 
     * @param iParameter    The index of the pose parameter to get the value of.
     * 
     * @return              The value of the given pose parameter index.
     *                      0.0 if the entity has no model or sequence is not available or bad iParameter index (x <= 0), or not found.
    */
    public native float GetPoseParameter(int iParameter);

    /**
     * Sets the value of the given pose parameter index.
     * 
     * @param iParameter    The index of the pose parameter to set the value of.
     * @param flValue       The value to set the pose parameter to.
     * 
     * @return              Unknown. Should be flValue itself.
    */
    public native float SetPoseParameter(int iParameter, float flValue);

    /**
     * Returns pose parameter range.
     * 
     * @note                Return the range if true, else minValue = 0.0, maxValue = 1.0.
     * 
     * @param index         The index of the pose parameter to get the range of.
     * @param minValue      A float buffer to store the minimum value of the pose parameter.
     * @param maxValue      A float buffer to store the maximum value of the pose parameter.
     * 
     * @return              True if the operation was successful, false otherwise.
    */
    public native bool GetPoseParameterRange(int index, float &minValue, float &maxValue);

    /*<------------------->*/
    /* HitBox Set Related */

    /**
     * Get/Set the value of m_nHitboxSet.
    */
    property int m_nHitboxSet {
        public native get();
        public native set(int setnum);
    }

    /**
     * Retrieves the number of hitbox sets in the model.
     * 
     * @return          The number of hitbox sets in the model.
     *                  -1 if the entity has no model.
    */
    public native int GetNumHitboxSets();

    /**
     * Computes a box's absolute position that surrounds all hitboxes.
     * 
     * @note                  Returns nothing on the vector if return false.
     * @note                  See SDK: https://github.com/ValveSoftware/source-sdk-2013/tree/master/mp/src/game/server/baseanimating.cpp#L3120
     * 
     * @param pVecWorldMins   A Vector buffer to store the minimums absolute position of the box.
     * @param pVecWorldMaxs   A Vector buffer to store the maximums absolute position of the box.
     * 
     * @return                True if the operation was successful, false if the entity has no model or have a bad m_nHitboxSet value.
    */
    public native bool ComputeHitboxSurroundingBox(float pVecWorldMins[3], float pVecWorldMaxs[3]);

    /**
     * No descripting found yet.
     * 
     * @note                    See SDK: https://github.com/ValveSoftware/source-sdk-2013/tree/master/mp/src/game/server/baseanimating.cpp#L3217
     * 
     * @return                  unknown.
    */
    public native int GetHitboxesFrontside(int boxList, int boxMax, const float normal[3], float dist);

    /*<------------------------>*/
    /* Animation Event Related */

    /**
     * Dispatches all animation events on one entity.
     * 
     * @note                Do nothing if the entity has no model, no available sequence, m_flPlaybackRate == 0.0, or it has no animation event.
     * @note                Catches all animation events in the time frame of flFutureInterval, and calls HandleAnimEvent for each caught events. This is typically called every 0.1 seconds in the Think method.
     * 
     * @param eventHandler  The entity to dispatch the animation events on. For most cases, this should be yourself (this).
     * 
     * @noreturn
    */
    public native void DispatchAnimEvents(CBaseAnimating eventHandler);

    /*<------------------------->*/
    /* Animation / Misc Related */

    /**
     * Copy animation data of source entity's model to our own entity's model.
     * This includes sequence index, model scale, cycle, effect...
     * 
     * @note            See: https://github.com/ValveSoftware/source-sdk-2013/tree/master/mp/src/game/server/baseanimating.cpp#L3207
     * 
     * @param pSource   The source entity to copy the animation data from. It uses instance since we need to pass a pointer.
     * 
     * @noreturn
    */
    public native void CopyAnimationDataFrom(CBaseAnimating pSource)
}

// Listed this native alone because it has no class.

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

// Activity List
// https://github.com/ValveSoftware/source-sdk-2013/blob/master/mp/src/game/shared/activitylist.cpp
// all activity index should be parsed by left4dhooks_anim.inc.
// could have a consideration of things like: https://developer.valvesoftware.com/wiki/Adding_Weapon_Inspect

/**
 * Register a new shared activity to the game's activity database (Activity List).
 * 
 * @note                    If this function returns false, the console should print: "***\nShared activity collision! %s<->%s\n***\n"
 * 
 * @param pszActivityName   The name of the activity to register.
 * @param iActivityIndex    The index of the activity to register.
 * 
 * @return                  True if the operation was successful, false if the name or index has already been registered.
*/
native bool ActivityList_RegisterSharedActivity(const char[] pszActivityName, int iActivityIndex);

/**
 * Register a new private activity to the game's activity database (Activity List).                
 * 
 * @param pszActivityName   The name of the activity to register.
 * 
 * @return                  The index of the registered activity. Normally, this indicates g_HighestActivity + 1. 
 *                          -1 (ACT_INVALID) if the name collides with a shared activity. 
 *                          If the name collides with a already registered private activity, returns the index of the existing private activity.
*/
native int ActivityList_RegisterPrivateActivity(const char[] pszActivityName);

/**
 * Get the index for a given activity name
 * 
 * @note                    From SDK: "Done at load time for all models."
 * @note                    This function searches activity name through activitylist_t, compared with LookupActivity() which searches through mstudioseqdesc_t, which should be local.
 * 
 * @param pszActivityName   The name of the activity to get the index of.
 * 
 * @return                  The index of the given activity name.
*/
native int ActivityList_IndexForName(const char[] pszActivityName);

/**
 * Get the name for a given index.
 * 
 * @note                    Return NULL (c++), which should be NULL_STRING in sp on none existed index.
 * 
 * @param activityIndex     The index of the activity to get the name of.
 * @param pszActivityName   A buffer to store the name of the activity.
 * 
 * @noreturn
*/
native void ActivityList_NameForIndex(int activityIndex, char[] pszActivityName);

/**
 * Get the highest activity index.
 * 
 * @return                  The highest activity index.
*/
native int ActivityList_HighestActivity();

/**
 * Find the hitbox set index by name.
 * 
 * @param entity    The entity index to find the hitbox set for.
 * @param name      The name of the hitbox set to find.
 * 
 * @return          The index of the hitbox set with the given name.
 *                  -1 if the entity has no model, or the hitbox set is not found.
*/
native int FindHitboxSetByName(int entity, const char[] name);

methodmap CStudioHdr
{
    /*<------------------------>*/
    /* CStudioHdr Constructor */

    /**
     * Creates a new CStudioHdr instance based on the model path via operator new.
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
     * @note            The game itself will check if the pointer is null or not.
     * @note            Recommend not to delete an existed and being used instance in case of the error.
     * 
     * @noreturn
    */
    public native void deleteThis();

    /**
     * Retrieves the number of attachments in the model.
     * 
     * @note            https://github.com/ValveSoftware/source-sdk-2013/tree/master/mp/src/public/studio.cpp#L1093
     * 
     * @return          The number of attachments in the model.
     *                  Returns local attachment number if m_pVModel == NULL.
    */
    public native int GetNumAttachments();

    /**
     * Retrieves the number of pose parameters in the model.
     * 
     * @return          The number of pose parameters in the model.
    */
    public native int GetNumPoseParameters();
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
    MarkNativeAsOptional("CBaseAnimating.m_nBody.get");
    MarkNativeAsOptional("CBaseAnimating.m_nBody.set");
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
    MarkNativeAsOptional("CBaseAnimating.m_flCycle.get");
    MarkNativeAsOptional("CBaseAnimating.m_flCycle.set");
    MarkNativeAsOptional("CBaseAnimating.m_flPlaybackRate.get");
    MarkNativeAsOptional("CBaseAnimating.m_flPlaybackRate.set");
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
    MarkNativeAsOptional("CBaseAnimating.LastVisibleCycle");
    MarkNativeAsOptional("CBaseAnimating.GetSequenceGroundSpeed");
    MarkNativeAsOptional("CBaseAnimating.LookupSequence");
    MarkNativeAsOptional("CBaseAnimating.IsValidSequence");
    MarkNativeAsOptional("CBaseAnimating.IsSequenceFinished");
    MarkNativeAsOptional("CBaseAnimating.IsSequenceLooping");
    MarkNativeAsOptional("CBaseAnimating.ResetSequence");
    MarkNativeAsOptional("CBaseAnimating.ResetSequenceInfo");
    MarkNativeAsOptional("CBaseAnimating.FindTransitionSequence");
    MarkNativeAsOptional("CBaseAnimating.GoToSequence");
    MarkNativeAsOptional("CBaseAnimating.SelectWeightedSequence");

    MarkNativeAsOptional("CBaseAnimating.m_flModelScale.get");
    MarkNativeAsOptional("CBaseAnimating.m_flModelScale.set");
    MarkNativeAsOptional("CBaseAnimating.SetModel");
    MarkNativeAsOptional("CBaseAnimating.GetModelPtr");

    MarkNativeAsOptional("CBaseAnimating.LookupBone");
    MarkNativeAsOptional("CBaseAnimating.GetNumBones");
    MarkNativeAsOptional("CBaseAnimating.GetBonePosition");
    MarkNativeAsOptional("CBaseAnimating.GetAttachmentBone");
    MarkNativeAsOptional("CBaseAnimating.GetBoneCache");
    MarkNativeAsOptional("CBaseAnimating.GetPhysicsBone");
    MarkNativeAsOptional("CBaseAnimating.GetHitboxBone");

    MarkNativeAsOptional("CBaseAnimating.LookupAttachment");
    MarkNativeAsOptional("CBaseAnimating.GetAttachment");

    MarkNativesAsOptional("CBaseAnimating.LookupPoseParameter");
    MarkNativesAsOptional("CBaseAnimating.GetPoseParameter");
    MarkNativesAsOptional("CBaseAnimating.SetPoseParameter");
    MarkNativesAsOptional("CBaseAnimating.GetPoseParameterRange");

    MarkNativeAsOptional("CBaseAnimating.m_nHitboxSet.get");
    MarkNativeAsOptional("CBaseAnimating.m_nHitboxSet.set");
    MarkNativeAsOptional("CBaseAnimating.ComputeHitboxSurroundingBox");
    MarkNativeAsOptional("CBaseAnimating.GetNumHitboxSets");
    MarkNativeAsOptional("CBaseAnimating.GetHitboxesFrontside");

    MarkNativeAsOptional("CBaseAnimating.DispatchAnimEvents");

    MarkNativeAsOptional("CBaseAnimating.CopyAnimationDataFrom");

    MarkNativeAsOptional("GetSequenceFlags");
    MarkNativeAsOptional("ActivityList_RegisterSharedActivity");
    MarkNativeAsOptional("ActivityList_RegisterPrivateActivity");
    MarkNativeAsOptional("ActivityList_IndexForName");
    MarkNativeAsOptional("ActivityList_NameForIndex");
    MarkNativeAsOptional("ActivityList_HighestActivity");
    MarkNativeAsOptional("FindHitboxSetByName");

    MarkNativeAsOptional("CStudioHdr.CStudioHdr");
    MarkNativeAsOptional("CStudioHdr.deleteThis");
    MarkNativeAsOptional("CStudioHdr.GetNumAttachments");
    MarkNativeAsOptional("CStudioHdr.GetNumPoseParameters");
}
#endif