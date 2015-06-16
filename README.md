ssh
====

#### Table of Contents

1. [Overview - What is the ssh module?](#overview)
2. [Dependencies](#dependencies)
3. [Usage - How to use and configure the module](#usage)
4. [Implementation - An under-the-hood peek at what the module is doing](#implementation)
5. [Limitations - OS compatibility, etc.](#limitations)

Overview
--------

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

Implementation
--------------

Limitations
-----------

** Supported Operating Systems **

  * RHEL/CentOS 5,6
