param (
  [Parameter()]
  [String]$ManagementSubscriptionId = "$($env:MANAGEMENT_SUBSCRIPTION_ID)",

  [Parameter()]
  [String]$LoggingResourceGroup = "$($env:LOGGING_RESOURCE_GROUP)",

  [Parameter()]
  [String]$TemplateFile = "upstream-releases\$($env:UPSTREAM_RELEASE_VERSION)\infra-as-code\bicep\orchestration\LoggingAndSentinelDeployment\LoggingAndSentinelDeployment.bicep",

  [Parameter()]
  [String]$TemplateParameterFile = "config\custom-parameters\loggingAndSentinelDeployment.parameters.all"
)

$inputObject = @{
  Name                     = 'ALZ-Logging'
  ManagementGroupId        = 'psc'
  Location                 = $Location
  TemplateFile             = $TemplateFile
  TemplateParameterFile    = $TemplateParameterFile
  DeploymentSubscriptionId = $ManagementSubscriptionId
  DeleteAll                = $true
  Tag                      = @{Environment = 'Demo' }
  Verbose                  = $true
  DenySettingsMode         = 'DenyDelete'
  Force                    = $true
}

$StackExists = Get-AzManagementGroupDeploymentStack -Name $inputObject.Name -ManagementGroupId $inputObject.ManagementGroupId -ErrorAction SilentlyContinue

if ($StackExists) {

  Set-AzManagementGroupDeploymentStack @inputObject

} else {

  New-AzManagementGroupDeploymentStack @inputObject

}
