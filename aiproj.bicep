param instanceId string

param location string = resourceGroup().location

param modelName string = 'gpt-4o'
param modelVersion string = '2024-11-20'
param deploymentName string = modelName
param capacity int = 1000 // 1000 K TPM = 1 M TPM
param deploymentType string = 'GlobalStandard'

var hubName = 'hub${instanceId}'
var projectName = 'project${instanceId}'
var aiServiceName = 'aiservice${instanceId}'
var strageName = 'storage${instanceId}'
var keyVaultName = 'keyvault${instanceId}'


resource aiservice 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: aiServiceName
  location: location
  kind: 'AIServices'
  sku: {
    name: 'S0'
    tier: 'Standard'
  }
  properties: {
    customSubDomainName: aiServiceName
    publicNetworkAccess: 'Enabled'
  }

  resource deploy 'deployments@2025-04-01-preview' = {
    name: deploymentName
    properties: {
      model: {
        format: 'OpenAI'
        name: modelName
        version: modelVersion
      }
    }
    sku: {
      name: deploymentType
      capacity: capacity
    }    
  }

}

resource storage 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: strageName   // simplistic naming; ensure uniqueness in real use
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2024-12-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      name: 'standard'
      family: 'A'
    }
    accessPolicies: []  // (could add policies for hub identity after hub created)
    publicNetworkAccess: 'Enabled'
  }
}

resource hub 'Microsoft.MachineLearningServices/workspaces@2025-01-01-preview' = {
  name: hubName
  location: location

  kind: 'Hub'
  properties: {
    description: hubName
    friendlyName: hubName
    storageAccount: storage.id
    keyVault: keyVault.id
  }

  identity: {
    type: 'SystemAssigned'
  }

  resource hubConnection 'connections@2025-01-01-preview' = {
    name: 'hubConnection'
    properties: {
      category: 'AIServices'
      target: aiservice.properties.endpoint
      authType: 'ApiKey'
      credentials: {
        key: aiservice.listKeys().key1
      }
      isSharedToAll: true
      metadata: {
        ApiType: 'Azure'
        ResourceId: aiservice.id
      }
    }
  }
}

resource project 'Microsoft.MachineLearningServices/workspaces@2025-01-01-preview' = {
  name: projectName
  location: 'eastus'
  kind: 'Project'
  
  properties: {
    description: projectName
    friendlyName: projectName
    hubResourceId: hub.id
  }

  identity: {
    type: 'SystemAssigned'
  }
}
