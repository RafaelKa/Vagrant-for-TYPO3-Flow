class tools {

  package { 'unzip':
    ensure  => 'latest'
  }

  file { "/var/www/tools":
    ensure => directory,
    owner => 'www-data',
    group => 'www-data',
    require => User['typo3'],
    mode => 0750
  }
  ->
  notify { 'directory-for-tools-created':
    message => 'directory /var/www/tools for tools like phpMyAdmin created'
  }


  include tools::phpmyadmin
}