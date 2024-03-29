param (
  [Parameter()]
  [String]$Location = "$($env:LOCATION)",

  [Parameter()]
  [String]$TopLevelMGPrefix = "$($env:TOP_LEVEL_MG_PREFIX)",

  [Parameter()]
  [String]$TemplateFile = "upstream-releases\$($env:UPSTREAM_RELEASE_VERSION)\infra-as-code\bicep\modules\policy\assignments\alzDefaults\alzDefaultPolicyAssignments.bicep",

  [Parameter()]
  [String]$TemplateParameterFile = "config\custom-parameters\alzDefaultPolicyAssignments.parameters.all.json"
)

# Parameters necessary for deployment
$inputObject = @{
  DeploymentName        = 'alz-PolicyAssignmentsDeployment-{0}' -f ( -join (Get-Date -Format 'yyyyMMddTHHMMssffffZ')[0..63])
  Location              = $Location
  ManagementGroupId     = $TopLevelMGPrefix
  TemplateFile          = $TemplateFile
  TemplateParameterFile = $TemplateParameterFile
  Verbose               = $true
}

#New-AzManagementGroupDeployment @inputObject

Write-Host "alzDefaultPolicyAssignments is disabled until Deployment Stacks supports deploying to Management Groups (definitions deployed to subscription to show-case policy deployments via Stacks"