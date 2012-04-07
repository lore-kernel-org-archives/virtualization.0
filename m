From: Asias He <asias.hejun@gmail.com>
Subject: [PATCH 05/14] kvm tools: Add virtio-mmio support
Date: Sun,  8 Apr 2012 07:52:49 +0800
Message-ID: <1333842778-4349-5-git-send-email-asias__48206.0345508673$1333842874$gmane$org@redhat.com>
References: <1333842778-4349-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1333842778-4349-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org, Cyrill Gorcunov <gorcunov@gmail.com>, Sasha Levin <levinsasha928@gmail.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

From: Asias He <asias.hejun@gmail.com>

This patch is based on Sasha's 'kvm tools: Add support for virtio-mmio'
patch. ioeventfds support is added which was missing in the previous one.
VQ size/align is still not supported.

It adds support for the new virtio-mmio transport layer added in
3.2-rc1. The purpose of this new layer is to allow virtio to work on
systems which don't necessarily support PCI, such as embedded systems.

To apply the patch on top of the KVM tools tree, you must first pull
Linus' tree on top. Also, CONFIG_VIRTIO_MMIO=y should be set in the
guest kernel.

To easily test it it's recommended to apply Pawel Moll's patch named
'virtio-mmio: Devices parameter parsing' on top, and define the
virtio-mmio device using kernel command line.

LKVM will print a message to help user to figure out how to add kernel
command line to support virtio-mmio.

To instantiate guest virtio-mmio devices using kernel command line (or
module) parameter, e.g.

   virtio_mmio.devices=0x200@0xd2000000:5,0x200@0xd2000200:6

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Sasha Levin <levinsasha928@gmail.com>
Signed-off-by: Asias He <asias.hejun@gmail.com>
---
 tools/kvm/Makefile                  |    1 +
 tools/kvm/include/kvm/virtio-mmio.h |   58 ++++++++
 tools/kvm/virtio/mmio.c             |  256 +++++++++++++++++++++++++++++++++++
 3 files changed, 315 insertions(+), 0 deletions(-)
 create mode 100644 tools/kvm/include/kvm/virtio-mmio.h
 create mode 100644 tools/kvm/virtio/mmio.c

diff --git a/tools/kvm/Makefile b/tools/kvm/Makefile
index 38d4788..376990b 100644
--- a/tools/kvm/Makefile
+++ b/tools/kvm/Makefile
@@ -86,6 +86,7 @@ OBJS	+= hw/vesa.o
 OBJS	+= hw/pci-shmem.o
 OBJS	+= kvm-ipc.o
 OBJS	+= builtin-sandbox.o
+OBJS	+= virtio/mmio.o
 
 # Additional ARCH settings for x86
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ \
diff --git a/tools/kvm/include/kvm/virtio-mmio.h b/tools/kvm/include/kvm/virtio-mmio.h
new file mode 100644
index 0000000..e0ede3c
--- /dev/null
+++ b/tools/kvm/include/kvm/virtio-mmio.h
@@ -0,0 +1,58 @@
+#ifndef KVM__VIRTIO_MMIO_H
+#define KVM__VIRTIO_MMIO_H
+
+#include <linux/types.h>
+#include <linux/virtio_mmio.h>
+
+#define VIRTIO_MMIO_MAX_VQ	3
+#define VIRTIO_MMIO_MAX_CONFIG	1
+#define VIRTIO_MMIO_IO_SIZE	0x200
+
+struct kvm;
+
+struct virtio_mmio_ioevent_param {
+	struct virtio_device	*vdev;
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
+	u32	reserved_1[2];
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
+	u32	reserved_5[2];
+	u32	status;
+} __attribute__((packed));
+
+struct virtio_mmio {
+	u32			addr;
+	void			*dev;
+	struct kvm		*kvm;
+	u8			irq;
+	struct virtio_mmio_hdr	hdr;
+	struct virtio_mmio_ioevent_param ioeventfds[VIRTIO_MMIO_MAX_VQ];
+};
+
+int virtio_mmio_signal_vq(struct kvm *kvm, struct virtio_device *vdev, u32 vq);
+int virtio_mmio_signal_config(struct kvm *kvm, struct virtio_device *vdev);
+int virtio_mmio_exit(struct kvm *kvm, struct virtio_device *vdev);
+int virtio_mmio_init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
+		      int device_id, int subsys_id, int class);
+#endif
diff --git a/tools/kvm/virtio/mmio.c b/tools/kvm/virtio/mmio.c
new file mode 100644
index 0000000..8319954
--- /dev/null
+++ b/tools/kvm/virtio/mmio.c
@@ -0,0 +1,256 @@
+#include "kvm/virtio-mmio.h"
+#include "kvm/ioeventfd.h"
+#include "kvm/ioport.h"
+#include "kvm/virtio.h"
+#include "kvm/kvm.h"
+#include "kvm/irq.h"
+
+#include <linux/virtio_mmio.h>
+#include <string.h>
+
+static u32 virtio_mmio_io_space_blocks = KVM_VIRTIO_MMIO_AREA;
+
+static u32 virtio_mmio_get_io_space_block(u32 size)
+{
+	u32 block = virtio_mmio_io_space_blocks;
+	virtio_mmio_io_space_blocks += size;
+
+	return block;
+}
+
+static void virtio_mmio_ioevent_callback(struct kvm *kvm, void *param)
+{
+	struct virtio_mmio_ioevent_param *ioeventfd = param;
+	struct virtio_mmio *vmmio = ioeventfd->vdev->virtio;
+
+	ioeventfd->vdev->ops->notify_vq(kvm, vmmio->dev, ioeventfd->vq);
+}
+
+static int virtio_mmio_init_ioeventfd(struct kvm *kvm,
+				      struct virtio_device *vdev, u32 vq)
+{
+	struct virtio_mmio *vmmio = vdev->virtio;
+	struct ioevent ioevent;
+	int err;
+
+	vmmio->ioeventfds[vq] = (struct virtio_mmio_ioevent_param) {
+		.vdev		= vdev,
+		.vq		= vq,
+	};
+
+	ioevent = (struct ioevent) {
+		.io_addr	= vmmio->addr + VIRTIO_MMIO_QUEUE_NOTIFY,
+		.io_len		= sizeof(u32),
+		.fn		= virtio_mmio_ioevent_callback,
+		.fn_ptr		= &vmmio->ioeventfds[vq],
+		.datamatch	= vq,
+		.fn_kvm		= kvm,
+		.fd		= eventfd(0, 0),
+	};
+
+	err = ioeventfd__add_event(&ioevent, false);
+	if (err)
+		return err;
+
+	if (vdev->ops->notify_vq_eventfd)
+		vdev->ops->notify_vq_eventfd(kvm, vmmio->dev, vq, ioevent.fd);
+
+	return 0;
+}
+
+int virtio_mmio_signal_vq(struct kvm *kvm, struct virtio_device *vdev, u32 vq)
+{
+	struct virtio_mmio *vmmio = vdev->virtio;
+
+	vmmio->hdr.interrupt_state |= VIRTIO_MMIO_INT_VRING;
+	kvm__irq_trigger(vmmio->kvm, vmmio->irq);
+
+	return 0;
+}
+
+int virtio_mmio_signal_config(struct kvm *kvm, struct virtio_device *vdev)
+{
+	struct virtio_mmio *vmmio = vdev->virtio;
+
+	vmmio->hdr.interrupt_state |= VIRTIO_MMIO_INT_CONFIG;
+	kvm__irq_trigger(vmmio->kvm, vmmio->irq);
+
+	return 0;
+}
+
+static void virtio_mmio_device_specific(u64 addr, u8 *data, u32 len,
+					u8 is_write, struct virtio_device *vdev)
+{
+	struct virtio_mmio *vmmio = vdev->virtio;
+	u32 i;
+
+	for (i = 0; i < len; i++) {
+		if (is_write)
+			vdev->ops->set_config(vmmio->kvm, vmmio->dev,
+					      *(u8 *)data + i, addr + i);
+		else
+			data[i] = vdev->ops->get_config(vmmio->kvm,
+							vmmio->dev, addr + i);
+	}
+}
+
+static void virtio_mmio_config_in(u64 addr, void *data, u32 len,
+				  struct virtio_device *vdev)
+{
+	struct virtio_mmio *vmmio = vdev->virtio;
+	u32 val = 0;
+
+	switch (addr) {
+	case VIRTIO_MMIO_MAGIC_VALUE:
+	case VIRTIO_MMIO_VERSION:
+	case VIRTIO_MMIO_DEVICE_ID:
+	case VIRTIO_MMIO_VENDOR_ID:
+	case VIRTIO_MMIO_STATUS:
+	case VIRTIO_MMIO_INTERRUPT_STATUS:
+		ioport__write32(data, *(u32 *)(((void *)&vmmio->hdr) + addr));
+		break;
+	case VIRTIO_MMIO_HOST_FEATURES:
+		if (vmmio->hdr.host_features_sel == 0)
+			val = vdev->ops->get_host_features(vmmio->kvm,
+							   vmmio->dev);
+		ioport__write32(data, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_PFN:
+		val = vdev->ops->get_pfn_vq(vmmio->kvm, vmmio->dev,
+					    vmmio->hdr.queue_sel);
+		ioport__write32(data, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_NUM_MAX:
+		val = vdev->ops->get_size_vq(vmmio->kvm, vmmio->dev,
+					     vmmio->hdr.queue_sel);
+		ioport__write32(data, val);
+		break;
+	default:
+		break;
+	}
+}
+
+static void virtio_mmio_config_out(u64 addr, void *data, u32 len,
+				   struct virtio_device *vdev)
+{
+	struct virtio_mmio *vmmio = vdev->virtio;
+	u32 val = 0;
+
+	switch (addr) {
+	case VIRTIO_MMIO_HOST_FEATURES_SEL:
+	case VIRTIO_MMIO_GUEST_FEATURES_SEL:
+	case VIRTIO_MMIO_QUEUE_SEL:
+	case VIRTIO_MMIO_STATUS:
+		val = ioport__read32(data);
+		*(u32 *)(((void *)&vmmio->hdr) + addr) = val;
+		break;
+	case VIRTIO_MMIO_GUEST_FEATURES:
+		if (vmmio->hdr.guest_features_sel == 0) {
+			val = ioport__read32(data);
+			vdev->ops->set_guest_features(vmmio->kvm,
+						      vmmio->dev, val);
+		}
+		break;
+	case VIRTIO_MMIO_GUEST_PAGE_SIZE:
+		val = ioport__read32(data);
+		vmmio->hdr.guest_page_size = val;
+		/* FIXME: set guest page size */
+		break;
+	case VIRTIO_MMIO_QUEUE_NUM:
+		val = ioport__read32(data);
+		vmmio->hdr.queue_num = val;
+		/* FIXME: set vq size */
+		vdev->ops->set_size_vq(vmmio->kvm, vmmio->dev,
+				       vmmio->hdr.queue_sel, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_ALIGN:
+		val = ioport__read32(data);
+		vmmio->hdr.queue_align = val;
+		/* FIXME: set used ring alignment */
+		break;
+	case VIRTIO_MMIO_QUEUE_PFN:
+		val = ioport__read32(data);
+		virtio_mmio_init_ioeventfd(vmmio->kvm, vdev, vmmio->hdr.queue_sel);
+		vdev->ops->init_vq(vmmio->kvm, vmmio->dev,
+				   vmmio->hdr.queue_sel, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_NOTIFY:
+		val = ioport__read32(data);
+		vdev->ops->notify_vq(vmmio->kvm, vmmio->dev, val);
+		break;
+	case VIRTIO_MMIO_INTERRUPT_ACK:
+		val = ioport__read32(data);
+		vmmio->hdr.interrupt_state &= ~val;
+		break;
+	default:
+		break;
+	};
+}
+
+static void virtio_mmio_mmio_callback(u64 addr, u8 *data, u32 len,
+				      u8 is_write, void *ptr)
+{
+	struct virtio_device *vdev = ptr;
+	struct virtio_mmio *vmmio = vdev->virtio;
+	u32 offset = addr - vmmio->addr;
+
+	if (offset >= VIRTIO_MMIO_CONFIG) {
+		offset -= VIRTIO_MMIO_CONFIG;
+		virtio_mmio_device_specific(offset, data, len, is_write, ptr);
+		return;
+	}
+
+	if (is_write)
+		virtio_mmio_config_out(offset, data, len, ptr);
+	else
+		virtio_mmio_config_in(offset, data, len, ptr);
+}
+
+int virtio_mmio_init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
+		     int device_id, int subsys_id, int class)
+{
+	struct virtio_mmio *vmmio = vdev->virtio;
+	u8 device, pin, line;
+
+	vmmio->addr	= virtio_mmio_get_io_space_block(VIRTIO_MMIO_IO_SIZE);
+	vmmio->kvm	= kvm;
+	vmmio->dev	= dev;
+
+	kvm__register_mmio(kvm, vmmio->addr, VIRTIO_MMIO_IO_SIZE,
+			   false, virtio_mmio_mmio_callback, vdev);
+
+	vmmio->hdr = (struct virtio_mmio_hdr) {
+		.magic		= {'v', 'i', 'r', 't'},
+		.version	= 1,
+		.device_id	= device_id - 0x1000 + 1,
+		.vendor_id	= 0x4d564b4c , /* 'LKVM' */
+		.queue_num_max	= 256,
+	};
+
+	if (irq__register_device(subsys_id, &device, &pin, &line) < 0)
+		return -1;
+	vmmio->irq = line;
+
+	/*
+	 * Instantiate guest virtio-mmio devices using kernel command line
+	 * (or module) parameter, e.g
+	 *
+	 * virtio_mmio.devices=0x200@0xd2000000:5,0x200@0xd2000200:6
+	 */
+	pr_info("virtio-mmio.devices=0x%x@0x%x:%d\n", VIRTIO_MMIO_IO_SIZE, vmmio->addr, line);
+
+	return 0;
+}
+
+int virtio_mmio_exit(struct kvm *kvm, struct virtio_device *vdev)
+{
+	struct virtio_mmio *vmmio = vdev->virtio;
+	int i;
+
+	kvm__deregister_mmio(kvm, vmmio->addr);
+
+	for (i = 0; i < VIRTIO_MMIO_MAX_VQ; i++)
+		ioeventfd__del_event(vmmio->addr + VIRTIO_MMIO_QUEUE_NOTIFY, i);
+
+	return 0;
+}
-- 
1.7.7.6
