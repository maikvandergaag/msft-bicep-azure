
az account set --subscription 'f124b668-7e3d-4b53-ba80-09c364def1f3'


az stack sub create --name 'bicep-heroes' `
                    --template-file '.\prerequisites\prerequisites.bicep' `
                    --parameters '.\prerequisites\prerequisites.bicepparam' `
                    --deny-settings-mode 'denyWriteAndDelete' `
                    --action-on-unmanage 'deleteAll' `
                    --location 'westeurope' `
                    --yes


#local deploy app
az stack sub create --name 'bicep-heroes-app' `
                    --template-file '.\main.bicep' `
                    --parameters '.\main-param.bicepparam' `
                    --deny-settings-mode 'denyWriteAndDelete' `
                    --action-on-unmanage 'deleteAll' `
                    --location 'westeurope' `
                    --yes
