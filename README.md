# [L4D2/ANY?] Library for Animating

### Introduction

- Various internal functions of class CBaseAnimating or others. Currently supported L4D2.

### Note

- These natives are NOT TESTED. Use at your own risk. I'd be appreciated if you could report any issues or bugs, or help fix them.
- May not work in windows server since the signatures are unstable or not found.

### Credits To

- Forgetest, for his original idea of gamedata methodmap wrapper for setting up, which increases the overall readability of the code.
- LuqS, for his findings on CStudioHdr stuff.

### Requiements

- None.

### ChangeLog

- 10/5/24: v1.0
  - Initial commit.
  - Natives:
    1. CBaseAnimating.FindBodyGroupByName
    2. CBaseAnimating.SetBodyGroup

- 10/6/24: v1.1
  - Natives:
    1. CBaseAnimating.GetBodyGroup
    2. CBaseAnimating.GetBodyGroupCount
    3. CBaseAnimating.GetBodyGroupName
    4. CBaseAnimating.GetBodyPartName
    5. CBaseAnimating.BodyGroupNum.get
    6. CBaseAnimating.FindBodyGroupVariant
    7. CBaseAnimating.CountBodyGroupVariants

- 10/7/24: v1.2
  - Natives:
    1. CBaseAnimating.IsRagdoll
    2. CBaseAnimating.CanBecomeRagdoll
    3. CBaseAnimating.BecomeRagdollOnClient

- 10/7/24: v1.3
  - Natives:
    1. CBaseAnimating.m_nSequence.get
    2. CBaseAnimating.m_nSequence.set
    3. CBaseAnimating.GetSequenceName
    4. CBaseAnimating.GetSequenceActivity
    5. CBaseAnimating.GetSequenceActivityName
    6. CBaseAnimating.GetSequenceKeyValues
    7. CBaseAnimating.GetSequenceLinearMotion
    8. CBaseAnimating.GetSequenceMoveYaw
    9. CBaseAnimating.GetSequenceMoveDist

  - Changes:
    1. An entity that has no model will fail to create a new instance.
    2. Some documentations added for natives.

- 10/8/24: v1.4
  - Natives:
    1. CBaseAnimating.GetSequenceMovement
    2. CBaseAnimating.SequenceDuration
    3. CBaseAnimating.GetSequenceCycleRate
    4. CBaseAnimating.GetSequenceGroundSpeed
    5. CBaseAnimating.LookupSequence
    6. CBaseAnimating.IsValidSequence
    7. CBaseAnimating.IsSequenceFinished

  - Changes:
    1. Added method to get the CStudioHdr pointer, credits to LuqS.
    2. MARKED NATIVE AS OPTIONAL
    3. Some documentations added for natives.
    4. Fixed an issue related to FindBodyGroupByName string passing.

- 10/8/24: v1.4.1
  - Changes:
    1. Fixed parameter missing of SequenceDration call setup.

- 10/8/24: v1.4.2
  - Natives:
    1. CStudioHdr.CStudioHdr
    2. CStudioHdr.deleteThis

  - Changes:
    1. Fixed an issue related to CStudioHdr call setup.
    2. Fixed an issue related to SequenceDuration call method.
    3. Seperated CStudioHdr and CBaseAnimating natives.

- 10/8/24: v1.4.3
  - Changes:
    1. Fixed an issue related to GetSequenceMovement call setup.

- 10/8/24: v1.4.4
  - Changes:
    1. Removed all methodmap wrappers. Since there may be a potential issue when creating multiple instances in other plugins which calls the APIs from animating_library. For best stability and safty, we manually call the SDKCalls inside of native functions itself.
    2. Added IsValidEntity() check for CBaseAnimating and CStudioHdr instance creating.
    3. Fixed extra arg in IsSequenceFinished.

- 10/9/24: v1.5
  - Natives:
    1. CBaseAnimating.IsSequenceLooping
    2. CBaseAnimating.ResetSequence
    3. CBaseAnimating.ResetSequenceInfo
    4. CBaseAnimating.FindTransitionSequence
    5. CBaseAnimating.GoToSequence
    6. GetSequenceFlags

- 10/10/24: v1.6
  - Natives:
    1. CBaseAnimating.m_nBody.get
    2. CBaseAnimating.m_nBody.set
    3. CBaseAnimating.m_flCycle.get
    4. CBaseAnimating.m_flCycle.set
    5. CBaseAnimating.m_flPlaybackRate.get
    6. CBaseAnimating.m_flPlaybackRate.set
    7. CBaseAnimating.LastVisibleCycle
    8. CBaseAnimating.SelectWeightedSequence
    9. CBaseAnimating.m_flModelScale.get
    10. CBaseAnimating.m_flModelScale.set
    11. CBaseAnimating.SetModel
  
  - Changes:
    1. Modified links in the documentations.

- 10/11/24: v1.6.1
  - Natives:
    1. CBaseAnimating.GetModelPtr
    2. CBaseAnimating.LookupBone
    3. CBaseAnimating.GetNumBones
    4. CBaseAnimating.GetBonePosition

  - Changes:
    1. Changed some natives of CBaseAnimating that need to pass a CStudioHdr pointer to retrieve an existed one via CBaseAnimating.GetModelPtr instead of creating one.
    2. String length change in CBaseAnimating.LookupSequence.
    3. Changed native name CBaseAnimating.BodyGroupNum.get -> CBaseAnimating.GetBodyGroupNum.
    4. Documentations stuff.

- 10/12/24: v1.7
  - Natives:
    1. CBaseAnimating.GetAttachmentBone
    2. CBaseAnimating.GetBoneCache
    3. CBaseAnimating.GetPhysicsBone
    4. CBaseAnimating.GetHitboxBone
    5. CBaseAnimating.LookupAttachment
    6. CBaseAnimating.GetAttachment
    7. CStudioHdr.GetNumAttachments