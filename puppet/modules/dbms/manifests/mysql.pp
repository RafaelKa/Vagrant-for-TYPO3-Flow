class dbms::mysql {

  apt::source { 'mysql':
    comment           => 'This is the official repository for MySQL',
    location          => 'http://repo.mysql.com/apt/ubuntu/',
    release           => 'trusty',
    repos             => 'mysql-5.6',
    key               => '5072E1F5',
    key_server        => 'pgp.mit.edu',
    include_src       => true,
    include_deb       => true
  }

  package { 'mysql-server':
    ensure  => 'installed',
    require => Apt::Source['mysql']
  }

  $settings = hiera('dbms')
  if $settings['MySQL']['autostart'] == true {
    exec { 'enable-autostart-for-mysql':
      command => 'update-rc.d mysql defaults',
      require => Package['mysql-server']
    }
    ->
    exec { 'start-mysql-server':
      command => 'service mysql start'
    }
    ->
    notify { 'MySQL-enable-autostart':
      message => 'autostart for MySQL enabled and server started'
    }
  } else {
    exec { 'disable-autostart-for-mysql':
      command => 'update-rc.d -f mysql remove',
      require => Package['mysql-server']
    }
    ->
    exec { 'stop-mysql-server':
      command => 'service mysql stop'
    }
    ->
    notify { 'MySQL-disable-autostart':
      message => 'autostart for MySQL disabled and server stopped'
    }
  }

}
