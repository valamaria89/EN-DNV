#!/bin/sh

set -e

# Use getopts to parse arguments. We expect the following arguments: -n --name, -c --container
# If the arguments are not provided, print usage and exit with error code 1
usage() {
    echo "Usage: $0 -n <name> -c <container>"
    echo "  -n, --name            Storage account name"
    echo "  -c, --container       Storage container name"
    echo "  -h, --help            Print this help"
    
    exit 1
}

# Parse arguments
options="hn:c:"
long_options="help,name:,container:"
while getopts $options option; do
    case "$option" in
        h) usage ;;
        n) NAME="$OPTARG" ;;
        c) CONTAINER="$OPTARG" ;;
        *) echo "Unknown parameter passed: $1. Use -h for help."; exit 1 ;;
    esac
done

# Check if the name and container arguments are provided
if [ -z "$NAME" ]; then
    echo "Storage account name is required. Use -h for help."
    exit 1
fi

if [ -z "$CONTAINER" ]; then
    echo "Storage container name is required. Use -h for help."
    exit 1
fi

# Get the storage account key
STORAGE_KEY=$(az storage account keys list --account-name $NAME --query "[0].value" -o tsv)
# Get the SAS key. It should be valid for 1 year. This command only works on a mac
if [ "$(uname)" == "Darwin" ]; then
    EXPIRY=$(date -v +1y '+%Y-%m-%dT%H:%MZ')
else 
    EXPIRY=$(date -d "+1 year" '+%Y-%m-%dT%H:%MZ') 
fi   


# Alternative command for linux
# EXPIRY=$(date -d "+1 year" '+%Y-%m-%dT%H:%MZ')
SAS_KEY=$(az storage container generate-sas --account-name $NAME --account-key $STORAGE_KEY --name $CONTAINER --permissions acdlrw --expiry $EXPIRY --https-only -o tsv)

# Print the SAS key
echo $SAS_KEY



