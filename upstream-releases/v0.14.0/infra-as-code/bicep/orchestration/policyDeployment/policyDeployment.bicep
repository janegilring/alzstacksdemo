targetScope = 'managementGroup'
//targetScope = 'tenant'

metadata name = 'ALZ Bicep - Policy Module'
metadata description = 'ALZ Bicep Module used to set up Azure Policy definitions and assignments'

@sys.description('Prefix for the management group hierarchy. This management group will be created as part of the deployment.')
param parCustomPolicyDefinitionsTargetManagementGroupId string = 'psc'

@sys.description('Set Parameter to true to Opt-out of deployment telemetry.')
param parTelemetryOptOut bool = false

module modCustomPolicyDefinitions'../../modules/policy/definitions/customPolicyDefinitions.bicep' = {
  name: 'deploy-CustomPolicyDefinitions'
  //scope: managementGroup(parCustomPolicyDefinitionsTargetManagementGroupId)
  scope: managementGroup()
  params: {
    parTargetManagementGroupId: parCustomPolicyDefinitionsTargetManagementGroupId
    parTelemetryOptOut: parTelemetryOptOut
  }
}
