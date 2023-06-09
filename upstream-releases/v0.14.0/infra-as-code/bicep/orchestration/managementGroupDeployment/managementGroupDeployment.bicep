//targetScope = 'tenant'
targetScope = 'managementGroup'

metadata name = 'ALZ Bicep - Management Group Module'
metadata description = 'ALZ Bicep Module used to set up Management Groups'

@sys.description('Prefix for the management group hierarchy. This management group will be created as part of the deployment.')
@minLength(2)
@maxLength(10)
param parTopLevelManagementGroupPrefix string

@sys.description('Optional suffix for the management group hierarchy. This suffix will be appended to management group names/IDs. Include a preceding dash if required. Example: -suffix')
@maxLength(10)
param parTopLevelManagementGroupSuffix string = ''

@sys.description('Display name for top level management group. This name will be applied to the management group prefix defined in parTopLevelManagementGroupPrefix parameter.')
@minLength(2)
param parTopLevelManagementGroupDisplayName string = 'Azure Landing Zones'

@sys.description('Optional parent for Management Group hierarchy, used as intermediate root Management Group parent, if specified. If empty, default, will deploy beneath Tenant Root Management Group.')
param parTopLevelManagementGroupParentId string = ''

@sys.description('Deploys Corp & Online Management Groups beneath Landing Zones Management Group if set to true.')
param parLandingZoneMgAlzDefaultsEnable bool = true

@sys.description('Deploys Management, Identity and Connectivity Management Groups beneath Platform Management Group if set to true.')
param parPlatformMgAlzDefaultsEnable bool = true

@sys.description('Deploys Confidential Corp & Confidential Online Management Groups beneath Landing Zones Management Group if set to true.')
param parLandingZoneMgConfidentialEnable bool = false

@sys.description('Dictionary Object to allow additional or different child Management Groups of Landing Zones Management Group to be deployed.')
param parLandingZoneMgChildren object = {}

@sys.description('Dictionary Object to allow additional or different child Management Groups of Platform Management Group to be deployed.')
param parPlatformMgChildren object = {}

@sys.description('Set Parameter to true to Opt-out of deployment telemetry.')
param parTelemetryOptOut bool = false

@sys.description('Tags you would like to be applied to all resources in this module.')
param parTags object = {}


module modManagementGroups '../../modules/managementGroups/managementGroups.bicep' = {
  name: 'deploy-ManagementGroups'
  scope: tenant()
  params: {
    parLandingZoneMgAlzDefaultsEnable: parLandingZoneMgAlzDefaultsEnable
    parLandingZoneMgChildren: parLandingZoneMgChildren
    parLandingZoneMgConfidentialEnable: parLandingZoneMgConfidentialEnable
    parPlatformMgAlzDefaultsEnable: parPlatformMgAlzDefaultsEnable
    parPlatformMgChildren: parPlatformMgChildren
    parTopLevelManagementGroupDisplayName: parTopLevelManagementGroupDisplayName
    parTopLevelManagementGroupParentId: parTopLevelManagementGroupParentId
    parTopLevelManagementGroupPrefix: parTopLevelManagementGroupPrefix
    parTopLevelManagementGroupSuffix: parTopLevelManagementGroupSuffix
    parTelemetryOptOut: parTelemetryOptOut
  }
}
