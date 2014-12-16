class webserver {

  class { 'apt':
    always_apt_update => true,
  }

#  include webserver::nginx
  include webserver::apache2

}