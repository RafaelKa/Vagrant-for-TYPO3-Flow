class hosting {

  user { 'typo3-flow':
    name        => 'typo3-flow',
    home        => '/var/www/projects',
    managehome  =>  false,
    ensure      => present,
    shell       => '/bin/false',
    allowdupe   => true,
    uid         => 33,
    gid         => 'www-data',

    require     => Package['apache2']
  }

  user { 'typo3-flow-ssh':
    name        => 'typo3-flow-ssh',
    home        => '/var/www/projects',
    managehome  =>  false,
    ensure      => present,
    shell       => '/bin/bash',
    uid         => 33,
    allowdupe   => true,
    gid         => 'www-data',
    # password: typo3-flow
    password    => '$6$/hIk9.lgRIvEShZ2$M9qvJfEmMQpuXDjsyfrq4427EiTD9Sio1dxdGqUQMQG4k20n53W7eGYRFw0qNKKhJfwR2q/TWfAnI0awZAK6J/',


    require     => Package['apache2']
  }

  file { "/var/www/projects":
    ensure => directory,
    owner => 'typo3-flow',
    group => 'www-data',
    mode => 0750,
    require => [ User['typo3-flow'], Package['apache2']]
  }
  ->
  notify { 'directory-for-hosting-created':
    message => 'directory /var/www/projects for your projects created'
  }

  file { "/var/www/logs":
    ensure => directory,
    owner => 'typo3-flow',
    group => 'www-data',
    mode => 0750,
    require => [ User['typo3-flow'], Package['apache2']]
  }
  ->
  notify { 'directory-for-logs-created':
    message => 'directory /var/www/logs for the log files from your projects created'
  }


  include hosting::apache
  include hosting::php

}