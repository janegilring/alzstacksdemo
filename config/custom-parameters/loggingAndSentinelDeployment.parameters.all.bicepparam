using '/tmp/alz_accelerator_stacks/upstream-releases/v0.14.0/infra-as-code/bicep/orchestration/LoggingAndSentinelDeployment/LoggingAndSentinelDeployment.bicep'

param parManagementSubscriptionId = '72949fb8-297a-4da5-bfed-aed671c680d0'

param parTelemetryOptOut = true

param parLocation = 'northeurope'

param parLoggingAndSentinelResourceGroupResourceGroupName = 'rg-psc-logging'

param parTags = {
  Environment: 'demo'
}

param parLogAnalyticsWorkspaceName = 'psc-log-analytics'

param parLogAnalyticsWorkspaceLocation = 'northeurope'

param parLogAnalyticsWorkspaceSkuName = 'PerGB2018'

param parLogAnalyticsWorkspaceLogRetentionInDays = 365

param parLogAnalyticsWorkspaceSolutions = [
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

param parAutomationAccountName = 'psc-automation-account'

param parAutomationAccountLocation = 'northeurope'

param parAutomationAccountUseManagedIdentity = true
