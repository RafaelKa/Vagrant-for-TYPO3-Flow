class webserver::apache2 {

  apt::ppa { 'ppa:ondrej/apache2':}

  package { 'apache2':
    ensure  => 'installed',
    require => Apt::Ppa['ppa:ondrej/apache2']
  }

  /*
    @todo: use hiera file to enable or disable this service
    exec { 'disable-starting-couchdb-on-start'
      command: 'echo "manual" | tee /etc/init/couchdb.override'
    }
  */

}