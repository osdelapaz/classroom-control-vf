class nginx (
$root = undef,
){
case $::osfamily {

  'redhat':{
  $user = 'nginx'
#  $webroot = '/var/www'
  $log_dir = '/var/log/nginx'
  $conf_dir = '/etc/nginx'
  $owner = 'root'
  $group = 'root'
  package { 'nginx':
    ensure => present,
    }
  $default_webroot = '/var/www'
  }

  'debian':{
  $user = 'www-data'
#  $webroot = '/var/www'
  $log_dir = '/var/log/nginx'
  $conf_dir = '/etc/nginx'
  $owner = 'root'
  $group = 'root'
  package { 'nginx':
    ensure => present,
    }
  $default_webroot = '/var/www'
  }

  'windows':{
  $user = 'nobody'
#  $webroot = 'C:/ProgramData/nginx/html'
  $log_dir = 'C:/ProgramData/nginx/logs'
  $conf_dir = 'C:/ProgramData/nginx'
  $owner = 'Administrator'
  $group = 'Administrators'
  package { 'nginx-service':
    ensure => present,
    }
  $default_webroot = 'C:/ProgramData/nginx/html'
  }
  
  default :{
    fail("Service is not available in ${::osfamily}")
  }

}

$webroot = $root ? {
undef => $default_webroot,
default => $root,
} 

File {
owner => $owner,
group => $group,
mode => '0644',
}

file {[$webroot, $log_dir, $conf_dir]:
  ensure => directory,
}

file { "${webroot}/index.html":
  ensure => file,
  source => 'puppet:///modules/nginx/index.html',
}

file { "${conf_dir}/nginx.conf":
  ensure => file,
  content => template('nginx/nginx.conf.erb'),
  notify => Service['nginx'],
}

file { "${conf_dir}/conf.d/default.conf":
  ensure => file,
  content => template('nginx/default.conf.erb'),
  notify => Service['nginx'],
}

service { 'nginx':
  ensure => running,
  enable => true,
}

} 
