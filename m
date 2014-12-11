From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 5/5] virtio_pci: macros for PCI layout offsets.
Date: Thu, 11 Dec 2014 21:37:41 +0200
Message-ID: <1418326570-9541-6-git-send-email-mst@redhat.com>
References: <1418326570-9541-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418326570-9541-1-git-send-email-mst@redhat.com>
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

From: Rusty Russell <rusty@rustcorp.com.au>

QEMU wants it, so why not?  Trust, but verify.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_pci_modern.c | 61 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index e6e65e1..19568da 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -406,6 +406,65 @@ static void __iomem *map_capability(struct pci_dev *dev, int off, size_t minlen,
 	return p;
 }
 
+/* This is part of the ABI.  Don't screw with it. */
+static inline void check_offsets(void)
+{
+	/* Note: disk space was harmed in compilation of this function. */
+	BUILD_BUG_ON(VIRTIO_PCI_CAP_VNDR !=
+		     offsetof(struct virtio_pci_cap, cap_vndr));
+	BUILD_BUG_ON(VIRTIO_PCI_CAP_NEXT !=
+		     offsetof(struct virtio_pci_cap, cap_next));
+	BUILD_BUG_ON(VIRTIO_PCI_CAP_LEN !=
+		     offsetof(struct virtio_pci_cap, cap_len));
+	BUILD_BUG_ON(VIRTIO_PCI_CAP_TYPE_AND_BAR !=
+		     offsetof(struct virtio_pci_cap, type_and_bar));
+	BUILD_BUG_ON(VIRTIO_PCI_CAP_OFFSET !=
+		     offsetof(struct virtio_pci_cap, offset));
+	BUILD_BUG_ON(VIRTIO_PCI_CAP_LENGTH !=
+		     offsetof(struct virtio_pci_cap, length));
+	BUILD_BUG_ON(VIRTIO_PCI_NOTIFY_CAP_MULT !=
+		     offsetof(struct virtio_pci_notify_cap,
+			      notify_off_multiplier));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_DFSELECT !=
+		     offsetof(struct virtio_pci_common_cfg,
+			      device_feature_select));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_DF !=
+		     offsetof(struct virtio_pci_common_cfg, device_feature));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_GFSELECT !=
+		     offsetof(struct virtio_pci_common_cfg,
+			      guest_feature_select));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_GF !=
+		     offsetof(struct virtio_pci_common_cfg, guest_feature));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_MSIX !=
+		     offsetof(struct virtio_pci_common_cfg, msix_config));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_NUMQ !=
+		     offsetof(struct virtio_pci_common_cfg, num_queues));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_STATUS !=
+		     offsetof(struct virtio_pci_common_cfg, device_status));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_SELECT !=
+		     offsetof(struct virtio_pci_common_cfg, queue_select));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_SIZE !=
+		     offsetof(struct virtio_pci_common_cfg, queue_size));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_MSIX !=
+		     offsetof(struct virtio_pci_common_cfg, queue_msix_vector));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_ENABLE !=
+		     offsetof(struct virtio_pci_common_cfg, queue_enable));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_NOFF !=
+		     offsetof(struct virtio_pci_common_cfg, queue_notify_off));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_DESCLO !=
+		     offsetof(struct virtio_pci_common_cfg, queue_desc_lo));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_DESCHI !=
+		     offsetof(struct virtio_pci_common_cfg, queue_desc_hi));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_AVAILLO !=
+		     offsetof(struct virtio_pci_common_cfg, queue_avail_lo));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_AVAILHI !=
+		     offsetof(struct virtio_pci_common_cfg, queue_avail_hi));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_USEDLO !=
+		     offsetof(struct virtio_pci_common_cfg, queue_used_lo));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_USEDHI !=
+		     offsetof(struct virtio_pci_common_cfg, queue_used_hi));
+}
+
 /* the PCI probing function */
 static int virtio_pci_probe(struct pci_dev *pci_dev,
 			    const struct pci_device_id *id)
@@ -413,6 +472,8 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 	struct virtio_pci_device *vp_dev;
 	int err, common, isr, notify, device;
 
+	check_offsets();
+
 	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
 	if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
 		return -ENODEV;
-- 
MST
