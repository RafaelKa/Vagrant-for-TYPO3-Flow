class dbms::mariadb {

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

  package { 'software-properties-common':
    ensure  => 'installed'
  }
  ->
  package { 'mariadb-server':
    ensure  => 'latest',
    require => Apt::Source['mariadb']
  }

}