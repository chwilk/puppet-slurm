class slurm::service inherits slurm {
  unless $slurm::disable_slurmd {
    service {$slurm::slurm_service_name:
      ensure => running,
      enable => true,
      hasstatus => true,
      hasrestart => true,
    }
  }
  unless $slurm::disable_munge {
    service {'munge':
      ensure => running,
      enable => true,
      hasstatus => true,
      hasrestart => true,
      notify => Service[$slurm::slurm_service_name],
    }
  }
}
