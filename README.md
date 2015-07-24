ssh
====

#### Table of Contents

1. [Overview - What is the ssh module?](#overview)
2. [Dependencies - What other modules does this module depend on?](#dependencies)
3. [Usage - How to use and configure the module](#usage)
4. [Parameter - List of available parameters to pass](#parameters)
5. [Limitations - OS compatibility, etc.](#limitations)

Overview
--------

**This module is under development and untested. Use at your own risk.**

The ssh module is designed to manage the ssh packages and service, and leave the configuration to the user. However, if you pass in one or more of the config hashes, the module will use create_resources to pass the hash along to the matching resource provided by herculesteam/augeasproviders_ssh.

Currently, the module supports passing a config hash to the following 4 resources:

  * ssh_config
  * sshd_config
  * sshd_config_match
  * sshd_config_subsystem

Dependencies
------------

  * [puppetlabs/stdlib](https://forge.puppetlabs.com/puppetlabs/stdlib)
  * [herculesteam/augeasproviders_core](https://forge.puppetlabs.com/herculesteam/augeasproviders_core)
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
            'value'  => 'no',
        },
    }

    class { '::ssh':
      ssh_config  => $ssh_cfg
      sshd_config => $sshd_cfg
    }

**parameters within `ssh`:**

####`client_pkg`

The name of the package to manage (default is OS dependent).

####`client_pkg_ensure`

This param holds the ensure value for the client package resource (default is present).

####`config_manage`

This param determines if we should apply config changes (default is true).

####`install_options`

This param holds the install_options value for package resources (default is undef).

####`server_pkg`

The name of the package to manage (default is OS dependent).

####`server_pkg_ensure`

This param holds the ensure value for the server package resource (default is present).

####`service_ensure`

This param holds the ensure value for the server service resource (default is running).

####`service_manage`

This param determines if we should manage the service resource for the server (default is true).

####`ssh_config`

This param contains a hash of ssh_config resources (default is undef).

####`sshd_config`

This param contains a hash of sshd_config resources (default is undef).

####`sshd_config_match`

This param contains a hash of sshd_config_match resources (default is undef).

####`sshd_config_subsystem`

This param contains a hash of sshd_config_subsystem resources (default is undef).

Limitations
-----------

**Supported Operating Systems**

  * RHEL/CentOS 5,6
