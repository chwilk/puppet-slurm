class slurm::config inherits slurm {

    # MUNGE
    unless $slurm::disable_munge {
        if $slurm::force_munge {
            file { "/etc/default/$slurm::munge_service_name":
                ensure => file,
                owner => 'root',
                group => 'root',
                mode => '0644',
                content => "OPTIONS='--force'\n",
            }
        }

        file {'/etc/munge/munge.key':
            ensure => file,
            source => $slurm::munge_key_filename,
            owner => "munge",
            group => "munge",
            mode => "0400",
        }

    }
}
