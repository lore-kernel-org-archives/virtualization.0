From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2] vdpa: make vhost, virtio depend on menu
Date: Sun, 12 Apr 2020 08:50:52 -0400
Message-ID: <20200412125018.74964-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

If user did not configure any vdpa drivers, neither vhost
nor virtio vdpa are going to be useful. So there's no point
in prompting for these and selecting vdpa core automatically.
Simplify configuration by making virtio and vhost vdpa
drivers depend on vdpa menu entry. Once done, we no longer
need a separate menu entry, so also get rid of this.
While at it, fix up the IFC entry: VDPA->vDPA for consistency
with other places.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v1:
	fix up virtio vdpa Kconfig

 drivers/vdpa/Kconfig   | 16 +++++-----------
 drivers/vhost/Kconfig  |  2 +-
 drivers/virtio/Kconfig |  2 +-
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index d0cb0e583a5d..71d9a64f2c7d 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -1,21 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config VDPA
-	tristate
+menuconfig VDPA
+	tristate "vDPA drivers"
 	help
 	  Enable this module to support vDPA device that uses a
 	  datapath which complies with virtio specifications with
 	  vendor specific control path.
 
-menuconfig VDPA_MENU
-	bool "VDPA drivers"
-	default n
-
-if VDPA_MENU
+if VDPA
 
 config VDPA_SIM
 	tristate "vDPA device simulator"
 	depends on RUNTIME_TESTING_MENU && HAS_DMA
-	select VDPA
 	select VHOST_RING
 	select VHOST_IOTLB
 	default n
@@ -25,9 +20,8 @@ config VDPA_SIM
 	  development of vDPA.
 
 config IFCVF
-	tristate "Intel IFC VF VDPA driver"
+	tristate "Intel IFC VF vDPA driver"
 	depends on PCI_MSI
-	select VDPA
 	default n
 	help
 	  This kernel module can drive Intel IFC VF NIC to offload
@@ -35,4 +29,4 @@ config IFCVF
 	  To compile this driver as a module, choose M here: the module will
 	  be called ifcvf.
 
-endif # VDPA_MENU
+endif # VDPA
diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index cb6b17323eb2..e79cbbdfea45 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -64,7 +64,7 @@ config VHOST_VDPA
 	tristate "Vhost driver for vDPA-based backend"
 	depends on EVENTFD
 	select VHOST
-	select VDPA
+	depends on VDPA
 	help
 	  This kernel module can be loaded in host kernel to accelerate
 	  guest virtio devices with the vDPA-based backends.
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 2aadf398d8cc..395c3f4d49cb 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -45,7 +45,7 @@ config VIRTIO_PCI_LEGACY
 
 config VIRTIO_VDPA
 	tristate "vDPA driver for virtio devices"
-	select VDPA
+	depends on VDPA
 	select VIRTIO
 	help
 	  This driver provides support for virtio based paravirtual
-- 
MST
