using '/tmp/alz_accelerator_stacks/upstream-releases/v0.14.0/infra-as-code/bicep/orchestration/managementGroupDeployment/managementGroupDeployment.bicep'

param parTopLevelManagementGroupPrefix = 'psc'

param parTopLevelManagementGroupSuffix = ''

param parTopLevelManagementGroupDisplayName = 'PowerShell Conference EU'

param parTopLevelManagementGroupParentId = ''

param parLandingZoneMgAlzDefaultsEnable = true

param parPlatformMgAlzDefaultsEnable = true

param parLandingZoneMgConfidentialEnable = false

param parLandingZoneMgChildren = {}

param parPlatformMgChildren = {}

param parTelemetryOptOut = true
