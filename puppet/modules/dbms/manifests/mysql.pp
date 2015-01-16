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
      command => 'service mysql start',
      refreshonly => true,
      subscribe => Package['mysql-server'],
    }
    notify { 'enabling autostart for MySQL':
      subscribe => Exec['enable-starting-mysql-server-on-start']
    }
  } else {
    exec { 'disable-starting-mysql-server-on-start':
      command => 'service mysql stop',
      require => Package['mysql-server']
    }
    notify { 'disabling autostart for MySQL':
      subscribe => Exec['disable-starting-mysql-server-on-start'],
    }
  }

}
