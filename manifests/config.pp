# Class: limits::config
#
# This class manage the default limits configuration
class limits::config {
  case $::operatingsystem {
    /(Ubuntu|Debian)/ : {
      augeas { 'pam_set_su_limits':
        context => '/files/etc/pam.d/su',
        changes => [
          "ins 1000 after #comment[. =~ regexp(\".*pam_limits.so.*\")]",
          'set 1000/type session',
          'set 1000/control required',
          'set 1000/module pam_limits.so'],
        onlyif  => 'match *[type=\'session\'][control=\'required\'][module=\'pam_limits.so\'] size == 0',
        require => Package['augeas-tools']
      }
    }
    default           : {
      fail("The ${module_name} module is not supported on ${::operatingsystem}")
    }
  }
}
