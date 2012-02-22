# Class: limits::params
#
# This class manage the limits parameters for different OS
class limits::params {
		
	case $::operatingsystem {
		/(Ubuntu|Debian)/: {
            $configuration_file  = "/etc/security/limits.d/by_puppet.conf"
		}
		default: {
			fail ("The ${module_name} module is not supported on $::operatingsystem")
		}
	}
}