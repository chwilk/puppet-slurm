class slurm::service inherits slurm {
    service {$slurm::slurm_service_name:
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
        unless $slurm::disable_munge {
            require => Service['munge'],
        }
    }
    unless $slurm::disable_munge {
        service {'munge':
            ensure => running,
            enable => true,
            hasstatus => true,
            hasrestart => true,
        }
    }
}
