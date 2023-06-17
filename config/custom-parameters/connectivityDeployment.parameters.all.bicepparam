using '/tmp/alz_accelerator_stacks/upstream-releases/v0.14.0/infra-as-code/bicep/orchestration/connectivityDeployment/connectivityDeployment.bicep'

param parLocation = 'northeurope'

param parResourceGroupName = 'rg-psc-connectivity'

param parTags = {
  Environment: 'demo'
}

param parCompanyPrefix = 'psc'

param parHubNetworkName = 'psc-hub-northeurope'

param parHubNetworkAddressPrefix = '10.20.0.0/16'

param parSubnets = [
  {
    name: 'AzureBastionSubnet'
    ipAddressRange: '10.20.0.0/24'
    networkSecurityGroupId: ''
    routeTableId: ''
  }
  {
    name: 'GatewaySubnet'
    ipAddressRange: '10.20.254.0/24'
    networkSecurityGroupId: ''
    routeTableId: ''
  }
  {
    name: 'AzureFirewallSubnet'
    ipAddressRange: '10.20.255.0/24'
    networkSecurityGroupId: ''
    routeTableId: ''
  }
  {
    name: 'AzureFirewallManagementSubnet'
    ipAddressRange: '10.20.253.0/24'
    networkSecurityGroupId: ''
    routeTableId: ''
  }
]

param parDnsServerIps = []

param parPublicIpSku = 'Standard'

param parPublicIpPrefix = ''

param parPublicIpSuffix = '-PublicIP'

param parAzBastionEnabled = false

param parAzBastionName = 'psc-bastion'

param parAzBastionSku = 'Standard'

param parAzBastionNsgName = 'nsg-AzureBastionSubnet'

param parDdosEnabled = false

param parDdosPlanName = 'psc-ddos-plan'

param parAzFirewallEnabled = false

param parAzFirewallName = 'psc-azfw-northeurope'

param parAzFirewallPoliciesName = 'psc-azfwpolicy-northeurope'

param parAzFirewallTier = 'Standard'

param parAzFirewallAvailabilityZones = []

param parAzErGatewayAvailabilityZones = []

param parAzVpnGatewayAvailabilityZones = []

param parAzFirewallDnsProxyEnabled = true

param parHubRouteTableName = 'psc-hub-routetable'

param parDisableBgpRoutePropagation = false

param parPrivateDnsZonesEnabled = true

param parPrivateDnsZones = [
  'privatelink.northeurope.azmk8s.io'
  'privatelink.northeurope.batch.azure.com'
  'privatelink.northeurope.kusto.windows.net'
  'privatelink.northeurope.backup.windowsazure.com'
  'privatelink.adf.azure.com'
  'privatelink.afs.azure.net'
  'privatelink.agentsvc.azure-automation.net'
  'privatelink.analysis.windows.net'
  'privatelink.api.azureml.ms'
  'privatelink.azconfig.io'
  'privatelink.azure-api.net'
  'privatelink.azure-automation.net'
  'privatelink.azurecr.io'
  'privatelink.azure-devices.net'
  'privatelink.azure-devices-provisioning.net'
  'privatelink.azurehdinsight.net'
  'privatelink.azurehealthcareapis.com'
  'privatelink.azurestaticapps.net'
  'privatelink.azuresynapse.net'
  'privatelink.azurewebsites.net'
  'privatelink.batch.azure.com'
  'privatelink.blob.core.windows.net'
  'privatelink.cassandra.cosmos.azure.com'
  'privatelink.cognitiveservices.azure.com'
  'privatelink.database.windows.net'
  'privatelink.datafactory.azure.net'
  'privatelink.dev.azuresynapse.net'
  'privatelink.dfs.core.windows.net'
  'privatelink.dicom.azurehealthcareapis.com'
  'privatelink.digitaltwins.azure.net'
  'privatelink.directline.botframework.com'
  'privatelink.documents.azure.com'
  'privatelink.eventgrid.azure.net'
  'privatelink.file.core.windows.net'
  'privatelink.gremlin.cosmos.azure.com'
  'privatelink.guestconfiguration.azure.com'
  'privatelink.his.arc.azure.com'
  'privatelink.kubernetesconfiguration.azure.com'
  'privatelink.managedhsm.azure.net'
  'privatelink.mariadb.database.azure.com'
  'privatelink.media.azure.net'
  'privatelink.mongo.cosmos.azure.com'
  'privatelink.monitor.azure.com'
  'privatelink.mysql.database.azure.com'
  'privatelink.notebooks.azure.net'
  'privatelink.ods.opinsights.azure.com'
  'privatelink.oms.opinsights.azure.com'
  'privatelink.pbidedicated.windows.net'
  'privatelink.postgres.database.azure.com'
  'privatelink.prod.migration.windowsazure.com'
  'privatelink.purview.azure.com'
  'privatelink.purviewstudio.azure.com'
  'privatelink.queue.core.windows.net'
  'privatelink.redis.cache.windows.net'
  'privatelink.redisenterprise.cache.azure.net'
  'privatelink.search.windows.net'
  'privatelink.service.signalr.net'
  'privatelink.servicebus.windows.net'
  'privatelink.siterecovery.windowsazure.com'
  'privatelink.sql.azuresynapse.net'
  'privatelink.table.core.windows.net'
  'privatelink.table.cosmos.azure.com'
  'privatelink.tip1.powerquery.microsoft.com'
  'privatelink.token.botframework.com'
  'privatelink.vaultcore.azure.net'
  'privatelink.web.core.windows.net'
  'privatelink.webpubsub.azure.com'
]

param parVpnGatewayConfig = {
  name: 'noconfigVpn'
  gatewayType: 'Vpn'
  sku: 'VpnGw1'
  vpnType: 'RouteBased'
  generation: 'Generation1'
  enableBgp: false
  activeActive: false
  enableBgpRouteTranslationForNat: false
  enableDnsForwarding: false
  bgpPeeringAddress: ''
  bgpsettings: {
    asn: '65515'
    bgpPeeringAddress: ''
    peerWeight: '5'
  }
}

param parExpressRouteGatewayConfig = {
  name: 'noconfigEr'
  gatewayType: 'ExpressRoute'
  sku: 'Standard'
  vpnType: 'RouteBased'
  generation: 'None'
  enableBgp: false
  activeActive: false
  enableBgpRouteTranslationForNat: false
  enableDnsForwarding: false
  bgpPeeringAddress: ''
  bgpsettings: {
    asn: '65515'
    bgpPeeringAddress: ''
    peerWeight: '5'
  }
}

param parTelemetryOptOut = true

param parBastionOutboundSshRdpPorts = [
  '22'
  '3389'
]
