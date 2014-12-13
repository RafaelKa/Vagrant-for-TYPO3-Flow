class dbms::postgresql {

  apt::source { 'postgresql':
    comment           => 'This is the official repository for MySQL',
    location          => 'http://apt.postgresql.org/pub/repos/apt ',
    release           => 'trusty-pgdg',
    repos             => 'main',
    key               => 'ACCC4CF8',
    key_server        => 'p80.pool.sks-keyservers.net',
    include_src       => true,
    include_deb       => true
  }

  package { 'postgresql-9.3':
    ensure  => 'installed',
    require => Apt::Source['postgresql']
  }

}
