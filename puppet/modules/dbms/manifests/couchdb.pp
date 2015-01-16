class dbms::couchdb {

  apt::ppa { 'ppa:couchdb/stable':}

  package { 'couchdb':
    ensure  => 'installed',
    require => Apt::Ppa['ppa:couchdb/stable']
  }

  $settings = hiera('dbms')
  if $settings['CouchDB']['autostart'] == true {
    notify { 'enabling autostart for CouchDB': }
    exec { 'enable-starting-couchdb-on-start':
      command => 'rm -f /etc/init/couchdb.override && service couchdb start',
      require => Package['couchdb']
    }
  } else {
    notify { 'disabling autostart for CouchDB': }
    exec { 'disable-starting-couchdb-on-start':
      command => 'echo "manual" | tee /etc/init/couchdb.override && service couchdb stop',
      require => Package['couchdb']
    }
  }

}