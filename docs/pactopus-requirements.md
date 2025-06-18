# Pactopus

## Overview
This document defines the requirements for implementation of a software solution to the problem of standardizing, to a
reasonable degree, the user operation environment for a user, across multiple devices and operating contexts.
The intention is for this software to manage the installation and configuration of sets of software packages, 
as well as storing and installing small user created support utilities and helsper scripts.

The software is intended for CLI usage on Linux operating systems.  The initial design will target support for several
popular distributions, but it could possibly work or be easily adapted on other derivative distributions, WSL versions
of supported distributions, other Unix or Unix like systems *BSD, or versions of MacOS.  Outside of WSL, support for
Windows is not planned or easily viable.

## Functional Requirements

### Software Installation
Pactopus should perform the installation of sets of software in a uniform manner, in a variety of environments.  The
specific technical details of which environments are specified in the ** Technical Requirements ** section.  It should
use the most appropriate method of installation for the environment it is running in.  It will need to take into 
consideration variations for each environment, including but not limited to:

    * The same software may track by different names in different platforms
    * Not every software or package is required or needed on every platform (dpkg development tools are not needed
      outside of the Debian family tree for example)
    * Some platforms may being using outdated versions of software
    * Some software may only be available through manual installers or compilation on one or all platforms

#### Composable Configuration sets
Pactopus is intended for use in a variety of Linux environments, including docker containers, remote servers via
a terminal interface only, minimal desktop environments, and full workstation environments.   It should also
support usablity for mulitple specific purposes, such as development activities.  Pactopus should support installing
packages as combosable sets during setup.  A package set should be defineable as a list of packages and other package
sets.  For example the Basline set may list 3 packages, the remote server set may list 2 additional packages plus the
baseline set, and the delevelopment package may define 4 packages and the baseline set.   The user should be able to 
request installation of a single package plus multiple package sets, and pactopus should aggregate and deduplicate the
combined list of packages, and proceed to install the aggregate set.  For the initial implementation these package sets
can be defined and managed at build/design time. 

The full set of package set definitions for initial implementation can be found in
[pactopus-initial-package-lists.md](pactopus-initial-package-lists.md).

### Software Configuration
Pactopus should clone, or pull the latest version of https://github.com/jdubba/dotfiles/, install using make install,
then initialize dotfiles management using the "dotfiles install" command.  This will take care of basic software
configuration.

### User Defined Tools
Pactopus should also keep a /bin and /lib folder, to holder user created utilities, and helper scripts that can be
installed along side the core pactopus application.

## Technical requirements

### Suported Platforms
Pactopus should support the following list of Linux distributions:
    * Arch Linux
    * Fedora Workstation and all non Atomic Spins
    * Fedora Server
    * CentOS Stream
    * RedHat Enterprise Linux
    * Alma Linux
    * Rocky Linux
    * Amazon Linux 2
    * Debian
    * Linux Mint Debian Edition
    * Ubuntu Workstation
    * Ubuntu Server 
    * Kubuntu
    * Linux Mint
    * PopOS!
    * Alpine Linux
    * OpenSUSE
    * OpenSUSE Tumbleweed

#### Platform Categories and Strategies
Among distributions, some platforms are rolling releases, staying continually up to date with the latest versions
of packages, and others are stable or long term releases.  Pactopus should employ different installation strategies
for rolling versus stable releases.  For rolling release distributions, Pactopus should favor using the package 
management platform provided by the distribution.  For stable release distributions, Pactopus should favor installing
binaries, alternate packages, alternate package sources, or compilation from source to ensure the latest versions
of software.

Below are the list of rolling distributions.  All others from the supported platforms list should be considered
long term stable.

    * Arch Linux
    * Fedora Workstation
    * Fedora Server
    * CentOS Stream
    * OpenSUSE Tumbleweed

### Construction
The primary interface for Pactopus should be a CLI bash utility: pactopus.  It should support a general structure of:

    pactopus [COMMAND] <OPTIONS> arguments

It should implement a "help" command to display usage information.

It should implement an install command that takes a space separated list of package sets, or packages and runs the 
installation process for them.  Installation should track the list of installed package sets and packages for
future update support.  The installation data can be stored in the $XDG_CONFIG_HOME/pactopus/ directory.

It should implement an update command that will update all currently installed packages and package sets

The install and update commands should be idempotent.

The installation process should be implemented using Ansible and Ansible playbooks.

Platapus should be initially be implemented to be built/installed from source after either cloning the repository
or downloading a source tarball.  It should leverage make for the installation process, along with unit testing, 
and linting via make.

The install process should also idempotently provide update functionality.

Install should installing the CLI bash utility, along with all user defined tools to $HOME/.local/share/pactopus, then
symlink everything to $HOME/.local/bin/

Project structure
/                          : project root, makefile, README.md, CHANGELOG.md
|----/src                  : Project source code
      |----/user           : Extra user defined scripts and tools
      |----/playbooks      : Anisble playbooks for package and package-set installation
|----/docs                 : Project documentation
|----/tests                : Project unit tests
