//targetScope = 'tenant'
targetScope = 'managementGroup'

metadata name = 'ALZ Bicep - Management Group Module'
metadata description = 'ALZ Bicep Module used to set up Management Groups'

@sys.description('Prefix for the management group hierarchy. This management group will be created as part of the deployment.')
@minLength(2)
@maxLength(10)
param parTopLevelManagementGroupPrefix string

@sys.description('Prefix for the management group hierarchy. This management group will be created as part of the deployment.')
param parCustomPolicyDefinitionsTargetManagementGroupId string

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

@sys.description('')
param parManagementSubscriptionId string

@sys.description('')
param parLoggingAndSentinelResourceGroupResourceGroupName string = 'rg-alz-logging'

@sys.description('The Azure Region to deploy the resources into.')
param parLocation string

@sys.description('Tags you would like to be applied to all resources in this module.')
param parTags object = {}

@sys.description('Log Analytics Workspace name.')
param parLogAnalyticsWorkspaceName string = 'alz-log-analytics'

@sys.description('Log Analytics region name - Ensure the regions selected is a supported mapping as per: https://docs.microsoft.com/azure/automation/how-to/region-mappings.')
param parLogAnalyticsWorkspaceLocation string

@allowed([
  'CapacityReservation'
  'Free'
  'LACluster'
  'PerGB2018'
  'PerNode'
  'Premium'
  'Standalone'
  'Standard'
])
@sys.description('Log Analytics Workspace sku name.')
param parLogAnalyticsWorkspaceSkuName string = 'PerGB2018'

@minValue(30)
@maxValue(730)
@sys.description('Number of days of log retention for Log Analytics Workspace.')
param parLogAnalyticsWorkspaceLogRetentionInDays int = 365

@allowed([
  'AgentHealthAssessment'
  'AntiMalware'
  'ChangeTracking'
  'Security'
  'SecurityInsights'
  'ServiceMap'
  'SQLAdvancedThreatProtection'
  'SQLVulnerabilityAssessment'
  'SQLAssessment'
  'Updates'
  'VMInsights'
])
@sys.description('Solutions that will be added to the Log Analytics Workspace.')
param parLogAnalyticsWorkspaceSolutions array = [
  'AgentHealthAssessment'
  'AntiMalware'
  'ChangeTracking'
  'Security'
  'SecurityInsights'
  'SQLAdvancedThreatProtection'
  'SQLVulnerabilityAssessment'
  'SQLAssessment'
  'Updates'
  'VMInsights'
]

@sys.description('Automation account name.')
param parAutomationAccountName string = 'alz-automation-account'

@sys.description('Automation Account region name. - Ensure the regions selected is a supported mapping as per: https://docs.microsoft.com/azure/automation/how-to/region-mappings.')
param parAutomationAccountLocation string

@sys.description('Automation Account - use managed identity.')
param parAutomationAccountUseManagedIdentity bool = true

@sys.description('Tags you would like to be applied to Automation Account.')
param parAutomationAccountTags object = parTags

@sys.description('Tags you would like to be applied to Log Analytics Workspace.')
param parLogAnalyticsWorkspaceTags object = parTags

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

module modLoggingAndSentinelResourceGroup'../../modules/resourceGroup/resourceGroup.bicep' = {
  name: 'deploy-LoggingAndSentinelResourceGroup'
  scope: subscription(parManagementSubscriptionId)
  params: {
    parResourceGroupName: parLoggingAndSentinelResourceGroupResourceGroupName
    parLocation: parLocation
    parTags: parTags
    parTelemetryOptOut: parTelemetryOptOut
  }
}

module modLoggingAndSentinelResources'../../modules/logging/logging.bicep' = {
  name: 'deploy-LoggingAndSentinelResources'
  scope: resourceGroup(parManagementSubscriptionId,parLoggingAndSentinelResourceGroupResourceGroupName)
  dependsOn: [modLoggingAndSentinelResourceGroup]
  params: {
    parAutomationAccountLocation: parAutomationAccountLocation
    parAutomationAccountName: parAutomationAccountName
    parAutomationAccountTags: parAutomationAccountTags
    parAutomationAccountUseManagedIdentity: parAutomationAccountUseManagedIdentity
    parLogAnalyticsWorkspaceLogRetentionInDays: parLogAnalyticsWorkspaceLogRetentionInDays
    parLogAnalyticsWorkspaceName: parLogAnalyticsWorkspaceName
    parLogAnalyticsWorkspaceSkuName: parLogAnalyticsWorkspaceSkuName
    parLogAnalyticsWorkspaceSolutions: parLogAnalyticsWorkspaceSolutions
    parLogAnalyticsWorkspaceTags: parLogAnalyticsWorkspaceTags
    parLogAnalyticsWorkspaceLocation: parLogAnalyticsWorkspaceLocation
    parTags: parTags
    parTelemetryOptOut: parTelemetryOptOut
  }
}


module modCustomPolicyDefinitions'../../modules/policy/definitions/customPolicyDefinitions.bicep' = {
  name: 'deploy-CustomPolicyDefinitions'
  //scope: managementGroup()
  scope: managementGroup(parCustomPolicyDefinitionsTargetManagementGroupId)
  //scope: managementGroup(tenantResourceId('Microsoft.Management/managementGroups', parCustomPolicyDefinitionsTargetManagementGroupId))
  params: {
    parTargetManagementGroupId: parCustomPolicyDefinitionsTargetManagementGroupId
    parTelemetryOptOut: parTelemetryOptOut
  }
}
