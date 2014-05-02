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

  file { $logdir:
    ensure => directory,
    owner  => 500,
    mode   => '0755'
  }

  docker::image { 'jenkinsciinfra/butlerbot':
    image_tag => 'build6',
  }

  docker::run { 'butlerbot':
    command => undef,
    image   => 'jenkinsciinfra/butlerbot',
    env     => ["NICK=${nick}","PASSWORD=${password}","HTML_DIR==${logdir}"],
    volumes => [$logdir]
  }
}