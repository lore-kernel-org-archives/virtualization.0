From: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH V4 0/3] vdpa: Support config interrupt in vhost_vdpa
Date: Sun, 26 Apr 2020 19:43:23 +0800
Message-ID: <1587901406-27400-1-git-send-email-lingshan.zhu@intel.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jasowang@redhat.com
Cc: lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com, Zhu Lingshan <lingshan.zhu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This series includes two patches, one introduced
config interrupt support in VDPA core, the other
one implemented config interrupt in IFCVF.

changes from V3:
move changes in driver/vhost/vhost.c to a 
separated patch.

changes from V2:
move VHOST_FILE_UNBIND to the uapi header.

changes from V1:
vdpa: more efficient code to handle eventfd unbind.
ifcvf: add VIRTIO_NET_F_STATUS feature bit.

Zhu Lingshan (3):
  vdpa: Support config interrupt in vhost_vdpa
  vhost: replace -1 with  VHOST_FILE_UNBIND in iotcls
  vdpa: implement config interrupt in IFCVF

 drivers/vdpa/ifcvf/ifcvf_base.c |  3 +++
 drivers/vdpa/ifcvf/ifcvf_base.h |  3 +++
 drivers/vdpa/ifcvf/ifcvf_main.c | 22 ++++++++++++++++++-
 drivers/vhost/vdpa.c            | 47 +++++++++++++++++++++++++++++++++++++++++
 drivers/vhost/vhost.c           |  8 +++----
 include/uapi/linux/vhost.h      |  4 ++++
 6 files changed, 82 insertions(+), 5 deletions(-)

-- 
1.8.3.1
