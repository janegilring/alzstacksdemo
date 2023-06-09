//targetScope = 'tenant'
targetScope = 'managementGroup'

metadata name = 'ALZ Bicep - Management Group Module'
metadata description = 'ALZ Bicep Module used to set up Management Groups'
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
