class hosting {
  user { 'typo3-flow':
    name        => 'typo3-flow',
    home        => '/var/www/projects/',
    managehome  =>  true,
    ensure      => present,
    shell       => '/bin/false',
    uid         => 33,
    gid         => 'www-data'
  }

  user { 'typo3-flow-ssh':
    name        => 'typo3-flow-ssh',
    home        => '/var/www/projects/',
    managehome  =>  true,
    ensure      => present,
    shell       => '/bin/bash',
    uid         => 33,
    gid         => 'www-data',
    # password: typo3-flow
    password    => '$6$/hIk9.lgRIvEShZ2$M9qvJfEmMQpuXDjsyfrq4427EiTD9Sio1dxdGqUQMQG4k20n53W7eGYRFw0qNKKhJfwR2q/TWfAnI0awZAK6J/'
  }

  file { "/var/www/projects":
    ensure => directory,
    owner => 'typo3-flow',
    group => 'www-data',
    mode => 0750,
    require => User['typo3-flow']
  }


  # Configure Apache HTTPd to run PHP with FPM
  file { '/etc/apache2/sites-available/000-default.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    ensure  => file,
    require => Package['apache2'],
    content => template('hosting/apache.default.vhost.erb')
  }
  ->
  notify { 'mass-vhost-configuration-applied':
    message => 'mass hosting configuration for Apache HTTPd applied'
  }

}