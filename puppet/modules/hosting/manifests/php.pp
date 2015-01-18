class hosting::php {

  file { '/etc/php5/fpm/pool.d/typo3-flow.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    ensure  => file,
    require => Package['php5-fpm'],
    content => template('hosting/php5-fpm.typo3-flow.conf.erb')
  }
  ->
  notify { 'php5-fpm-config-for-typo3-flow-applied':
    message => 'PHP-FPM pool for TYPO3 Flow applied'
  }

}