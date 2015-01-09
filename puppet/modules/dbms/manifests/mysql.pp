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

}