# puppet-nrpe ![License badge][license-img]

1. [Overview](#overview)
2. [Description](#description)
3. [Setup](#setup)
4. [Usage](#usage)
5. [Limitations](#limitations)
6. [Development](#development)
7. [Miscellaneous](#miscellaneous)

## Overview

NRPE  allows  you  to  remotely  execute Nagios  plugins  on  other  Linux/Unix
machines. This  allows you to monitor  remote machine metrics (disk  usage, CPU
load, etc.). NRPE  can also communicate with some of  the Windows agent addons,
so you  can execute  scripts and  check metrics on  remote Windows  machines as
well.

[github.com/nagiosenterprises/nrpe](https://github.com/nagiosenterprises/nrpe/)

## Description

Puppet module to install, deploy and configure nrpe.

## Setup

Copy this module in your modules folder without *puppet-* in the name.

or

```bash
puppet module install vpgrp-nrpe
```

## Usage

```puppet
class { 'nrpe':
  package       => true,
  service       => true,
  allowed_hosts => [ '10.0.0.0/8', '192.168.0.0/16' ],
}
```

```puppet
nrpe::plugin {
  'check_memory':
    source => 'puppet:///modules/nrpe/check_memory'
}

nrpe::command {
  'check_memory':
    command => 'check_memory'
}
```

## Limitations

So far, this is compatible with Debian, RedHat, and other derivatives.

## Development

Please read carefully CONTRIBUTING.md before making a merge request.

## Miscellaneous

```
    ╚⊙ ⊙╝
  ╚═(███)═╝
 ╚═(███)═╝
╚═(███)═╝
 ╚═(███)═╝
  ╚═(███)═╝
   ╚═(███)═╝
```

[license-img]: https://img.shields.io/badge/license-Apache-blue.svg
