class dbms::mysql {

  ### MySQL and MariaDB can not be installed at same time by this way.
  ### So one must be choosed
  $settings = hiera('dbms')
  if $settings['MySQL']['prefer_maria_db'] == true {
    $mysql_or_mariadb = 'mariadb-server'

    apt::source { 'mariadb':
      comment           => 'This is the official repository for MariaDB',
      location          => 'http://ftp.hosteurope.de/mirror/mariadb.org/repo/10.0/ubuntu',
      release           => 'trusty',
      repos             => 'main',
      key               => {
        id     => '199369E5404BD5FC7D2FE43BCBCB082A1BB943DB',
        server  => 'keyserver.ubuntu.com',
      },

      include           => {
        'src'  =>  true,
        'deb'  =>  true
      }
    }

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
  } else {
    $mysql_or_mariadb = 'mysql-server'

    apt::source { 'mysql':
      comment           => 'This is the official repository for MySQL',
      location          => 'http://repo.mysql.com/apt/ubuntu/',
      release           => 'trusty',
      repos             => 'mysql-5.6',
      key               => {
        id     => 'A4A9406876FCBD3C456770C88C718D3B5072E1F5',
        server  => 'pgp.mit.edu',
      },
      include           => {
        'src'  =>  true,
        'deb'  =>  true
      }
    }

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
      require => Package[$mysql_or_mariadb]
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
