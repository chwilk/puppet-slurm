# slurm

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with slurm](#setup)
    * [What slurm affects](#what-slurm-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with slurm](#beginning-with-slurm)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

The [Slurm Workload Manager](http://slurm.schedmd.com/) is an open source project designed to manage compute
resources on computational clusters of various sizes.

## Module Description

This module is intended for the automated provisioning and management of compute
nodes in a RedHat/CentOS based SLURM cluster.

For simplicity, some key configuration decisions have been assumed, namely:
* [MUNGE](https://code.google.com/p/munge/) will be used for shared key authentication, and the shared key can be provided to puppet via a URI.
* Standard MUNGE and SLURM packages have been compiled and made available to compute nodes via their installation repository of choice.
* slurm.conf is present on a shared file system, and that directory may be provided to the module as a parameter. /etc/slurm will be symlinked to it.

## Setup

### What slurm affects

* MUNGE packages will be installed (optional)
* The shared MUNGE key will be installed from a URI passed as a parameter to the module
* /etc/slurm will be removed and recreated as a symbolic link to the shared file system passed as a parameter to the module.
* munge and slurmd services will be kept alive
* The PAM stack will be (optionally) edited to insert SLURM PAM controls to meter access to the node only to users running jobs on said node.
* Optionally, the [Warewulf Node Health Check](https://github.com/mej/nhc) will be installed and configured.

### Setup Requirements

This module requires SLURM packages be made available by repo to the local node, and a shared file system with the SLURM configuration file be mounted already.

### Beginning with slurm

The slurm module requires some parameters to be functional.

The most basic example, using munge with a provided munge key:

```
class slurm: {
    munge_key_filename => '/shared/secret/munge.key',
    slurm_conf_location => '/shared/slurm/etc',
}
```

Alternatively, if sharing the munge key over NFS is undesireable, you could set it up on the puppet file server as [documented here](https://docs.puppetlabs.com/guides/file_serving.html) 
and then pass the puppet URI as the `munge_key_filename`.

## Usage

The slurm module is intended to be modular for use in differently managed clusters. For instance:

### We use something other than MUNGE to authenticate

```
class slurm: {
    disable_munge => true,
    slurm_conf_location => '/shared/slurm/etc',
}

```

### We don't want users logging into compute nodes whether or not they have jobs there.

```
class slurm: {
    munge_key_filename => '/shared/secret/munge.key',
    slurm_conf_location => '/shared/slurm/etc',
    disable_pam => true,
}
```

## Reference

The style of this module has been borrowed heavily from the [puppetlabs-ntp](http://github.com/puppetlabs/puppetlabs-ntp) module.

### Classes

#### Public Classes

* slurm: Main class, includes all other classes

#### Private Classes

* slurm::install: Handles Package resources

* slurm::config: Handles editing configuration files, symbolic link of /etc/slurm, and the munge key.

* slurm::service: Handles slurmd and munge services

### Parameters

#### Booleans

Some features of the slurm module can be turned on or off through the use of boolean switches:

#####`disable_munge`

Turns off all handling of munge keys or services. This may be used in case munge is to be handled separately, or if another authentication system is desired altogether.

Defaults to false

#####`disable_pam`

Turns off all editing of the PAM stack. PAM will no longer meter access by users running jobs.

Defaults to false

#####`disable_slurmd`

Turns off slurm daemon service (might be useful on login nodes, for instance)

Defaults to false

#####`force_munge`

Turns on the munged option --force which causes the munge server to attempt to run even if it is unhappy with its environment.

Defaults to false

#####`package_manage`

Turns off package installation, in case SLURM and/or MUNGE are to be handled in a different way.

Defaults to true

#### Strings

#####`munge_key_filename`

File or Puppet file server path to munge-key accessible by compute node.

#####`munge_service_name`

Which service to manage for munge.

Defaults to `munge` for most OS's

#####`package_ensure`

Set to `'present'` by default, you could change this to `'latest'` to force Puppet to automatically keep SLURM/MUNGE packages updated.

#####`slurm_conf_location`

Directory on compute node that contains the shared slurm.conf

Set to `undef` by default.

#####`slurm_service_name`

Which service to manage for the local slurmd daemon.

Varies based on distribution.

#####`sysconfigdir`

Where SLURM expects to find daemon config files on this distro.

Varies based on distribution.

#### Arrays

#####`munge_packages`

Set of packages to be maintained for munge.

#####`pam_packages`

Set of packages to be maintained for SLURM PAM integration.

#####`slurm_packages`

Set of packages to be maintained for SLURM itself.

## Limitations

This module is being developed on Red Hat Enterprise Linux (RHEL) version 6. Contributions helping to port to other distributions or operating systems are welcome. I've tried to leave it in a state that will be considerate of porting efforts.

## Development

I would be happy to review bug reports and pull requests via GitHub.

## Release Notes/Contributors/Etc

* Fri Feb 5 2016 Chandler Wilkerson <chwilk@gmail.com> 0.1.2
- Updating `disable_slurmd` parameter to `ensure_slurmd`

* Wed Feb 3 2016 Chandler Wilkerson <chwilk@gmail.com> 0.1.1
- Added `disable_slurmd` parameter

* Mon Feb 1 2016 Chandler Wilkerson <chwilk@gmail.com> 0.1.0
- Packaged and uploaded 0.1.0 release to Puppet Forge
