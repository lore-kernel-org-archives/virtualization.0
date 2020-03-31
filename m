From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH] vhost: make CONFIG_VHOST depend on CONFIG_EVENTFD
Date: Tue, 31 Mar 2020 10:29:02 +0800
Message-ID: <20200331022902.12229-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

After commit ec9d8449a99b ("vhost: refine vhost and vringh kconfig"),
CONFIG_VHOST could be enabled independently. This means we need make
CONFIG_VHOST depend on CONFIG_EVENTFD, otherwise we break compiling
without CONFIG_EVENTFD.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: ec9d8449a99b ("vhost: refine vhost and vringh kconfig")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index 2a4efe39d79b..2be84b949e11 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -13,6 +13,7 @@ config VHOST_RING
=20
 menuconfig VHOST
 	tristate "Host kernel accelerator for virtio (VHOST)"
+	depends on EVENTFD
 	select VHOST_IOTLB
 	help
 	  This option is selected by any driver which needs to access
@@ -22,7 +23,7 @@ if VHOST
=20
 config VHOST_NET
 	tristate "Host kernel accelerator for virtio net"
-	depends on NET && EVENTFD && (TUN || !TUN) && (TAP || !TAP)
+	depends on NET && (TUN || !TUN) && (TAP || !TAP)
 	---help---
 	  This kernel module can be loaded in host kernel to accelerate
 	  guest networking with virtio_net. Not to be confused with virtio_net
@@ -33,7 +34,7 @@ config VHOST_NET
=20
 config VHOST_SCSI
 	tristate "VHOST_SCSI TCM fabric driver"
-	depends on TARGET_CORE && EVENTFD
+	depends on TARGET_CORE
 	default n
 	---help---
 	Say M here to enable the vhost_scsi TCM fabric module
@@ -41,7 +42,7 @@ config VHOST_SCSI
=20
 config VHOST_VSOCK
 	tristate "vhost virtio-vsock driver"
-	depends on VSOCKETS && EVENTFD
+	depends on VSOCKETS
 	select VIRTIO_VSOCKETS_COMMON
 	default n
 	---help---
@@ -54,7 +55,6 @@ config VHOST_VSOCK
=20
 config VHOST_VDPA
 	tristate "Vhost driver for vDPA-based backend"
-	depends on EVENTFD
 	select VDPA
 	help
 	  This kernel module can be loaded in host kernel to accelerate
--=20
2.20.1
