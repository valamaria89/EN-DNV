bash scripts/create_remote_state_store.sh -s 9017d57d-c4df-480d-b92d-7aea2266b0f0 -l westeurope -o en -p mltfstate -c prod 

export ARM_SAS_TOKEN=$(bash scripts/get_remote_state_sas_key.sh -n enmltfstateprodsawe -c tfstate)