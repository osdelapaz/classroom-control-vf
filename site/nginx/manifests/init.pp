class nginx {

File {
  owner => 'root',
  group => 'root',
  mode => '0664',
}

$web_dir='/var/www'
$nginx_conf='/etc/nginx/conf.d'

  package { 'nginx':
  ensure => present,
  }

  file { $web_dir:
  ensure => directory,
  }

  file { "${web_dir}/index.html":
  ensure => file,
  source => 'puppet:///modules/nginx/index.html',
  }

  file { '/etc/nginx/nginx.conf':
  ensure => file,
  source => 'puppet:///modules/nginx/nginx.conf',
  require => Package['nginx'],
  notify => Service['nginx'],
  }

  file { $nginx_conf:
  ensure => directory
  }

  file { "${nginx_conf}/default.conf":
  ensure => file,
  source => 'puppet:///modules/nginx/default.conf',
  require => Package['nginx'],
  notify => Service['nginx'],
  }

  service { 'nginx':
  ensure => running,
  enable => true,
  }

}
