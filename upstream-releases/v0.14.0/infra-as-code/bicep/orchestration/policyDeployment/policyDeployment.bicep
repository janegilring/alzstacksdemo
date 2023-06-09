//targetScope = 'managementGroup'
targetScope = 'subscription'


metadata name = 'ALZ Bicep - Policy Module'
metadata description = 'ALZ Bicep Module used to set up Azure Policy definitions and assignments'

@sys.description('Prefix for the management group hierarchy. This management group will be created as part of the deployment.')
param parCustomPolicyDefinitionsTargetManagementGroupId string

@sys.description('Set Parameter to true to Opt-out of deployment telemetry.')
param parTelemetryOptOut bool = false
module modCustomPolicyDefinitions'../../modules/policy/definitions/customPolicyDefinitions.bicep' = {
  name: 'deploy-CustomPolicyDefinitions'
  params: {
    parTargetManagementGroupId: parCustomPolicyDefinitionsTargetManagementGroupId
    parTelemetryOptOut: parTelemetryOptOut
  }
}

//var parTargetManagementGroupId = managementGroup(tenantResourceId('Microsoft.Management/managementGroups', parCustomPolicyDefinitionsTargetManagementGroupId))

//var parTargetManagementGroupId = '/providers/Microsoft.Management/managementGroups/psc'

//module modCustomPolicyDefinitions'../../modules/policy/definitions/linked-customPolicyDefinitions.bicep' = {
  //name: 'deploy-CustomPolicyDefinitions'
  //params: {
    //parTargetManagementGroupId: parTargetManagementGroupId
    //parTelemetryOptOut: parTelemetryOptOut
    //parDeploymentLocation: parDeploymentLocation
  //}
//}


//@sys.description('Set Parameter to true to Opt-out of deployment telemetry.')
//param parTelemetryOptOut bool = false
//module modCustomPolicyDefinitions'../../modules/policy/definitions/ts-customPolicyDefinitions.bicep' = {
  //name: 'deploy-CustomPolicyDefinitions'
  //params: {
    //parTargetManagementGroupId: parCustomPolicyDefinitionsTargetManagementGroupId
    //parTelemetryOptOut: parTelemetryOptOut
    //parDeploymentLocation: parDeploymentLocation
  //}
//}

