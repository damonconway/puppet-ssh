ssh
====

#### Table of Contents

1. [Overview - What is the ssh module?](#overview)
2. [Dependencies](#dependencies)
3. [Usage - How to use and configure the module](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)

Overview
--------

** This module is under development and untested. Use at your own risk. **

The ssh module is designed to manage the ssh packages and service, and leave the configuration to herculesteam/augeasproviders_ssh. However, if you pass in one or more of the config hashes, the module will use create_resources to pass the hash along to the matching resource provided by herculesteam/augeasproviders_ssh.

Currently, the module supports passing a config hash to the following 4 resources:

  * ssh_config
  * sshd_config
  * ssh_config_match
  * sshd_config_match

Dependencies
------------

  * [puppetlabs/stdlib](https://forge.puppetlabs.com/puppetlabs/stdlib)
  * [herculesteam/augeasproviders_ssh](https://forge.puppetlabs.com/herculesteam/augeasproviders_ssh)

Usage
-----

To simply have the module manage the packages and sshd service do:

    include ::ssh

To pass some configuration options do:

    $ssh_cfg = {
        'ForwardAgent' => {
            'ensure' => 'present',
            'value'  => 'yes',
        },
        'ForwardAgent on example.net' => {
            'ensure' => 'present',
            'key'    => 'ForwardAgent',
            'host'   => 'secure.example.net',
            'value'  => 'no'
        },
        'X11Forwarding' => {
            'ensure' => 'present',
            'host'   => 'example.net',
            'value'  => 'yes',
        },
    }

    $sshd_cfg = {
        'AllowGroups' => {
            'ensure' => 'present',
            'value'  => ['sshgroups", "admins"],
        },
        'Protocol' => {
            'ensure' => 'present',
            'value'  => '2',
        },
        'PermitRootLogin' => {
            'ensure' => 'present',
            'value'  => 'yes',
        },
    }

    class { '::ssh':
      ssh_config  => $ssh_cfg
      sshd_config => $sshd_cfg
    }

Limitations
-----------

** Supported Operating Systems **

  * RHEL/CentOS 5,6
