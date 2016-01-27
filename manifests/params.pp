class slurm::params {
    $disable_munge = false
    $disable_pam = false
    $package_manage = true
    $package_ensure = 'present'

    $munge_key_filename = undef
    $slurm_conf_location = undef

    $munge_packages = []
    $pam_packages = []
    $slurm_packages = []

    case $::osfamily {
        'RedHat': {
            $munge_packages = ['munge', 'slurm-munge']
            $pam_packages = ['slurm-pam_slurm']
            $slurm_packages = ['slurm', 'slurm-devel', 'slurm-plugins']
        }
        'Debian': {
            $munge_packages = ['munge']
            $pam_packages = ['libpam-slurm',]
            $slurm_packages = ['slurmd', 'slurm-client', 'slurm-wlm-basic-plugins', 'libslurm-dev']
        }
        default: {
            fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
        }
    }
}

