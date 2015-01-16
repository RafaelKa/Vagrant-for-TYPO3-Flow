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

  apt::source { 'mariadb':
    comment           => 'This is the official repository for MariaDB',
    location          => 'http://ftp.hosteurope.de/mirror/mariadb.org/repo/10.0/ubuntu',
    release           => 'trusty',
    repos             => 'main',
    key               => '0xcbcb082a1bb943db',
    key_server        => 'keyserver.ubuntu.com',
    include_src       => true,
    include_deb       => true
  }

  ### MySQL and MariaDB can not be installed at same time by this way.
  ### So one must be choosed
  $settings = hiera('dbms')
  if $settings['MySQL']['prefer_maria_db'] == true {
    $mysql_or_mariadb = 'mariadb-server'
    package { 'software-properties-common':
      ensure  => 'installed'
    }
    ->
    package { 'mariadb-server':
      ensure  => 'latest',
      require => Apt::Source['mariadb']
    }
    ->
    notify { 'MariaDB-instead-of-MySQL-will-be-installed':
      message => 'MariaDB installed instead of MySQL.'
    }
    include dbms::mariadb
  } else {
    $mysql_or_mariadb = 'mysql-server'
    package { 'mysql-server':
      ensure  => 'installed',
      require => Apt::Source['mysql']
    }
  }

  if $settings['MySQL']['autostart'] == true {
    exec { 'enable-autostart-for-mysql':
      command => 'update-rc.d mysql defaults',
      require => Package[$mysql_or_mariadb]
    }
    ->
    exec { 'start-mysql-server':
      command => 'service mysql start'
    }
    ->
    notify { 'MySQL-enable-autostart':
      message => 'autostart for MySQL enabled and MySQL server started'
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
      message => 'autostart for MySQL disabled and MySQL server stopped'
    }
  }

}
