define users::managed_user (
) {
  user { $title:
  ensure => present,
  }
  file { "/home/${title}":
  ensure => directory,
  owner => $title,
  group => $title,
  mode => '0700',
  }
  file { "/home/${title}/.ssh":
  ensure => directory,
  owner => $title,
  group => $title,
  mode => '0700',
  }
}
