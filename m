From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv4 6/6] qemu-kvm: vhost-net implementation
Date: Tue, 3 Nov 2009 00:24:33 +0200
Message-ID: <20091102222433.GG15153__24406.566276639$1257200937$gmane$org@redhat.com>
References: <cover.1257200517.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1257200517.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This adds support for vhost-net virtio kernel backend.

This patch is not intended to being merged yet.
I'm posting it for the benefit of people testing
the backend.

Usage instructions:
vhost currently requires MSI-X support in guest virtio.
This means guests kernel version should be >= 2.6.31.

To enable vhost, simply add ",vhost" flag to nic options.
Example with tap backend:
qemu-system-x86_64 -m 1G disk-c.qcow2 \
-net tap,ifname=msttap0,script=/home/mst/ifup,downscript=no \
 -net nic,model=virtio,vhost

Example with raw socket backend:
ifconfig eth3 promisc
qemu-system-x86_64 -m 1G disk-c.qcow2 \
-net raw,ifname=eth3 \
 -net nic,model=virtio,vhost

This patchset is RFC, but works without issues for me.

TODO:
    * migration support
    * level triggered interrupts
    * fix driver unloading/hotplug
    * general cleanup and upstreaming

It still needs to be split up, tested and benchmarked properly,
but posting it here in case people want to test drive
the kernel bits I posted.

Some further info, performance etc:
	http://www.linux-kvm.org/page/VhostNet

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Makefile.target           |    3 +-
 hw/vhost_net.c            |  251 +++++++++++++++++++++++++++++++++++++++++++++
 hw/vhost_net.h            |   38 +++++++
 hw/virtio-net.c           |   67 ++++++++++--
 hw/virtio-pci.c           |   40 +++++++
 hw/virtio.c               |   19 ----
 hw/virtio.h               |   28 +++++-
 kvm/include/linux/vhost.h |  126 +++++++++++++++++++++++
 net.c                     |    7 ++
 net.h                     |    1 +
 qemu-kvm.c                |    8 --
 qemu-kvm.h                |    9 ++
 12 files changed, 555 insertions(+), 42 deletions(-)
 create mode 100644 hw/vhost_net.c
 create mode 100644 hw/vhost_net.h
 create mode 100644 kvm/include/linux/vhost.h

diff --git a/Makefile.target b/Makefile.target
index acee285..0d8e688 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -160,7 +160,8 @@ obj-y = vl.o monitor.o pci.o isa_mmio.o machine.o \
         gdbstub.o gdbstub-xml.o
 # virtio has to be here due to weird dependency between PCI and virtio-net.
 # need to fix this properly
-obj-y += virtio-blk.o virtio-balloon.o virtio-net.o virtio-console.o virtio-pci.o
+obj-y += virtio-blk.o virtio-balloon.o virtio-net.o virtio-console.o virtio-pci.o \
+	vhost_net.o
 obj-$(CONFIG_KVM) += kvm.o kvm-all.o
 # MSI-X depends on kvm for interrupt injection,
 # so moved it from Makefile.hw to Makefile.target for now
diff --git a/hw/vhost_net.c b/hw/vhost_net.c
new file mode 100644
index 0000000..bc179ab
--- /dev/null
+++ b/hw/vhost_net.c
@@ -0,0 +1,251 @@
+#include <sys/eventfd.h>
+#include <sys/socket.h>
+#include <linux/kvm.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <linux/vhost.h>
+#include <linux/virtio_ring.h>
+#include <netpacket/packet.h>
+#include <net/ethernet.h>
+#include <net/if.h>
+#include <netinet/in.h>
+
+#include <stdio.h>
+
+#include "net.h"
+#include "qemu-kvm.h"
+
+#include "vhost_net.h"
+
+static int vhost_virtqueue_init(struct vhost_dev *dev,
+				struct VirtIODevice *vdev,
+				struct vhost_virtqueue *vq,
+				struct VirtQueue *q,
+				unsigned idx)
+{
+	target_phys_addr_t s, l;
+	int r;
+	struct vhost_vring_addr addr = {
+		.index = idx,
+	};
+	struct vhost_vring_file file = {
+		.index = idx,
+	};
+	struct vhost_vring_state size = {
+		.index = idx,
+	};
+
+	size.num = q->vring.num;
+	r = ioctl(dev->control, VHOST_SET_VRING_NUM, &size);
+	if (r)
+		return -errno;
+
+	file.fd = vq->kick = eventfd(0, 0);
+	r = ioctl(dev->control, VHOST_SET_VRING_KICK, &file);
+	if (r)
+		return -errno;
+	file.fd = vq->call = eventfd(0, 0);
+	r = ioctl(dev->control, VHOST_SET_VRING_CALL, &file);
+	if (r)
+		return -errno;
+
+	s = l = sizeof(struct vring_desc) * q->vring.num;
+	vq->desc = cpu_physical_memory_map(q->vring.desc, &l, 0);
+	if (!vq->desc || l != s)
+		return -ENOMEM;
+	addr.user_addr = (u_int64_t)(unsigned long)vq->desc;
+	r = ioctl(dev->control, VHOST_SET_VRING_DESC, &addr);
+	if (r < 0)
+		return -errno;
+	s = l = offsetof(struct vring_avail, ring) +
+		sizeof(u_int64_t) * q->vring.num;
+	vq->avail = cpu_physical_memory_map(q->vring.avail, &l, 0);
+	if (!vq->avail || l != s)
+		return -ENOMEM;
+	addr.user_addr = (u_int64_t)(unsigned long)vq->avail;
+	r = ioctl(dev->control, VHOST_SET_VRING_AVAIL, &addr);
+	if (r < 0)
+		return -errno;
+	s = l = offsetof(struct vring_used, ring) +
+		sizeof(struct vring_used_elem) * q->vring.num;
+	vq->used = cpu_physical_memory_map(q->vring.used, &l, 1);
+	if (!vq->used || l != s)
+		return -ENOMEM;
+	addr.user_addr = (u_int64_t)(unsigned long)vq->used;
+	r = ioctl(dev->control, VHOST_SET_VRING_USED, &addr);
+	if (r < 0)
+		return -errno;
+
+        r = vdev->binding->irqfd(vdev->binding_opaque, q->vector, vq->call);
+        if (r < 0)
+            return -errno;
+
+        r = vdev->binding->queuefd(vdev->binding_opaque, idx, vq->kick);
+        if (r < 0)
+            return -errno;
+
+	return 0;
+}
+
+static int vhost_dev_init(struct vhost_dev *hdev)
+{
+	uint64_t features;
+	int r;
+	hdev->control = open("/dev/vhost-net", O_RDWR);
+	if (hdev->control < 0)
+		return -errno;
+	r = ioctl(hdev->control, VHOST_SET_OWNER, NULL);
+	if (r < 0)
+		return -errno;
+
+	r = ioctl(hdev->control, VHOST_GET_FEATURES, &features);
+	if (r < 0)
+		return -errno;
+	hdev->features = features;
+	return 0;
+}
+
+static void vhost_dev_cleanup(struct vhost_dev *hdev)
+{
+	close(hdev->control);
+}
+
+static int vhost_dev_start(struct vhost_dev *hdev,
+			   VirtIODevice *vdev)
+{
+	int i, r, n = 0;
+	struct vhost_memory *mem;
+
+	r = ioctl(hdev->control, VHOST_ACK_FEATURES, &hdev->acked_features);
+	if (r < 0)
+		return -errno;
+
+	for (i = 0; i < KVM_MAX_NUM_MEM_REGIONS; ++i) {
+		if (!slots[i].len || (slots[i].flags & KVM_MEM_LOG_DIRTY_PAGES)) {
+			continue;
+		}
+		++n;
+	}
+
+	mem = qemu_mallocz(offsetof(struct vhost_memory, regions) +
+			   n * sizeof(struct vhost_memory_region));
+	if (!mem)
+		return -ENOMEM;
+	mem->nregions = n;
+	n = 0;
+	for (i = 0; i < KVM_MAX_NUM_MEM_REGIONS; ++i) {
+		if (!slots[i].len || (slots[i].flags & KVM_MEM_LOG_DIRTY_PAGES)) {
+			continue;
+		}
+		mem->regions[n].guest_phys_addr = slots[i].phys_addr;
+		mem->regions[n].memory_size = slots[i].len;
+		mem->regions[n].userspace_addr = slots[i].userspace_addr;
+		++n;
+	}
+
+	r = ioctl(hdev->control, VHOST_SET_MEM_TABLE, mem);
+	if (r < 0)
+		return -errno;
+
+	for (i = 0; i < hdev->nvqs; ++i) {
+		r = vhost_virtqueue_init(hdev,
+		   			 vdev,
+					 hdev->vqs + i,
+					 vdev->vq + i,
+					 i);
+		if (r < 0)
+			return r;
+	}
+
+	return 0;
+}
+
+unsigned vhost_net_get_features(struct vhost_net *net)
+{
+	unsigned features = 0;
+	if (net->dev.features & (1 << VIRTIO_F_NOTIFY_ON_EMPTY))
+		features |= VIRTIO_F_NOTIFY_ON_EMPTY;
+	if (net->dev.features & (1 << VIRTIO_RING_F_INDIRECT_DESC))
+		features |= VIRTIO_RING_F_INDIRECT_DESC;
+	return features;
+}
+
+void vhost_net_ack_features(struct vhost_net *net, unsigned features)
+{
+	net->dev.acked_features = net->dev.backend_features;
+	if (features & (1 << VIRTIO_F_NOTIFY_ON_EMPTY))
+		net->dev.acked_features |= VIRTIO_F_NOTIFY_ON_EMPTY;
+	if (features & (1 << VIRTIO_RING_F_INDIRECT_DESC))
+		net->dev.acked_features |= VIRTIO_RING_F_INDIRECT_DESC;
+}
+
+static int vhost_net_get_fd(VLANClientState *backend,
+			    unsigned long long *backend_features)
+{
+	int r;
+	r = raw_get_fd(backend);
+	if (r >= 0) {
+		*backend_features = (1 << VHOST_NET_F_VIRTIO_NET_HDR);
+		return r;
+	}
+	r = tap_get_fd(backend);
+	if (r >= 0) {
+		*backend_features = 0;
+		return r;
+	}
+	fprintf(stderr, "vhost requires raw socket or tap backend\n");
+	return -EBADFD;
+}
+
+int vhost_net_init(struct vhost_net *net, VLANClientState *backend)
+{
+	int r;
+
+	if (!backend) {
+		fprintf(stderr, "vhost requires backend to be setup\n");
+		return -EINVAL;
+	}
+	r = vhost_net_get_fd(backend, &net->dev.backend_features);
+	if (r < 0)
+		return r;
+	net->backend = r;
+
+	r = vhost_dev_init(&net->dev);
+	if (r < 0)
+		return r;
+	if (~net->dev.features & net->dev.backend_features) {
+		fprintf(stderr, "vhost lacks feature mask %llu for backend\n",
+			~net->dev.features & net->dev.backend_features);
+		vhost_dev_cleanup(&net->dev);
+		return -EINVAL;
+	}
+
+	/* Set sane init value. Override when guest acks. */
+	vhost_net_ack_features(net, 0);
+	return 0;
+}
+
+int vhost_net_start(struct vhost_net *net,
+		    VirtIODevice *dev)
+{
+	struct vhost_vring_file file = { };
+	int r;
+
+	net->dev.nvqs = 2;
+	net->dev.vqs = net->vqs;
+	r = vhost_dev_start(&net->dev, dev);
+	if (r < 0)
+		return r;
+
+	/* Stop polling backend from qemu. */
+	qemu_set_fd_handler(net->backend, NULL, NULL, NULL);
+	file.fd = net->backend;
+	for (file.index = 0; file.index < net->dev.nvqs; ++file.index) {
+		r = ioctl(net->dev.control, VHOST_NET_SET_BACKEND, &file);
+		if (r < 0) {
+			/* TODO: cleanup on error. */
+			return -errno;
+		}
+	}
+	return 0;
+}
diff --git a/hw/vhost_net.h b/hw/vhost_net.h
new file mode 100644
index 0000000..65720e1
--- /dev/null
+++ b/hw/vhost_net.h
@@ -0,0 +1,38 @@
+#ifndef VHOST_NET_H
+#define VHOST_NET_H
+
+#include "hw/virtio.h"
+
+struct vhost_virtqueue {
+	int kick;
+	int call;
+	void *desc;
+	void *avail;
+	void *used;
+};
+
+struct vhost_dev {
+	int control;
+	struct vhost_virtqueue *vqs;
+	int nvqs;
+	unsigned long long features;
+	unsigned long long acked_features;
+	unsigned long long backend_features;
+};
+
+struct vhost_net {
+	struct vhost_dev dev;
+	struct vhost_virtqueue vqs[2];
+	int backend;
+};
+
+int vhost_net_init(struct vhost_net *net,
+		   VLANClientState *backend);
+
+int vhost_net_start(struct vhost_net *net,
+		   VirtIODevice *dev);
+
+unsigned vhost_net_get_features(struct vhost_net *net);
+void vhost_net_ack_features(struct vhost_net *net, unsigned features);
+
+#endif
diff --git a/hw/virtio-net.c b/hw/virtio-net.c
index 2e51a6a..3b0b947 100644
--- a/hw/virtio-net.c
+++ b/hw/virtio-net.c
@@ -19,6 +19,8 @@
 #include "qemu-kvm.h"
 #endif
 
+#include "vhost_net.h"
+
 #define TAP_VNET_HDR
 
 #define VIRTIO_NET_VM_VERSION    10
@@ -56,6 +58,8 @@ typedef struct VirtIONet
         uint8_t *macs;
     } mac_table;
     uint32_t *vlans;
+    int vhost_device;
+    struct vhost_net vhost;
 } VirtIONet;
 
 /* TODO
@@ -127,16 +131,10 @@ static void virtio_net_reset(VirtIODevice *vdev)
 
 static uint32_t virtio_net_get_features(VirtIODevice *vdev)
 {
-    uint32_t features = (1 << VIRTIO_NET_F_MAC) |
-                        (1 << VIRTIO_NET_F_MRG_RXBUF) |
-                        (1 << VIRTIO_NET_F_STATUS) |
-                        (1 << VIRTIO_NET_F_CTRL_VQ) |
-                        (1 << VIRTIO_NET_F_CTRL_RX) |
-                        (1 << VIRTIO_NET_F_CTRL_VLAN) |
-                        (1 << VIRTIO_NET_F_CTRL_RX_EXTRA);
+    uint32_t features = 0;
+    VirtIONet *n = to_virtio_net(vdev);
 
 #ifdef TAP_VNET_HDR
-    VirtIONet *n = to_virtio_net(vdev);
     VLANClientState *host = n->vc->vlan->first_client;
 
     if (tap_has_vnet_hdr(host)) {
@@ -149,12 +147,23 @@ static uint32_t virtio_net_get_features(VirtIODevice *vdev)
         features |= (1 << VIRTIO_NET_F_HOST_TSO4);
         features |= (1 << VIRTIO_NET_F_HOST_TSO6);
         features |= (1 << VIRTIO_NET_F_HOST_ECN);
-        features |= (1 << VIRTIO_NET_F_MRG_RXBUF);
         /* Kernel can't actually handle UFO in software currently. */
     }
 #endif
 
-    return features | virtio_common_features();
+    if (n->vhost_device)
+	features |= (1 << VIRTIO_NET_F_MAC) | vhost_net_get_features(&n->vhost);
+    else
+	features |= virtio_common_features() |
+			(1 << VIRTIO_NET_F_MAC) |
+                        (1 << VIRTIO_NET_F_MRG_RXBUF) |
+                        (1 << VIRTIO_NET_F_STATUS) |
+                        (1 << VIRTIO_NET_F_CTRL_VQ) |
+                        (1 << VIRTIO_NET_F_CTRL_RX) |
+                        (1 << VIRTIO_NET_F_CTRL_VLAN) |
+                        (1 << VIRTIO_NET_F_CTRL_RX_EXTRA);
+
+    return features;
 }
 
 static uint32_t virtio_net_bad_features(VirtIODevice *vdev)
@@ -175,11 +184,15 @@ static uint32_t virtio_net_bad_features(VirtIODevice *vdev)
 static void virtio_net_set_features(VirtIODevice *vdev, uint32_t features)
 {
     VirtIONet *n = to_virtio_net(vdev);
+    /* vhost net supports no features */
 #ifdef TAP_VNET_HDR
     VLANClientState *host = n->vc->vlan->first_client;
 #endif
 
     n->mergeable_rx_bufs = !!(features & (1 << VIRTIO_NET_F_MRG_RXBUF));
+    if (n->vhost_device) {
+        vhost_net_ack_features(&n->vhost, features);
+    }
 
 #ifdef TAP_VNET_HDR
     if (!tap_has_vnet_hdr(host) || !host->set_offload)
@@ -351,6 +364,9 @@ static void virtio_net_handle_rx(VirtIODevice *vdev, VirtQueue *vq)
 
 static int do_virtio_net_can_receive(VirtIONet *n, int bufsize)
 {
+    if (n->vhost_device)
+	    return 0;
+
     if (!virtio_queue_ready(n->rx_vq) ||
         !(n->vdev.status & VIRTIO_CONFIG_S_DRIVER_OK))
         return 0;
@@ -411,6 +427,7 @@ static int iov_fill(struct iovec *iov, int iovcnt, const void *buf, int count)
     while (offset < count && i < iovcnt) {
         int len = MIN(iov[i].iov_len, count - offset);
         memcpy(iov[i].iov_base, buf + offset, len);
+	
         offset += len;
         i++;
     }
@@ -611,6 +628,8 @@ static void virtio_net_flush_tx(VirtIONet *n, VirtQueue *vq)
 #else
     int has_vnet_hdr = 0;
 #endif
+    if (n->vhost_device)
+	    return;
 
     if (!(n->vdev.status & VIRTIO_CONFIG_S_DRIVER_OK))
         return;
@@ -810,6 +829,8 @@ static void virtio_net_cleanup(VLANClientState *vc)
 {
     VirtIONet *n = vc->opaque;
 
+    /* TODO: vhost device cleanup */
+
     qemu_purge_queued_packets(vc);
 
     unregister_savevm("virtio-net", n);
@@ -823,6 +844,21 @@ static void virtio_net_cleanup(VLANClientState *vc)
     virtio_cleanup(&n->vdev);
 }
 
+static void virtio_net_driver_ok(VirtIODevice *vdev)
+{
+    VirtIONet *n = to_virtio_net(vdev);
+    int r;
+
+    if (!n->vhost_device)
+        return;
+
+    r = vhost_net_start(&n->vhost, vdev);
+    if (r) {
+	fprintf(stderr, "\nvhost_net_init returned %d\n", r);
+	exit(-r);
+    }
+}
+
 VirtIODevice *virtio_net_init(DeviceState *dev)
 {
     VirtIONet *n;
@@ -831,6 +867,15 @@ VirtIODevice *virtio_net_init(DeviceState *dev)
     n = (VirtIONet *)virtio_common_init("virtio-net", VIRTIO_ID_NET,
                                         sizeof(struct virtio_net_config),
                                         sizeof(VirtIONet));
+    n->vhost_device = dev->nd->vhost_device;
+    if (n->vhost_device) {
+            int r = vhost_net_init(&n->vhost, dev->nd->vlan->first_client);
+            if (r) {
+                fprintf(stderr, "Unable to initialize vhost device: %d\n", r);
+                virtio_cleanup(&n->vdev);
+                return NULL;
+            }
+    }
 
     n->vdev.get_config = virtio_net_get_config;
     n->vdev.set_config = virtio_net_set_config;
@@ -838,6 +883,7 @@ VirtIODevice *virtio_net_init(DeviceState *dev)
     n->vdev.set_features = virtio_net_set_features;
     n->vdev.bad_features = virtio_net_bad_features;
     n->vdev.reset = virtio_net_reset;
+    n->vdev.driver_ok = virtio_net_driver_ok;
     n->rx_vq = virtio_add_queue(&n->vdev, 256, virtio_net_handle_rx);
     n->tx_vq = virtio_add_queue(&n->vdev, 256, virtio_net_handle_tx);
     n->ctrl_vq = virtio_add_queue(&n->vdev, 64, virtio_net_handle_ctrl);
@@ -864,7 +910,6 @@ VirtIODevice *virtio_net_init(DeviceState *dev)
         n->vdev.nvectors = 3;
     else
         n->vdev.nvectors = dev->nd->nvectors;
-
     register_savevm("virtio-net", virtio_net_id++, VIRTIO_NET_VM_VERSION,
                     virtio_net_save, virtio_net_load, n);
 
diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index 0716f6f..b7f073b 100644
--- a/hw/virtio-pci.c
+++ b/hw/virtio-pci.c
@@ -15,11 +15,13 @@
 
 #include <inttypes.h>
 
+#include <linux/kvm.h>
 #include "virtio.h"
 #include "pci.h"
 #include "sysemu.h"
 #include "msix.h"
 #include "net.h"
+#include "qemu-kvm.h"
 
 /* from Linux's linux/virtio_pci.h */
 
@@ -199,6 +201,8 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
         vdev->status = val & 0xFF;
         if (vdev->status == 0)
             virtio_pci_reset(&proxy->pci_dev.qdev);
+	if ((val & VIRTIO_CONFIG_S_DRIVER_OK) && vdev->driver_ok)
+		vdev->driver_ok(vdev);
         break;
     case VIRTIO_MSI_CONFIG_VECTOR:
         msix_vector_unuse(&proxy->pci_dev, vdev->config_vector);
@@ -373,12 +377,48 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
     msix_write_config(pci_dev, address, val, len);
 }
 
+static int virtio_pci_irqfd(void * opaque, uint16_t vector, int fd)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    struct kvm_irqfd call = { };
+    int r;
+
+    if (vector >= proxy->pci_dev.msix_entries_nr)
+        return -EINVAL;
+    if (!proxy->pci_dev.msix_entry_used[vector])
+        return -ENOENT;
+    call.fd = fd;
+    call.gsi = proxy->pci_dev.msix_irq_entries[vector].gsi;
+    r = kvm_vm_ioctl(kvm_state, KVM_IRQFD, &call);
+    if (r < 0)
+        return r;
+    return 0;
+}
+
+static int virtio_pci_queuefd(void * opaque, int n, int fd)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    struct kvm_ioeventfd kick = {
+        .datamatch = n,
+        .addr = proxy->addr + VIRTIO_PCI_QUEUE_NOTIFY,
+        .len = 2,
+        .flags = KVM_IOEVENTFD_FLAG_DATAMATCH | KVM_IOEVENTFD_FLAG_PIO,
+        .fd = fd,
+    };
+    int r = kvm_vm_ioctl(kvm_state, KVM_IOEVENTFD, &kick);
+    if (r < 0)
+        return r;
+    return 0;
+}
+
 static const VirtIOBindings virtio_pci_bindings = {
     .notify = virtio_pci_notify,
     .save_config = virtio_pci_save_config,
     .load_config = virtio_pci_load_config,
     .save_queue = virtio_pci_save_queue,
     .load_queue = virtio_pci_load_queue,
+    .irqfd = virtio_pci_irqfd,
+    .queuefd = virtio_pci_queuefd,
 };
 
 static void virtio_init_pci(VirtIOPCIProxy *proxy, VirtIODevice *vdev,
diff --git a/hw/virtio.c b/hw/virtio.c
index 337ff27..cc5c205 100644
--- a/hw/virtio.c
+++ b/hw/virtio.c
@@ -54,24 +54,6 @@ typedef struct VRingUsed
     VRingUsedElem ring[0];
 } VRingUsed;
 
-typedef struct VRing
-{
-    unsigned int num;
-    target_phys_addr_t desc;
-    target_phys_addr_t avail;
-    target_phys_addr_t used;
-} VRing;
-
-struct VirtQueue
-{
-    VRing vring;
-    target_phys_addr_t pa;
-    uint16_t last_avail_idx;
-    int inuse;
-    uint16_t vector;
-    void (*handle_output)(VirtIODevice *vdev, VirtQueue *vq);
-};
-
 #define VIRTIO_PCI_QUEUE_MAX        16
 
 /* virt queue functions */
@@ -401,7 +383,6 @@ int virtqueue_pop(VirtQueue *vq, VirtQueueElement *elem)
 
         sg->iov_base = cpu_physical_memory_map(vring_desc_addr(desc_pa, i),
                                                &len, is_write);
-
         if (sg->iov_base == NULL || len != sg->iov_len) {
             fprintf(stderr, "virtio: trying to map MMIO memory\n");
             exit(1);
diff --git a/hw/virtio.h b/hw/virtio.h
index 799e608..12792da 100644
--- a/hw/virtio.h
+++ b/hw/virtio.h
@@ -54,15 +54,34 @@
 
 struct VirtQueue;
 
+typedef struct VRing
+{
+    unsigned int num;
+    target_phys_addr_t desc;
+    target_phys_addr_t avail;
+    target_phys_addr_t used;
+} VRing;
+
+typedef struct VirtQueue VirtQueue;
+struct VirtIODevice;
+typedef struct VirtIODevice VirtIODevice;
+
+struct VirtQueue
+{
+    VRing vring;
+    target_phys_addr_t pa;
+    uint16_t last_avail_idx;
+    int inuse;
+    uint16_t vector;
+    void (*handle_output)(VirtIODevice *vdev, VirtQueue *vq);
+};
+
 static inline target_phys_addr_t vring_align(target_phys_addr_t addr,
                                              unsigned long align)
 {
     return (addr + align - 1) & ~(align - 1);
 }
 
-typedef struct VirtQueue VirtQueue;
-typedef struct VirtIODevice VirtIODevice;
-
 #define VIRTQUEUE_MAX_SIZE 1024
 
 typedef struct VirtQueueElement
@@ -81,6 +100,8 @@ typedef struct {
     void (*save_queue)(void * opaque, int n, QEMUFile *f);
     int (*load_config)(void * opaque, QEMUFile *f);
     int (*load_queue)(void * opaque, int n, QEMUFile *f);
+    int (*irqfd)(void * opaque, uint16_t vector, int fd);
+    int (*queuefd)(void * opaque, int n, int fd);
 } VirtIOBindings;
 
 #define VIRTIO_PCI_QUEUE_MAX 16
@@ -104,6 +125,7 @@ struct VirtIODevice
     void (*get_config)(VirtIODevice *vdev, uint8_t *config);
     void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
     void (*reset)(VirtIODevice *vdev);
+    void (*driver_ok)(VirtIODevice *vdev);
     VirtQueue *vq;
     const VirtIOBindings *binding;
     void *binding_opaque;
diff --git a/kvm/include/linux/vhost.h b/kvm/include/linux/vhost.h
new file mode 100644
index 0000000..aa4ff24
--- /dev/null
+++ b/kvm/include/linux/vhost.h
@@ -0,0 +1,126 @@
+#ifndef _LINUX_VHOST_H
+#define _LINUX_VHOST_H
+/* Userspace interface for in-kernel virtio accelerators. */
+
+/* vhost is used to reduce the number of system calls involved in virtio.
+ *
+ * Existing virtio net code is used in the guest without modification.
+ *
+ * This header includes interface used by userspace hypervisor for
+ * device configuration.
+ */
+
+#include <linux/types.h>
+
+#include <linux/ioctl.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_ring.h>
+
+struct vhost_vring_state {
+	unsigned int index;
+	unsigned int num;
+};
+
+struct vhost_vring_file {
+	unsigned int index;
+	int fd; /* Pass -1 to unbind from file. */
+
+};
+
+struct vhost_vring_addr {
+	unsigned int index;
+	unsigned int padding;
+	__u64 user_addr;
+};
+
+struct vhost_memory_region {
+	__u64 guest_phys_addr;
+	__u64 memory_size; /* bytes */
+	__u64 userspace_addr;
+	__u64 flags_padding; /* No flags are currently specified. */
+};
+
+/* All region addresses and sizes must be 4K aligned. */
+#define VHOST_PAGE_SIZE 0x1000
+
+struct vhost_memory {
+	__u32 nregions;
+	__u32 padding;
+	struct vhost_memory_region regions[0];
+};
+
+/* ioctls */
+
+#define VHOST_VIRTIO 0xAF
+
+/* Features bitmask for forward compatibility.  Transport bits are used for
+ * vhost specific features. */
+#define VHOST_GET_FEATURES	_IOR(VHOST_VIRTIO, 0x00, __u64)
+#define VHOST_ACK_FEATURES	_IOW(VHOST_VIRTIO, 0x00, __u64)
+
+/* Set current process as the (exclusive) owner of this file descriptor.  This
+ * must be called before any other vhost command.  Further calls to
+ * VHOST_OWNER_SET fail until VHOST_OWNER_RESET is called. */
+#define VHOST_SET_OWNER _IO(VHOST_VIRTIO, 0x01)
+/* Give up ownership, and reset the device to default values.
+ * Allows subsequent call to VHOST_OWNER_SET to succeed. */
+#define VHOST_RESET_OWNER _IO(VHOST_VIRTIO, 0x02)
+
+/* Set up/modify memory layout */
+#define VHOST_SET_MEM_TABLE	_IOW(VHOST_VIRTIO, 0x03, struct vhost_memory)
+
+/* Write logging setup. */
+/* Memory writes can optionally be logged by setting bit at an offset
+ * (calculated from the physical address) from specified log base.
+ * The bit is set using an atomic 32 bit operation. */
+/* Set base address for logging. */
+#define VHOST_SET_LOG_BASE _IOW(VHOST_VIRTIO, 0x04, __u64)
+/* Specify an eventfd file descriptor to signal on log write. */
+#define VHOST_SET_LOG_FD _IOW(VHOST_VIRTIO, 0x07, int)
+
+/* Ring setup. These parameters can not be modified while ring is running
+ * (bound to a device). */
+/* Set number of descriptors in ring */
+#define VHOST_SET_VRING_NUM _IOW(VHOST_VIRTIO, 0x10, struct vhost_vring_state)
+/* Start of array of descriptors (virtually contiguous) */
+#define VHOST_SET_VRING_DESC _IOW(VHOST_VIRTIO, 0x11, struct vhost_vring_addr)
+/* Used structure address. Must be 32 bit aligned */
+#define VHOST_SET_VRING_USED _IOW(VHOST_VIRTIO, 0x12, struct vhost_vring_addr)
+/* Available structure address. Must be 16 bit aligned */
+#define VHOST_SET_VRING_AVAIL _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_addr)
+/* Base value where queue looks for available descriptors */
+#define VHOST_SET_VRING_BASE _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
+/* Get accessor: reads index, writes value in num */
+#define VHOST_GET_VRING_BASE _IOWR(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
+
+/* Logging support. Can be modified while ring is running. */
+/* Log writes to used structure, at offset calculated from specified address.
+ * Address must be 32 bit aligned. Pass 0x1 to disable logging. */
+#define VHOST_SET_VRING_LOG _IOW(VHOST_VIRTIO, 0x18, struct vhost_vring_addr)
+#define VHOST_VRING_LOG_DISABLE (0x1)
+
+/* The following ioctls use eventfd file descriptors to signal and poll
+ * for events. */
+
+/* Set eventfd to poll for added buffers */
+#define VHOST_SET_VRING_KICK _IOW(VHOST_VIRTIO, 0x20, struct vhost_vring_file)
+/* Set eventfd to signal when buffers have beed used */
+#define VHOST_SET_VRING_CALL _IOW(VHOST_VIRTIO, 0x21, struct vhost_vring_file)
+/* Set eventfd to signal an error */
+#define VHOST_SET_VRING_ERR _IOW(VHOST_VIRTIO, 0x22, struct vhost_vring_file)
+
+/* VHOST_NET specific defines */
+
+/* Attach virtio net ring to a raw socket, or tap device.
+ * The socket must be already bound to an ethernet device, this device will be
+ * used for transmit.  Pass fd -1 to unbind from the socket and the transmit
+ * device.  This can be used to stop the ring (e.g. for migration). */
+#define VHOST_NET_SET_BACKEND _IOW(VHOST_VIRTIO, 0x30, struct vhost_vring_file)
+
+/* Feature bits */
+/* Log all write descriptors. Can be changed while device is active. */
+#define VHOST_F_LOG_ALL 26
+/* vhost-net should add virtio_net_hdr for RX, and strip for TX packets. */
+#define VHOST_NET_F_VIRTIO_NET_HDR 27
+
+#endif
diff --git a/net.c b/net.c
index 9168460..5d98e90 100644
--- a/net.c
+++ b/net.c
@@ -2767,6 +2767,9 @@ static int net_init_nic(QemuOpts *opts, Monitor *mon)
     if (qemu_opt_get(opts, "addr")) {
         nd->devaddr = qemu_strdup(qemu_opt_get(opts, "addr"));
     }
+    if (qemu_opt_get(opts, "vhost")) {
+        nd->vhost_device = qemu_opt_get_bool(opts, "vhost", 0);
+    }
 
     nd->macaddr[0] = 0x52;
     nd->macaddr[1] = 0x54;
@@ -3182,6 +3185,10 @@ static struct {
                 .name = "vectors",
                 .type = QEMU_OPT_NUMBER,
                 .help = "number of MSI-x vectors, 0 to disable MSI-X",
+            }, {
+                .name = "vhost",
+                .type = QEMU_OPT_BOOL,
+                .help = "enable vhost backend",
             },
             { /* end of list */ }
         },
diff --git a/net.h b/net.h
index 932b50d..adcd5c6 100644
--- a/net.h
+++ b/net.h
@@ -115,6 +115,7 @@ struct NICInfo {
     int used;
     int bootable;
     int nvectors;
+    int vhost_device;
 };
 
 extern int nb_nics;
diff --git a/qemu-kvm.c b/qemu-kvm.c
index 62ca050..a547975 100644
--- a/qemu-kvm.c
+++ b/qemu-kvm.c
@@ -150,14 +150,6 @@ static inline void clear_gsi(kvm_context_t kvm, unsigned int gsi)
         DPRINTF("Invalid GSI %d\n");
 }
 
-struct slot_info {
-    unsigned long phys_addr;
-    unsigned long len;
-    unsigned long userspace_addr;
-    unsigned flags;
-    int logging_count;
-};
-
 struct slot_info slots[KVM_MAX_NUM_MEM_REGIONS];
 
 static void init_slots(void)
diff --git a/qemu-kvm.h b/qemu-kvm.h
index d6748c7..2ab6c33 100644
--- a/qemu-kvm.h
+++ b/qemu-kvm.h
@@ -1240,6 +1240,15 @@ int kvm_ioctl(KVMState *s, int type, ...);
 int kvm_vm_ioctl(KVMState *s, int type, ...);
 int kvm_check_extension(KVMState *s, unsigned int ext);
 
+struct slot_info {
+	unsigned long phys_addr;
+	unsigned long len;
+	unsigned long userspace_addr;
+	unsigned flags;
+	int logging_count;
+};
+
+extern struct slot_info slots[KVM_MAX_NUM_MEM_REGIONS];
 #endif
 
 #endif
-- 
1.6.5.2.143.g8cc62
