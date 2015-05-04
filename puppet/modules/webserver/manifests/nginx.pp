class webserver::nginx {

  apt::source { 'nginx':
    comment           => 'This is the official repository for NginX',
    location          => 'http://nginx.org/packages/ubuntu/',
    release           => 'trusty',
    repos             => 'nginx',
    key               => {
      id     => 'ABF5BD827BD9BF62',
      source  => 'http://nginx.org/keys/nginx_signing.key',
    },
    include           => {
      'src'  =>  true,
      'deb'  =>  true
    }
  }

  package { 'nginx':
    ensure  => 'latest',
    require => Apt::Source['nginx']
  }
}