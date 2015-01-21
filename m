From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH post-squash 7/9] virtio_pci: add an option to disable legacy
	driver
Date: Wed, 21 Jan 2015 17:05:29 +0200
Message-ID: <1421852670-23742-8-git-send-email-mst__8640.64918500862$1421852798$gmane$org@redhat.com>
References: <1421852670-23742-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1421852670-23742-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Useful for testing device virtio 1 compatibility.
Based on patch by Rusty - couldn't resist putting
that flying car joke in there!

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/virtio/virtio_pci_common.h | 10 ++++++++++
 drivers/virtio/Kconfig             | 19 +++++++++++++++++++
 drivers/virtio/Makefile            |  3 ++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index d391805..28ee4e5 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -147,8 +147,18 @@ const char *vp_bus_name(struct virtio_device *vdev);
  */
 int vp_set_vq_affinity(struct virtqueue *vq, int cpu);
 
+#if IS_ENABLED(CONFIG_VIRTIO_PCI_LEGACY)
 int virtio_pci_legacy_probe(struct virtio_pci_device *);
 void virtio_pci_legacy_remove(struct virtio_pci_device *);
+#else
+static inline int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
+{
+	return -ENODEV;
+}
+static inline void virtio_pci_legacy_remove(struct virtio_pci_device *vp_dev)
+{
+}
+#endif
 int virtio_pci_modern_probe(struct virtio_pci_device *);
 void virtio_pci_modern_remove(struct virtio_pci_device *);
 
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 083fb45..b546da5 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -19,6 +19,25 @@ config VIRTIO_PCI
 
 	  If unsure, say M.
 
+config VIRTIO_PCI_LEGACY
+	bool "Support for legacy virtio draft 0.9.X and older devices"
+	default y
+	depends on VIRTIO_PCI
+	---help---
+          Virtio PCI Card 0.9.X Draft (circa 2014) and older device support.
+
+	  This option enables building a transitional driver, supporting
+	  both devices conforming to Virtio 1 specification, and legacy devices.
+	  If disabled, you get a slightly smaller, non-transitional driver,
+	  with no legacy compatibility.
+
+          So look out into your driveway.  Do you have a flying car?  If
+          so, you can happily disable this option and virtio will not
+          break.  Otherwise, leave it set.  Unless you're testing what
+          life will be like in The Future.
+
+	  If unsure, say Y.
+
 config VIRTIO_BALLOON
 	tristate "Virtio balloon driver"
 	depends on VIRTIO
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index bd230d1..d85565b 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
 obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
-virtio_pci-y := virtio_pci_modern.o virtio_pci_legacy.o virtio_pci_common.o
+virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
+virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
-- 
MST
