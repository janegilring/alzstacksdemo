param (

  [Parameter()]
  [String]$Location = "$($env:LOCATION)",

  [Parameter()]
  [String]$ManagementSubscriptionId = "$($env:MANAGEMENT_SUBSCRIPTION_ID)",

  [Parameter()]
  [String]$LoggingResourceGroup = "$($env:LOGGING_RESOURCE_GROUP)",

  [Parameter()]
  [String]$TemplateFile = "upstream-releases\$($env:UPSTREAM_RELEASE_VERSION)\infra-as-code\bicep\orchestration\LoggingAndSentinelDeployment\LoggingAndSentinelDeployment.bicep",

  [Parameter()]
  [String]$TemplateParameterFile = 'config\custom-parameters\loggingAndSentinelDeployment.parameters.all.json'
)

$inputObject = @{
  Name                           = 'ALZ-Logging'
  ManagementGroupId              = 'fd91810c-57b4-43e3-b513-c2a81e8d6a27' #'Tenant Root Group'
  Location                       = $Location
  TemplateFile                   = $TemplateFile
  TemplateParameterFile          = $TemplateParameterFile
  DeploymentSubscriptionId       = $ManagementSubscriptionId
  DenySettingsApplyToChildScopes = $true
  DeleteAll                      = $true
  Tag                            = @{Environment = 'Demo' }
  Verbose                        = $true
  DenySettingsMode               = 'DenyWriteAndDelete'
  DenySettingsExcludedPrincipals = '2702bead-8908-4edd-a184-d8e3232fa109'
  Force                          = $true
}

$StackExists = Get-AzManagementGroupDeploymentStack -Name $inputObject.Name -ManagementGroupId $inputObject.ManagementGroupId -ErrorAction SilentlyContinue

if ($StackExists) {

  Set-AzManagementGroupDeploymentStack @inputObject

} else {

  New-AzManagementGroupDeploymentStack @inputObject

}
