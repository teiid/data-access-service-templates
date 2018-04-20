#!/bin/sh

function create {
  type=$1
  name=$2
  file=$3

  if [ -z "$type" ]; then
    echo "FAILED: Cannot run create function due to no artifact type." && exit 1
  fi

  if [ -z "$name" ]; then
    echo "FAILED: Cannot run create function due to no artifact name." && exit 1
  fi

  #
  # Delete artifact if it exists
  #
  oc get $type $name -n openshift >/dev/null 2>&1 && \
    { { echo "Deleting $type/$name ... " && oc delete $type $name -n openshift; } || \
      { echo "FAILED: Cannot delete type '$type' named '$name'" && exit 1; } \
    }

  echo

  #
  # Create the artifact
  #
  if [ -n "$file" ]; then
    if [ ! -f "$file" ]; then
      echo "FAILED: Cannot run create function as file '$file' not found." && exit 1
    fi

    { echo "Creating artifacts from $file ..." && oc create -f $file -n openshift; } || \
      { echo "FAILED: Cannot create from file '$file'" && exit 1; }

    echo
  fi
}

create is redhat-openjdk18-openshift
create is komodo komodo-image-streams.json
create is beetle beetle-image-streams.json
create template data-access-service data-access-service.json
