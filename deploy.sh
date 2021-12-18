#!/usr/bin/env bash

# This simple script just wraps all the tools into a single command
# necessary to deploy a droplet ready to host docker container workloads

REMOTE_SERVER=$(cat inventory.yml | awk '/[:]/{$NF=$NF""}{sub(/ /,"")sub(/:/,"")}1' | grep -E "[[:digit:]]{1,3}.[[:digit:]]{1,3}.[[:digit:]]{1,3}.[[:digit:]]{1,3}")

set -e
echo "Configuring server" && \
ssh-keygen -f "/home/aimeri/.ssh/known_hosts" -R "${REMOTE_SERVER}" && \
if ./ansible-runner.sh ansible-playbook -i inventory.yml playbook.yml; then
  echo "Deployment completed"
  exit 0;
else
  echo "Deployment failed with error code: $?"
  exit $?
fi;
