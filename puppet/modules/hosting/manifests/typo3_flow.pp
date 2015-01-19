class hosting::typo3_flow {

  exec { 'install-typo3-flow':
  command => 'su --login --shell /bin/bash --command "composer create-project --dev --keep-vcs typo3/flow-base-distribution /var/www/projects/typo3-flow.dev" typo3',
  require => [ User['typo3'], Exec['composer-install'], File['/var/www/projects'], Package['git'] ],
  returns => [0, 1, 2, 14]

  }
  ->
  notify { 'typo3-flow-is-installed':
    message => 'TYPO3 Flow is installed'
  }
}