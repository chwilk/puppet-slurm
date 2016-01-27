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

    # PAM
    unless $slurm::disable_pam {
        case $::operatingsystem {
            'RedHat': {
                if $::operatingsystemmajrelease >= 7 { # sshd is going to password-auth in 7 and above.
                    file_line { 'slurm_pam_password_auth_suff_access':
                        path => '/etc/pam.d/password-auth',
                        line => 'account  sufficient     pam_access.so',
                        match => 'pam_access.so',
                    }

                    file_line { 'slurm_pam_password_auth_req_slurm':
                        path => '/etc/pam.d/password-auth',
                        line => 'account  required     pam_slurm.so',
                        after => 'pam_access.so',
                    }
                }
                file_line { 'slurm_pam_system_auth_suff_access':
                    path => '/etc/pam.d/system-auth-ac',
                    line => 'account  sufficient     pam_access.so',
                    match => 'pam_access.so',
                }

                file_line { 'slurm_pam_system_auth_req_slurm':
                    path => '/etc/pam.d/system-auth-ac',
                    line => 'account  required     pam_slurm.so',
                    after => 'pam_access.so',
                }
                
            }
        }
    }
    # SLURM
    file { '/etc/default/slurmd':
        ensure => file,
        owner => 'root',
        group => 'root',
        mode => '0644',
        content => "ulimit -l unlimited\n",
    }

    file {'/var/spool/slurm':
        ensure => directory,
        owner => "root",
        group => "root",
        mode => "0755",
    }

    file {'/var/spool/slurm/logs':
        ensure => directory,
        owner => "root",
        group => "root",
        mode => "0755",
    }

    file {'/var/run/slurm':
        ensure => directory,
        owner => "root",
        group => "root",
        mode => "0755",
    }
    
    file {'/etc/slurm':
        ensure => link,
        target => $slurm::slurm_conf_location,
        force  => true,
    }

}
