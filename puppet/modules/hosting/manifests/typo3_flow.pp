class hosting::typo3_flow {

  exec { 'install-typo3-flow':
  command => 'composer create-project --dev --keep-vcs typo3/flow-base-distribution /var/www/projects/typo3-flow.dev',
  require => [ Exec['composer-install'], File["/var/www/projects"] ]
  }
  ->
  notify { 'typo3-flow-is-installed':
    message => 'TYPO3 Flow is installed'
  }
}