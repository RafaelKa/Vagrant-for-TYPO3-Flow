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

#  apt::source { 'mariadb':
#    comment           => 'This is the official repository for MariaDB',
#    location          => 'http://ftp.hosteurope.de/mirror/mariadb.org/repo/10.0/ubuntu',
#    release           => 'trusty',
#    repos             => 'main',
#    key               => '0xcbcb082a1bb943db',
#    key_server        => 'keyserver.ubuntu.com',
#    include_src       => true,
#    include_deb       => true
#  }

  /*
    @todo:
    ### use hiera file to decide if MySQL or MariaDB should be used

  ######
  if $config['mysql']['preferMariaDB'] {
    package { 'software-properties-common':
      ensure  => 'installed'
    }

    package { 'mariadb-server':
      ensure  => 'installed',
      require => Apt::Source['mariadb']
    }
  } else {
    package { 'mysql-server':
      ensure  => 'installed',
      require => Apt::Source['mysql']
    }

  }
  ######



    ### use hiera file to enable or disable this service
    exec { 'disable-starting-mysql-on-start'
      command: 'echo "manual" | tee /etc/init/couchdb.override'
    }
  */

}