#
# Basic profile for configuring collectd on a machine
class profile::collectd {
  class { '::collectd':
    purge        => true,
    recurse      => true,
    purge_config => true,
  }

  # All our handy collectd plugins
  class {
    [
      '::collectd::plugin::cpu',
      '::collectd::plugin::load',
      '::collectd::plugin::memory',
      '::collectd::plugin::uptime',
      '::collectd::plugin::users',
      '::collectd::plugin::vmem',
    ] : ;
  }

  class { '::collectd::plugin::syslog':
    log_level => 'warning',
  }

  class { '::collectd::plugin::interface':
    interfaces     => ['lo'],
    ignoreselected => true,
  }
}
