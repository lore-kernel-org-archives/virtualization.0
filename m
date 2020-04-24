From: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 0/2] Config interrupt support in VDPA and IFCVF
Date: Fri, 24 Apr 2020 18:04:17 +0800
Message-ID: <1587722659-1300-1-git-send-email-lingshan.zhu@intel.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jasowang@redhat.com
Cc: lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com, Zhu Lingshan <lingshan.zhu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This series includes two patches, one introduced
config interrupt support in VDPA core, the other
one implemented config interrupt in IFCVF.

Zhu Lingshan (2):
  vdpa: Support config interrupt in vhost_vdpa
  vdpa: implement config interrupt in IFCVF

 drivers/vdpa/ifcvf/ifcvf_base.c  |  3 +++
 drivers/vdpa/ifcvf/ifcvf_base.h  |  2 ++
 drivers/vdpa/ifcvf/ifcvf_main.c  | 22 ++++++++++++++++-
 drivers/vhost/vdpa.c             | 53 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vhost.h       |  2 ++
 include/uapi/linux/vhost_types.h |  2 ++
 6 files changed, 83 insertions(+), 1 deletion(-)

-- 
1.8.3.1
