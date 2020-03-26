From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V9 1/9] vhost: refine vhost and vringh kconfig
Date: Thu, 26 Mar 2020 22:01:17 +0800
Message-ID: <20200326140125.19794-2-jasowang@redhat.com>
References: <20200326140125.19794-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326140125.19794-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Currently, CONFIG_VHOST depends on CONFIG_VIRTUALIZATION. But vhost is
not necessarily for VM since it's a generic userspace and kernel
communication protocol. Such dependency may prevent archs without
virtualization support from using vhost.

To solve this, a dedicated vhost menu is created under drivers so
CONIFG_VHOST can be decoupled out of CONFIG_VIRTUALIZATION.

While at it, also squash Kconfig.vringh into vhost Kconfig file. This
avoids the trick of conditional inclusion from VOP or CAIF. Then it
will be easier to introduce new vringh users and common dependency for
both vringh and vhost.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 arch/arm/kvm/Kconfig         |  2 --
 arch/arm64/kvm/Kconfig       |  2 --
 arch/mips/kvm/Kconfig        |  2 --
 arch/powerpc/kvm/Kconfig     |  2 --
 arch/s390/kvm/Kconfig        |  4 ----
 arch/x86/kvm/Kconfig         |  4 ----
 drivers/Kconfig              |  2 ++
 drivers/misc/mic/Kconfig     |  4 ----
 drivers/net/caif/Kconfig     |  4 ----
 drivers/vhost/Kconfig        | 23 ++++++++++++++---------
 drivers/vhost/Kconfig.vringh |  6 ------
 11 files changed, 16 insertions(+), 39 deletions(-)
 delete mode 100644 drivers/vhost/Kconfig.vringh

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index f591026347a5..be97393761bf 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -54,6 +54,4 @@ config KVM_ARM_HOST
 	---help---
 	  Provides host support for ARM processors.
=20
-source "drivers/vhost/Kconfig"
-
 endif # VIRTUALIZATION
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index a475c68cbfec..449386d76441 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -64,6 +64,4 @@ config KVM_ARM_PMU
 config KVM_INDIRECT_VECTORS
        def_bool KVM && (HARDEN_BRANCH_PREDICTOR || HARDEN_EL2_VECTORS)
=20
-source "drivers/vhost/Kconfig"
-
 endif # VIRTUALIZATION
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index eac25aef21e0..b91d145aa2d5 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -72,6 +72,4 @@ config KVM_MIPS_DEBUG_COP0_COUNTERS
=20
 	  If unsure, say N.
=20
-source "drivers/vhost/Kconfig"
-
 endif # VIRTUALIZATION
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 711fca9bc6f0..12885eda324e 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -204,6 +204,4 @@ config KVM_XIVE
 	default y
 	depends on KVM_XICS && PPC_XIVE_NATIVE && KVM_BOOK3S_HV_POSSIBLE
=20
-source "drivers/vhost/Kconfig"
-
 endif # VIRTUALIZATION
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index d3db3d7ed077..def3b60f1fe8 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -55,8 +55,4 @@ config KVM_S390_UCONTROL
=20
 	  If unsure, say N.
=20
-# OK, it's a little counter-intuitive to do this, but it puts it neatly =
under
-# the virtualization menu.
-source "drivers/vhost/Kconfig"
-
 endif # VIRTUALIZATION
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 991019d5eee1..0dfe70e17af9 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -94,8 +94,4 @@ config KVM_MMU_AUDIT
 	 This option adds a R/W kVM module parameter 'mmu_audit', which allows
 	 auditing of KVM MMU events at runtime.
=20
-# OK, it's a little counter-intuitive to do this, but it puts it neatly =
under
-# the virtualization menu.
-source "drivers/vhost/Kconfig"
-
 endif # VIRTUALIZATION
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 8befa53f43be..7a6d8b2b68b4 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -138,6 +138,8 @@ source "drivers/virt/Kconfig"
=20
 source "drivers/virtio/Kconfig"
=20
+source "drivers/vhost/Kconfig"
+
 source "drivers/hv/Kconfig"
=20
 source "drivers/xen/Kconfig"
diff --git a/drivers/misc/mic/Kconfig b/drivers/misc/mic/Kconfig
index b6841ba6d922..8f201d019f5a 100644
--- a/drivers/misc/mic/Kconfig
+++ b/drivers/misc/mic/Kconfig
@@ -133,8 +133,4 @@ config VOP
 	  OS and tools for MIC to use with this driver are available from
 	  <http://software.intel.com/en-us/mic-developer>.
=20
-if VOP
-source "drivers/vhost/Kconfig.vringh"
-endif
-
 endmenu
diff --git a/drivers/net/caif/Kconfig b/drivers/net/caif/Kconfig
index e74e2bb61236..9db0570c5beb 100644
--- a/drivers/net/caif/Kconfig
+++ b/drivers/net/caif/Kconfig
@@ -58,8 +58,4 @@ config CAIF_VIRTIO
 	---help---
 	  The CAIF driver for CAIF over Virtio.
=20
-if CAIF_VIRTIO
-source "drivers/vhost/Kconfig.vringh"
-endif
-
 endif # CAIF_DRIVERS
diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index 3d03ccbd1adc..4aef10a54cd1 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -1,8 +1,20 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config VHOST_RING
+	tristate
+	help
+	  This option is selected by any driver which needs to access
+	  the host side of a virtio ring.
+
+menuconfig VHOST
+	tristate "Host kernel accelerator for virtio (VHOST)"
+	help
+	  This option is selected by any driver which needs to access
+	  the core of vhost.
+if VHOST
+
 config VHOST_NET
 	tristate "Host kernel accelerator for virtio net"
 	depends on NET && EVENTFD && (TUN || !TUN) && (TAP || !TAP)
-	select VHOST
 	---help---
 	  This kernel module can be loaded in host kernel to accelerate
 	  guest networking with virtio_net. Not to be confused with virtio_net
@@ -14,7 +26,6 @@ config VHOST_NET
 config VHOST_SCSI
 	tristate "VHOST_SCSI TCM fabric driver"
 	depends on TARGET_CORE && EVENTFD
-	select VHOST
 	default n
 	---help---
 	Say M here to enable the vhost_scsi TCM fabric module
@@ -24,7 +35,6 @@ config VHOST_VSOCK
 	tristate "vhost virtio-vsock driver"
 	depends on VSOCKETS && EVENTFD
 	select VIRTIO_VSOCKETS_COMMON
-	select VHOST
 	default n
 	---help---
 	This kernel module can be loaded in the host kernel to provide AF_VSOCK
@@ -34,12 +44,6 @@ config VHOST_VSOCK
 	To compile this driver as a module, choose M here: the module will be c=
alled
 	vhost_vsock.
=20
-config VHOST
-	tristate
-	---help---
-	  This option is selected by any driver which needs to access
-	  the core of vhost.
-
 config VHOST_CROSS_ENDIAN_LEGACY
 	bool "Cross-endian support for vhost"
 	default n
@@ -54,3 +58,4 @@ config VHOST_CROSS_ENDIAN_LEGACY
 	  adds some overhead, it is disabled by default.
=20
 	  If unsure, say "N".
+endif
diff --git a/drivers/vhost/Kconfig.vringh b/drivers/vhost/Kconfig.vringh
deleted file mode 100644
index c1fe36a9b8d4..000000000000
--- a/drivers/vhost/Kconfig.vringh
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-config VHOST_RING
-	tristate
-	---help---
-	  This option is selected by any driver which needs to access
-	  the host side of a virtio ring.
--=20
2.20.1
