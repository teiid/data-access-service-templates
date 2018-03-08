#!/bin/sh

oc delete is komodo -n openshift
oc delete is beetle -n openshift
oc delete template data-access-service -n openshift

oc create -f komodo-image-streams.json -n openshift
oc create -f beetle-image-streams.json -n openshift
oc create -f data-access-service.json -n openshift
