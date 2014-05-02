#
# IRC bot that runs project meeting
# containerized in https://github.com/jenkins-infra/robobutler
#
class profile::robobutler (
  # all injected from hiera
  $nick,
  $password,
  $logdir = '/var/www/meetings.jenkins-ci.org'
) {
  $tag = 'build9'

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
    image_tag => $tag,
  }

  docker::run { 'butlerbot':
    command  => undef,
    image    => "jenkinsciinfra/butlerbot:${tag}",
    volumes  => [$logdir, '/etc/butlerbot.conf']
  }

  include 'apache'
  jenkins_apache::virtualhost { 'meetings.jenkins-ci.org':
    content => template('jenkins_apache/standard_virtualhost.erb'),
  }
}