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
# The profile to install ceph glance client
#
class opensteak::ceph-client-glance (
    $secret = "AQB6ns9UWJCEBhAAz1632+o+zxgMLGrXlp3rHQ=="
  ){
  require opensteak::ceph-base

  if ! defined(Ceph::Key['client.glance']) {
    ceph::key { 'client.glance':
      secret       => $secret,
    }
  }

  # Ceph conf needed by Nova
  ceph_config {
    'client.glance/key': value => $secret;
  }
}


