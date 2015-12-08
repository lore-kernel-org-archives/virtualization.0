From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/6] Revert "VSOCK: Add Makefile and Kconfig"
Date: Tue,  8 Dec 2015 19:57:32 +0800
Message-ID: <1449575856-28507-3-git-send-email-stefanha__1058.37354572049$1449575894$gmane$org@redhat.com>
References: <1449575856-28507-1-git-send-email-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1449575856-28507-1-git-send-email-stefanha@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Matt Benjamin <mbenjamin@redhat.com>, "David S. Miller" <davem@davemloft.net>, Christoffer Dall <christoffer.dall@linaro.org>, matt.ma@linaro.org
List-Id: virtualization@lists.linuxfoundation.org

This reverts commit 8a2a2029893b4c35d1aba2932111a1a164b9c948.

Keep virtio-vsock out-of-tree until the device specification is
finalized.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/vhost/Kconfig       |  4 ----
 drivers/vhost/Kconfig.vsock |  7 -------
 drivers/vhost/Makefile      |  4 ----
 net/vmw_vsock/Kconfig       | 18 ------------------
 net/vmw_vsock/Makefile      |  2 --
 5 files changed, 35 deletions(-)
 delete mode 100644 drivers/vhost/Kconfig.vsock

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index 81449bf..533eaf0 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -47,7 +47,3 @@ config VHOST_CROSS_ENDIAN_LEGACY
 	  adds some overhead, it is disabled by default.
 
 	  If unsure, say "N".
-
-if STAGING
-source "drivers/vhost/Kconfig.vsock"
-endif
diff --git a/drivers/vhost/Kconfig.vsock b/drivers/vhost/Kconfig.vsock
deleted file mode 100644
index 3491865..0000000
--- a/drivers/vhost/Kconfig.vsock
+++ /dev/null
@@ -1,7 +0,0 @@
-config VHOST_VSOCK
-	tristate "vhost virtio-vsock driver"
-	depends on VSOCKETS && EVENTFD
-	select VIRTIO_VSOCKETS_COMMON
-	default n
-	---help---
-	Say M here to enable the vhost-vsock for virtio-vsock guests
diff --git a/drivers/vhost/Makefile b/drivers/vhost/Makefile
index 6b012b9..e0441c3 100644
--- a/drivers/vhost/Makefile
+++ b/drivers/vhost/Makefile
@@ -4,9 +4,5 @@ vhost_net-y := net.o
 obj-$(CONFIG_VHOST_SCSI) += vhost_scsi.o
 vhost_scsi-y := scsi.o
 
-obj-$(CONFIG_VHOST_VSOCK) += vhost_vsock.o
-vhost_vsock-y := vsock.o
-
 obj-$(CONFIG_VHOST_RING) += vringh.o
-
 obj-$(CONFIG_VHOST)	+= vhost.o
diff --git a/net/vmw_vsock/Kconfig b/net/vmw_vsock/Kconfig
index 74e0bc8..14810ab 100644
--- a/net/vmw_vsock/Kconfig
+++ b/net/vmw_vsock/Kconfig
@@ -26,21 +26,3 @@ config VMWARE_VMCI_VSOCKETS
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called vmw_vsock_vmci_transport. If unsure, say N.
-
-config VIRTIO_VSOCKETS
-	tristate "virtio transport for Virtual Sockets"
-	depends on VSOCKETS && VIRTIO
-	select VIRTIO_VSOCKETS_COMMON
-	help
-	  This module implements a virtio transport for Virtual Sockets.
-
-	  Enable this transport if your Virtual Machine runs on Qemu/KVM.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called virtio_vsock_transport. If unsure, say N.
-
-config VIRTIO_VSOCKETS_COMMON
-       tristate
-       ---help---
-         This option is selected by any driver which needs to access
-         the virtio_vsock.
diff --git a/net/vmw_vsock/Makefile b/net/vmw_vsock/Makefile
index cf4c294..2ce52d7 100644
--- a/net/vmw_vsock/Makefile
+++ b/net/vmw_vsock/Makefile
@@ -1,7 +1,5 @@
 obj-$(CONFIG_VSOCKETS) += vsock.o
 obj-$(CONFIG_VMWARE_VMCI_VSOCKETS) += vmw_vsock_vmci_transport.o
-obj-$(CONFIG_VIRTIO_VSOCKETS) += virtio_transport.o
-obj-$(CONFIG_VIRTIO_VSOCKETS_COMMON) += virtio_transport_common.o
 
 vsock-y += af_vsock.o vsock_addr.o
 
-- 
2.5.0
