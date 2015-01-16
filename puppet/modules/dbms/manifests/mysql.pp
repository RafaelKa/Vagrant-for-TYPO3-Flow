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
    exec { 'enable-starting-mysql-server-on-start':
      command => 'update-rc.d mysql defaults && service mysql start',
#      refreshonly => true,
      require => Package['mysql-server'],
    }
    ->
    notify { 'enable autostart for MySQL':
      message => 'enabling autostart for MySQL'
    }
  } else {
    exec { 'disable-starting-mysql-server-on-start':
      command => 'update-rc.d -f mysql remove && service mysql stop',
      require => Package['mysql-server']
    }
    ->
    notify { 'disable autostart for MySQL':
      message => 'disabling autostart for MySQL'
    }
  }

}
