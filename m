From: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH RESEND 0/5] vDPA:config interrupt support and IRQ improvements
Date: Fri,  5 Jun 2020 18:27:10 +0800
Message-ID: <1591352835-22441-1-git-send-email-lingshan.zhu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jasowang@redhat.com
Cc: lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com, Zhu Lingshan <lingshan.zhu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This series intends to introduce:
(1) config interrupt in vhost_vdpa and IFCVF.
(2) handle datapath and IRQ managent in the status handler,
so that it would comply to virtio spec, and more reliable

Most patches already got ACKed, excepted for 
ifcvf: ignore continuous setting same staus value

Please help review

Zhu Lingshan (5):
  ifcvf: move IRQ request/free to status change handlers
  ifcvf: ignore continuous setting same staus value
  vhost_vdpa: Support config interrupt in vhost_vdpa
  vhost: replace -1 with VHOST_FILE_UNBIND in iotcls
  ifcvf: implement config interrupt in IFCVF

 drivers/vdpa/ifcvf/ifcvf_base.c |   3 +
 drivers/vdpa/ifcvf/ifcvf_base.h |   4 ++
 drivers/vdpa/ifcvf/ifcvf_main.c | 146 +++++++++++++++++++++++++++-------------
 drivers/vhost/vdpa.c            |  47 +++++++++++++
 drivers/vhost/vhost.c           |   8 +--
 include/uapi/linux/vhost.h      |   4 ++
 6 files changed, 160 insertions(+), 52 deletions(-)

-- 
1.8.3.1
