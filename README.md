# [L4D2/ANY?] Library for CBaseAnimating

### Introduction

- Various internal functions of class CBaseAnimating. Currently supported L4D2.

### Requiements

- None.

### ChangeLog

- 10/5/24: v1.0
  - Initial commit.
  - Natives:
    1. FindBodyGroupByName
    2. SetBodyGroup

- 10/6/24: v1.1
  - Natives:
    1. GetBodyGroup
    2. GetBodyGroupCount
    3. GetBodyGroupName
    4. GetBodyPartName
    5. BodyGroupNum.get
    6. FindBodyGroupVariant
    7. CountBodyGroupVariants

- 10/7/24: v1.2
  - Natives:
    1. IsRagdoll
    2. CanBecomeRagdoll
    3. BecomeRagdollOnClient

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