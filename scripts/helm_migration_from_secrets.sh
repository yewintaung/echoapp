#!/bin/bash

# Run the kubectl command and store the output
output=$(kubectl get secrets -l owner=helm --all-namespaces)
OUTPUT_FILE=migration_output.txt

# Extracting the headers to get column names
headers=$(echo "$output" | head -n 1)

# Set a flag to track if it's the first line
first_line=true

# Loop through each line containing "owner=helm"
echo "$output" | while IFS= read -r line; do

    # Check if it's the first line
    if $first_line; then
        # Skip processing the first line
        first_line=false
        continue
    fi

    namespace=$(echo "$line" | awk '{print $1}')
    name=$(echo "$line" | awk '{print $2}')
    type=$(echo "$line" | awk '{print $3}')

    # Get body of the release
    body=$(kubectl -n $namespace get secret $name -o jsonpath='{.data.release}' | base64 --decode) 

    # Get version
    version=$(kubectl -n $namespace get secret $name -o jsonpath='{.metadata.labels.version}')

    # Get owner
    owner=$(kubectl -n $namespace get secret $name -o jsonpath='{.metadata.labels.owner}')

    # Get labels on secret
    release_name=$(kubectl -n $namespace get secret $name -o jsonpath='{.metadata.labels.name}')

    # Get status on secret
    status=$(kubectl -n $namespace get secret $name -o jsonpath='{.metadata.labels.status}')

    # Get creation timestamp in epoch time
    creationTime=$(kubectl -n $namespace get secret $name -o jsonpath='{.metadata.creationTimestamp}')
    creationEpochTime=$(date -d "$creationTime" +%s)

    # Get modifiedAt in epochtime
    modifiedAt=$(kubectl -n $namespace get secret $name -o jsonpath='{.metadata.labels.modifiedAt}')

    echo "INSERT INTO releases_v1 (key, type, body, name, namespace, version, status, owner, createdat, modifiedat)
    VALUES ('$name', '$type', '$body', '$release_name', '$namespace', $version, '$status', '$owner', $creationEpochTime, $modifiedAt);" >> $OUTPUT_FILE

done

PWD=$(pwd)
OUTPUT_FILE="$PWD/$OUTPUT_FILE"

echo "Generated file in $OUTPUT_FILE, Happy Helming 🐱"
