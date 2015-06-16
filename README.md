# Class: ssh
#
# This class manages the ssh packages and service. By default, it does not make
# any configuration changes. Howeer, you can pass in 4 different hashes that
# will be processed with the resources provided by
# 'herculesteam/augeasproviders_ssh'. These resources are ssh_config,
# ssh_config_match, sshd_config, sshd_config_match, and each has a matching
# parameter you can give to pass to create_resources.
#
# Parameters:
#   $config_manage:
#       Determines if we should apply config changes
#       Default: true
#       Type: boolean
#
#   $client_pkg:
#       Name of the client package to manage
#       Default: OS Dependent
#       Type: string
#
#   $client_pkg_ensure:
#       String to pass to ensure param on client package
#       Default: present
#       Type: string
#
#   $install_options:
#       String to pass to install_options param on packages
#       Default: undef
#       Type: string
#
#   $install_manage:
#       Determines if we should manage package installation
#       Default: true
#       Type: boolean
#
#   $server_pkg:
#       Name of the server package to manage
#       Default: OS Dependent
#       Type: string
#
#   $server_pkg_ensure:
#       String to pass to ensure param on server package
#       Default: present
#       Type: string
#
#   $service_ensure:
#       String to pass to ensure param on service
#       Default: running
#       Type: string
#
#   $service_manage:
#       Determines if we should manage the sshd service
#       Default: true
#       Type: boolean
#
#   $ssh_config:
#       Hash of options ot pass to ssh_config resources
#       Default: undef
#       Type: Hash
#
#   $ssh_config_match:
#       Hash of options ot pass to ssh_config_match resources
#       Default: undef
#       Type: Hash
#
#   $sshd_config:
#       Hash of options ot pass to sshd_config resources
#       Default: undef
#       Type: Hash
#
#   $sshd_config_match:
#       Hash of options ot pass to sshd_config_match resources
#       Default: undef
#       Type: Hash
#
# Actions:
#   Actions should be described here
#
# Requires:
#   - Package["foopackage"]
#
# Sample Usage:
#   Simply make sure the packages are installed and the service is running:
#     include ::ssh
#
class ssh (
  $config_manage     = $ssh::params::config_manage,
  $client_pkg        = $ssh::params::client_pkg,
  $client_pkg_ensure = $ssh::params::client_pkg_ensure,
  $install_options   = $ssh::params::install_options,
  $install_manage    = $ssh::params::install_manage,
  $server_pkg        = $ssh::params::server_pkg,
  $server_pkg_ensure = $ssh::params::server_pkg_ensure,
  $service_ensure    = $ssh::params::service_ensure,
  $service_manage    = $ssh::params::service_manage,
  $ssh_config        = $ssh::params::ssh_config,
  $ssh_config_match  = $ssh::params::ssh_config_match,
  $sshd_config       = $ssh::params::sshd_config,
  $sshd_config_match = $ssh::params::sshd_config_match,
) inherits ssh::params {

  contain ssh::install
  contain ssh::service
  contain ssh::ssh_cfg
  contain ssh::sshd_cfg

  $defaults     = $ssh::params::defaults
  $service_name = $ssh::params::service_name

  if is_bool($config_manage) {
    $real_config_manage = $config_manage
  } elsif is_string($config_manage) {
    $real_config_manage = str2bool($config_manage)
  } else {
    fail("${name}::config_manage should be a boolean or string.")
  }
 
  # Check all our inputs
  #
  if is_bool($service_manage) {
    $real_service_manage = $service_manage
  } elsif is_string($service_manage) {
    $real_service_manage = str2bool($service_manage)
  } else {
    fail("${name}::serivce_manage should be a boolean or string.")
  }

  if $ssh_config {
    validate_hash($sshd_config_match)
  }
  
  if $ssh_config_match {
    validate_hash($sshd_config_match)
  }
  
  if $sshd_config {
    validate_hash($sshd_config)
  }
  
  if $sshd_config_match {
    validate_hash($sshd_config_match)
  }
  
  Class['ssh::install']->
  Class['ssh::sshd_cfg']->
  Class['ssh::ssh_cfg']->
  Class['ssh::service']

}
