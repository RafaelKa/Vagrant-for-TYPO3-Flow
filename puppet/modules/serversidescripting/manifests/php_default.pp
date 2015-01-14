class serversidescripting::php_default {


  $php_packages = [
    "php5",
    "php5-common",
    "php5-gd",
    "php5-mysql",
    "php5-imap",
    "phpmyadmin",
    "php5-cli",
    "php5-cgi",
    "php-pear",
    "php-auth",
    "php5-mcrypt",
    "mcrypt",
    "php5-imagick",
    "imagemagick",
    "php5-curl",
    "php5-intl",
    "php5-memcache",
    "php5-memcached",
    "php5-ming",
    "php5-ps",
    "php5-pspell",
    "php5-recode",
    "php5-snmp",
    "php5-sqlite",
    "php5-tidy",
    "php5-xmlrpc",
    "php5-xsl",
    "memcached",
    "libexpat1",
    "ssl-cert"

  ]

  package { $php_packages:
    ensure  => 'installed'
  }

  /*
  php5
  php5-common
  php5-gd
  php5-mysql
  php5-imap
  phpmyadmin
  php5-cli
  php5-cgi
  php-pear
  php-auth
  php5-mcrypt
  mcrypt
  php5-imagick
  imagemagick
  libapache2-mod-suphp
  libruby
  php5-curl
  php5-intl
  php5-memcache
  php5-memcached
  php5-ming
  php5-ps
  php5-pspell
  php5-recode
  php5-snmp
  php5-sqlite
  php5-tidy
  php5-xmlrpc
  php5-xsl
  memcached

  libexpat1
  ssl-cert

  */

}
