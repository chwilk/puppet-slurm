class slurm::params {
    $disable_munge = false
    $disable_pam = false
    $package_manage = true
    $package_ensure = 'present'
    $force_munge = false

    $munge_key_filename = undef
    $slurm_conf_location = undef


    case $::osfamily {
        'RedHat': {
            $munge_packages = ['munge', 'slurm-munge']
            $pam_packages = ['slurm-pam_slurm']
            $slurm_packages = ['slurm', 'slurm-devel', 'slurm-plugins']
            $munge_service_name = 'munge'
            $slurm_service_name = 'slurm'
        }
        'Debian': {
            $munge_packages = ['munge']
            $pam_packages = ['libpam-slurm',]
            $slurm_packages = ['slurmd', 'slurm-client', 'slurm-wlm-basic-plugins', 'libslurm-dev']
            $munge_service_name = 'munge'
            $slurm_service_name = 'slurmd'
        }
        default: {
            fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
        }
    }
}

