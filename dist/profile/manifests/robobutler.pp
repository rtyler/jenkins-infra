#
# IRC bot that runs project meeting
# containerized in https://github.com/jenkins-infra/robobutler
#
class profile::robobutler (
  # all injected from hiera
  $nick,
  $password,
  $logdir = '/var/lib/butlerbot'
) {
  include 'docker'

  # butlerbot user id. hard-coded into butlerbot image
  $uid = 500
  user { 'butlerbot':
    uid   => $uid,
    shell => '/bin/false'
  }

  file { $logdir:
    ensure => directory,
    owner  => 'butlerbot',
    mode   => '0755'
  }

  file { '/etc/butlerbot.conf':
    owner => 'butlerbot',
    mode  => '0600',
    content => "export NICK=${nick}\nexport PASSWORD=${password}\nexport HTML_DIR=${logdir}"
  }

  docker::image { 'jenkinsciinfra/butlerbot':
    image_tag => 'build9',
  }

  docker::run { 'butlerbot':
    command  => undef,
    use_name => true,
    image    => 'jenkinsciinfra/butlerbot',
    volumes  => [$logdir, '/etc/butlerbot.conf']
  }
}