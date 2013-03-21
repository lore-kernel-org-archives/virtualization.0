From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 08/22] virtio-pci: define layout for virtio vendor-specific
	capabilities.
Date: Thu, 21 Mar 2013 18:59:29 +1030
Message-ID: <1363854584-25795-9-git-send-email-rusty@rustcorp.com.au>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Based on patch by Michael S. Tsirkin <mst@redhat.com>, but I found it
hard to follow so changed to use structures which are more
self-documenting.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 include/uapi/linux/virtio_pci.h |   41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index ea66f3f..b0e7c91 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -92,4 +92,45 @@
 /* The alignment to use between consumer and producer parts of vring.
  * x86 pagesize again. */
 #define VIRTIO_PCI_VRING_ALIGN		4096
+
+/* IDs for different capabilities.  Must all exist. */
+/* FIXME: Do we win from separating ISR, NOTIFY and COMMON? */
+/* Common configuration */
+#define VIRTIO_PCI_CAP_COMMON_CFG	1
+/* Notifications */
+#define VIRTIO_PCI_CAP_NOTIFY_CFG	2
+/* ISR access */
+#define VIRTIO_PCI_CAP_ISR_CFG		3
+/* Device specific confiuration */
+#define VIRTIO_PCI_CAP_DEVICE_CFG	4
+
+/* This is the PCI capability header: */
+struct virtio_pci_cap {
+	u8 cap_vndr;	/* Generic PCI field: PCI_CAP_ID_VNDR */
+	u8 cap_next;	/* Generic PCI field: next ptr. */
+	u8 cfg_type;	/* One of the VIRTIO_PCI_CAP_*_CFG. */
+/* FIXME: Should we use a bir, instead of raw bar number? */
+	u8 bar;		/* Where to find it. */
+	__le32 offset;	/* Offset within bar. */
+	__le32 length;	/* Length. */
+};
+
+/* Fields in VIRTIO_PCI_CAP_COMMON_CFG: */
+struct virtio_pci_common_cfg {
+	/* About the whole device. */
+	__le32 device_feature_select;	/* read-write */
+	__le32 device_feature;		/* read-only */
+	__le32 guest_feature_select;	/* read-write */
+	__le32 guest_feature;		/* read-only */
+	__le16 msix_config;		/* read-write */
+	__u8 device_status;		/* read-write */
+	__u8 unused;
+
+	/* About a specific virtqueue. */
+	__le16 queue_select;	/* read-write */
+	__le16 queue_align;	/* read-write, power of 2. */
+	__le16 queue_size;	/* read-write, power of 2. */
+	__le16 queue_msix_vector;/* read-write */
+	__le64 queue_address;	/* read-write: 0xFFFFFFFFFFFFFFFF == DNE. */
+};
 #endif
-- 
1.7.10.4
