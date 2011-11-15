From: Sasha Levin <levinsasha928@gmail.com>
Subject: [RFC] kvm tools: Add support for virtio-mmio
Date: Tue, 15 Nov 2011 18:47:47 +0200
Message-ID: <1321375667-17284-1-git-send-email-levinsasha928__29244.7864696898$1321375853$gmane$org@gmail.com>
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
To: penberg@kernel.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, asias.hejun@gmail.com, virtualization@lists.linux-foundation.org, gorcunov@gmail.com, Sasha Levin <levinsasha928@gmail.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This patch adds support for the new virtio-mmio transport layer added in
3.2-rc1.

The purpose of this new layer is to allow virtio to work on systems which
don't necessarily support PCI, such as embedded systems.

To apply the patch on top of the KVM tools tree, you must first pull Linus'
tree on top. Also, CONFIG_VIRTIO_MMIO=y should be set in the guest kernel.

This is an early RFC, command line currently only supports virtio-net
(although this can be easily extended). ioeventfds and VQ size/align
still unsupported (but will work on x86).

To easily test it it's recommended to apply Pawel Moll's patch named
'virtio-mmio: Devices parameter parsing' on top, and define the virtio-mmio
device using kernel command line.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Sasha Levin <levinsasha928@gmail.com>
---
 tools/kvm/Makefile                   |    1 +
 tools/kvm/builtin-run.c              |    2 +
 tools/kvm/include/kvm/virtio-mmio.h  |   61 ++++++++++++
 tools/kvm/include/kvm/virtio-net.h   |    1 +
 tools/kvm/include/kvm/virtio-trans.h |    1 +
 tools/kvm/virtio/mmio.c              |  177 ++++++++++++++++++++++++++++++++++
 tools/kvm/virtio/net.c               |    8 +-
 tools/kvm/virtio/trans.c             |   11 ++
 8 files changed, 260 insertions(+), 2 deletions(-)
 create mode 100644 tools/kvm/include/kvm/virtio-mmio.h
 create mode 100644 tools/kvm/virtio/mmio.c

diff --git a/tools/kvm/Makefile b/tools/kvm/Makefile
index bb5f6b0..449651c 100644
--- a/tools/kvm/Makefile
+++ b/tools/kvm/Makefile
@@ -84,6 +84,7 @@ OBJS	+= hw/vesa.o
 OBJS	+= hw/i8042.o
 OBJS	+= hw/pci-shmem.o
 OBJS	+= kvm-ipc.o
+OBJS	+= virtio/mmio.o
 
 FLAGS_BFD := $(CFLAGS) -lbfd
 has_bfd := $(call try-cc,$(SOURCE_BFD),$(FLAGS_BFD))
diff --git a/tools/kvm/builtin-run.c b/tools/kvm/builtin-run.c
index 13025db..1701202 100644
--- a/tools/kvm/builtin-run.c
+++ b/tools/kvm/builtin-run.c
@@ -217,6 +217,8 @@ static int set_net_param(struct virtio_net_params *p, const char *param,
 		p->guest_ip = strdup(val);
 	} else if (strcmp(param, "host_ip") == 0) {
 		p->host_ip = strdup(val);
+	} else if (strcmp(param, "virtio_trans") == 0) {
+		p->virtio_trans = strdup(val);
 	}
 
 	return 0;
diff --git a/tools/kvm/include/kvm/virtio-mmio.h b/tools/kvm/include/kvm/virtio-mmio.h
new file mode 100644
index 0000000..1b07df1
--- /dev/null
+++ b/tools/kvm/include/kvm/virtio-mmio.h
@@ -0,0 +1,61 @@
+#ifndef KVM__VIRTIO_MMIO_H
+#define KVM__VIRTIO_MMIO_H
+
+#include "kvm/virtio-trans.h"
+
+#include <linux/types.h>
+#include <linux/virtio_mmio.h>
+
+#define VIRTIO_MMIO_MAX_VQ	3
+#define VIRTIO_MMIO_MAX_CONFIG	1
+
+struct kvm;
+
+struct virtio_mmio_ioevent_param {
+	struct virtio_trans	*vtrans;
+	u32			vq;
+};
+
+struct virtio_mmio_hdr {
+	char	magic[4];
+	u32	version;
+	u32	device_id;
+	u32	vendor_id;
+	u32	host_features;
+	u32	host_features_sel;
+	u64	reserved_1;
+	u32	guest_features;
+	u32	guest_features_sel;
+	u32	guest_page_size;
+	u32	reserved_2;
+	u32	queue_sel;
+	u32	queue_num_max;
+	u32	queue_num;
+	u32	queue_align;
+	u32	queue_pfn;
+	u32	reserved_3[3];
+	u32	queue_notify;
+	u32	reserved_4[3];
+	u32	interrupt_state;
+	u32	interrupt_ack;
+	u32	status;
+};
+
+struct virtio_mmio {
+	u32			addr;
+	void			*dev;
+	struct kvm		*kvm;
+
+	u8			irq;
+	struct virtio_mmio_hdr	hdr;
+	//struct virtio_mmio_ioevent_param ioeventfds[VIRTIO_MMIO_MAX_VQ];
+};
+
+int virtio_mmio__init(struct kvm *kvm, struct virtio_trans *vtrans, void *dev,
+			int device_id, int subsys_id, int class);
+int virtio_mmio__signal_vq(struct kvm *kvm, struct virtio_trans *vtrans, u32 vq);
+int virtio_mmio__signal_config(struct kvm *kvm, struct virtio_trans *vtrans);
+
+struct virtio_trans_ops *virtio_mmio__get_trans_ops(void);
+
+#endif
diff --git a/tools/kvm/include/kvm/virtio-net.h b/tools/kvm/include/kvm/virtio-net.h
index 58ae162..a419dc7 100644
--- a/tools/kvm/include/kvm/virtio-net.h
+++ b/tools/kvm/include/kvm/virtio-net.h
@@ -7,6 +7,7 @@ struct virtio_net_params {
 	const char *guest_ip;
 	const char *host_ip;
 	const char *script;
+	const char *virtio_trans;
 	char guest_mac[6];
 	char host_mac[6];
 	struct kvm *kvm;
diff --git a/tools/kvm/include/kvm/virtio-trans.h b/tools/kvm/include/kvm/virtio-trans.h
index d9f4b95..5e69335 100644
--- a/tools/kvm/include/kvm/virtio-trans.h
+++ b/tools/kvm/include/kvm/virtio-trans.h
@@ -5,6 +5,7 @@
 
 enum virtio_trans_type {
 	VIRTIO_PCI,
+	VIRTIO_MMIO,
 };
 
 struct virtio_trans;
diff --git a/tools/kvm/virtio/mmio.c b/tools/kvm/virtio/mmio.c
new file mode 100644
index 0000000..1449b04
--- /dev/null
+++ b/tools/kvm/virtio/mmio.c
@@ -0,0 +1,177 @@
+#include "kvm/virtio-mmio.h"
+
+#include "kvm/ioport.h"
+#include "kvm/kvm.h"
+#include "kvm/irq.h"
+#include "kvm/virtio.h"
+#include "kvm/ioeventfd.h"
+#include "kvm/virtio-trans.h"
+#include "kvm/virtio-mmio.h"
+#include "kvm/pci.h"
+#include "kvm/virtio-pci-dev.h"
+#include "kvm/util.h"
+
+#include <linux/virtio_mmio.h>
+#include <string.h>
+
+struct virtio_trans_ops *virtio_mmio__get_trans_ops(void)
+{
+	static struct virtio_trans_ops virtio_pci_trans = (struct virtio_trans_ops) {
+		.signal_vq	= virtio_mmio__signal_vq,
+		.signal_config	= virtio_mmio__signal_config,
+		.init		= virtio_mmio__init,
+	};
+	return &virtio_pci_trans;
+};
+
+int virtio_mmio__signal_vq(struct kvm *kvm, struct virtio_trans *vtrans, u32 vq)
+{
+	struct virtio_mmio *vmmio = vtrans->virtio;
+
+	vmmio->hdr.interrupt_state |= VIRTIO_MMIO_INT_VRING;
+	kvm__irq_trigger(vmmio->kvm, vmmio->irq);
+
+	return 0;
+}
+
+int virtio_mmio__signal_config(struct kvm *kvm, struct virtio_trans *vtrans)
+{
+	struct virtio_mmio *vmmio = vtrans->virtio;
+
+	vmmio->hdr.interrupt_state |= VIRTIO_MMIO_INT_CONFIG;
+	kvm__irq_trigger(vmmio->kvm, vmmio->irq);
+
+	return 0;
+}
+
+static void virtio_mmio__device_specific(u64 addr, u8 *data, u32 len, u8 is_write,
+					struct virtio_trans *vtrans)
+{
+	struct virtio_mmio *vmmio = vtrans->virtio;
+	u32 i;
+
+	for (i = 0; i < len; i++) {
+		if (is_write)
+			vtrans->virtio_ops->set_config(vmmio->kvm, vmmio->dev,
+							*(u8 *)data + i, addr + i);
+		else
+			data[i] =
+				vtrans->virtio_ops->get_config(vmmio->kvm, vmmio->dev, addr + i);
+	}
+}
+
+static void virtio_mmio__config_out(u64 addr, void *data, u32 len, struct virtio_trans *vtrans)
+{
+	struct virtio_mmio *vmmio = vtrans->virtio;
+	u32 val = 0;
+
+	switch(addr) {
+	case VIRTIO_MMIO_HOST_FEATURES_SEL:
+	case VIRTIO_MMIO_GUEST_FEATURES_SET:
+	case VIRTIO_MMIO_GUEST_PAGE_SIZE:
+	case VIRTIO_MMIO_QUEUE_SEL:
+	case VIRTIO_MMIO_QUEUE_NUM:
+	case VIRTIO_MMIO_QUEUE_ALIGN:
+	case VIRTIO_MMIO_STATUS:
+		*(u32 *)(((void *)&vmmio->hdr) + addr) = ioport__read32(data);
+		break;
+	case VIRTIO_MMIO_GUEST_FEATURES:
+		if (vmmio->hdr.guest_features_sel == 0) {
+			val = ioport__read32(data);
+			vtrans->virtio_ops->set_guest_features(vmmio->kvm, vmmio->dev, val);
+		}
+		break;
+	case VIRTIO_MMIO_QUEUE_PFN:
+		val = ioport__read32(data);
+		vtrans->virtio_ops->init_vq(vmmio->kvm, vmmio->dev, vmmio->hdr.queue_sel, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_NOTIFY:
+		val = ioport__read32(data);
+		vtrans->virtio_ops->notify_vq(vmmio->kvm, vmmio->dev, val);
+		break;
+	case VIRTIO_MMIO_INTERRUPT_ACK:
+		val = ioport__read32(data);
+		vmmio->hdr.interrupt_state &= ~val;
+		break;
+	};
+}
+
+static void virtio_mmio__config_in(u64 addr, void *data, u32 len, struct virtio_trans *vtrans)
+{
+	struct virtio_mmio *vmmio = vtrans->virtio;
+	u32 val = 0;
+
+	switch(addr) {
+	case VIRTIO_MMIO_MAGIC_VALUE:
+	case VIRTIO_MMIO_DEVICE_ID:
+	case VIRTIO_MMIO_INTERRUPT_STATUS:
+	case VIRTIO_MMIO_STATUS:
+	case VIRTIO_MMIO_VENDOR_ID:
+	case VIRTIO_MMIO_VERSION:
+		ioport__write32(data, *(u32 *)(((void *)&vmmio->hdr) + addr));
+		break;
+	case VIRTIO_MMIO_HOST_FEATURES:
+		if (vmmio->hdr.host_features_sel == 0)
+			val = vtrans->virtio_ops->get_host_features(vmmio->kvm, vmmio->dev);
+		ioport__write32(data, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_PFN:
+		val = vtrans->virtio_ops->get_pfn_vq(vmmio->kvm, vmmio->dev,
+						vmmio->hdr.queue_sel);
+		ioport__write32(data, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_NUM_MAX:
+		val = vtrans->virtio_ops->get_size_vq(vmmio->kvm, vmmio->dev,
+						vmmio->hdr.queue_sel);
+		ioport__write32(data, val);
+		break;
+	}
+}
+
+static void callback_mmio(u64 addr, u8 *data, u32 len, u8 is_write, void *ptr)
+{
+	struct virtio_trans *vtrans = ptr;
+	struct virtio_mmio *vmmio = vtrans->virtio;
+	u32 offset = addr - vmmio->addr;
+
+	if (offset >= VIRTIO_MMIO_CONFIG) {
+		offset -= VIRTIO_MMIO_CONFIG;
+		virtio_mmio__device_specific(offset, data, len, is_write, ptr);
+		return;
+	}
+
+	if (is_write)
+		virtio_mmio__config_out(offset, data, len, ptr);
+	else
+		virtio_mmio__config_in(offset, data, len, ptr);
+}
+
+int virtio_mmio__init(struct kvm *kvm, struct virtio_trans *vtrans, void *dev,
+			int device_id, int subsys_id, int class)
+{
+	struct virtio_mmio *vmmio = vtrans->virtio;
+	u8 pin, ndev, line;
+
+	vmmio->dev = dev;
+	vmmio->addr = pci_get_io_space_block(PCI_IO_SIZE * 2);
+	vmmio->kvm = kvm;
+
+	kvm__register_mmio(kvm, vmmio->addr, PCI_IO_SIZE * 2, callback_mmio, vtrans);
+
+	vmmio->hdr = (struct virtio_mmio_hdr) {
+		.magic		= {'v', 'i', 'r', 't'},
+		.version	= 1,
+		.device_id	= device_id - 0x1000 + 1,
+		.vendor_id	= PCI_VENDOR_ID_REDHAT_QUMRANET,
+		.queue_num_max	= 256,
+	};
+
+	if (irq__register_device(subsys_id, &ndev, &pin, &line) < 0)
+		return -1;
+
+	pr_info("virtio-net assigned addr: %x - %x line: %d\n", vmmio->addr,
+				vmmio->addr + 0x200, line);
+	vmmio->irq = line;
+
+	return 0;
+}
diff --git a/tools/kvm/virtio/net.c b/tools/kvm/virtio/net.c
index cee2b5b..cfaab8c 100644
--- a/tools/kvm/virtio/net.c
+++ b/tools/kvm/virtio/net.c
@@ -26,7 +26,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
-#define VIRTIO_NET_QUEUE_SIZE		128
+#define VIRTIO_NET_QUEUE_SIZE		256
 #define VIRTIO_NET_NUM_QUEUES		2
 #define VIRTIO_NET_RX_QUEUE		0
 #define VIRTIO_NET_TX_QUEUE		1
@@ -410,7 +410,11 @@ void virtio_net__init(const struct virtio_net_params *params)
 		ndev->ops = &uip_ops;
 	}
 
-	virtio_trans_init(&ndev->vtrans, VIRTIO_PCI);
+	if (params->virtio_trans &&
+		strcmp(params->virtio_trans, "mmio") == 0)
+		virtio_trans_init(&ndev->vtrans, VIRTIO_MMIO);
+	else
+		virtio_trans_init(&ndev->vtrans, VIRTIO_PCI);
 	ndev->vtrans.trans_ops->init(kvm, &ndev->vtrans, ndev, PCI_DEVICE_ID_VIRTIO_NET,
 					VIRTIO_ID_NET, PCI_CLASS_NET);
 	ndev->vtrans.virtio_ops = &net_dev_virtio_ops;
diff --git a/tools/kvm/virtio/trans.c b/tools/kvm/virtio/trans.c
index 50c206d..60dbe88 100644
--- a/tools/kvm/virtio/trans.c
+++ b/tools/kvm/virtio/trans.c
@@ -1,6 +1,7 @@
 #include "kvm/virtio-trans.h"
 
 #include "kvm/virtio-pci.h"
+#include "kvm/virtio-mmio.h"
 #include "kvm/util.h"
 
 #include <stdlib.h>
@@ -16,7 +17,17 @@ int virtio_trans_init(struct virtio_trans *vtrans, enum virtio_trans_type type)
 			die("Failed allocating virtio transport");
 		vtrans->virtio = trans;
 		vtrans->trans_ops = virtio_pci__get_trans_ops();
+		break;
+	case VIRTIO_MMIO:
+		trans = calloc(sizeof(struct virtio_mmio), 1);
+		if (!trans)
+			die("Failed allocating virtio transport");
+		vtrans->virtio = trans;
+		vtrans->trans_ops = virtio_mmio__get_trans_ops();
+		break;
 	default:
 		return -1;
 	};
+
+	return 0;
 }
\ No newline at end of file
-- 
1.7.8.rc1
