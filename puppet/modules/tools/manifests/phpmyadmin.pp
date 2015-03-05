class tools::phpmyadmin {

  exec { 'install-phpmyadmin':
    command => 'su --login --shell /bin/bash --command "composer create-project --keep-vcs --stability=dev phpmyadmin/phpmyadmin /var/www/tools/phpmyadmin >=4.3.10" www-data',
    require => [ Exec['composer-install'], File['/var/www/tools'], Package['git'] ],
    #    returns => [0, 1, 2, 14]
    timeout => 600
  }
  ->
  notify { 'phpMyAdmin-is-installed':
    message => 'phpMyAdmin is installed'
  }
}