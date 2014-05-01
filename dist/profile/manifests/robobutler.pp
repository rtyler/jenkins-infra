#
# IRC bot that runs project meeting
# containerized in https://github.com/jenkins-infra/robobutler
#
class profile::robobutler (
  # all injected from hiera
  # TODO: defining default as undef makes no sense. reconsider this lint check
  $nick     = undef,
  $password = undef
) {
  include 'docker'

  docker::image { 'jenkinsciinfra/butlerbot':
    image_tag => 'build6',
  }

  docker::run { 'butlerbot':
    command => undef,
    image   => 'jenkinsciinfra/butlerbot',
    env     => ["NICK=${nick}","PASSWORD=${password}"],
  }
}