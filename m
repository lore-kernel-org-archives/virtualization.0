From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] vdpa: move to drivers/vdpa
Date: Tue, 31 Mar 2020 15:19:33 -0400
Message-ID: <20200331191825.249436-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We have both vhost and virtio drivers that depend on vdpa.
It's easier to locate it at a top level directory otherwise
we run into issues e.g. if vhost is built-in but virtio
is modular.  Let's just move it up a level.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Randy I'd say the issue you are reporting (vhost=y, virtio=m)
is esoteric enough not to require a rebase for this.
So I'd just apply this on top.
Do you agree?

 MAINTAINERS                                   | 1 +
 drivers/Kconfig                               | 2 ++
 drivers/Makefile                              | 1 +
 drivers/{virtio => }/vdpa/Kconfig             | 0
 drivers/{virtio => }/vdpa/Makefile            | 0
 drivers/{virtio => }/vdpa/ifcvf/Makefile      | 0
 drivers/{virtio => }/vdpa/ifcvf/ifcvf_base.c  | 0
 drivers/{virtio => }/vdpa/ifcvf/ifcvf_base.h  | 0
 drivers/{virtio => }/vdpa/ifcvf/ifcvf_main.c  | 0
 drivers/{virtio => }/vdpa/vdpa.c              | 0
 drivers/{virtio => }/vdpa/vdpa_sim/Makefile   | 0
 drivers/{virtio => }/vdpa/vdpa_sim/vdpa_sim.c | 0
 drivers/virtio/Kconfig                        | 2 --
 13 files changed, 4 insertions(+), 2 deletions(-)
 rename drivers/{virtio => }/vdpa/Kconfig (100%)
 rename drivers/{virtio => }/vdpa/Makefile (100%)
 rename drivers/{virtio => }/vdpa/ifcvf/Makefile (100%)
 rename drivers/{virtio => }/vdpa/ifcvf/ifcvf_base.c (100%)
 rename drivers/{virtio => }/vdpa/ifcvf/ifcvf_base.h (100%)
 rename drivers/{virtio => }/vdpa/ifcvf/ifcvf_main.c (100%)
 rename drivers/{virtio => }/vdpa/vdpa.c (100%)
 rename drivers/{virtio => }/vdpa/vdpa_sim/Makefile (100%)
 rename drivers/{virtio => }/vdpa/vdpa_sim/vdpa_sim.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 70c47bc55343..7cfa55c765fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17695,6 +17695,7 @@ L:	virtualization@lists.linux-foundation.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/virtio/
 F:	drivers/virtio/
+F:	drivers/vdpa/
 F:	tools/virtio/
 F:	drivers/net/virtio_net.c
 F:	drivers/block/virtio_blk.c
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 7a6d8b2b68b4..ac23d520e916 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -138,6 +138,8 @@ source "drivers/virt/Kconfig"
 
 source "drivers/virtio/Kconfig"
 
+source "drivers/vdpa/Kconfig"
+
 source "drivers/vhost/Kconfig"
 
 source "drivers/hv/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 31cf17dee252..21688f3b1588 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_DMADEVICES)	+= dma/
 obj-y				+= soc/
 
 obj-$(CONFIG_VIRTIO)		+= virtio/
+obj-$(CONFIG_VDPA)		+= vdpa/
 obj-$(CONFIG_XEN)		+= xen/
 
 # regulators early, since some subsystems rely on them to initialize
diff --git a/drivers/virtio/vdpa/Kconfig b/drivers/vdpa/Kconfig
similarity index 100%
rename from drivers/virtio/vdpa/Kconfig
rename to drivers/vdpa/Kconfig
diff --git a/drivers/virtio/vdpa/Makefile b/drivers/vdpa/Makefile
similarity index 100%
rename from drivers/virtio/vdpa/Makefile
rename to drivers/vdpa/Makefile
diff --git a/drivers/virtio/vdpa/ifcvf/Makefile b/drivers/vdpa/ifcvf/Makefile
similarity index 100%
rename from drivers/virtio/vdpa/ifcvf/Makefile
rename to drivers/vdpa/ifcvf/Makefile
diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
similarity index 100%
rename from drivers/virtio/vdpa/ifcvf/ifcvf_base.c
rename to drivers/vdpa/ifcvf/ifcvf_base.c
diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
similarity index 100%
rename from drivers/virtio/vdpa/ifcvf/ifcvf_base.h
rename to drivers/vdpa/ifcvf/ifcvf_base.h
diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
similarity index 100%
rename from drivers/virtio/vdpa/ifcvf/ifcvf_main.c
rename to drivers/vdpa/ifcvf/ifcvf_main.c
diff --git a/drivers/virtio/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
similarity index 100%
rename from drivers/virtio/vdpa/vdpa.c
rename to drivers/vdpa/vdpa.c
diff --git a/drivers/virtio/vdpa/vdpa_sim/Makefile b/drivers/vdpa/vdpa_sim/Makefile
similarity index 100%
rename from drivers/virtio/vdpa/vdpa_sim/Makefile
rename to drivers/vdpa/vdpa_sim/Makefile
diff --git a/drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
similarity index 100%
rename from drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c
rename to drivers/vdpa/vdpa_sim/vdpa_sim.c
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 99e424570644..2aadf398d8cc 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -109,5 +109,3 @@ config VIRTIO_MMIO_CMDLINE_DEVICES
 	 If unsure, say 'N'.
 
 endif # VIRTIO_MENU
-
-source "drivers/virtio/vdpa/Kconfig"
-- 
MST
