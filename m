From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 3/3] qemu-kvm: vhost-net implementation
Date: Thu, 13 Aug 2009 11:50:59 +0300
Message-ID: <20090813085059.GD4726__12322.0029789538$1250153753$gmane$org@redhat.com>
References: <cover.1250153371.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1250153371.git.mst@redhat.com>
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
To enable (assuming device eth2):
1. enable promisc mode or program guest mac in device eth2
2. disable tso, gso, lro on the card
3. add vhost=eth0 to -net flag
4. run with CAP_NET_ADMIN priviledge (e.g. root)

This patch is RFC, but works without issues for me.

It still needs to be split up, tested and benchmarked properly,
but posting it here in case people want to test drive
the kernel bits I posted.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Makefile.target |    3 +-
 hw/vhost_net.c  |  181 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vhost_net.h  |   30 +++++++++
 hw/virtio-net.c |   32 ++++++++++-
 hw/virtio-pci.c |   40 ++++++++++++
 hw/virtio.c     |   19 ------
 hw/virtio.h     |   28 ++++++++-
 net.c           |    5 ++
 net.h           |    1 +
 qemu-kvm.h      |    9 +++
 10 files changed, 324 insertions(+), 24 deletions(-)
 create mode 100644 hw/vhost_net.c
 create mode 100644 hw/vhost_net.h

diff --git a/Makefile.target b/Makefile.target
index f6d9708..e941a36 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -170,7 +170,8 @@ obj-y = vl.o osdep.o monitor.o pci.o loader.o isa_mmio.o machine.o \
         gdbstub.o gdbstub-xml.o msix.o ioport.o qemu-config.o
 # virtio has to be here due to weird dependency between PCI and virtio-net.
 # need to fix this properly
-obj-y += virtio-blk.o virtio-balloon.o virtio-net.o virtio-console.o virtio-pci.o
+obj-y += virtio-blk.o virtio-balloon.o virtio-net.o virtio-console.o virtio-pci.o \
+	vhost_net.o
 obj-$(CONFIG_KVM) += kvm.o kvm-all.o
 
 LIBS+=-lz
diff --git a/hw/vhost_net.c b/hw/vhost_net.c
new file mode 100644
index 0000000..7d52de0
--- /dev/null
+++ b/hw/vhost_net.c
@@ -0,0 +1,181 @@
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
+#include "qemu-kvm.h"
+
+#include "vhost_net.h"
+
+const char *vhost_net_device;
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
+static int vhost_dev_init(struct vhost_dev *hdev,
+			  VirtIODevice *vdev)
+{
+	int i, r, n = 0;
+	struct vhost_memory *mem;
+	hdev->control = open("/dev/vhost-net", O_RDWR);
+	if (hdev->control < 0)
+		return -errno;
+	r = ioctl(hdev->control, VHOST_SET_OWNER, NULL);
+	if (r < 0)
+		return -errno;
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
+int vhost_net_init(struct vhost_net *net,
+		   VirtIODevice *dev,
+		   char *vhost_device)
+{
+	struct sockaddr_ll lladdr;
+	struct ifreq req;
+	int r;
+	const char *ifname = vhost_device;
+	if (!ifname)
+		return 0;
+
+	net->dev.nvqs = 2;
+	net->dev.vqs = net->vqs;
+	r = vhost_dev_init(&net->dev, dev);
+	if (r < 0)
+		return r;
+
+	net->sock = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	if (net->sock < 0)
+		return -errno;
+
+	memset(&req, 0, sizeof(req));
+	strncpy(req.ifr_name, ifname, IFNAMSIZ-1);
+	r = ioctl(net->sock, SIOCGIFINDEX, &req);
+	if (r < 0)
+		return -errno;
+
+	memset(&lladdr, 0, sizeof(lladdr));
+	lladdr.sll_family   = AF_PACKET;
+	lladdr.sll_protocol = htons(ETH_P_ALL);
+	lladdr.sll_ifindex  = req.ifr_ifindex;
+	r = bind(net->sock, (const struct sockaddr *)&lladdr, sizeof(lladdr));
+	if (r < 0)
+		return -errno;
+	
+	r = ioctl(net->dev.control, VHOST_NET_SET_SOCKET, &net->sock);
+	if (r < 0)
+		return -errno;
+	return 0;
+}
diff --git a/hw/vhost_net.h b/hw/vhost_net.h
new file mode 100644
index 0000000..73e0a76
--- /dev/null
+++ b/hw/vhost_net.h
@@ -0,0 +1,30 @@
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
+};
+
+struct vhost_net {
+	struct vhost_dev dev;
+	struct vhost_virtqueue vqs[2];
+	int sock;
+};
+
+int vhost_net_init(struct vhost_net *net,
+		   VirtIODevice *dev,
+		   char *vhost_device);
+
+#endif
diff --git a/hw/virtio-net.c b/hw/virtio-net.c
index 469c6e3..1ac05a2 100644
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
+    char *vhost_device;
+    struct vhost_net vhost;
 } VirtIONet;
 
 /* TODO
@@ -134,9 +138,12 @@ static uint32_t virtio_net_get_features(VirtIODevice *vdev)
                         (1 << VIRTIO_NET_F_CTRL_RX) |
                         (1 << VIRTIO_NET_F_CTRL_VLAN) |
                         (1 << VIRTIO_NET_F_CTRL_RX_EXTRA);
+    VirtIONet *n = to_virtio_net(vdev);
+
+    if (n->vhost_device)
+	return 1 << VIRTIO_NET_F_MAC;
 
 #ifdef TAP_VNET_HDR
-    VirtIONet *n = to_virtio_net(vdev);
     VLANClientState *host = n->vc->vlan->first_client;
 
     if (tap_has_vnet_hdr(host)) {
@@ -175,6 +182,9 @@ static uint32_t virtio_net_bad_features(VirtIODevice *vdev)
 static void virtio_net_set_features(VirtIODevice *vdev, uint32_t features)
 {
     VirtIONet *n = to_virtio_net(vdev);
+    /* vhost net supports no features */
+    if (n->vhost_device)
+	    return;
 #ifdef TAP_VNET_HDR
     VLANClientState *host = n->vc->vlan->first_client;
 #endif
@@ -351,6 +361,9 @@ static void virtio_net_handle_rx(VirtIODevice *vdev, VirtQueue *vq)
 
 static int do_virtio_net_can_receive(VirtIONet *n, int bufsize)
 {
+    if (n->vhost_device)
+	    return 0;
+
     if (!virtio_queue_ready(n->rx_vq) ||
         !(n->vdev.status & VIRTIO_CONFIG_S_DRIVER_OK))
         return 0;
@@ -411,6 +424,7 @@ static int iov_fill(struct iovec *iov, int iovcnt, const void *buf, int count)
     while (offset < count && i < iovcnt) {
         int len = MIN(iov[i].iov_len, count - offset);
         memcpy(iov[i].iov_base, buf + offset, len);
+	
         offset += len;
         i++;
     }
@@ -610,6 +624,8 @@ static void virtio_net_flush_tx(VirtIONet *n, VirtQueue *vq)
 #else
     int has_vnet_hdr = 0;
 #endif
+    if (n->vhost_device)
+	    return;
 
     if (!(n->vdev.status & VIRTIO_CONFIG_S_DRIVER_OK))
         return;
@@ -822,6 +838,18 @@ static void virtio_net_cleanup(VLANClientState *vc)
     virtio_cleanup(&n->vdev);
 }
 
+static void virtio_net_driver_ok(VirtIODevice *vdev)
+{
+    VirtIONet *n = to_virtio_net(vdev);
+    int r;
+
+    r = vhost_net_init(&n->vhost, vdev, n->vhost_device);
+    if (r) {
+	fprintf(stderr, "\nvhost_net_init returned %d\n", r);
+	exit(-r);
+    }
+}
+
 VirtIODevice *virtio_net_init(DeviceState *dev)
 {
     VirtIONet *n;
@@ -837,6 +865,7 @@ VirtIODevice *virtio_net_init(DeviceState *dev)
     n->vdev.set_features = virtio_net_set_features;
     n->vdev.bad_features = virtio_net_bad_features;
     n->vdev.reset = virtio_net_reset;
+    n->vdev.driver_ok = virtio_net_driver_ok;
     n->rx_vq = virtio_add_queue(&n->vdev, 256, virtio_net_handle_rx);
     n->tx_vq = virtio_add_queue(&n->vdev, 256, virtio_net_handle_tx);
     n->ctrl_vq = virtio_add_queue(&n->vdev, 64, virtio_net_handle_ctrl);
@@ -863,6 +892,7 @@ VirtIODevice *virtio_net_init(DeviceState *dev)
         n->vdev.nvectors = 3;
     else
         n->vdev.nvectors = dev->nd->nvectors;
+    n->vhost_device = dev->nd->vhost_device;
 
     register_savevm("virtio-net", virtio_net_id++, VIRTIO_NET_VM_VERSION,
                     virtio_net_save, virtio_net_load, n);
diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index ab6e9c4..4b02df3 100644
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
             virtio_pci_reset(proxy);
+	if ((val & VIRTIO_CONFIG_S_DRIVER_OK) && vdev->driver_ok)
+		vdev->driver_ok(vdev);
         break;
     case VIRTIO_MSI_CONFIG_VECTOR:
         msix_vector_unuse(&proxy->pci_dev, vdev->config_vector);
@@ -365,12 +369,48 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
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
index 41e7ca2..bf53386 100644
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
index cbf472b..0f49017 100644
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
diff --git a/net.c b/net.c
index 1e845cf..3c834bd 100644
--- a/net.c
+++ b/net.c
@@ -2589,6 +2589,8 @@ int net_client_init(Monitor *mon, const char *device, const char *p)
     if (!strcmp(device, "nic")) {
         static const char * const nic_params[] = {
             "vlan", "name", "macaddr", "model", "addr", "id", "vectors", NULL
+            "vlan", "name", "macaddr", "model", "addr", "id", "vectors",
+	    "vhost", NULL
         };
         NICInfo *nd;
         uint8_t *macaddr;
@@ -2620,6 +2622,9 @@ int net_client_init(Monitor *mon, const char *device, const char *p)
                 goto out;
             }
         }
+        if (get_param_value(buf, sizeof(buf), "vhost", p)) {
+            nd->vhost_device = strdup(buf);
+        }
         if (get_param_value(buf, sizeof(buf), "model", p)) {
             nd->model = strdup(buf);
         }
diff --git a/net.h b/net.h
index b172691..dd58e2b 100644
--- a/net.h
+++ b/net.h
@@ -110,6 +110,7 @@ struct NICInfo {
     int used;
     int bootable;
     int nvectors;
+    char *vhost_device;
 };
 
 extern int nb_nics;
diff --git a/qemu-kvm.h b/qemu-kvm.h
index 6476e6f..2b6e0b6 100644
--- a/qemu-kvm.h
+++ b/qemu-kvm.h
@@ -1215,6 +1215,15 @@ int kvm_ioctl(KVMState *s, int type, ...);
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
1.6.2.5
