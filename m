From: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH V2 0/6] IRQ offloading for vDPA
Date: Thu, 16 Jul 2020 19:23:43 +0800
Message-ID: <1594898629-18790-1-git-send-email-lingshan.zhu@intel.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: mst@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, kvm@vger.kernel.org, Zhu Lingshan <lingshan.zhu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This series intends to implement IRQ offloading for
vhost_vdpa.

By the feat of irq forwarding facilities like posted
interrupt on X86, irq bypass can  help deliver
interrupts to vCPU directly.

vDPA devices have dedicated hardware backends like VFIO
pass-throughed devices. So it would be possible to setup
irq offloading(irq bypass) for vDPA devices and gain
performance improvements.

In my testing, with this feature, we can save 0.1ms
in a ping between two VFs on average.

changes from V1:
(1)dropped vfio changes.
(3)removed KVM_HVAE_IRQ_BYPASS checks
(4)locking fixes
(5)simplified vhost_vdpa_update_vq_irq()
(6)minor improvements

Zhu Lingshan (6):
  vhost: introduce vhost_call_ctx
  kvm: detect assigned device via irqbypass manager
  vDPA: implement IRQ offloading helpers in vDPA core
  vhost_vdpa: implement IRQ offloading in vhost_vdpa
  ifcvf: replace irq_request/free with vDPA helpers
  irqbypass: do not start cons/prod when failed connect

 arch/x86/kvm/x86.c              | 10 ++++++--
 drivers/vdpa/ifcvf/ifcvf_main.c | 14 +++++++----
 drivers/vdpa/vdpa.c             | 42 +++++++++++++++++++++++++++++++++
 drivers/vhost/Kconfig           |  1 +
 drivers/vhost/vdpa.c            | 52 +++++++++++++++++++++++++++++++++++++++--
 drivers/vhost/vhost.c           | 22 ++++++++++++-----
 drivers/vhost/vhost.h           |  9 ++++++-
 include/linux/vdpa.h            | 13 +++++++++++
 virt/lib/irqbypass.c            | 16 ++++++++-----
 9 files changed, 157 insertions(+), 22 deletions(-)

-- 
1.8.3.1
