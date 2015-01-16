class dbms::couchdb {

  apt::ppa { 'ppa:couchdb/stable':}

  package { 'couchdb':
    ensure  => 'latest',
    require => Apt::Ppa['ppa:couchdb/stable']
  }

  $settings = hiera('dbms')
  if $settings['CouchDB']['autostart'] == true {
    exec { 'enable-starting-couchdb-on-start':
      command => 'update-rc.d couchdb defaults',
      require => Package['couchdb']
    }
    ->
    exec { 'start-couchdb-server':
      command => 'service couchdb start'
    }
    ->
    notify { 'CouchDB-enable-autostart':
      message => 'autostart for CouchDB enabled and CouchDB server started'
    }
  } else {
    exec { 'disable-starting-couchdb-on-start':
      command => 'update-rc.d -f couchdb remove',
      require => Package['couchdb']
    }
    ->
    exec { 'stop-couchdb-server':
      command => 'service couchdb stop'
    }
    ->
    notify { 'CouchDB-disable-autostart':
      message => 'autostart for CouchDB disabled and CouchDB server stopped'
    }
  }

}