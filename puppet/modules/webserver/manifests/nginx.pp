class webserver::nginx {

  apt::source { 'nginx':
    comment           => 'This is the official repository for NginX',
    location          => 'http://nginx.org/packages/ubuntu/',
    release           => 'trusty',
    repos             => 'nginx',
    key               => 'ABF5BD827BD9BF62',
    key_server        => 'keyserver.ubuntu.com',
    include_src       => true,
    include_deb       => true
  }

  package { 'nginx':
    ensure  => 'latest',
    require => Apt::Source['nginx']
  }
}