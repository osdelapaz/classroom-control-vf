class nginx::params {
  case $::osfamily {
  'redhat','debian':{
    $user = 'nginx'
    $webroot = '/var/www'
    $log_dir = '/var/log/nginx'
    $conf_dir = '/etc/nginx'
    $owner = 'root'
    $group = 'root'
    package { 'nginx':
      ensure => present,
      }
    }
    
  'windows':{
  $user = 'nobody'
  $webroot = 'C:/ProgramData/nginx/html'
  $log_dir = 'C:/ProgramData/nginx/logs'
  $conf_dir = 'C:/ProgramData/nginx'
  $owner = 'Administrator'
  $group = 'Administrators'
  package { 'nginx-service':
    ensure => present,
    }
  }
  default :{
    fail("Service is not available in ${::osfamily}")
    }
}
}

$user = $::osfamily ? {
  'redhat' => 'nginx',
  'debian' => 'www-data',
  'windows' => 'nobody',
}

