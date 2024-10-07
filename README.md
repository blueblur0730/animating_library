# [L4D2/ANY?] Library for CBaseAnimating

### Introduction

- Various internal functions of class CBaseAnimating. Currently supported L4D2.

### Note

- These natives are NOT TESTED. Use at your own risk. I'd be appreciated if you could report any issues or bugs, or help fix them.

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
