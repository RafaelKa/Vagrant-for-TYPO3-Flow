class dbms {

  class { 'apt':
    always_apt_update => true,
  }

#  include dbms::couchdb
#  include dbms::mysql
  include dbms::mongodb

}