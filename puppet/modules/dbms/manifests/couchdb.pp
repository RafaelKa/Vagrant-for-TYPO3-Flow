class dbms::couchdb {

  apt::ppa { 'ppa:couchdb/stable':}

  package { 'couchdb':
    ensure  => 'installed',
    require => Apt::Ppa['ppa:couchdb/stable']
  }

    /*
      @todo: use hiera file to enable or disable this service
      exec { 'disable-starting-couchdb-on-start':
        command => 'echo "manual" | tee /etc/init/couchdb.override',
        require => Package['couchdb']
      }
    */

}