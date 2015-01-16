class dbms::mongodb {

  apt::source { 'mongodb':
    comment           => 'This is the official repository for MongoDB',
    location          => 'http://downloads-distro.mongodb.org/repo/ubuntu-upstart',
    release           => 'dist',
    repos             => '10gen',
    key               => '7F0CEB10',
    key_server        => 'keyserver.ubuntu.com',
    ## sources does not exist currently
    include_src       => false,
    include_deb       => true
  }

  # latest stable release
  package { 'mongodb-org':
    ensure  => 'latest',
    require => Apt::Source['mongodb']
  }

  $settings = hiera('dbms')
  if $settings['MongoDB']['autostart'] == true {
    exec { 'enable-autostart-for-mongodb':
      command => 'update-rc.d mongod defaults',
      require => Package['mongodb-org']
    }
    ->
    exec { 'start-mongodb-server':
      command => 'service mongod start'
    }
    ->
    notify { 'MongoDB-enable-autostart':
      message => 'autostart for MongoDB enabled and MongoDB server started'
    }
  } else {
    exec { 'disable-autostart-for-mongodb':
      command => 'update-rc.d -f mongod remove',
      require => Package['mongodb-org']
    }
    ->
    exec { 'stop-mongodb-server':
      command => 'service mongod stop'
    }
    ->
    notify { 'MongoDB-disable-autostart':
      message => 'autostart for MongoDB disabled and MongoDB server stopped'
    }
  }

  /*
    todo: make versions configurable

  package {[
    'mongodb-org=' + settings['MongoDB']['version'],
    'mongodb-org-server=' + settings['MongoDB']['version'],
    'mongodb-org-shell=' + settings['MongoDB']['version'],
    'mongodb-org-mongos=' + settings['MongoDB']['version'],
    'mongodb-org-tools=' + settings['MongoDB']['version']]:
    ensure  => 'installed',
    require => Apt::Source['mongodb']
  }

  exec{
    'Pin a ' + settings['MongoDB']['version'] + ' version of MongoDB.' :
    command => 'echo "mongodb-org hold" | dpkg --set-selections; ' +
               'echo "mongodb-org-server hold" | dpkg --set-selections; ' +
               'echo "mongodb-org-shell hold" | dpkg --set-selections; ' +
               'echo "mongodb-org-mongos hold" | dpkg --set-selections; ' +
               'echo "mongodb-org-tools hold" | dpkg --set-selections; ' +
  }

  */

}