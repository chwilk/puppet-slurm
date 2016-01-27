# == Class: slurm
#
# This module is intended for the automated provisioning and management of
# compute nodes in a RedHat/CentOS based SLURM cluster.
#
# === Parameters
#
# [*munge_key_filename*]
#   File or Puppet file server path to munge-key accessible by compute node.
# [*slurm_conf_location*]
#   Directory on compute node that contains the shared slurm.conf
#
# === Examples
#
#  class { slurm:
#    munge_key_filename => '/opt/apps/system/munge/munge.key',
#    slurm_conf_location => '/opt/apps/system/slurm',
#  }
#
# === Authors
#
# Chandler Wilkerson <chwilk@rice.edu>
#
# === Copyright
#
# Copyright 2016 Chandler Wilkerson
#
class slurm (
    $disable_munge       = $slurm::params::disable_munge,
    $disable_pam         = $slurm::params::disable_pam,
    $package_ensure      = $slurm::params::package_ensure,
    $package_manage      = $slurm::params::package_manage,

    $munge_key_filename  = $slurm::params::munge_key_filename,
    $slurm_conf_location = $slurm::params::slurm_conf_location,

    $munge_packages      = $slurm::params::munge_packages,
    $pam_packages        = $slurm::params::pam_packages,
    $slurm_packages      = $slurm::params::slurm_packages,
) inherits slurm::params {
    validate_bool($disable_munge)
    validate_bool($disable_pam)
    validate_string($package_ensure)
    validate_boolean($package_manage)
    validate_absolute_path($munge_key_filename)
    validate_absolute_path($slurm_conf_location)
    validate_array($munge_packages)
    validate_array($slurm_packages)
    validate_array($pam_packages)

    # Borrowing from structure of puppetlabs-ntp module

    anchor { 'slurm::begin': } ->
    class { '::slurm::install': } ->
    class { '::slurm::config': } ->
    class { '::slurm::service': } ->
    anchor { 'slurm::end': }
}
