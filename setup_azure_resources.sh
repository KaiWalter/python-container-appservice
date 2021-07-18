#!/bin/sh
rg_name=python-container
location=westeurope
acr_name=kwacr42
az group create -n $rg_name -l $location

groupId=$(az group show \
  --name $rg_name \
  --query id --output tsv)

az acr create -n $acr_name -g $rg_name --sku Standard

az ad sp create-for-rbac \
  --scope $groupId \
  --role Contributor \
  --sdk-auth

registryId=$(az acr show \
  --name $acr_name \
  --query id --output tsv)

az role assignment create \
  --assignee <ClientId> \
  --scope $registryId \
  --role AcrPush
