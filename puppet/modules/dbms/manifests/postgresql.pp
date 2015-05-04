class dbms::postgresql {

  apt::source { 'postgresql':
    comment   => 'This is the official repository for PostgreSQL',
    location  => 'http://apt.postgresql.org/pub/repos/apt',
    release   => 'trusty-pgdg',
    repos     => 'main',
    key       => {
      id       => 'B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8',
      #server  => 'p80.pool.sks-keyservers.net',
      source  => 'https://www.postgresql.org/media/keys/ACCC4CF8.asc',
    },
    include   => {
      'src'  =>  true,
      'deb'  =>  true
    }
  }

  package { 'postgresql-9.4':
    ensure  => 'latest',
    require => Apt::Source['postgresql']
  }

  $settings = hiera('dbms')
  if $settings['PostgreSQL']['autostart'] == true {
    exec { 'enable-autostart-for-postgresql':
      command => 'update-rc.d postgresql defaults',
      require => Package['postgresql-9.4']
    }
    ->
    exec { 'start-postgresql-server':
      command => 'service postgresql start'
    }
    ->
    notify { 'PostgreSQL-enable-autostart':
      message => 'autostart for PostgreSQL enabled and PostgreSQL server started'
    }
  } else {
    exec { 'disable-autostart-for-postgresql':
      command => 'update-rc.d -f postgresql remove',
      require => Package['postgresql-9.4']
    }
    ->
    exec { 'stop-postgresql-server':
      command => 'service postgresql stop'
    }
    ->
    notify { 'PostgreSQL-disable-autostart':
      message => 'autostart for PostgreSQL disabled and PostgreSQL server stopped'
    }
  }

}
