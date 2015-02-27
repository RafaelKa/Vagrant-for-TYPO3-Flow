class hosting {

  user { 'typo3':
    name        => 'typo3',
    home        => '/var/www/projects',
    managehome  =>  false,
    ensure      => present,
    shell       => '/bin/bash',
    uid         => 33,
    allowdupe   => true,
    gid         => 'www-data',
    # password: typo3
    password    => '$6$rOvX7PUSps1aYZ$mTGeOPYKy.Y9pcB90m.P4SDw5Ecidn6WuheGUAC8yFgL9ulHLMpBTwTMcm74UzGqm2Aj83fiYVC2UTaOQ8zF11',
    require     => Package['apache2']
  }
  ->
  notify { 'ssh-user-typo3-created':
    message => 'SSH user typo3 created. User: "typo3" and Password: "typo3"'
  }

  file { "/var/www/projects":
    ensure => directory,
    owner => 'typo3',
    group => 'www-data',
    mode => 0750,
    require => User['typo3']
  }
  ->
  notify { 'directory-for-hosting-created':
    message => 'directory /var/www/projects for your projects created'
  }

  file { "/var/www/logs":
    ensure => directory,
    owner => 'typo3',
    group => 'www-data',
    mode => 0750,
    require => [ User['typo3'], Package['apache2']]
  }
  ->
  notify { 'directory-for-logs-created':
    message => 'directory /var/www/logs for the log files from your projects created'
  }


  include hosting::apache
  include hosting::php
  include hosting::typo3_flow

}