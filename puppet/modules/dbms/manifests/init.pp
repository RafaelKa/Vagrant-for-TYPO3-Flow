class dbms {

  ### MySQL and MariaDB can not be installed at same time by this way.
  ### So one must be choosed
  $settings = hiera('dbms')
  if ($settings['MySQL']['prefer_maria_db']) {
    notify { "MariaDB will be installed instead of MySQL.":}
    include dbms::mariadb
  } else {
    include dbms::mysql
  }

  include dbms::postgresql
  include dbms::couchdb
  include dbms::mongodb

}