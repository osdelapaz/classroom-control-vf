class nginx (
$user = $nginx::params::user,
$webroot = $nginx::params::webroot,
$conf_dir = $nginx::params::conf_dir,
$log_dir = $nginx::params::log_dir,
$owner = $nginx::params::owner,
$group = $nginx::params::group,
$package = $nginx::params::package,
) inherits nginx::params {

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
