From: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH V3 0/2] Config interrupt support in VDPA and IFCVF
Date: Sun, 26 Apr 2020 16:42:50 +0800
Message-ID: <1587890572-39093-1-git-send-email-lingshan.zhu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jasowang@redhat.com
Cc: lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com, Zhu Lingshan <lingshan.zhu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This series includes two patches, one introduced
config interrupt support in VDPA core, the other
one implemented config interrupt in IFCVF.

changes from V2:
move VHOST_FILE_UNBIND to the uapi header.

changes from V1:
vdpa: more efficient code to handle eventfd unbind.
ifcvf: add VIRTIO_NET_F_STATUS feature bit.

Zhu Lingshan (2):
  vdpa: Support config interrupt in vhost_vdpa
  vdpa: implement config interrupt in IFCVF
Zhu Lingshan (2):
  vdpa: Support config interrupt in vhost_vdpa
  vdpa: implement config interrupt in IFCVF

 drivers/vdpa/ifcvf/ifcvf_base.c |  3 +++
 drivers/vdpa/ifcvf/ifcvf_base.h |  3 +++
 drivers/vdpa/ifcvf/ifcvf_main.c | 22 ++++++++++++++++++-
 drivers/vhost/vdpa.c            | 47 +++++++++++++++++++++++++++++++++++++++++
 drivers/vhost/vhost.c           |  2 +-
 include/uapi/linux/vhost.h      |  4 ++++
 6 files changed, 79 insertions(+), 2 deletions(-)

-- 
1.8.3.1
