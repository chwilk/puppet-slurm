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

* MUNGE packages will be installed
* The shared MUNGE key will be installed from a URI passed as a parameter to the module
* /etc/slurm will be removed and recreated as a symbolic link to the shared file system passed as a parameter to the module.
* slurmd services will be kept alive
* Optionally, the [Warewulf Node Health Check](https://github.com/mej/nhc) will be installed and configured.

### Setup Requirements

This module requires SLURM packages be made available by repo to the local node, and a shared file system with the SLURM configuration file be mounted already.

### Beginning with slurm

The very basic steps needed for a user to get the module up and running.

## Usage **TODO**

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference **TODO**

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This module is being developed on Red Hat Enterprise Linux (RHEL) version 6. Contributions helping to port to other distributions or operating systems are welcome.

## Development

I would be happy to review bug reports and pull requests via GitHub.

## Release Notes/Contributors/Etc

Unreleased as yet... 
