class skeleton {
  file {'/etc/skel':
  ensure => directory;
  owner => 'root',
  group => 'root',
  mpde => '0755',
  }
  file {'etc/skel/.bashrc',
  owner => 'root',
  group => 'root',
  mode => '0644',
  source => 'puppet:///site/skeleton/files/bashrc',
}
