class slurm::install inherits slurm {

  if $slurm::package_manage {
    unless $slurm::disable_munge {
      package {$slurm::munge_packages:
        ensure => $slurm::package_ensure,
      }
    }
    unless $slurm::disable_pam {
      package {$slurm::pam_packages:
        ensure => $slurm::package_ensure,
      }
    }
    package { $slurm::slurm_packages:
      ensure => $slurm::package_ensure,
    }
  }
}
