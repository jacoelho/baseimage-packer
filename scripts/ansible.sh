#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7BB9C367

echo deb http://ppa.launchpad.net/ansible/ansible/ubuntu $(lsb_release -cs) main > /etc/apt/sources.list.d/ansible.list

apt-get update -qq && apt-get install -y --no-install-recommends git-core ansible

echo '[local]\nlocalhost ansible_connection=local\n' > /etc/ansible/hosts
