group {
  'puppet': ensure => 'present'
}

include stdlib

Exec {
  path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ]
}

## Use Mac style installation folder
#file { "/usr/local/bin":
#  owner => "vagrant",
#  group => "vagrant",
#  recurse => true
#}

# Strangely, bash is not the default...
user { "vagrant":
  ensure => present,
  shell => "/bin/bash"
}

### exec apt-get update for each package
exec { "apt-update":
  command => "/usr/bin/apt-get update"
}
Exec["apt-update"] -> Package <| |>

class { 'apt':
  always_apt_update => true
}

include dbms
include webserver
include serversidescripting
include hosting