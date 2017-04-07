From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH kvmtool 03/15] virtio: add virtio-iommu
Date: Fri,  7 Apr 2017 20:24:43 +0100
Message-ID: <20170407192455.26814-4-jean-philippe.brucker__27285.7304350056$1491593110$gmane$org@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407192455.26814-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170407192455.26814-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: cdall@linaro.org, lorenzo.pieralisi@arm.com, mst@redhat.com, marc.zyngier@arm.com, joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

Implement a simple para-virtualized IOMMU for handling device address
spaces in guests.

Four operations are implemented:
* attach/detach: guest creates an address space, symbolized by a unique
  identifier (IOASID), and attaches the device to it.
* map/unmap: guest creates a GVA->GPA mapping in an address space. Devices
  attached to this address space can then access the GVA.

Each subsystem can register its own IOMMU, by calling register/unregister.
A unique device-tree phandle is allocated for each IOMMU. The IOMMU
receives commands from the driver through the virtqueue, and has a set of
callbacks for each device, allowing to implement different map/unmap
operations for passed-through and emulated devices. Note that a single
virtual IOMMU per guest would be enough, this multi-instance model is just
here for experimenting and allow different subsystems to offer different
vIOMMU features.

Add a global --viommu parameter to enable the virtual IOMMU.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 Makefile                   |   1 +
 builtin-run.c              |   2 +
 include/kvm/devices.h      |   4 +
 include/kvm/iommu.h        |  64 +++++
 include/kvm/kvm-config.h   |   1 +
 include/kvm/virtio-iommu.h |  10 +
 virtio/iommu.c             | 628 +++++++++++++++++++++++++++++++++++++++++++++
 virtio/mmio.c              |  11 +
 8 files changed, 721 insertions(+)
 create mode 100644 include/kvm/iommu.h
 create mode 100644 include/kvm/virtio-iommu.h
 create mode 100644 virtio/iommu.c

diff --git a/Makefile b/Makefile
index 3e21c597..67953870 100644
--- a/Makefile
+++ b/Makefile
@@ -68,6 +68,7 @@ OBJS	+= virtio/net.o
 OBJS	+= virtio/rng.o
 OBJS    += virtio/balloon.o
 OBJS	+= virtio/pci.o
+OBJS	+= virtio/iommu.o
 OBJS	+= disk/blk.o
 OBJS	+= disk/qcow.o
 OBJS	+= disk/raw.o
diff --git a/builtin-run.c b/builtin-run.c
index b4790ebc..7535b531 100644
--- a/builtin-run.c
+++ b/builtin-run.c
@@ -113,6 +113,8 @@ void kvm_run_set_wrapper_sandbox(void)
 	OPT_BOOLEAN('\0', "sdl", &(cfg)->sdl, "Enable SDL framebuffer"),\
 	OPT_BOOLEAN('\0', "rng", &(cfg)->virtio_rng, "Enable virtio"	\
 			" Random Number Generator"),			\
+	OPT_BOOLEAN('\0', "viommu", &(cfg)->viommu,			\
+			"Enable virtio IOMMU"),				\
 	OPT_CALLBACK('\0', "9p", NULL, "dir_to_share,tag_name",		\
 		     "Enable virtio 9p to share files between host and"	\
 		     " guest", virtio_9p_rootdir_parser, kvm),		\
diff --git a/include/kvm/devices.h b/include/kvm/devices.h
index 405f1952..70a00c5b 100644
--- a/include/kvm/devices.h
+++ b/include/kvm/devices.h
@@ -11,11 +11,15 @@ enum device_bus_type {
 	DEVICE_BUS_MAX,
 };
 
+struct iommu_ops;
+
 struct device_header {
 	enum device_bus_type	bus_type;
 	void			*data;
 	int			dev_num;
 	struct rb_node		node;
+	struct iommu_ops	*iommu_ops;
+	void			*iommu_data;
 };
 
 int device__register(struct device_header *dev);
diff --git a/include/kvm/iommu.h b/include/kvm/iommu.h
new file mode 100644
index 00000000..925e1993
--- /dev/null
+++ b/include/kvm/iommu.h
@@ -0,0 +1,64 @@
+#ifndef KVM_IOMMU_H
+#define KVM_IOMMU_H
+
+#include <stdlib.h>
+
+#include "devices.h"
+
+#define IOMMU_PROT_NONE		0x0
+#define IOMMU_PROT_READ		0x1
+#define IOMMU_PROT_WRITE	0x2
+#define IOMMU_PROT_EXEC		0x4
+
+struct iommu_ops {
+	const struct iommu_properties *(*get_properties)(struct device_header *);
+
+	void *(*alloc_address_space)(struct device_header *);
+	void (*free_address_space)(void *);
+
+	int (*attach)(void *, struct device_header *, int flags);
+	int (*detach)(void *, struct device_header *);
+	int (*map)(void *, u64 virt_addr, u64 phys_addr, u64 size, int prot);
+	int (*unmap)(void *, u64 virt_addr, u64 size, int flags);
+};
+
+struct iommu_properties {
+	const char			*name;
+	u32				phandle;
+
+	size_t				input_addr_size;
+	u64				pgsize_mask;
+};
+
+/*
+ * All devices presented to the system have a device ID, that allows the IOMMU
+ * to identify them. Since multiple buses can share an IOMMU, this device ID
+ * must be unique system-wide. We define it here as:
+ *
+ *	(bus_type << 16) + dev_num
+ *
+ * Where dev_num is the device number on the bus as allocated by devices.c
+ *
+ * TODO: enforce this limit, by checking that the device number allocator
+ * doesn't overflow BUS_SIZE.
+ */
+
+#define BUS_SIZE 0x10000
+
+static inline long device_to_iommu_id(struct device_header *dev)
+{
+	return dev->bus_type * BUS_SIZE + dev->dev_num;
+}
+
+#define iommu_id_to_bus(device_id)	((device_id) / BUS_SIZE)
+#define iommu_id_to_devnum(device_id)	((device_id) % BUS_SIZE)
+
+static inline struct device_header *iommu_get_device(u32 device_id)
+{
+	enum device_bus_type bus = iommu_id_to_bus(device_id);
+	u32 dev_num = iommu_id_to_devnum(device_id);
+
+	return device__find_dev(bus, dev_num);
+}
+
+#endif /* KVM_IOMMU_H */
diff --git a/include/kvm/kvm-config.h b/include/kvm/kvm-config.h
index 62dc6a2f..9678065b 100644
--- a/include/kvm/kvm-config.h
+++ b/include/kvm/kvm-config.h
@@ -60,6 +60,7 @@ struct kvm_config {
 	bool no_dhcp;
 	bool ioport_debug;
 	bool mmio_debug;
+	bool viommu;
 };
 
 #endif
diff --git a/include/kvm/virtio-iommu.h b/include/kvm/virtio-iommu.h
new file mode 100644
index 00000000..5532c82b
--- /dev/null
+++ b/include/kvm/virtio-iommu.h
@@ -0,0 +1,10 @@
+#ifndef KVM_VIRTIO_IOMMU_H
+#define KVM_VIRTIO_IOMMU_H
+
+#include "virtio.h"
+
+const struct iommu_properties *viommu_get_properties(void *dev);
+void *viommu_register(struct kvm *kvm, struct iommu_properties *props);
+void viommu_unregister(struct kvm *kvm, void *cookie);
+
+#endif
diff --git a/virtio/iommu.c b/virtio/iommu.c
new file mode 100644
index 00000000..c72e7322
--- /dev/null
+++ b/virtio/iommu.c
@@ -0,0 +1,628 @@
+#include <errno.h>
+#include <stdbool.h>
+
+#include <linux/compiler.h>
+
+#include <linux/bitops.h>
+#include <linux/byteorder.h>
+#include <linux/err.h>
+#include <linux/list.h>
+#include <linux/types.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_iommu.h>
+
+#include "kvm/guest_compat.h"
+#include "kvm/iommu.h"
+#include "kvm/threadpool.h"
+#include "kvm/virtio.h"
+#include "kvm/virtio-iommu.h"
+
+/* Max size */
+#define VIOMMU_DEFAULT_QUEUE_SIZE	256
+
+struct viommu_endpoint {
+	struct device_header		*dev;
+	struct viommu_ioas		*ioas;
+	struct list_head		list;
+};
+
+struct viommu_ioas {
+	u32				id;
+
+	struct mutex			devices_mutex;
+	struct list_head		devices;
+	size_t				nr_devices;
+	struct rb_node			node;
+
+	struct iommu_ops		*ops;
+	void				*priv;
+};
+
+struct viommu_dev {
+	struct virtio_device		vdev;
+	struct virtio_iommu_config	config;
+
+	const struct iommu_properties	*properties;
+
+	struct virt_queue		vq;
+	size_t				queue_size;
+	struct thread_pool__job		job;
+
+	struct rb_root			address_spaces;
+	struct kvm			*kvm;
+};
+
+static int compat_id = -1;
+
+static struct viommu_ioas *viommu_find_ioas(struct viommu_dev *viommu,
+					    u32 ioasid)
+{
+	struct rb_node *node;
+	struct viommu_ioas *ioas;
+
+	node = viommu->address_spaces.rb_node;
+	while (node) {
+		ioas = container_of(node, struct viommu_ioas, node);
+		if (ioas->id > ioasid)
+			node = node->rb_left;
+		else if (ioas->id < ioasid)
+			node = node->rb_right;
+		else
+			return ioas;
+	}
+
+	return NULL;
+}
+
+static struct viommu_ioas *viommu_alloc_ioas(struct viommu_dev *viommu,
+					     struct device_header *device,
+					     u32 ioasid)
+{
+	struct rb_node **node, *parent = NULL;
+	struct viommu_ioas *new_ioas, *ioas;
+	struct iommu_ops *ops = device->iommu_ops;
+
+	if (!ops || !ops->get_properties || !ops->alloc_address_space ||
+	    !ops->free_address_space || !ops->attach || !ops->detach ||
+	    !ops->map || !ops->unmap) {
+		/* Catch programming mistakes early */
+		pr_err("Invalid IOMMU ops");
+		return NULL;
+	}
+
+	new_ioas = calloc(1, sizeof(*new_ioas));
+	if (!new_ioas)
+		return NULL;
+
+	INIT_LIST_HEAD(&new_ioas->devices);
+	mutex_init(&new_ioas->devices_mutex);
+	new_ioas->id		= ioasid;
+	new_ioas->ops		= ops;
+	new_ioas->priv		= ops->alloc_address_space(device);
+
+	/* A NULL priv pointer is valid. */
+
+	node = &viommu->address_spaces.rb_node;
+	while (*node) {
+		ioas = container_of(*node, struct viommu_ioas, node);
+		parent = *node;
+
+		if (ioas->id > ioasid) {
+			node = &((*node)->rb_left);
+		} else if (ioas->id < ioasid) {
+			node = &((*node)->rb_right);
+		} else {
+			pr_err("IOAS exists!");
+			free(new_ioas);
+			return NULL;
+		}
+	}
+
+	rb_link_node(&new_ioas->node, parent, node);
+	rb_insert_color(&new_ioas->node, &viommu->address_spaces);
+
+	return new_ioas;
+}
+
+static void viommu_free_ioas(struct viommu_dev *viommu,
+			     struct viommu_ioas *ioas)
+{
+	if (ioas->priv)
+		ioas->ops->free_address_space(ioas->priv);
+
+	rb_erase(&ioas->node, &viommu->address_spaces);
+	free(ioas);
+}
+
+static int viommu_ioas_add_device(struct viommu_ioas *ioas,
+				  struct viommu_endpoint *vdev)
+{
+	mutex_lock(&ioas->devices_mutex);
+	list_add_tail(&vdev->list, &ioas->devices);
+	ioas->nr_devices++;
+	vdev->ioas = ioas;
+	mutex_unlock(&ioas->devices_mutex);
+
+	return 0;
+}
+
+static int viommu_ioas_del_device(struct viommu_ioas *ioas,
+				  struct viommu_endpoint *vdev)
+{
+	mutex_lock(&ioas->devices_mutex);
+	list_del(&vdev->list);
+	ioas->nr_devices--;
+	vdev->ioas = NULL;
+	mutex_unlock(&ioas->devices_mutex);
+
+	return 0;
+}
+
+static struct viommu_endpoint *viommu_alloc_device(struct device_header *device)
+{
+	struct viommu_endpoint *vdev = calloc(1, sizeof(*vdev));
+
+	device->iommu_data = vdev;
+	vdev->dev = device;
+
+	return vdev;
+}
+
+static int viommu_detach_device(struct viommu_dev *viommu,
+				struct viommu_endpoint *vdev)
+{
+	int ret;
+	struct viommu_ioas *ioas = vdev->ioas;
+	struct device_header *device = vdev->dev;
+
+	if (!ioas)
+		return -EINVAL;
+
+	pr_debug("detaching device %#lx from IOAS %u",
+		 device_to_iommu_id(device), ioas->id);
+
+	ret = device->iommu_ops->detach(ioas->priv, device);
+	if (!ret)
+		ret = viommu_ioas_del_device(ioas, vdev);
+
+	if (!ioas->nr_devices)
+		viommu_free_ioas(viommu, ioas);
+
+	return ret;
+}
+
+static int viommu_handle_attach(struct viommu_dev *viommu,
+				struct virtio_iommu_req_attach *attach)
+{
+	int ret;
+	struct viommu_ioas *ioas;
+	struct device_header *device;
+	struct viommu_endpoint *vdev;
+
+	u32 device_id	= le32_to_cpu(attach->device);
+	u32 ioasid	= le32_to_cpu(attach->address_space);
+
+	device = iommu_get_device(device_id);
+	if (IS_ERR_OR_NULL(device)) {
+		pr_err("could not find device %#x", device_id);
+		return -ENODEV;
+	}
+
+	pr_debug("attaching device %#x to IOAS %u", device_id, ioasid);
+
+	vdev = device->iommu_data;
+	if (!vdev) {
+		vdev = viommu_alloc_device(device);
+		if (!vdev)
+			return -ENOMEM;
+	}
+
+	ioas = viommu_find_ioas(viommu, ioasid);
+	if (!ioas) {
+		ioas = viommu_alloc_ioas(viommu, device, ioasid);
+		if (!ioas)
+			return -ENOMEM;
+	} else if (ioas->ops->map != device->iommu_ops->map ||
+		   ioas->ops->unmap != device->iommu_ops->unmap) {
+		return -EINVAL;
+	}
+
+	if (vdev->ioas) {
+		ret = viommu_detach_device(viommu, vdev);
+		if (ret)
+			return ret;
+	}
+
+	ret = device->iommu_ops->attach(ioas->priv, device, 0);
+	if (!ret)
+		ret = viommu_ioas_add_device(ioas, vdev);
+
+	if (ret && ioas->nr_devices == 0)
+		viommu_free_ioas(viommu, ioas);
+
+	return ret;
+}
+
+static int viommu_handle_detach(struct viommu_dev *viommu,
+				struct virtio_iommu_req_detach *detach)
+{
+	struct device_header *device;
+	struct viommu_endpoint *vdev;
+
+	u32 device_id	= le32_to_cpu(detach->device);
+
+	device = iommu_get_device(device_id);
+	if (IS_ERR_OR_NULL(device)) {
+		pr_err("could not find device %#x", device_id);
+		return -ENODEV;
+	}
+
+	vdev = device->iommu_data;
+	if (!vdev)
+		return -ENODEV;
+
+	return viommu_detach_device(viommu, vdev);
+}
+
+static int viommu_handle_map(struct viommu_dev *viommu,
+			     struct virtio_iommu_req_map *map)
+{
+	int prot = 0;
+	struct viommu_ioas *ioas;
+
+	u32 ioasid	= le32_to_cpu(map->address_space);
+	u64 virt_addr	= le64_to_cpu(map->virt_addr);
+	u64 phys_addr	= le64_to_cpu(map->phys_addr);
+	u64 size	= le64_to_cpu(map->size);
+	u32 flags	= le64_to_cpu(map->flags);
+
+	ioas = viommu_find_ioas(viommu, ioasid);
+	if (!ioas) {
+		pr_err("could not find address space %u", ioasid);
+		return -ESRCH;
+	}
+
+	if (flags & ~VIRTIO_IOMMU_MAP_F_MASK)
+		return -EINVAL;
+
+	if (flags & VIRTIO_IOMMU_MAP_F_READ)
+		prot |= IOMMU_PROT_READ;
+
+	if (flags & VIRTIO_IOMMU_MAP_F_WRITE)
+		prot |= IOMMU_PROT_WRITE;
+
+	if (flags & VIRTIO_IOMMU_MAP_F_EXEC)
+		prot |= IOMMU_PROT_EXEC;
+
+	pr_debug("map %#llx -> %#llx (%llu) to IOAS %u", virt_addr,
+		 phys_addr, size, ioasid);
+
+	return ioas->ops->map(ioas->priv, virt_addr, phys_addr, size, prot);
+}
+
+static int viommu_handle_unmap(struct viommu_dev *viommu,
+			       struct virtio_iommu_req_unmap *unmap)
+{
+	struct viommu_ioas *ioas;
+
+	u32 ioasid	= le32_to_cpu(unmap->address_space);
+	u64 virt_addr	= le64_to_cpu(unmap->virt_addr);
+	u64 size	= le64_to_cpu(unmap->size);
+
+	ioas = viommu_find_ioas(viommu, ioasid);
+	if (!ioas) {
+		pr_err("could not find address space %u", ioasid);
+		return -ESRCH;
+	}
+
+	pr_debug("unmap %#llx (%llu) from IOAS %u", virt_addr, size,
+		 ioasid);
+
+	return ioas->ops->unmap(ioas->priv, virt_addr, size, 0);
+}
+
+static size_t viommu_get_req_len(union virtio_iommu_req *req)
+{
+	switch (req->head.type) {
+	case VIRTIO_IOMMU_T_ATTACH:
+		return sizeof(req->attach);
+	case VIRTIO_IOMMU_T_DETACH:
+		return sizeof(req->detach);
+	case VIRTIO_IOMMU_T_MAP:
+		return sizeof(req->map);
+	case VIRTIO_IOMMU_T_UNMAP:
+		return sizeof(req->unmap);
+	default:
+		pr_err("unknown request type %x", req->head.type);
+		return 0;
+	}
+}
+
+static int viommu_errno_to_status(int err)
+{
+	switch (err) {
+	case 0:
+		return VIRTIO_IOMMU_S_OK;
+	case EIO:
+		return VIRTIO_IOMMU_S_IOERR;
+	case ENOSYS:
+		return VIRTIO_IOMMU_S_UNSUPP;
+	case ERANGE:
+		return VIRTIO_IOMMU_S_RANGE;
+	case EFAULT:
+		return VIRTIO_IOMMU_S_FAULT;
+	case EINVAL:
+		return VIRTIO_IOMMU_S_INVAL;
+	case ENOENT:
+	case ENODEV:
+	case ESRCH:
+		return VIRTIO_IOMMU_S_NOENT;
+	case ENOMEM:
+	case ENOSPC:
+	default:
+		return VIRTIO_IOMMU_S_DEVERR;
+	}
+}
+
+static ssize_t viommu_dispatch_commands(struct viommu_dev *viommu,
+					struct iovec *iov, int nr_in, int nr_out)
+{
+	u32 op;
+	int i, ret;
+	ssize_t written_len = 0;
+	size_t len, expected_len;
+	union virtio_iommu_req *req;
+	struct virtio_iommu_req_tail *tail;
+
+	/*
+	 * Are we picking up in the middle of a request buffer? Keep a running
+	 * count.
+	 *
+	 * Here we assume that a request is always made of two descriptors, a
+	 * head and a tail. TODO: get rid of framing assumptions by keeping
+	 * track of request fragments.
+	 */
+	static bool is_head = true;
+	static int cur_status = 0;
+
+	for (i = 0; i < nr_in + nr_out; i++, is_head = !is_head) {
+		len = iov[i].iov_len;
+		if (is_head && len < sizeof(req->head)) {
+			pr_err("invalid command length (%zu)", len);
+			cur_status = EIO;
+			continue;
+		} else if (!is_head && len < sizeof(*tail)) {
+			pr_err("invalid tail length (%zu)", len);
+			cur_status = 0;
+			continue;
+		}
+
+		if (!is_head) {
+			int status = viommu_errno_to_status(cur_status);
+
+			tail = iov[i].iov_base;
+			tail->status = cpu_to_le32(status);
+			written_len += sizeof(tail->status);
+			cur_status = 0;
+			continue;
+		}
+
+		req = iov[i].iov_base;
+		op = req->head.type;
+		expected_len = viommu_get_req_len(req) - sizeof(*tail);
+		if (expected_len != len) {
+			pr_err("invalid command %x length (%zu != %zu)", op,
+			       len, expected_len);
+			cur_status = EIO;
+			continue;
+		}
+
+		switch (op) {
+		case VIRTIO_IOMMU_T_ATTACH:
+			ret = viommu_handle_attach(viommu, &req->attach);
+			break;
+
+		case VIRTIO_IOMMU_T_DETACH:
+			ret = viommu_handle_detach(viommu, &req->detach);
+			break;
+
+		case VIRTIO_IOMMU_T_MAP:
+			ret = viommu_handle_map(viommu, &req->map);
+			break;
+
+		case VIRTIO_IOMMU_T_UNMAP:
+			ret = viommu_handle_unmap(viommu, &req->unmap);
+			break;
+
+		default:
+			pr_err("unhandled command %x", op);
+			ret = -ENOSYS;
+		}
+
+		if (ret)
+			cur_status = -ret;
+	}
+
+	return written_len;
+}
+
+static void viommu_command(struct kvm *kvm, void *dev)
+{
+	int len;
+	u16 head;
+	u16 out, in;
+
+	struct virt_queue *vq;
+	struct viommu_dev *viommu = dev;
+	struct iovec iov[VIOMMU_DEFAULT_QUEUE_SIZE];
+
+	vq = &viommu->vq;
+
+	while (virt_queue__available(vq)) {
+		head = virt_queue__get_iov(vq, iov, &out, &in, kvm);
+
+		len = viommu_dispatch_commands(viommu, iov, in, out);
+		if (len < 0) {
+			/* Critical error, abort everything */
+			pr_err("failed to dispatch viommu command");
+			return;
+		}
+
+		virt_queue__set_used_elem(vq, head, len);
+	}
+
+	if (virtio_queue__should_signal(vq))
+		viommu->vdev.ops->signal_vq(kvm, &viommu->vdev, 0);
+}
+
+/* Virtio API */
+static u8 *viommu_get_config(struct kvm *kvm, void *dev)
+{
+	struct viommu_dev *viommu = dev;
+
+	return (u8 *)&viommu->config;
+}
+
+static u32 viommu_get_host_features(struct kvm *kvm, void *dev)
+{
+	return 1ULL << VIRTIO_RING_F_EVENT_IDX
+	     | 1ULL << VIRTIO_RING_F_INDIRECT_DESC
+	     | 1ULL << VIRTIO_IOMMU_F_INPUT_RANGE;
+}
+
+static void viommu_set_guest_features(struct kvm *kvm, void *dev, u32 features)
+{
+}
+
+static int viommu_init_vq(struct kvm *kvm, void *dev, u32 vq, u32 page_size,
+			  u32 align, u32 pfn)
+{
+	void *ptr;
+	struct virt_queue *queue;
+	struct viommu_dev *viommu = dev;
+
+	if (vq != 0)
+		return -ENODEV;
+
+	compat__remove_message(compat_id);
+
+	queue = &viommu->vq;
+	queue->pfn = pfn;
+	ptr = virtio_get_vq(kvm, queue->pfn, page_size);
+
+	vring_init(&queue->vring, viommu->queue_size, ptr, align);
+	virtio_init_device_vq(&viommu->vdev, queue);
+
+	thread_pool__init_job(&viommu->job, kvm, viommu_command, viommu);
+
+	return 0;
+}
+
+static int viommu_get_pfn_vq(struct kvm *kvm, void *dev, u32 vq)
+{
+	struct viommu_dev *viommu = dev;
+
+	return viommu->vq.pfn;
+}
+
+static int viommu_get_size_vq(struct kvm *kvm, void *dev, u32 vq)
+{
+	struct viommu_dev *viommu = dev;
+
+	return viommu->queue_size;
+}
+
+static int viommu_set_size_vq(struct kvm *kvm, void *dev, u32 vq, int size)
+{
+	struct viommu_dev *viommu = dev;
+
+	if (viommu->vq.pfn)
+		/* Already init, can't resize */
+		return viommu->queue_size;
+
+	viommu->queue_size = size;
+
+	return size;
+}
+
+static int viommu_notify_vq(struct kvm *kvm, void *dev, u32 vq)
+{
+	struct viommu_dev *viommu = dev;
+
+	thread_pool__do_job(&viommu->job);
+
+	return 0;
+}
+
+static void viommu_notify_vq_gsi(struct kvm *kvm, void *dev, u32 vq, u32 gsi)
+{
+	/* TODO: when implementing vhost */
+}
+
+static void viommu_notify_vq_eventfd(struct kvm *kvm, void *dev, u32 vq, u32 fd)
+{
+	/* TODO: when implementing vhost */
+}
+
+static struct virtio_ops iommu_dev_virtio_ops = {
+	.get_config		= viommu_get_config,
+	.get_host_features	= viommu_get_host_features,
+	.set_guest_features	= viommu_set_guest_features,
+	.init_vq		= viommu_init_vq,
+	.get_pfn_vq		= viommu_get_pfn_vq,
+	.get_size_vq		= viommu_get_size_vq,
+	.set_size_vq		= viommu_set_size_vq,
+	.notify_vq		= viommu_notify_vq,
+	.notify_vq_gsi		= viommu_notify_vq_gsi,
+	.notify_vq_eventfd	= viommu_notify_vq_eventfd,
+};
+
+const struct iommu_properties *viommu_get_properties(void *dev)
+{
+	struct viommu_dev *viommu = dev;
+
+	return viommu->properties;
+}
+
+void *viommu_register(struct kvm *kvm, struct iommu_properties *props)
+{
+	struct viommu_dev *viommu;
+	u64 pgsize_mask = ~(PAGE_SIZE - 1);
+
+	if (!kvm->cfg.viommu)
+		return NULL;
+
+	props->phandle = fdt_alloc_phandle();
+
+	viommu = calloc(1, sizeof(struct viommu_dev));
+	if (!viommu)
+		return NULL;
+
+	viommu->queue_size		= VIOMMU_DEFAULT_QUEUE_SIZE;
+	viommu->address_spaces		= (struct rb_root)RB_ROOT;
+	viommu->properties		= props;
+
+	viommu->config.page_sizes	= props->pgsize_mask ?: pgsize_mask;
+	viommu->config.input_range.end	= props->input_addr_size % BITS_PER_LONG ?
+					  (1UL << props->input_addr_size) - 1 :
+					  -1UL;
+
+	if (virtio_init(kvm, viommu, &viommu->vdev, &iommu_dev_virtio_ops,
+			VIRTIO_MMIO, 0, VIRTIO_ID_IOMMU, 0)) {
+		free(viommu);
+		return NULL;
+	}
+
+	pr_info("Loaded virtual IOMMU %s", props->name);
+
+	if (compat_id == -1)
+		compat_id = virtio_compat_add_message("virtio-iommu",
+						      "CONFIG_VIRTIO_IOMMU");
+
+	return viommu;
+}
+
+void viommu_unregister(struct kvm *kvm, void *viommu)
+{
+	free(viommu);
+}
diff --git a/virtio/mmio.c b/virtio/mmio.c
index f0af4bd1..b3dea51a 100644
--- a/virtio/mmio.c
+++ b/virtio/mmio.c
@@ -1,14 +1,17 @@
 #include "kvm/devices.h"
 #include "kvm/virtio-mmio.h"
 #include "kvm/ioeventfd.h"
+#include "kvm/iommu.h"
 #include "kvm/ioport.h"
 #include "kvm/virtio.h"
+#include "kvm/virtio-iommu.h"
 #include "kvm/kvm.h"
 #include "kvm/kvm-cpu.h"
 #include "kvm/irq.h"
 #include "kvm/fdt.h"
 
 #include <linux/virtio_mmio.h>
+#include <linux/virtio_ids.h>
 #include <string.h>
 
 static u32 virtio_mmio_io_space_blocks = KVM_VIRTIO_MMIO_AREA;
@@ -237,6 +240,7 @@ void generate_virtio_mmio_fdt_node(void *fdt,
 							     u8 irq,
 							     enum irq_type))
 {
+	const struct iommu_properties *props;
 	char dev_name[DEVICE_NAME_MAX_LEN];
 	struct virtio_mmio *vmmio = container_of(dev_hdr,
 						 struct virtio_mmio,
@@ -254,6 +258,13 @@ void generate_virtio_mmio_fdt_node(void *fdt,
 	_FDT(fdt_property(fdt, "reg", reg_prop, sizeof(reg_prop)));
 	_FDT(fdt_property(fdt, "dma-coherent", NULL, 0));
 	generate_irq_prop(fdt, vmmio->irq, IRQ_TYPE_EDGE_RISING);
+
+	if (vmmio->hdr.device_id == VIRTIO_ID_IOMMU) {
+		props = viommu_get_properties(vmmio->dev);
+		_FDT(fdt_property_cell(fdt, "phandle", props->phandle));
+		_FDT(fdt_property_cell(fdt, "#iommu-cells", 1));
+	}
+
 	_FDT(fdt_end_node(fdt));
 }
 #else
-- 
2.12.1
