case $::osfamily {

  'redhat':{
  $user = 'nginx'
  $webroot = '/var/www/'
  $log_dir = '/var/log/nginx/'
  $conf_dir = '/etc/nginx/'
  package { 'nginx':
    ensure => present,
    }
  }

  'debian':{
  $user = 'nginx'
  $webroot = '/var/www/'
  $log_dir = '/var/log/nginx/'
  $conf_dir = '/etc/nginx/'
    package { 'nginx':
    ensure => present,
    }
  }

  'windows':{
  $user = 'nginx'
  $webroot = 'C:/ProgramData/nginx/html/'
  $log_dir = 'C:/ProgramData/nginx/logs/'
  $conf_dir = 'C:/ProgramData/nginx/'
  package { 'nginx-service':
    ensure => present,
    }
  }
  
}

include nginx
