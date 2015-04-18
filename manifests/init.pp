# == Class: ssh_login_message
#
# Full description of class ssh_login_message here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { ssh_login_message:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class ssh_login_message {

    file{ "/etc/motd" :
        ensure => file,
        owner => root,
        group => root,
        mode => 0644,
        source => 'puppet:///modules/ssh_login_message/login_message',

        notify => Service['sshd']
    }

    augeas{ "disable_last_login_msg":
        context => "/files/etc/ssh/sshd_config",
        changes => [
            "set PrintLastLog no",
            "set PrintMotd yes"
            ],
        before => Service['sshd']
    }

    service {"sshd":
        ensure => running,
        path => "/etc/init.d/"
    }

}
