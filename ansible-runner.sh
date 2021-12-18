#!/usr/bin/env bash

# Usage:
# ./ansible-runner.sh ansible --version
# ./ansible-runner.sh ansible-playbook -i inventory.yml playbook.yml
#
# This script proxies ansible commands through a
# docker container configured to run as a
# non-sudo user.

start_ansible(){
  if docker run -it --rm -v "$(pwd)":/home/sloth/ansible \
  -v ~/.ssh:/home/sloth/.ssh \
  -e ANSIBLE_HOST_KEY_CHECKING=False \
  aimeri/terraform-ansible sh -c "cd ansible; ansible $*"; then
    exit 0;
  else exit 1;
  fi;
}
start_ansible_playbook(){
  if   docker run -it --rm -v "$(pwd)":/home/sloth/ansible \
  -v ~/.ssh:/home/sloth/.ssh \
  -e ANSIBLE_HOST_KEY_CHECKING=False \
  aimeri/terraform-ansible sh -c "cd ansible; ansible-playbook $*"; then
    exit 0;
  else exit 1;
  fi;
}

if [[ "$#" -gt 0 ]]; then
  case $1 in
    ansible)          start_ansible "${@:2}";;
    ansible-playbook) start_ansible_playbook "${@:2}";;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
fi
