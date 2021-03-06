#
# Copyright (C) 2014 Orange Labs
# 
# This software is distributed under the terms and conditions of the 'Apache-2.0'
# license which can be found in the file 'LICENSE.txt' in this package distribution 
# or at 'http://www.apache.org/licenses/LICENSE-2.0'. 
#
# Authors: Arnaud Morin <arnaud1.morin@orange.com> 
#          David Blaisonneau <david.blaisonneau@orange.com>
#

#
#  The profile to install horizon
#
class opensteak::horizon (
    $debug              = "false",
    $stack_domain       = "stack.opensteak.fr",
    $server_aliases     = "*",
    $secret_key         = "password",
  ){
    
    class { 'memcached':
        listen_ip => '127.0.0.1',
        tcp_port  => '11211',
        udp_port  => '11211',
    }
    
    class { '::horizon':
        servername            => $stack_domain,
        server_aliases       => $server_aliases,
        keystone_url          => "http://keystone.${stack_domain}:5000/v2.0",
        cache_server_ip       => '127.0.0.1',
        cache_server_port     => '11211',
        secret_key            => $secret_key,
        django_debug          => $debug,
        api_result_limit      => '2000',
        #listen_ssl            => true,
        listen_ssl            => false,
        allowed_hosts         => ['*',],
        horizon_cert          => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
        horizon_ca            => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
        horizon_key           => '/etc/ssl/private/ssl-cert-snakeoil.key',
    }
    if $::selinux and str2bool($::selinux) != false {
        selboolean{'httpd_can_network_connect':
            value      => on,
            persistent => true,
        }
    }
}
