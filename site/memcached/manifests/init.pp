class memcached {
  file {'/etc/sysconfig/memcached':
  ensure => file,
  source => 'puppet:///modules/memcached/memcached',
  require => Package['memcached'],
  }
  
  package { 'memcached':
  ensure => present,
  }
 
  service {'memcached':
  ensure => running,
  enable => true,
  subscribe => File['/etc/sysconfig/memcached'],
  }

  
}
