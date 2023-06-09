targetScope = 'managementGroup'

metadata name = 'ALZ Bicep - Custom Policy Defitions at Management Group Scope'
metadata description = 'This policy definition is used to deploy custom policy definitions at management group scope'

//@sys.description('The management group scope to which the policy definitions are to be created at.')
//param parTargetManagementGroupId string

@sys.description('The management group scope to which the policy definitions are to be created at.')
param parDeploymentLocation string

resource customPolicyDefinitionDeployment 'Microsoft.Resources/deployments@2022-09-01' = {
  name: 'customPolicyDefinitionTSDeploy'
  location: parDeploymentLocation
  //scope: managementGroup(tenantResourceId('Microsoft.Management/managementGroups', parTargetManagementGroupId))
  //scope: managementGroup()
  //scope: 'Microsoft.Management/managementGroups/psc'
  properties: {
    mode: 'Incremental'
    templateLink: {
  //id: resourceId('alz-template-spec-rg', 'Microsoft.Resources/templateSpecs/versions', 'alz-customPolicyDefinitions', 'v1.0')
  id: resourceId('72949fb8-297a-4da5-bfed-aed671c680d0', 'alz-template-spec-rg', 'Microsoft.Resources/templateSpecs/versions', 'alz-customPolicyDefinitions', 'v1.0')
   }
   parameters:{
    parTargetManagementGroupId: '/subscriptions/72949fb8-297a-4da5-bfed-aed671c680d0'
    //parTargetManagementGroupId:  managementGroup(tenantResourceId('Microsoft.Management/managementGroups', parTargetManagementGroupId))
    //parTelemetryOptOut: parTelemetryOptOut
  }
  }
}


