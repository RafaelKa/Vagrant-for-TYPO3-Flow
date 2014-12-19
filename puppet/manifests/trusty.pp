group {
  'puppet': ensure => 'present'
}

include stdlib

Exec {
  path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ]
}

# Use Mac style installation folder
file { "/usr/local/bin":
  owner => "vagrant",
  group => "vagrant",
  recurse => true
}

# Strangely, bash is not the default...
user { "vagrant":
  ensure => present,
  shell => "/bin/bash"
}

class { 'apt':
  always_apt_update => true
}

include dbms

include webserver