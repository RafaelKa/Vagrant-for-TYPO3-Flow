class dbms {

  class { 'apt':
    always_apt_update => true,
  }

  include dbms::mysql
  include dbms::postgresql
  include dbms::couchdb
  include dbms::mongodb

}