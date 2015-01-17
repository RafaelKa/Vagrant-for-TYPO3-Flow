class dbms {


  include dbms::mysql
  include dbms::postgresql
  include dbms::couchdb
  # MongoDB makes troubles on build, it fails even only MongoDB is included.
  # @todo: search for cause from this behaviour
#  include dbms::mongodb

}
