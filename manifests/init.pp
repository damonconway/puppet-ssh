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
#   $client_pkg:
#       Name of the client package to manage
#       Default: OS Dependent
#       Type: String
#
#   $client_pkg_ensure:
#       String to pass to ensure param on client package
#       Default: present
#       Type: String
#
#   $config_manage:
#       Determines if we should apply config changes
#       Default: true
#       Type: Boolean
#
#   $install_options:
#       String to pass to install_options param on packages
#       Default: undef
#       Type: String
#
#   $merge_configs:
#       Determines if we should use lookup to get all instances of the config hashes.
#       Default: true
#       Type: Boolean
#
#   $moduli_type:
#       Determines if we should regenerate /etc/ssh/moduli, and if so if we should use all or safe.
#       Default: undef
#       Type: Enum['all', 'safe', Undef]
#
#   $server_pkg:
#       Name of the server package to manage
#       Default: OS Dependent
#       Type: String
#
#   $server_pkg_ensure:
#       String to pass to ensure param on server package
#       Default: present
#       Type: String
#
#   $service_ensure:
#       String to pass to ensure param on service
#       Default: running
#       Type: Enum['stopped', 'running']
#
#   $service_manage:
#       Determines if we should manage the sshd service
#       Default: true
#       Type: Boolean
#
#   $ssh_config:
#       Hash of options ot pass to ssh_config resources
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
#   $sshd_config_subsystem:
#       Hash of options ot pass to ssh_config_subsystem resources
#       Default: undef
#       Type: Hash
#
# Actions:
#   * Install ssh package
#   * Configure ssh and sshd
#
# Requires:
#   - puppetlabs/stdlib
#
# Sample Usage:
#   Simply make sure the packages are installed and the service is running:
#     include ::ssh
#
class ssh (
  String $client_pkg                        = $ssh::params::client_pkg,
  String $client_pkg_ensure                 = 'present',
  Boolean $config_manage                    = true,
  Optional[String] $install_options         = undef,
  Boolean $install_manage                   = true,
  Boolean $merge_config                     = true,
  Enum['all','safe',Undef] $moduli_type     = undef,
  String $server_pkg                        = $ssh::params::server_pkg,
  String $server_pkg_ensure                 = 'present',
  Enum['stopped','running'] $service_ensure = 'running',
  Boolean $service_manage                   = true,
  String $service_name                      = $ssh::params::service_name,
  Boolean $service_notify                   = true,
  Optional[Hash] $ssh_config                = undef,
  Optional[Hash] $sshd_config               = undef,
  Optional[Hash] $sshd_config_match         = undef,
  Optional[Hash] $sshd_config_subsystem     = undef,
) inherits ssh::params {

  contain ssh::install
  contain ssh::service
  contain ssh::ssh_cfg
  contain ssh::sshd_cfg

  Class['ssh::install']
  ->Class['ssh::sshd_cfg']
  ->Class['ssh::ssh_cfg']
  ->Class['ssh::service']

}
