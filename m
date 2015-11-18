From: Sasha Levin <sasha.levin@oracle.com>
Subject: [RFC] kvmtool: add support for modern virtio-pci
Date: Wed, 18 Nov 2015 00:11:12 -0500
Message-ID: <1447823472-17047-1-git-send-email-sasha.levin@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org
Cc: mst@redhat.com, andre.przywara@arm.com, will.deacon@arm.com, josh@joshtriplett.org, virtualization@lists.linux-foundation.org, penberg@kernel.org, Sasha Levin <sasha.levin@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

This is a first go at adding support for the modern (based on the 1.0 virtio
spec) virtio-pci implementation.

kvmtool makes it simple to add additional transports such as this because of
it's layering, so we are able to add it as a 3rd (after legacy virtio-pci and
virtio-mmio) transport layer, and still allow users to choose to use either
the legacy or the modern implementations (but setting the modern one as
default.

The changes to the virtio devices are mostly the result of needing to support
>32bit features, and the different initialization method for VQs.

It's worth noting that supporting v1.0 implies any_layout, but some of our
devices made assumptions about the layout - which I've fixed. But it's worth
to keep in mind that some probably went unnoticed.

To sum it up: this is a lightly tested version for feedback about the design
and to weed out major bugs people notice. Feedback is very welcome!

Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 Makefile                                          |   1 +
 builtin-run.c                                     |   4 +
 include/kvm/kvm-config.h                          |   1 +
 include/kvm/pci.h                                 |   8 +-
 include/kvm/virtio-9p.h                           |   2 +-
 include/kvm/{virtio-pci.h => virtio-pci-modern.h} |  23 +-
 include/kvm/virtio-pci.h                          |   6 +-
 include/kvm/virtio.h                              |  25 +-
 include/linux/virtio_pci.h                        | 199 +++++++
 net/uip/core.c                                    |   7 +-
 virtio/9p.c                                       |  35 +-
 virtio/balloon.c                                  |  37 +-
 virtio/blk.c                                      |  50 +-
 virtio/console.c                                  |  42 +-
 virtio/core.c                                     |  16 +
 virtio/mmio.c                                     |  13 +-
 virtio/net.c                                      |  59 ++-
 virtio/pci.c                                      |   4 +-
 virtio/pci_modern.c                               | 599 ++++++++++++++++++++++
 virtio/rng.c                                      |  29 +-
 virtio/scsi.c                                     |  36 +-
 x86/include/kvm/kvm-arch.h                        |   2 +-
 22 files changed, 1109 insertions(+), 89 deletions(-)
 copy include/kvm/{virtio-pci.h => virtio-pci-modern.h} (69%)
 create mode 100644 include/linux/virtio_pci.h
 create mode 100644 virtio/pci_modern.c

diff --git a/Makefile b/Makefile
index 59622c3..13a12f8 100644
--- a/Makefile
+++ b/Makefile
@@ -67,6 +67,7 @@ OBJS	+= virtio/net.o
 OBJS	+= virtio/rng.o
 OBJS    += virtio/balloon.o
 OBJS	+= virtio/pci.o
+OBJS	+= virtio/pci_modern.o
 OBJS	+= disk/blk.o
 OBJS	+= disk/qcow.o
 OBJS	+= disk/raw.o
diff --git a/builtin-run.c b/builtin-run.c
index edcaf3e..e133b10 100644
--- a/builtin-run.c
+++ b/builtin-run.c
@@ -128,6 +128,8 @@ void kvm_run_set_wrapper_sandbox(void)
 			" rootfs"),					\
 	OPT_STRING('\0', "hugetlbfs", &(cfg)->hugetlbfs_path, "path",	\
 			"Hugetlbfs path"),				\
+	OPT_BOOLEAN('\0', "virtio-legacy", &(cfg)->old_virtio, "Use"	\
+			" legacy virtio-pci devices"),			\
 									\
 	OPT_GROUP("Kernel options:"),					\
 	OPT_STRING('k', "kernel", &(cfg)->kernel_filename, "kernel",	\
@@ -517,6 +519,8 @@ static struct kvm *kvm_cmd_run_init(int argc, const char **argv)
 	kvm->cfg.vmlinux_filename = find_vmlinux();
 	kvm->vmlinux = kvm->cfg.vmlinux_filename;
 
+	default_transport = kvm->cfg.old_virtio ? VIRTIO_PCI : VIRTIO_PCI_MODERN;
+
 	if (kvm->cfg.nrcpus == 0)
 		kvm->cfg.nrcpus = nr_online_cpus;
 
diff --git a/include/kvm/kvm-config.h b/include/kvm/kvm-config.h
index 386fa8c..b1512a1 100644
--- a/include/kvm/kvm-config.h
+++ b/include/kvm/kvm-config.h
@@ -57,6 +57,7 @@ struct kvm_config {
 	bool no_dhcp;
 	bool ioport_debug;
 	bool mmio_debug;
+	bool old_virtio;
 };
 
 #endif
diff --git a/include/kvm/pci.h b/include/kvm/pci.h
index b0c28a1..19ec56a 100644
--- a/include/kvm/pci.h
+++ b/include/kvm/pci.h
@@ -4,6 +4,7 @@
 #include <linux/types.h>
 #include <linux/kvm.h>
 #include <linux/pci_regs.h>
+#include <linux/virtio_pci.h>
 #include <endian.h>
 
 #include "kvm/devices.h"
@@ -81,7 +82,12 @@ struct pci_device_header {
 	u8		min_gnt;
 	u8		max_lat;
 	struct msix_cap msix;
-	u8		empty[136]; /* Rest of PCI config space */
+	struct virtio_pci_cap common_cap;
+	struct virtio_pci_notify_cap notify_cap;
+	struct virtio_pci_cap isr_cap;
+	struct virtio_pci_cap device_cap;
+	struct virtio_pci_cfg_cap pci_cap;
+	u8		empty[48]; /* Rest of PCI config space */
 	u32		bar_size[6];
 } __attribute__((packed));
 
diff --git a/include/kvm/virtio-9p.h b/include/kvm/virtio-9p.h
index 19ffe50..2f7e25a 100644
--- a/include/kvm/virtio-9p.h
+++ b/include/kvm/virtio-9p.h
@@ -46,7 +46,7 @@ struct p9_dev {
 	struct rb_root		fids;
 
 	struct virtio_9p_config	*config;
-	u32			features;
+	u64			features;
 
 	/* virtio queue */
 	struct virt_queue	vqs[NUM_VIRT_QUEUES];
diff --git a/include/kvm/virtio-pci.h b/include/kvm/virtio-pci-modern.h
similarity index 69%
copy from include/kvm/virtio-pci.h
copy to include/kvm/virtio-pci-modern.h
index b70cadd..f07085a 100644
--- a/include/kvm/virtio-pci.h
+++ b/include/kvm/virtio-pci-modern.h
@@ -1,8 +1,9 @@
-#ifndef KVM__VIRTIO_PCI_H
-#define KVM__VIRTIO_PCI_H
+#ifndef KVM__VIRTIO_PCI_MODERN_H
+#define KVM__VIRTIO_PCI_MODERN_H
 
 #include "kvm/devices.h"
 #include "kvm/pci.h"
+#include "kvm/virtio.h"
 
 #include <linux/types.h>
 
@@ -11,14 +12,9 @@
 
 struct kvm;
 
-struct virtio_pci_ioevent_param {
-	struct virtio_device	*vdev;
-	u32			vq;
-};
-
 #define VIRTIO_PCI_F_SIGNAL_MSI (1 << 0)
 
-struct virtio_pci {
+struct virtio_pci_modern {
 	struct pci_device_header pci_hdr;
 	struct device_header	dev_hdr;
 	void			*dev;
@@ -28,6 +24,9 @@ struct virtio_pci {
 	u32			mmio_addr;
 	u8			status;
 	u8			isr;
+	u32			device_features_sel;
+	u32			driver_features_sel;
+
 	u32			features;
 
 	/*
@@ -52,10 +51,10 @@ struct virtio_pci {
 	struct virtio_pci_ioevent_param ioeventfds[VIRTIO_PCI_MAX_VQ];
 };
 
-int virtio_pci__signal_vq(struct kvm *kvm, struct virtio_device *vdev, u32 vq);
-int virtio_pci__signal_config(struct kvm *kvm, struct virtio_device *vdev);
-int virtio_pci__exit(struct kvm *kvm, struct virtio_device *vdev);
-int virtio_pci__init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
+int virtio_pcim__signal_vq(struct kvm *kvm, struct virtio_device *vdev, u32 vq);
+int virtio_pcim__signal_config(struct kvm *kvm, struct virtio_device *vdev);
+int virtio_pcim__exit(struct kvm *kvm, struct virtio_device *vdev);
+int virtio_pcim__init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 		     int device_id, int subsys_id, int class);
 
 #endif
diff --git a/include/kvm/virtio-pci.h b/include/kvm/virtio-pci.h
index b70cadd..7f2664e 100644
--- a/include/kvm/virtio-pci.h
+++ b/include/kvm/virtio-pci.h
@@ -3,6 +3,7 @@
 
 #include "kvm/devices.h"
 #include "kvm/pci.h"
+#include "kvm/virtio.h"
 
 #include <linux/types.h>
 
@@ -11,11 +12,6 @@
 
 struct kvm;
 
-struct virtio_pci_ioevent_param {
-	struct virtio_device	*vdev;
-	u32			vq;
-};
-
 #define VIRTIO_PCI_F_SIGNAL_MSI (1 << 0)
 
 struct virtio_pci {
diff --git a/include/kvm/virtio.h b/include/kvm/virtio.h
index 768ee96..3edd74f 100644
--- a/include/kvm/virtio.h
+++ b/include/kvm/virtio.h
@@ -21,6 +21,8 @@
 #define VIRTIO_ENDIAN_LE	(1 << 0)
 #define VIRTIO_ENDIAN_BE	(1 << 1)
 
+extern u8 default_transport;
+
 struct virt_queue {
 	struct vring	vring;
 	u32		pfn;
@@ -29,6 +31,7 @@ struct virt_queue {
 	u16		last_avail_idx;
 	u16		last_used_signalled;
 	u16		endian;
+	u8		enabled;
 };
 
 /*
@@ -125,6 +128,7 @@ u16 virt_queue__get_inout_iov(struct kvm *kvm, struct virt_queue *queue,
 int virtio__get_dev_specific_field(int offset, bool msix, u32 *config_off);
 
 enum virtio_trans {
+	VIRTIO_PCI_MODERN,
 	VIRTIO_PCI,
 	VIRTIO_MMIO,
 };
@@ -138,8 +142,8 @@ struct virtio_device {
 
 struct virtio_ops {
 	u8 *(*get_config)(struct kvm *kvm, void *dev);
-	u32 (*get_host_features)(struct kvm *kvm, void *dev);
-	void (*set_guest_features)(struct kvm *kvm, void *dev, u32 features);
+	u32 (*get_host_features)(struct kvm *kvm, void *dev, int sel);
+	void (*set_guest_features)(struct kvm *kvm, void *dev, u32 features, int sel);
 	int (*init_vq)(struct kvm *kvm, void *dev, u32 vq, u32 page_size,
 		       u32 align, u32 pfn);
 	int (*notify_vq)(struct kvm *kvm, void *dev, u32 vq);
@@ -154,6 +158,8 @@ struct virtio_ops {
 	int (*init)(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 		    int device_id, int subsys_id, int class);
 	int (*exit)(struct kvm *kvm, struct virtio_device *vdev);
+	int (*queue_cnt)(struct virtio_device *vdev);
+	struct virt_queue *(*get_queue)(void *dev, u32 vq);
 };
 
 int virtio_init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
@@ -167,10 +173,25 @@ static inline void *virtio_get_vq(struct kvm *kvm, u32 pfn, u32 page_size)
 	return guest_flat_to_host(kvm, (u64)pfn * page_size);
 }
 
+static inline void virtio_adjust_vq(struct kvm *kvm, struct virt_queue *queue, unsigned int num)
+{
+	queue->vring = (struct vring) {
+		.desc = guest_flat_to_host(kvm, (unsigned long)queue->vring.desc),
+		.used = guest_flat_to_host(kvm, (unsigned long)queue->vring.used),
+		.avail = guest_flat_to_host(kvm, (unsigned long)queue->vring.avail),
+		.num = num,
+	};
+}
+
 static inline void virtio_init_device_vq(struct virtio_device *vdev,
 					 struct virt_queue *vq)
 {
 	vq->endian = vdev->endian;
 }
 
+struct virtio_pci_ioevent_param {
+	struct virtio_device    *vdev;
+	u32                     vq;
+};
+
 #endif /* KVM__VIRTIO_H */
diff --git a/include/linux/virtio_pci.h b/include/linux/virtio_pci.h
new file mode 100644
index 0000000..90007a1
--- /dev/null
+++ b/include/linux/virtio_pci.h
@@ -0,0 +1,199 @@
+/*
+ * Virtio PCI driver
+ *
+ * This module allows virtio devices to be used over a virtual PCI device.
+ * This can be used with QEMU based VMMs like KVM or Xen.
+ *
+ * Copyright IBM Corp. 2007
+ *
+ * Authors:
+ *  Anthony Liguori  <aliguori@us.ibm.com>
+ *
+ * This header is BSD licensed so anyone can use the definitions to implement
+ * compatible drivers/servers.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of IBM nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#ifndef _LINUX_VIRTIO_PCI_H
+#define _LINUX_VIRTIO_PCI_H
+
+#include <linux/types.h>
+
+#ifndef VIRTIO_PCI_NO_LEGACY
+
+/* A 32-bit r/o bitmask of the features supported by the host */
+#define VIRTIO_PCI_HOST_FEATURES	0
+
+/* A 32-bit r/w bitmask of features activated by the guest */
+#define VIRTIO_PCI_GUEST_FEATURES	4
+
+/* A 32-bit r/w PFN for the currently selected queue */
+#define VIRTIO_PCI_QUEUE_PFN		8
+
+/* A 16-bit r/o queue size for the currently selected queue */
+#define VIRTIO_PCI_QUEUE_NUM		12
+
+/* A 16-bit r/w queue selector */
+#define VIRTIO_PCI_QUEUE_SEL		14
+
+/* A 16-bit r/w queue notifier */
+#define VIRTIO_PCI_QUEUE_NOTIFY		16
+
+/* An 8-bit device status register.  */
+#define VIRTIO_PCI_STATUS		18
+
+/* An 8-bit r/o interrupt status register.  Reading the value will return the
+ * current contents of the ISR and will also clear it.  This is effectively
+ * a read-and-acknowledge. */
+#define VIRTIO_PCI_ISR			19
+
+/* MSI-X registers: only enabled if MSI-X is enabled. */
+/* A 16-bit vector for configuration changes. */
+#define VIRTIO_MSI_CONFIG_VECTOR        20
+/* A 16-bit vector for selected queue notifications. */
+#define VIRTIO_MSI_QUEUE_VECTOR         22
+
+/* The remaining space is defined by each driver as the per-driver
+ * configuration space */
+#define VIRTIO_PCI_CONFIG_OFF(msix_enabled)	((msix_enabled) ? 24 : 20)
+/* Deprecated: please use VIRTIO_PCI_CONFIG_OFF instead */
+#define VIRTIO_PCI_CONFIG(dev)	VIRTIO_PCI_CONFIG_OFF((dev)->msix_enabled)
+
+/* Virtio ABI version, this must match exactly */
+#define VIRTIO_PCI_ABI_VERSION		0
+
+/* How many bits to shift physical queue address written to QUEUE_PFN.
+ * 12 is historical, and due to x86 page size. */
+#define VIRTIO_PCI_QUEUE_ADDR_SHIFT	12
+
+/* The alignment to use between consumer and producer parts of vring.
+ * x86 pagesize again. */
+#define VIRTIO_PCI_VRING_ALIGN		4096
+
+#endif /* VIRTIO_PCI_NO_LEGACY */
+
+/* The bit of the ISR which indicates a device configuration change. */
+#define VIRTIO_PCI_ISR_CONFIG		0x2
+/* Vector value used to disable MSI for queue */
+#define VIRTIO_MSI_NO_VECTOR            0xffff
+
+#ifndef VIRTIO_PCI_NO_MODERN
+
+/* IDs for different capabilities.  Must all exist. */
+
+/* Common configuration */
+#define VIRTIO_PCI_CAP_COMMON_CFG	1
+/* Notifications */
+#define VIRTIO_PCI_CAP_NOTIFY_CFG	2
+/* ISR access */
+#define VIRTIO_PCI_CAP_ISR_CFG		3
+/* Device specific configuration */
+#define VIRTIO_PCI_CAP_DEVICE_CFG	4
+/* PCI configuration access */
+#define VIRTIO_PCI_CAP_PCI_CFG		5
+
+/* This is the PCI capability header: */
+struct virtio_pci_cap {
+	__u8 cap_vndr;		/* Generic PCI field: PCI_CAP_ID_VNDR */
+	__u8 cap_next;		/* Generic PCI field: next ptr. */
+	__u8 cap_len;		/* Generic PCI field: capability length */
+	__u8 cfg_type;		/* Identifies the structure. */
+	__u8 bar;		/* Where to find it. */
+	__u8 padding[3];	/* Pad to full dword. */
+	__le32 offset;		/* Offset within bar. */
+	__le32 length;		/* Length of the structure, in bytes. */
+};
+
+struct virtio_pci_notify_cap {
+	struct virtio_pci_cap cap;
+	__le32 notify_off_multiplier;	/* Multiplier for queue_notify_off. */
+};
+
+/* Fields in VIRTIO_PCI_CAP_COMMON_CFG: */
+struct virtio_pci_common_cfg {
+	/* About the whole device. */
+	__le32 device_feature_select;	/* read-write */
+	__le32 device_feature;		/* read-only */
+	__le32 guest_feature_select;	/* read-write */
+	__le32 guest_feature;		/* read-write */
+	__le16 msix_config;		/* read-write */
+	__le16 num_queues;		/* read-only */
+	__u8 device_status;		/* read-write */
+	__u8 config_generation;		/* read-only */
+
+	/* About a specific virtqueue. */
+	__le16 queue_select;		/* read-write */
+	__le16 queue_size;		/* read-write, power of 2. */
+	__le16 queue_msix_vector;	/* read-write */
+	__le16 queue_enable;		/* read-write */
+	__le16 queue_notify_off;	/* read-only */
+	__le32 queue_desc_lo;		/* read-write */
+	__le32 queue_desc_hi;		/* read-write */
+	__le32 queue_avail_lo;		/* read-write */
+	__le32 queue_avail_hi;		/* read-write */
+	__le32 queue_used_lo;		/* read-write */
+	__le32 queue_used_hi;		/* read-write */
+};
+
+/* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
+struct virtio_pci_cfg_cap {
+	struct virtio_pci_cap cap;
+	__u8 pci_cfg_data[4]; /* Data for BAR access. */
+};
+
+/* Macro versions of offsets for the Old Timers! */
+#define VIRTIO_PCI_CAP_VNDR		0
+#define VIRTIO_PCI_CAP_NEXT		1
+#define VIRTIO_PCI_CAP_LEN		2
+#define VIRTIO_PCI_CAP_CFG_TYPE		3
+#define VIRTIO_PCI_CAP_BAR		4
+#define VIRTIO_PCI_CAP_OFFSET		8
+#define VIRTIO_PCI_CAP_LENGTH		12
+
+#define VIRTIO_PCI_NOTIFY_CAP_MULT	16
+
+#define VIRTIO_PCI_COMMON_DFSELECT	0
+#define VIRTIO_PCI_COMMON_DF		4
+#define VIRTIO_PCI_COMMON_GFSELECT	8
+#define VIRTIO_PCI_COMMON_GF		12
+#define VIRTIO_PCI_COMMON_MSIX		16
+#define VIRTIO_PCI_COMMON_NUMQ		18
+#define VIRTIO_PCI_COMMON_STATUS	20
+#define VIRTIO_PCI_COMMON_CFGGENERATION	21
+#define VIRTIO_PCI_COMMON_Q_SELECT	22
+#define VIRTIO_PCI_COMMON_Q_SIZE	24
+#define VIRTIO_PCI_COMMON_Q_MSIX	26
+#define VIRTIO_PCI_COMMON_Q_ENABLE	28
+#define VIRTIO_PCI_COMMON_Q_NOFF	30
+#define VIRTIO_PCI_COMMON_Q_DESCLO	32
+#define VIRTIO_PCI_COMMON_Q_DESCHI	36
+#define VIRTIO_PCI_COMMON_Q_AVAILLO	40
+#define VIRTIO_PCI_COMMON_Q_AVAILHI	44
+#define VIRTIO_PCI_COMMON_Q_USEDLO	48
+#define VIRTIO_PCI_COMMON_Q_USEDHI	52
+
+#endif /* VIRTIO_PCI_NO_MODERN */
+
+#endif
diff --git a/net/uip/core.c b/net/uip/core.c
index e860f3a..7d4b19d 100644
--- a/net/uip/core.c
+++ b/net/uip/core.c
@@ -25,6 +25,12 @@ int uip_tx(struct iovec *iov, u16 out, struct uip_info *info)
 	eth_len	 = iov[1].iov_len;
 	eth	 = iov[1].iov_base;
 
+	if (out == 1) {
+		vnet_len = info->vnet_hdr_len;
+		eth = (void *)((char *)vnet + vnet_len);
+		eth_len = iov[0].iov_len - vnet_len;
+	}
+
 	/*
 	 * In case, ethernet frame is in more than one iov entry.
 	 * Copy iov buffer into one linear buffer.
@@ -87,7 +93,6 @@ int uip_rx(struct iovec *iov, u16 in, struct uip_info *info)
 
 	memcpy_toiovecend(iov, buf->vnet, 0, buf->vnet_len);
 	memcpy_toiovecend(iov, buf->eth, buf->vnet_len, buf->eth_len);
-
 	len = buf->vnet_len + buf->eth_len;
 
 	uip_buf_set_free(info, buf);
diff --git a/virtio/9p.c b/virtio/9p.c
index 49e7c5c..8dc65f3 100644
--- a/virtio/9p.c
+++ b/virtio/9p.c
@@ -1252,17 +1252,19 @@ static u8 *get_config(struct kvm *kvm, void *dev)
 	return ((u8 *)(p9dev->config));
 }
 
-static u32 get_host_features(struct kvm *kvm, void *dev)
+static u32 get_host_features(struct kvm *kvm, void *dev, int sel)
 {
-	return 1 << VIRTIO_9P_MOUNT_TAG;
+	static u64 features =	1UL << VIRTIO_9P_MOUNT_TAG;
+
+	return features >> (32 * sel);
 }
 
-static void set_guest_features(struct kvm *kvm, void *dev, u32 features)
+static void set_guest_features(struct kvm *kvm, void *dev, u32 features, int sel)
 {
 	struct p9_dev *p9dev = dev;
 	struct virtio_9p_config *conf = p9dev->config;
 
-	p9dev->features = features;
+	p9dev->features |= (u64)features << (32 * sel);
 	conf->tag_len = virtio_host_to_guest_u16(&p9dev->vdev, conf->tag_len);
 }
 
@@ -1277,11 +1279,16 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 	compat__remove_message(compat_id);
 
 	queue		= &p9dev->vqs[vq];
-	queue->pfn	= pfn;
-	p		= virtio_get_vq(kvm, queue->pfn, page_size);
 	job		= &p9dev->jobs[vq];
 
-	vring_init(&queue->vring, VIRTQUEUE_NUM, p, align);
+	if (pfn) {
+		queue->pfn	= pfn;
+		p		= virtio_get_vq(kvm, queue->pfn, page_size);
+		vring_init(&queue->vring, VIRTQUEUE_NUM, p, align);
+	} else {
+		virtio_adjust_vq(kvm, queue, VIRTQUEUE_NUM);
+	}
+
 	virtio_init_device_vq(&p9dev->vdev, queue);
 
 	*job		= (struct p9_dev_job) {
@@ -1320,6 +1327,18 @@ static int set_size_vq(struct kvm *kvm, void *dev, u32 vq, int size)
 	return size;
 }
 
+static int queue_cnt(struct virtio_device *vdev)
+{
+	return 1;
+}
+
+static struct virt_queue *get_queue(void *dev, u32 vq)
+{
+	struct p9_dev *p9dev = dev;
+
+	return &p9dev->vqs[vq];
+}
+
 struct virtio_ops p9_dev_virtio_ops = {
 	.get_config		= get_config,
 	.get_host_features	= get_host_features,
@@ -1329,6 +1348,8 @@ struct virtio_ops p9_dev_virtio_ops = {
 	.get_pfn_vq		= get_pfn_vq,
 	.get_size_vq		= get_size_vq,
 	.set_size_vq		= set_size_vq,
+	.queue_cnt		= queue_cnt,
+	.get_queue		= get_queue,
 };
 
 int virtio_9p_rootdir_parser(const struct option *opt, const char *arg, int unset)
diff --git a/virtio/balloon.c b/virtio/balloon.c
index 9564aa3..16a8aba 100644
--- a/virtio/balloon.c
+++ b/virtio/balloon.c
@@ -32,7 +32,7 @@ struct bln_dev {
 	struct list_head	list;
 	struct virtio_device	vdev;
 
-	u32			features;
+	u64			features;
 
 	/* virtio queue */
 	struct virt_queue	vqs[NUM_VIRT_QUEUES];
@@ -181,16 +181,18 @@ static u8 *get_config(struct kvm *kvm, void *dev)
 	return ((u8 *)(&bdev->config));
 }
 
-static u32 get_host_features(struct kvm *kvm, void *dev)
+static u32 get_host_features(struct kvm *kvm, void *dev, int sel)
 {
-	return 1 << VIRTIO_BALLOON_F_STATS_VQ;
+	static u64 features = 1UL << VIRTIO_BALLOON_F_STATS_VQ;
+
+	return features >> (32 * sel);
 }
 
-static void set_guest_features(struct kvm *kvm, void *dev, u32 features)
+static void set_guest_features(struct kvm *kvm, void *dev, u32 features, int sel)
 {
 	struct bln_dev *bdev = dev;
 
-	bdev->features = features;
+	bdev->features = (u64)features << (32 * sel);
 }
 
 static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
@@ -203,11 +205,16 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 	compat__remove_message(compat_id);
 
 	queue		= &bdev->vqs[vq];
-	queue->pfn	= pfn;
-	p		= virtio_get_vq(kvm, queue->pfn, page_size);
+
+	if (pfn) {
+		queue->pfn	= pfn;
+		p		= virtio_get_vq(kvm, queue->pfn, page_size);
+		vring_init(&queue->vring, VIRTIO_BLN_QUEUE_SIZE, p, align);
+	} else {
+		virtio_adjust_vq(kvm, queue, VIRTIO_BLN_QUEUE_SIZE);
+	}
 
 	thread_pool__init_job(&bdev->jobs[vq], kvm, virtio_bln_do_io, queue);
-	vring_init(&queue->vring, VIRTIO_BLN_QUEUE_SIZE, p, align);
 
 	return 0;
 }
@@ -228,6 +235,13 @@ static int get_pfn_vq(struct kvm *kvm, void *dev, u32 vq)
 	return bdev->vqs[vq].pfn;
 }
 
+static struct virt_queue *get_queue(void *dev, u32 vq)
+{
+	struct bln_dev *bdev = dev;
+
+	return &bdev->vqs[vq];
+}
+
 static int get_size_vq(struct kvm *kvm, void *dev, u32 vq)
 {
 	return VIRTIO_BLN_QUEUE_SIZE;
@@ -239,6 +253,11 @@ static int set_size_vq(struct kvm *kvm, void *dev, u32 vq, int size)
 	return size;
 }
 
+static int queue_cnt(struct virtio_device *vdev)
+{
+	return NUM_VIRT_QUEUES;
+}
+
 struct virtio_ops bln_dev_virtio_ops = {
 	.get_config		= get_config,
 	.get_host_features	= get_host_features,
@@ -248,6 +267,8 @@ struct virtio_ops bln_dev_virtio_ops = {
 	.get_pfn_vq		= get_pfn_vq,
 	.get_size_vq		= get_size_vq,
 	.set_size_vq            = set_size_vq,
+	.queue_cnt		= queue_cnt,
+	.get_queue		= get_queue,
 };
 
 int virtio_bln__init(struct kvm *kvm)
diff --git a/virtio/blk.c b/virtio/blk.c
index c485e4f..e036b75 100644
--- a/virtio/blk.c
+++ b/virtio/blk.c
@@ -44,7 +44,7 @@ struct blk_dev {
 	struct virtio_device		vdev;
 	struct virtio_blk_config	blk_config;
 	struct disk_image		*disk;
-	u32				features;
+	u64				features;
 
 	struct virt_queue		vqs[NUM_VIRT_QUEUES];
 	struct blk_dev_req		reqs[VIRTIO_BLK_QUEUE_SIZE];
@@ -146,21 +146,34 @@ static u8 *get_config(struct kvm *kvm, void *dev)
 	return ((u8 *)(&bdev->blk_config));
 }
 
-static u32 get_host_features(struct kvm *kvm, void *dev)
+static u32 get_host_features(struct kvm *kvm, void *dev, int sel)
 {
-	return	1UL << VIRTIO_BLK_F_SEG_MAX
+	static u64 features = 1UL << VIRTIO_BLK_F_SEG_MAX
 		| 1UL << VIRTIO_BLK_F_FLUSH
 		| 1UL << VIRTIO_RING_F_EVENT_IDX
 		| 1UL << VIRTIO_RING_F_INDIRECT_DESC;
+
+	return features >> (32 * sel);
 }
 
-static void set_guest_features(struct kvm *kvm, void *dev, u32 features)
+static void set_guest_features(struct kvm *kvm, void *dev, u32 features, int sel)
 {
 	struct blk_dev *bdev = dev;
+
+	bdev->features |= (u64)features << (32 * sel);
+}
+
+static void notify_status(struct kvm *kvm, void *dev, u8 status)
+{
+	static bool init_done;
+	struct blk_dev *bdev = dev;
 	struct virtio_blk_config *conf = &bdev->blk_config;
 	struct virtio_blk_geometry *geo = &conf->geometry;
 
-	bdev->features = features;
+	if (!(status & VIRTIO_CONFIG_S_DRIVER_OK) || init_done)
+		return;
+
+	init_done = true;
 
 	conf->capacity = virtio_host_to_guest_u64(&bdev->vdev, conf->capacity);
 	conf->size_max = virtio_host_to_guest_u32(&bdev->vdev, conf->size_max);
@@ -173,7 +186,6 @@ static void set_guest_features(struct kvm *kvm, void *dev, u32 features)
 	conf->min_io_size = virtio_host_to_guest_u16(&bdev->vdev, conf->min_io_size);
 	conf->opt_io_size = virtio_host_to_guest_u32(&bdev->vdev, conf->opt_io_size);
 }
-
 static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 		   u32 pfn)
 {
@@ -184,10 +196,15 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 	compat__remove_message(compat_id);
 
 	queue		= &bdev->vqs[vq];
-	queue->pfn	= pfn;
-	p		= virtio_get_vq(kvm, queue->pfn, page_size);
 
-	vring_init(&queue->vring, VIRTIO_BLK_QUEUE_SIZE, p, align);
+	if (pfn) {
+		queue->pfn	= pfn;
+		p		= virtio_get_vq(kvm, queue->pfn, page_size);
+		vring_init(&queue->vring, VIRTIO_BLK_QUEUE_SIZE, p, align);
+	} else {
+		virtio_adjust_vq(kvm, queue, VIRTIO_BLK_QUEUE_SIZE);
+	}
+
 	virtio_init_device_vq(&bdev->vdev, queue);
 
 	return 0;
@@ -232,6 +249,13 @@ static int get_pfn_vq(struct kvm *kvm, void *dev, u32 vq)
 	return bdev->vqs[vq].pfn;
 }
 
+static struct virt_queue *get_queue(void *dev, u32 vq)
+{
+	struct blk_dev *bdev = dev;
+
+	return &bdev->vqs[vq];
+}
+
 static int get_size_vq(struct kvm *kvm, void *dev, u32 vq)
 {
 	/* FIXME: dynamic */
@@ -244,6 +268,11 @@ static int set_size_vq(struct kvm *kvm, void *dev, u32 vq, int size)
 	return size;
 }
 
+static int queue_cnt(struct virtio_device *vdev)
+{
+	return NUM_VIRT_QUEUES;
+}
+
 static struct virtio_ops blk_dev_virtio_ops = {
 	.get_config		= get_config,
 	.get_host_features	= get_host_features,
@@ -253,6 +282,9 @@ static struct virtio_ops blk_dev_virtio_ops = {
 	.get_pfn_vq		= get_pfn_vq,
 	.get_size_vq		= get_size_vq,
 	.set_size_vq		= set_size_vq,
+	.queue_cnt		= queue_cnt,
+	.get_queue		= get_queue,
+	.notify_status		= notify_status,
 };
 
 static int virtio_blk__init_one(struct kvm *kvm, struct disk_image *disk)
diff --git a/virtio/console.c b/virtio/console.c
index f1c0a19..0bdeecd 100644
--- a/virtio/console.c
+++ b/virtio/console.c
@@ -34,7 +34,7 @@ struct con_dev {
 	struct virtio_device		vdev;
 	struct virt_queue		vqs[VIRTIO_CONSOLE_NUM_QUEUES];
 	struct virtio_console_config	config;
-	u32				features;
+	u64				features;
 
 	pthread_cond_t			poll_cond;
 	int				vq_ready;
@@ -124,16 +124,26 @@ static u8 *get_config(struct kvm *kvm, void *dev)
 	return ((u8 *)(&cdev->config));
 }
 
-static u32 get_host_features(struct kvm *kvm, void *dev)
+static u32 get_host_features(struct kvm *kvm, void *dev, int sel)
 {
 	return 0;
 }
 
-static void set_guest_features(struct kvm *kvm, void *dev, u32 features)
+static void set_guest_features(struct kvm *kvm, void *dev, u32 features, int sel)
 {
+	return;
+}
+
+static void notify_status(struct kvm *kvm, void *dev, u8 status)
+{
+	static bool init_done;
 	struct con_dev *cdev = dev;
 	struct virtio_console_config *conf = &cdev->config;
 
+	if (!(status & VIRTIO_CONFIG_S_DRIVER_OK) || init_done)
+		return;
+
+	init_done = true;
 	conf->cols = virtio_host_to_guest_u16(&cdev->vdev, conf->cols);
 	conf->rows = virtio_host_to_guest_u16(&cdev->vdev, conf->rows);
 	conf->max_nr_ports = virtio_host_to_guest_u32(&cdev->vdev, conf->max_nr_ports);
@@ -150,10 +160,15 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 	compat__remove_message(compat_id);
 
 	queue		= &cdev.vqs[vq];
-	queue->pfn	= pfn;
-	p		= virtio_get_vq(kvm, queue->pfn, page_size);
 
-	vring_init(&queue->vring, VIRTIO_CONSOLE_QUEUE_SIZE, p, align);
+	if (pfn) {
+		queue->pfn	= pfn;
+		p		= virtio_get_vq(kvm, queue->pfn, page_size);
+		vring_init(&queue->vring, VIRTIO_CONSOLE_QUEUE_SIZE, p, align);
+	} else {
+		virtio_adjust_vq(kvm, queue, VIRTIO_CONSOLE_NUM_QUEUES);
+	}
+
 	virtio_init_device_vq(&cdev.vdev, queue);
 
 	if (vq == VIRTIO_CONSOLE_TX_QUEUE) {
@@ -186,6 +201,13 @@ static int get_pfn_vq(struct kvm *kvm, void *dev, u32 vq)
 	return cdev->vqs[vq].pfn;
 }
 
+static struct virt_queue *get_queue(void *dev, u32 vq)
+{
+	struct con_dev *cdev = dev;
+
+	return &cdev->vqs[vq];
+}
+
 static int get_size_vq(struct kvm *kvm, void *dev, u32 vq)
 {
 	return VIRTIO_CONSOLE_QUEUE_SIZE;
@@ -197,6 +219,11 @@ static int set_size_vq(struct kvm *kvm, void *dev, u32 vq, int size)
 	return size;
 }
 
+static int queue_cnt(struct virtio_device *vdev)
+{
+	return VIRTIO_CONSOLE_NUM_QUEUES;
+}
+
 static struct virtio_ops con_dev_virtio_ops = {
 	.get_config		= get_config,
 	.get_host_features	= get_host_features,
@@ -206,6 +233,9 @@ static struct virtio_ops con_dev_virtio_ops = {
 	.get_pfn_vq		= get_pfn_vq,
 	.get_size_vq		= get_size_vq,
 	.set_size_vq		= set_size_vq,
+	.queue_cnt		= queue_cnt,
+	.get_queue		= get_queue,
+	.notify_status		= notify_status,
 };
 
 int virtio_console__init(struct kvm *kvm)
diff --git a/virtio/core.c b/virtio/core.c
index 3b6e4d7..0225796 100644
--- a/virtio/core.c
+++ b/virtio/core.c
@@ -6,16 +6,20 @@
 #include "kvm/guest_compat.h"
 #include "kvm/barrier.h"
 #include "kvm/virtio.h"
+#include "kvm/virtio-pci-modern.h"
 #include "kvm/virtio-pci.h"
 #include "kvm/virtio-mmio.h"
 #include "kvm/util.h"
 #include "kvm/kvm.h"
 
+u8 default_transport;
 
 const char* virtio_trans_name(enum virtio_trans trans)
 {
 	if (trans == VIRTIO_PCI)
 		return "pci";
+	else if (trans == VIRTIO_PCI_MODERN)
+		return "pci-modern";
 	else if (trans == VIRTIO_MMIO)
 		return "mmio";
 	return "unknown";
@@ -187,6 +191,18 @@ int virtio_init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 	void *virtio;
 
 	switch (trans) {
+	case VIRTIO_PCI_MODERN:
+		virtio = calloc(sizeof(struct virtio_pci_modern), 1);
+		if (!virtio)
+			return -ENOMEM;
+		vdev->virtio                    = virtio;
+		vdev->ops                       = ops;
+		vdev->ops->signal_vq            = virtio_pcim__signal_vq;
+		vdev->ops->signal_config        = virtio_pcim__signal_config;
+		vdev->ops->init                 = virtio_pcim__init;
+		vdev->ops->exit                 = virtio_pcim__exit;
+		vdev->ops->init(kvm, dev, vdev, device_id, subsys_id, class);
+                break;
 	case VIRTIO_PCI:
 		virtio = calloc(sizeof(struct virtio_pci), 1);
 		if (!virtio)
diff --git a/virtio/mmio.c b/virtio/mmio.c
index 5174455..3d61bd6 100644
--- a/virtio/mmio.c
+++ b/virtio/mmio.c
@@ -123,9 +123,8 @@ static void virtio_mmio_config_in(struct kvm_cpu *vcpu,
 		ioport__write32(data, *(u32 *)(((void *)&vmmio->hdr) + addr));
 		break;
 	case VIRTIO_MMIO_HOST_FEATURES:
-		if (vmmio->hdr.host_features_sel == 0)
-			val = vdev->ops->get_host_features(vmmio->kvm,
-							   vmmio->dev);
+		val = vdev->ops->get_host_features(vmmio->kvm,
+				vmmio->dev, vmmio->hdr.host_features_sel);
 		ioport__write32(data, val);
 		break;
 	case VIRTIO_MMIO_QUEUE_PFN:
@@ -166,11 +165,9 @@ static void virtio_mmio_config_out(struct kvm_cpu *vcpu,
 			vdev->ops->notify_status(kvm, vmmio->dev, vmmio->hdr.status);
 		break;
 	case VIRTIO_MMIO_GUEST_FEATURES:
-		if (vmmio->hdr.guest_features_sel == 0) {
-			val = ioport__read32(data);
-			vdev->ops->set_guest_features(vmmio->kvm,
-						      vmmio->dev, val);
-		}
+		val = ioport__read32(data);
+		vdev->ops->set_guest_features(vmmio->kvm,
+				vmmio->dev, val, vmmio->hdr.host_features_sel);
 		break;
 	case VIRTIO_MMIO_GUEST_PAGE_SIZE:
 		val = ioport__read32(data);
diff --git a/virtio/net.c b/virtio/net.c
index 6d1be65..061ca4e 100644
--- a/virtio/net.c
+++ b/virtio/net.c
@@ -43,7 +43,8 @@ struct net_dev {
 
 	struct virt_queue		vqs[VIRTIO_NET_NUM_QUEUES * 2 + 1];
 	struct virtio_net_config	config;
-	u32				features, rx_vqs, tx_vqs, queue_pairs;
+	u64				features;
+	u32				rx_vqs, tx_vqs, queue_pairs;
 
 	pthread_t			io_thread[VIRTIO_NET_NUM_QUEUES * 2 + 1];
 	struct mutex			io_lock[VIRTIO_NET_NUM_QUEUES * 2 + 1];
@@ -431,11 +432,10 @@ static u8 *get_config(struct kvm *kvm, void *dev)
 	return ((u8 *)(&ndev->config));
 }
 
-static u32 get_host_features(struct kvm *kvm, void *dev)
+static u32 get_host_features(struct kvm *kvm, void *dev, int sel)
 {
 	struct net_dev *ndev = dev;
-
-	return 1UL << VIRTIO_NET_F_MAC
+	u64 features = 1UL << VIRTIO_NET_F_MAC
 		| 1UL << VIRTIO_NET_F_CSUM
 		| 1UL << VIRTIO_NET_F_HOST_UFO
 		| 1UL << VIRTIO_NET_F_HOST_TSO4
@@ -448,6 +448,8 @@ static u32 get_host_features(struct kvm *kvm, void *dev)
 		| 1UL << VIRTIO_NET_F_CTRL_VQ
 		| 1UL << VIRTIO_NET_F_MRG_RXBUF
 		| 1UL << (ndev->queue_pairs > 1 ? VIRTIO_NET_F_MQ : 0);
+
+	return features >> (32 * sel);
 }
 
 static int virtio_net__vhost_set_features(struct net_dev *ndev)
@@ -466,31 +468,42 @@ static int virtio_net__vhost_set_features(struct net_dev *ndev)
 	return ioctl(ndev->vhost_fd, VHOST_SET_FEATURES, &features);
 }
 
-static void set_guest_features(struct kvm *kvm, void *dev, u32 features)
+static void notify_status(struct kvm *kvm, void *dev, u8 status)
 {
+	static bool init_done;
 	struct net_dev *ndev = dev;
 	struct virtio_net_config *conf = &ndev->config;
 
-	ndev->features = features;
+	if (!(status & VIRTIO_CONFIG_S_DRIVER_OK) || init_done)
+		return;
+
+	init_done = true;
 
 	conf->status = virtio_host_to_guest_u16(&ndev->vdev, conf->status);
 	conf->max_virtqueue_pairs = virtio_host_to_guest_u16(&ndev->vdev,
-							     conf->max_virtqueue_pairs);
+							conf->max_virtqueue_pairs);
 
 	if (ndev->mode == NET_MODE_TAP) {
 		if (!virtio_net__tap_init(ndev))
 			die_perror("You have requested a TAP device, but creation of one has failed because");
 		if (ndev->vhost_fd &&
-				virtio_net__vhost_set_features(ndev) != 0)
+			virtio_net__vhost_set_features(ndev) != 0)
 			die_perror("VHOST_SET_FEATURES failed");
 	} else {
 		ndev->info.vnet_hdr_len = has_virtio_feature(ndev, VIRTIO_NET_F_MRG_RXBUF) ?
-						sizeof(struct virtio_net_hdr_mrg_rxbuf) :
-						sizeof(struct virtio_net_hdr);
+					sizeof(struct virtio_net_hdr_mrg_rxbuf) :
+					sizeof(struct virtio_net_hdr);
 		uip_init(&ndev->info);
 	}
 }
 
+static void set_guest_features(struct kvm *kvm, void *dev, u32 features, int sel)
+{
+	struct net_dev *ndev = dev;
+
+	ndev->features |= (u64)features << (32 * sel);
+}
+
 static bool is_ctrl_vq(struct net_dev *ndev, u32 vq)
 {
 	return vq == (u32)(ndev->queue_pairs * 2);
@@ -509,10 +522,15 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 	compat__remove_message(compat_id);
 
 	queue		= &ndev->vqs[vq];
-	queue->pfn	= pfn;
-	p		= virtio_get_vq(kvm, queue->pfn, page_size);
 
-	vring_init(&queue->vring, VIRTIO_NET_QUEUE_SIZE, p, align);
+	if (pfn) {
+		queue->pfn	= pfn;
+		p		= virtio_get_vq(kvm, queue->pfn, page_size);
+		vring_init(&queue->vring, VIRTIO_NET_QUEUE_SIZE, p, align);
+	} else {
+		virtio_adjust_vq(kvm, queue, VIRTIO_NET_QUEUE_SIZE);
+	}
+
 	virtio_init_device_vq(&ndev->vdev, queue);
 
 	mutex_init(&ndev->io_lock[vq]);
@@ -622,6 +640,13 @@ static int get_pfn_vq(struct kvm *kvm, void *dev, u32 vq)
 	return ndev->vqs[vq].pfn;
 }
 
+static struct virt_queue *get_queue(void *dev, u32 vq)
+{
+	struct net_dev *ndev = dev;
+
+	return &ndev->vqs[vq];
+}
+
 static int get_size_vq(struct kvm *kvm, void *dev, u32 vq)
 {
 	/* FIXME: dynamic */
@@ -634,6 +659,11 @@ static int set_size_vq(struct kvm *kvm, void *dev, u32 vq, int size)
 	return size;
 }
 
+static int queue_cnt(struct virtio_device *vdev)
+{
+	return VIRTIO_NET_NUM_QUEUES;
+}
+
 static struct virtio_ops net_dev_virtio_ops = {
 	.get_config		= get_config,
 	.get_host_features	= get_host_features,
@@ -645,6 +675,9 @@ static struct virtio_ops net_dev_virtio_ops = {
 	.notify_vq		= notify_vq,
 	.notify_vq_gsi		= notify_vq_gsi,
 	.notify_vq_eventfd	= notify_vq_eventfd,
+	.queue_cnt		= queue_cnt,
+	.get_queue		= get_queue,
+	.notify_status		= notify_status,
 };
 
 static void virtio_net__vhost_init(struct kvm *kvm, struct net_dev *ndev)
diff --git a/virtio/pci.c b/virtio/pci.c
index 90fcd64..c3a3113 100644
--- a/virtio/pci.c
+++ b/virtio/pci.c
@@ -125,7 +125,7 @@ static bool virtio_pci__io_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 p
 
 	switch (offset) {
 	case VIRTIO_PCI_HOST_FEATURES:
-		val = vdev->ops->get_host_features(kvm, vpci->dev);
+		val = vdev->ops->get_host_features(kvm, vpci->dev, 0);
 		ioport__write32(data, val);
 		break;
 	case VIRTIO_PCI_QUEUE_PFN:
@@ -211,7 +211,7 @@ static bool virtio_pci__io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16
 	switch (offset) {
 	case VIRTIO_PCI_GUEST_FEATURES:
 		val = ioport__read32(data);
-		vdev->ops->set_guest_features(kvm, vpci->dev, val);
+		vdev->ops->set_guest_features(kvm, vpci->dev, val, 0);
 		break;
 	case VIRTIO_PCI_QUEUE_PFN:
 		val = ioport__read32(data);
diff --git a/virtio/pci_modern.c b/virtio/pci_modern.c
new file mode 100644
index 0000000..6690366
--- /dev/null
+++ b/virtio/pci_modern.c
@@ -0,0 +1,599 @@
+#include "kvm/virtio-pci-modern.h"
+
+#include "kvm/ioport.h"
+#include "kvm/kvm.h"
+#include "kvm/kvm-cpu.h"
+#include "kvm/virtio-pci-dev.h"
+#include "kvm/irq.h"
+#include "kvm/virtio.h"
+#include "kvm/ioeventfd.h"
+
+#include <sys/ioctl.h>
+#include <linux/virtio_pci.h>
+#include <linux/byteorder.h>
+#include <linux/virtio_config.h>
+#include <string.h>
+
+static void virtio_pcim__ioevent_callback(struct kvm *kvm, void *param)
+{
+	struct virtio_pci_ioevent_param *ioeventfd = param;
+	struct virtio_pci_modern *vpci = ioeventfd->vdev->virtio;
+
+	ioeventfd->vdev->ops->notify_vq(kvm, vpci->dev, ioeventfd->vq);
+}
+
+__used static int virtio_pcim__init_ioeventfd(struct kvm *kvm, struct virtio_device *vdev, u32 vq)
+{
+	struct ioevent ioevent;
+	struct virtio_pci_modern *vpci = vdev->virtio;
+	int i, r, flags = 0;
+	int fds[2];
+
+	vpci->ioeventfds[vq] = (struct virtio_pci_ioevent_param) {
+		.vdev		= vdev,
+		.vq		= vq,
+	};
+
+	ioevent = (struct ioevent) {
+		.fn		= virtio_pcim__ioevent_callback,
+		.fn_ptr		= &vpci->ioeventfds[vq],
+		.datamatch	= vq,
+		.fn_kvm		= kvm,
+	};
+
+	/*
+	 * Vhost will poll the eventfd in host kernel side, otherwise we
+	 * need to poll in userspace.
+	 */
+	if (!vdev->use_vhost)
+		flags |= IOEVENTFD_FLAG_USER_POLL;
+
+	/* ioport */
+	ioevent.io_addr	= vpci->port_addr + 0x80 + vq * 2;
+	ioevent.io_len	= sizeof(u16);
+	ioevent.fd	= fds[0] = eventfd(0, 0);
+	r = ioeventfd__add_event(&ioevent, flags | IOEVENTFD_FLAG_PIO);
+	if (r)
+		return r;
+
+	/* mmio */
+	ioevent.io_addr	= vpci->mmio_addr + 0x80 + vq * 2;
+	ioevent.io_len	= sizeof(u16);
+	ioevent.fd	= fds[1] = eventfd(0, 0);
+	r = ioeventfd__add_event(&ioevent, flags);
+	if (r)
+		goto free_ioport_evt;
+
+	if (vdev->ops->notify_vq_eventfd)
+		for (i = 0; i < 2; ++i)
+			vdev->ops->notify_vq_eventfd(kvm, vpci->dev, vq,
+						     fds[i]);
+	return 0;
+
+free_ioport_evt:
+	ioeventfd__del_event(vpci->port_addr + VIRTIO_PCI_QUEUE_NOTIFY, vq);
+	return r;
+}
+
+static inline bool virtio_pcim__msix_enabled(struct virtio_pci_modern *vpci)
+{
+	return vpci->pci_hdr.msix.ctrl & cpu_to_le16(PCI_MSIX_FLAGS_ENABLE);
+}
+
+static bool virtio_pcim__notify_out(struct virtio_device *vdev, unsigned long offset, void *data, int size)
+{
+	u16 vq = ioport__read16(data);
+	struct virtio_pci_modern *vpci = vdev->virtio;
+	vdev->ops->notify_vq(vpci->kvm, vpci->dev, vq);
+
+	return true;
+}
+
+static bool virtio_pcim__config_out(struct virtio_device *vdev, unsigned long offset, void *data, int size)
+{
+	struct virtio_pci_modern *vpci = vdev->virtio;
+
+	vdev->ops->get_config(vpci->kvm, vpci->dev)[offset] = *(u8 *)data;
+
+	return true;
+}
+
+static bool virtio_pcim__common_out(struct virtio_device *vdev, unsigned long offset, void *data, int size)
+{
+	unsigned long addr;
+	u32 val, gsi, vec;
+	struct virtio_pci_modern *vpci = vdev->virtio;
+
+	switch (offset) {
+	case VIRTIO_PCI_COMMON_DFSELECT:
+		vpci->device_features_sel = ioport__read32(data);
+		break;
+	case VIRTIO_PCI_COMMON_GF:
+		val = ioport__read32(data);
+		if (vpci->driver_features_sel > 1)
+			break;
+		vdev->ops->set_guest_features(vpci->kvm, vpci->dev, val, vpci->driver_features_sel);
+		break;
+	case VIRTIO_PCI_COMMON_GFSELECT:
+		vpci->driver_features_sel = ioport__read32(data);
+		break;
+	case VIRTIO_PCI_COMMON_MSIX:
+		vec = vpci->config_vector = ioport__read16(data);
+		if (vec == VIRTIO_MSI_NO_VECTOR)
+			break;
+
+		gsi = irq__add_msix_route(vpci->kvm, &vpci->msix_table[vec].msg);
+
+		vpci->config_gsi = gsi;
+		break;
+	case VIRTIO_PCI_COMMON_STATUS:
+		vpci->status = ioport__read8(data);
+		if (vdev->ops->notify_status)
+			vdev->ops->notify_status(vpci->kvm, vpci->dev, vpci->status);
+		break;
+	case VIRTIO_PCI_COMMON_Q_SELECT:
+		vpci->queue_selector = ioport__read16(data);
+		break;
+	case VIRTIO_PCI_COMMON_Q_MSIX:
+		vec = vpci->vq_vector[vpci->queue_selector] = ioport__read16(data);
+
+		if (vec == VIRTIO_MSI_NO_VECTOR)
+			break;
+
+		gsi = irq__add_msix_route(vpci->kvm, &vpci->msix_table[vec].msg);
+		vpci->gsis[vpci->queue_selector] = gsi;
+		if (vdev->ops->notify_vq_gsi)
+			vdev->ops->notify_vq_gsi(vpci->kvm, vpci->dev,
+						vpci->queue_selector, gsi);
+		break;
+	case VIRTIO_PCI_COMMON_Q_SIZE:
+		val = ioport__read16(data);
+		break;
+	case VIRTIO_PCI_COMMON_Q_ENABLE:
+		val = ioport__read16(data);
+		if (val) {
+			virtio_pcim__init_ioeventfd(vpci->kvm, vdev, vpci->queue_selector);
+			vdev->ops->init_vq(vpci->kvm, vpci->dev, vpci->queue_selector,
+				1 << VIRTIO_PCI_QUEUE_ADDR_SHIFT,
+				VIRTIO_PCI_VRING_ALIGN, 0);
+		}
+		vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->enabled = val;
+		break;
+	case VIRTIO_PCI_COMMON_Q_DESCLO:
+		val = ioport__read32(data);
+		addr = (unsigned long)vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.desc;
+		addr = ((addr >> 32) << 32) | val;
+		vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.desc = (void *)addr;
+		break;
+	case VIRTIO_PCI_COMMON_Q_DESCHI:
+		val = ioport__read32(data);
+		addr = (unsigned long)vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.desc;
+		addr = ((addr << 32) >> 32) | val;
+		vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.desc = (void *)addr;
+		break;
+	case VIRTIO_PCI_COMMON_Q_AVAILLO:
+		val = ioport__read32(data);
+		addr = (unsigned long)vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.avail;
+		addr = ((addr >> 32) << 32) | val;
+		vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.avail = (void *)addr;
+		break;
+	case VIRTIO_PCI_COMMON_Q_AVAILHI:
+		val = ioport__read32(data);
+		addr = (unsigned long)vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.avail;
+		addr = ((addr << 32) >> 32) | val;
+		vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.avail = (void *)addr;
+		break;
+	case VIRTIO_PCI_COMMON_Q_USEDLO:
+		val = ioport__read32(data);
+		addr = (unsigned long)vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.used;
+		addr = ((addr >> 32) << 32) | val;
+		vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.used = (void *)addr;
+		break;
+	case VIRTIO_PCI_COMMON_Q_USEDHI:
+		val = ioport__read32(data);
+		addr = (unsigned long)vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.used;
+		addr = ((addr << 32) >> 32) | val;
+		vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.used = (void *)addr;
+		break;
+	}
+
+	return true;
+}
+
+static bool (*io_out_map[5])(struct virtio_device *, unsigned long, void *, int) = {
+	virtio_pcim__common_out,
+	virtio_pcim__notify_out,
+	NULL,
+	virtio_pcim__config_out,
+};
+
+static bool virtio_pcim__io_out(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
+{
+        unsigned long offset;
+        struct virtio_device *vdev;
+        struct virtio_pci_modern *vpci;
+
+        vdev = ioport->priv;
+        vpci = vdev->virtio;
+        offset = port - vpci->port_addr;
+
+	return io_out_map[offset/0x80](vdev, offset - (offset/0x80) * 0x80, data, size);
+}
+
+static bool virtio_pcim__config_in(struct virtio_device *vdev, unsigned long offset, void *data, int size)
+{
+	struct virtio_pci_modern *vpci = vdev->virtio;
+
+	switch (size) {
+	case 1:
+		ioport__write8(data, vdev->ops->get_config(vpci->kvm, vpci->dev)[offset]);
+		break;
+	case 2:
+		ioport__write16(data, ((u16 *)vdev->ops->get_config(vpci->kvm, vpci->dev))[offset]);
+		break;
+	};
+
+	return true;
+}
+
+static bool virtio_pcim__common_in(struct virtio_device *vdev, unsigned long offset, void *data, int size)
+{
+	u32 val;
+	struct virtio_pci_modern *vpci = vdev->virtio;
+	static u64 features = 1UL << VIRTIO_F_VERSION_1;
+
+	switch (offset) {
+	case VIRTIO_PCI_COMMON_DFSELECT:
+		val = vpci->device_features_sel;
+		ioport__write32(data, val);
+		break;
+	case VIRTIO_PCI_COMMON_DF:
+		if (vpci->device_features_sel > 1)
+			break;
+		val = vdev->ops->get_host_features(vpci->kvm, vpci->dev, vpci->device_features_sel);
+		val |= (u32)(features >> (32 * vpci->device_features_sel));
+		ioport__write32(data, val);
+		break;
+	case VIRTIO_PCI_COMMON_GFSELECT:
+		val = vpci->driver_features_sel;
+		ioport__write32(data, val);
+		break;
+	case VIRTIO_PCI_COMMON_MSIX:
+		val = vpci->config_vector;
+		ioport__write32(data, val);
+		break;
+	case VIRTIO_PCI_COMMON_NUMQ:
+		val = vdev->ops->queue_cnt(vdev);
+		ioport__write32(data, val);
+		break;
+	case VIRTIO_PCI_COMMON_STATUS:
+		ioport__write8(data, vpci->status);
+		break;
+	case VIRTIO_PCI_COMMON_CFGGENERATION:
+		ioport__write8(data, 0); /* TODO */
+		break;
+	case VIRTIO_PCI_COMMON_Q_SELECT:
+		ioport__write16(data, vpci->queue_selector);
+		break;
+	case VIRTIO_PCI_COMMON_Q_SIZE:
+		val = vdev->ops->get_size_vq(vpci->kvm, vpci->dev, vpci->queue_selector);
+		ioport__write16(data, val);
+		break;
+	case VIRTIO_PCI_COMMON_Q_MSIX:
+		val = vpci->vq_vector[vpci->queue_selector];
+		ioport__write16(data, val);
+		break;
+	case VIRTIO_PCI_COMMON_Q_ENABLE:
+		val = vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->enabled;
+		ioport__write16(data, val);
+		break;
+	case VIRTIO_PCI_COMMON_Q_NOFF:
+		val = vpci->queue_selector;
+		ioport__write16(data, val);
+		break;
+	case VIRTIO_PCI_COMMON_Q_DESCLO:
+		val = (unsigned long)vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.desc;
+		ioport__write32(data, val);
+		break;
+	case VIRTIO_PCI_COMMON_Q_DESCHI:
+		val = (unsigned long)vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.desc >> 32;
+		ioport__write32(data, val);
+		break;
+	case VIRTIO_PCI_COMMON_Q_AVAILLO:
+		val = (unsigned long)vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.avail;
+		ioport__write32(data, val);
+		break;
+	case VIRTIO_PCI_COMMON_Q_AVAILHI:
+		val = (unsigned long)vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.avail >> 32;
+		ioport__write32(data, val);
+		break;
+	case VIRTIO_PCI_COMMON_Q_USEDLO:
+		val = (unsigned long)vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.used;
+		ioport__write32(data, val);
+		break;
+	case VIRTIO_PCI_COMMON_Q_USEDHI:
+		val = (unsigned long)vdev->ops->get_queue(vpci->dev, vpci->queue_selector)->vring.used >> 32;
+		ioport__write32(data, val);
+		break;
+	};
+
+	return true;
+}
+
+static bool (*io_in_map[5])(struct virtio_device *, unsigned long, void *, int) = {
+	virtio_pcim__common_in,
+	NULL,
+	NULL,
+	virtio_pcim__config_in,
+};
+
+static bool virtio_pcim__io_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 port, void *data, int size)
+{
+        unsigned long offset;
+        struct virtio_device *vdev;
+        struct virtio_pci_modern *vpci;
+
+        vdev = ioport->priv;
+        vpci = vdev->virtio;
+        offset = port - vpci->port_addr;
+
+	return io_in_map[offset/0x80](vdev, offset - (offset/0x80) * 0x80, data, size);
+}
+
+static struct ioport_operations virtio_pcim__io_ops = {
+	.io_in	= virtio_pcim__io_in,
+	.io_out	= virtio_pcim__io_out,
+};
+
+static void virtio_pcim__msix_mmio_callback(struct kvm_cpu *vcpu,
+					   u64 addr, u8 *data, u32 len,
+					   u8 is_write, void *ptr)
+{
+	struct virtio_pci_modern *vpci = ptr;
+	void *table;
+	u32 offset;
+
+	if (addr > vpci->msix_io_block + PCI_IO_SIZE) {
+		table	= &vpci->msix_pba;
+		offset	= vpci->msix_io_block + PCI_IO_SIZE;
+	} else {
+		table	= &vpci->msix_table;
+		offset	= vpci->msix_io_block;
+	}
+
+	if (is_write)
+		memcpy(table + addr - offset, data, len);
+	else
+		memcpy(data, table + addr - offset, len);
+}
+
+static void virtio_pcim__signal_msi(struct kvm *kvm, struct virtio_pci_modern *vpci, int vec)
+{
+	struct kvm_msi msi = {
+		.address_lo = vpci->msix_table[vec].msg.address_lo,
+		.address_hi = vpci->msix_table[vec].msg.address_hi,
+		.data = vpci->msix_table[vec].msg.data,
+	};
+
+	ioctl(kvm->vm_fd, KVM_SIGNAL_MSI, &msi);
+}
+
+int virtio_pcim__signal_vq(struct kvm *kvm, struct virtio_device *vdev, u32 vq)
+{
+	struct virtio_pci_modern *vpci = vdev->virtio;
+	int tbl = vpci->vq_vector[vq];
+
+	if (virtio_pcim__msix_enabled(vpci) && tbl != VIRTIO_MSI_NO_VECTOR) {
+		if (vpci->pci_hdr.msix.ctrl & cpu_to_le16(PCI_MSIX_FLAGS_MASKALL) ||
+		    vpci->msix_table[tbl].ctrl & cpu_to_le16(PCI_MSIX_ENTRY_CTRL_MASKBIT)) {
+
+			vpci->msix_pba |= 1 << tbl;
+			return 0;
+		}
+
+		if (vpci->features & VIRTIO_PCI_F_SIGNAL_MSI)
+			virtio_pcim__signal_msi(kvm, vpci, vpci->vq_vector[vq]);
+		else
+			kvm__irq_trigger(kvm, vpci->gsis[vq]);
+	} else {
+		vpci->isr = VIRTIO_IRQ_HIGH;
+		kvm__irq_trigger(kvm, vpci->legacy_irq_line);
+	}
+	return 0;
+}
+
+int virtio_pcim__signal_config(struct kvm *kvm, struct virtio_device *vdev)
+{
+	struct virtio_pci_modern *vpci = vdev->virtio;
+	int tbl = vpci->config_vector;
+
+	if (virtio_pcim__msix_enabled(vpci) && tbl != VIRTIO_MSI_NO_VECTOR) {
+		if (vpci->pci_hdr.msix.ctrl & cpu_to_le16(PCI_MSIX_FLAGS_MASKALL) ||
+		    vpci->msix_table[tbl].ctrl & cpu_to_le16(PCI_MSIX_ENTRY_CTRL_MASKBIT)) {
+
+			vpci->msix_pba |= 1 << tbl;
+			return 0;
+		}
+
+		if (vpci->features & VIRTIO_PCI_F_SIGNAL_MSI)
+			virtio_pcim__signal_msi(kvm, vpci, tbl);
+		else
+			kvm__irq_trigger(kvm, vpci->config_gsi);
+	} else {
+		vpci->isr = VIRTIO_PCI_ISR_CONFIG;
+		kvm__irq_trigger(kvm, vpci->legacy_irq_line);
+	}
+
+	return 0;
+}
+
+static void virtio_pcim__io_mmio_callback(struct kvm_cpu *vcpu,
+					 u64 addr, u8 *data, u32 len,
+					 u8 is_write, void *ptr)
+{
+	struct virtio_pci_modern *vpci = ptr;
+	int direction = is_write ? KVM_EXIT_IO_OUT : KVM_EXIT_IO_IN;
+	u16 port = vpci->port_addr + (addr & (IOPORT_SIZE - 1));
+
+	kvm__emulate_io(vcpu, port, data, direction, len, 1);
+}
+
+int virtio_pcim__init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
+		     int device_id, int subsys_id, int class)
+{
+	struct virtio_pci_modern *vpci = vdev->virtio;
+	int r;
+
+	vpci->kvm = kvm;
+	vpci->dev = dev;
+
+	r = ioport__register(kvm, IOPORT_EMPTY, &virtio_pcim__io_ops, IOPORT_SIZE, vdev);
+	if (r < 0)
+		return r;
+	vpci->port_addr = (u16)r;
+
+	vpci->mmio_addr = pci_get_io_space_block(IOPORT_SIZE);
+	r = kvm__register_mmio(kvm, vpci->mmio_addr, IOPORT_SIZE, false,
+			       virtio_pcim__io_mmio_callback, vpci);
+	if (r < 0)
+		goto free_ioport;
+
+	vpci->msix_io_block = pci_get_io_space_block(PCI_IO_SIZE);
+	r = kvm__register_mmio(kvm, vpci->msix_io_block, PCI_IO_SIZE, false,
+			       virtio_pcim__msix_mmio_callback, vpci);
+	if (r < 0)
+		goto free_mmio;
+
+	vpci->pci_hdr = (struct pci_device_header) {
+		.vendor_id		= cpu_to_le16(PCI_VENDOR_ID_REDHAT_QUMRANET),
+		.device_id		= cpu_to_le16(device_id),
+		.command		= PCI_COMMAND_IO | PCI_COMMAND_MEMORY,
+		.header_type		= PCI_HEADER_TYPE_NORMAL,
+		.revision_id		= 0,
+		.class[0]		= class & 0xff,
+		.class[1]		= (class >> 8) & 0xff,
+		.class[2]		= (class >> 16) & 0xff,
+		.subsys_vendor_id	= cpu_to_le16(PCI_SUBSYSTEM_VENDOR_ID_REDHAT_QUMRANET),
+		.subsys_id		= cpu_to_le16(subsys_id),
+		.bar[0]			= cpu_to_le32(vpci->mmio_addr
+							| PCI_BASE_ADDRESS_SPACE_MEMORY),
+		.bar[1]			= cpu_to_le32(vpci->port_addr
+							| PCI_BASE_ADDRESS_SPACE_IO),
+		.bar[2]			= cpu_to_le32(vpci->msix_io_block
+							| PCI_BASE_ADDRESS_SPACE_MEMORY),
+		.status			= cpu_to_le16(PCI_STATUS_CAP_LIST),
+		.capabilities		= (void *)&vpci->pci_hdr.msix - (void *)&vpci->pci_hdr,
+		.bar_size[0]		= cpu_to_le32(IOPORT_SIZE),
+		.bar_size[1]		= cpu_to_le32(IOPORT_SIZE),
+		.bar_size[2]		= cpu_to_le32(PCI_IO_SIZE*2),
+	};
+
+	vpci->dev_hdr = (struct device_header) {
+		.bus_type		= DEVICE_BUS_PCI,
+		.data			= &vpci->pci_hdr,
+	};
+
+	vpci->pci_hdr.msix.cap = PCI_CAP_ID_MSIX;
+	vpci->pci_hdr.msix.next = (void *)&vpci->pci_hdr.common_cap - (void *)&vpci->pci_hdr,
+	/*
+	 * We at most have VIRTIO_PCI_MAX_VQ entries for virt queue,
+	 * VIRTIO_PCI_MAX_CONFIG entries for config.
+	 *
+	 * To quote the PCI spec:
+	 *
+	 * System software reads this field to determine the
+	 * MSI-X Table Size N, which is encoded as N-1.
+	 * For example, a returned value of "00000000011"
+	 * indicates a table size of 4.
+	 */
+	vpci->pci_hdr.msix.ctrl = cpu_to_le16(VIRTIO_PCI_MAX_VQ + VIRTIO_PCI_MAX_CONFIG - 1);
+
+	/* Both table and PBA are mapped to the same BAR (2) */
+	vpci->pci_hdr.msix.table_offset = cpu_to_le32(2);
+	vpci->pci_hdr.msix.pba_offset = cpu_to_le32(2 | PCI_IO_SIZE);
+	vpci->config_vector = 0;
+
+	if (kvm__supports_extension(kvm, KVM_CAP_SIGNAL_MSI))
+		vpci->features |= VIRTIO_PCI_F_SIGNAL_MSI;
+
+	vpci->pci_hdr.common_cap = (struct virtio_pci_cap) {
+		.cap_vndr = 0x09,
+		.cap_next = (void *)&vpci->pci_hdr.notify_cap - (void *)&vpci->pci_hdr,
+		.cap_len = sizeof(vpci->pci_hdr.common_cap),
+		.cfg_type = VIRTIO_PCI_CAP_COMMON_CFG,
+		.bar = 0,
+		.offset = 0,
+		.length = 0x80,
+	};
+	vpci->pci_hdr.notify_cap = (struct virtio_pci_notify_cap) {
+		.cap.cap_vndr = 0x09,
+		.cap.cap_next = (void *)&vpci->pci_hdr.isr_cap - (void *)&vpci->pci_hdr,
+		.cap.cap_len = sizeof(vpci->pci_hdr.notify_cap),
+		.cap.cfg_type = VIRTIO_PCI_CAP_NOTIFY_CFG,
+		.cap.bar = 0,
+		.cap.offset = 0x80,
+		.cap.length = 0x80,
+		.notify_off_multiplier = 2,
+	};
+	vpci->pci_hdr.isr_cap = (struct virtio_pci_cap) {
+		.cap_vndr = 0x09,
+		.cap_next = (void *)&vpci->pci_hdr.device_cap - (void *)&vpci->pci_hdr,
+		.cap_len = sizeof(vpci->pci_hdr.isr_cap),
+		.cfg_type = VIRTIO_PCI_CAP_ISR_CFG,
+		.bar = 0,
+		.offset = 0x100,
+		.length = 0x80,
+	};
+	vpci->pci_hdr.device_cap = (struct virtio_pci_cap) {
+		.cap_vndr = 0x09,
+		.cap_next = (void *)&vpci->pci_hdr.pci_cap - (void *)&vpci->pci_hdr,
+		.cap_len = sizeof(vpci->pci_hdr.device_cap),
+		.cfg_type = VIRTIO_PCI_CAP_DEVICE_CFG,
+		.bar = 0,
+		.offset = 0x180,
+		.length = 0x80,
+	};
+	vpci->pci_hdr.pci_cap = (struct virtio_pci_cfg_cap) {
+		.cap.cap_vndr = 0,
+		.cap.cap_next = 0,
+		.cap.cap_len = sizeof(vpci->pci_hdr.pci_cap),
+		.cap.cfg_type = VIRTIO_PCI_CAP_PCI_CFG,
+		.cap.bar = 0,
+		.cap.offset = 0x200,
+		.cap.length = 0x80,
+	};
+
+	r = device__register(&vpci->dev_hdr);
+	if (r < 0)
+		goto free_msix_mmio;
+
+	/* save the IRQ that device__register() has allocated */
+	vpci->legacy_irq_line = vpci->pci_hdr.irq_line;
+
+	return 0;
+
+free_msix_mmio:
+	kvm__deregister_mmio(kvm, vpci->msix_io_block);
+free_mmio:
+	kvm__deregister_mmio(kvm, vpci->mmio_addr);
+free_ioport:
+	ioport__unregister(kvm, vpci->port_addr);
+	return r;
+}
+
+int virtio_pcim__exit(struct kvm *kvm, struct virtio_device *vdev)
+{
+	struct virtio_pci_modern *vpci = vdev->virtio;
+	int i;
+
+	kvm__deregister_mmio(kvm, vpci->mmio_addr);
+	kvm__deregister_mmio(kvm, vpci->msix_io_block);
+	ioport__unregister(kvm, vpci->port_addr);
+
+	for (i = 0; i < VIRTIO_PCI_MAX_VQ; i++) {
+		ioeventfd__del_event(vpci->port_addr + VIRTIO_PCI_QUEUE_NOTIFY, i);
+		ioeventfd__del_event(vpci->mmio_addr + VIRTIO_PCI_QUEUE_NOTIFY, i);
+	}
+
+	return 0;
+}
diff --git a/virtio/rng.c b/virtio/rng.c
index 9b9e128..242bfa9 100644
--- a/virtio/rng.c
+++ b/virtio/rng.c
@@ -47,13 +47,13 @@ static u8 *get_config(struct kvm *kvm, void *dev)
 	return 0;
 }
 
-static u32 get_host_features(struct kvm *kvm, void *dev)
+static u32 get_host_features(struct kvm *kvm, void *dev, int sel)
 {
 	/* Unused */
 	return 0;
 }
 
-static void set_guest_features(struct kvm *kvm, void *dev, u32 features)
+static void set_guest_features(struct kvm *kvm, void *dev, u32 features, int sel)
 {
 	/* Unused */
 }
@@ -97,12 +97,17 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 	compat__remove_message(compat_id);
 
 	queue		= &rdev->vqs[vq];
-	queue->pfn	= pfn;
-	p		= virtio_get_vq(kvm, queue->pfn, page_size);
+
+	if (pfn) {
+		queue->pfn	= pfn;
+		p		= virtio_get_vq(kvm, queue->pfn, page_size);
+		vring_init(&queue->vring, VIRTIO_RNG_QUEUE_SIZE, p, align);
+	} else {
+		virtio_adjust_vq(kvm, queue, VIRTIO_RNG_QUEUE_SIZE);
+	}
 
 	job = &rdev->jobs[vq];
 
-	vring_init(&queue->vring, VIRTIO_RNG_QUEUE_SIZE, p, align);
 
 	*job = (struct rng_dev_job) {
 		.vq	= queue,
@@ -130,6 +135,13 @@ static int get_pfn_vq(struct kvm *kvm, void *dev, u32 vq)
 	return rdev->vqs[vq].pfn;
 }
 
+static struct virt_queue *get_queue(void *dev, u32 vq)
+{
+	struct rng_dev *rdev = dev;
+
+	return &rdev->vqs[vq];
+}
+
 static int get_size_vq(struct kvm *kvm, void *dev, u32 vq)
 {
 	return VIRTIO_RNG_QUEUE_SIZE;
@@ -141,6 +153,11 @@ static int set_size_vq(struct kvm *kvm, void *dev, u32 vq, int size)
 	return size;
 }
 
+static int queue_cnt(struct virtio_device *vdev)
+{
+	return NUM_VIRT_QUEUES;
+}
+
 static struct virtio_ops rng_dev_virtio_ops = {
 	.get_config		= get_config,
 	.get_host_features	= get_host_features,
@@ -150,6 +167,8 @@ static struct virtio_ops rng_dev_virtio_ops = {
 	.get_pfn_vq		= get_pfn_vq,
 	.get_size_vq		= get_size_vq,
 	.set_size_vq		= set_size_vq,
+	.queue_cnt		= queue_cnt,
+	.get_queue		= get_queue,
 };
 
 int virtio_rng__init(struct kvm *kvm)
diff --git a/virtio/scsi.c b/virtio/scsi.c
index 58d2353..3e4bb42 100644
--- a/virtio/scsi.c
+++ b/virtio/scsi.c
@@ -22,7 +22,7 @@ struct scsi_dev {
 	struct virt_queue		vqs[NUM_VIRT_QUEUES];
 	struct virtio_scsi_config	config;
 	struct vhost_scsi_target	target;
-	u32				features;
+	u64				features;
 	int				vhost_fd;
 	struct virtio_device		vdev;
 	struct list_head		list;
@@ -36,17 +36,19 @@ static u8 *get_config(struct kvm *kvm, void *dev)
 	return ((u8 *)(&sdev->config));
 }
 
-static u32 get_host_features(struct kvm *kvm, void *dev)
+static u32 get_host_features(struct kvm *kvm, void *dev, int sel)
 {
-	return	1UL << VIRTIO_RING_F_EVENT_IDX |
+	static u64 features = 1UL << VIRTIO_RING_F_EVENT_IDX |
 		1UL << VIRTIO_RING_F_INDIRECT_DESC;
+
+	return features >> (32 * sel);
 }
 
-static void set_guest_features(struct kvm *kvm, void *dev, u32 features)
+static void set_guest_features(struct kvm *kvm, void *dev, u32 features, int sel)
 {
 	struct scsi_dev *sdev = dev;
 
-	sdev->features = features;
+	sdev->features = (u64)features << (32 * sel);
 }
 
 static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
@@ -62,10 +64,14 @@ static int init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size, u32 align,
 	compat__remove_message(compat_id);
 
 	queue		= &sdev->vqs[vq];
-	queue->pfn	= pfn;
-	p		= virtio_get_vq(kvm, queue->pfn, page_size);
 
-	vring_init(&queue->vring, VIRTIO_SCSI_QUEUE_SIZE, p, align);
+	if (pfn) {
+		queue->pfn	= pfn;
+		p		= virtio_get_vq(kvm, queue->pfn, page_size);
+		vring_init(&queue->vring, VIRTIO_SCSI_QUEUE_SIZE, p, align);
+	} else {
+		virtio_adjust_vq(kvm, queue, VIRTIO_SCSI_QUEUE_SIZE);
+	}
 
 	if (sdev->vhost_fd == 0)
 		return 0;
@@ -157,6 +163,13 @@ static int get_pfn_vq(struct kvm *kvm, void *dev, u32 vq)
 	return sdev->vqs[vq].pfn;
 }
 
+static struct virt_queue *get_queue(void *dev, u32 vq)
+{
+	struct scsi_dev *sdev = dev;
+
+	return &sdev->vqs[vq];
+}
+
 static int get_size_vq(struct kvm *kvm, void *dev, u32 vq)
 {
 	return VIRTIO_SCSI_QUEUE_SIZE;
@@ -167,6 +180,11 @@ static int set_size_vq(struct kvm *kvm, void *dev, u32 vq, int size)
 	return size;
 }
 
+static int queue_cnt(struct virtio_device *vdev)
+{
+	return NUM_VIRT_QUEUES;
+}
+
 static struct virtio_ops scsi_dev_virtio_ops = {
 	.get_config		= get_config,
 	.get_host_features	= get_host_features,
@@ -178,6 +196,8 @@ static struct virtio_ops scsi_dev_virtio_ops = {
 	.notify_vq		= notify_vq,
 	.notify_vq_gsi		= notify_vq_gsi,
 	.notify_vq_eventfd	= notify_vq_eventfd,
+	.queue_cnt		= queue_cnt,
+	.get_queue		= get_queue,
 };
 
 static void virtio_scsi_vhost_init(struct kvm *kvm, struct scsi_dev *sdev)
diff --git a/x86/include/kvm/kvm-arch.h b/x86/include/kvm/kvm-arch.h
index 50b3bfb..0b216b9 100644
--- a/x86/include/kvm/kvm-arch.h
+++ b/x86/include/kvm/kvm-arch.h
@@ -28,7 +28,7 @@
 
 #define KVM_VM_TYPE		0
 
-#define VIRTIO_DEFAULT_TRANS(kvm)	VIRTIO_PCI
+#define VIRTIO_DEFAULT_TRANS(kvm) default_transport
 
 struct kvm_arch {
 	u16			boot_selector;
-- 
2.5.0
