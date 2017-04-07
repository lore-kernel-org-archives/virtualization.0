From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH kvmtool 12/15] vfio: add support for virtual IOMMU
Date: Fri,  7 Apr 2017 20:24:52 +0100
Message-ID: <20170407192455.26814-13-jean-philippe.brucker__47834.3455739834$1491593262$gmane$org@arm.com>
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

Currently all passed-through devices must access the same guest-physical
address space. Register an IOMMU to offer individual address spaces to
devices. The way we do it is allocate one container per group, and add
mappings on demand.

Since guest cannot access devices unless it is attached to a container,
and we cannot change container at runtime without resetting the device,
this implementation is limited. To implement bypass mode, we'd need to map
the whole guest physical memory first, and unmap everything when attaching
to a new address space. It is also not possible for devices to be attached
to the same address space, they all have different page tables.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 include/kvm/iommu.h |   6 ++
 include/kvm/vfio.h  |   2 +
 iommu.c             |   7 +-
 vfio.c              | 281 ++++++++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 273 insertions(+), 23 deletions(-)

diff --git a/include/kvm/iommu.h b/include/kvm/iommu.h
index 8f87ce5a..45a20f3b 100644
--- a/include/kvm/iommu.h
+++ b/include/kvm/iommu.h
@@ -10,6 +10,12 @@
 #define IOMMU_PROT_WRITE	0x2
 #define IOMMU_PROT_EXEC		0x4
 
+/*
+ * Test if mapping is present. If not, return an error but do not report it to
+ * stderr
+ */
+#define IOMMU_UNMAP_SILENT	0x1
+
 struct iommu_ops {
 	const struct iommu_properties *(*get_properties)(struct device_header *);
 
diff --git a/include/kvm/vfio.h b/include/kvm/vfio.h
index 71dfa8f7..84126eb9 100644
--- a/include/kvm/vfio.h
+++ b/include/kvm/vfio.h
@@ -55,6 +55,7 @@ struct vfio_device {
 	struct device_header		dev_hdr;
 
 	int				fd;
+	struct vfio_group		*group;
 	struct vfio_device_info		info;
 	struct vfio_irq_info		irq_info;
 	struct vfio_region		*regions;
@@ -65,6 +66,7 @@ struct vfio_device {
 struct vfio_group {
 	unsigned long			id; /* iommu_group number in sysfs */
 	int				fd;
+	struct vfio_guest_container	*container;
 };
 
 int vfio_group_parser(const struct option *opt, const char *arg, int unset);
diff --git a/iommu.c b/iommu.c
index c10a3f0b..2220e4b2 100644
--- a/iommu.c
+++ b/iommu.c
@@ -85,6 +85,7 @@ int iommu_unmap(void *address_space, u64 virt_addr, u64 size, int flags)
 	struct rb_int_node *node;
 	struct iommu_mapping *map;
 	struct iommu_ioas *ioas = address_space;
+	bool silent = flags & IOMMU_UNMAP_SILENT;
 
 	if (!ioas)
 		return -ENODEV;
@@ -97,7 +98,8 @@ int iommu_unmap(void *address_space, u64 virt_addr, u64 size, int flags)
 		map = container_of(node, struct iommu_mapping, iova_range);
 
 		if (node_size > size) {
-			pr_debug("cannot split mapping");
+			if (!silent)
+				pr_debug("cannot split mapping");
 			ret = -EINVAL;
 			break;
 		}
@@ -111,7 +113,8 @@ int iommu_unmap(void *address_space, u64 virt_addr, u64 size, int flags)
 	}
 
 	if (size && !ret) {
-		pr_debug("mapping not found");
+		if (!silent)
+			pr_debug("mapping not found");
 		ret = -ENXIO;
 	}
 	mutex_unlock(&ioas->mutex);
diff --git a/vfio.c b/vfio.c
index f4fd4090..406d0781 100644
--- a/vfio.c
+++ b/vfio.c
@@ -1,10 +1,13 @@
+#include "kvm/iommu.h"
 #include "kvm/irq.h"
 #include "kvm/kvm.h"
 #include "kvm/kvm-cpu.h"
 #include "kvm/pci.h"
 #include "kvm/util.h"
 #include "kvm/vfio.h"
+#include "kvm/virtio-iommu.h"
 
+#include <linux/bitops.h>
 #include <linux/kvm.h>
 #include <linux/pci_regs.h>
 
@@ -25,7 +28,16 @@ struct vfio_irq_eventfd {
 	int			fd;
 };
 
-static int vfio_container;
+struct vfio_guest_container {
+	struct kvm		*kvm;
+	int			fd;
+
+	void			*msi_doorbells;
+};
+
+static void *viommu = NULL;
+
+static int vfio_host_container;
 
 int vfio_group_parser(const struct option *opt, const char *arg, int unset)
 {
@@ -43,6 +55,7 @@ int vfio_group_parser(const struct option *opt, const char *arg, int unset)
 
 	cur = strtok(buf, ",");
 	group->id = strtoul(cur, NULL, 0);
+	group->container = NULL;
 
 	kvm->cfg.num_vfio_groups = ++idx;
 	free(buf);
@@ -68,11 +81,13 @@ static void vfio_pci_msix_pba_access(struct kvm_cpu *vcpu, u64 addr, u8 *data,
 static void vfio_pci_msix_table_access(struct kvm_cpu *vcpu, u64 addr, u8 *data,
 				       u32 len, u8 is_write, void *ptr)
 {
+	struct msi_msg msg;
 	struct kvm *kvm = vcpu->kvm;
 	struct vfio_pci_device *pdev = ptr;
 	struct vfio_pci_msix_entry *entry;
 	struct vfio_pci_msix_table *table = &pdev->msix_table;
 	struct vfio_device *device = container_of(pdev, struct vfio_device, pci);
+	struct vfio_guest_container *container = device->group->container;
 
 	u64 offset = addr - table->guest_phys_addr;
 
@@ -88,11 +103,16 @@ static void vfio_pci_msix_table_access(struct kvm_cpu *vcpu, u64 addr, u8 *data,
 
 	memcpy((void *)&entry->config + field, data, len);
 
-	if (field != PCI_MSIX_ENTRY_VECTOR_CTRL)
+	if (field != PCI_MSIX_ENTRY_VECTOR_CTRL || entry->config.ctrl & 1)
+		return;
+
+	msg = entry->config.msg;
+
+	if (container && iommu_translate_msi(container->msi_doorbells, &msg))
 		return;
 
 	if (entry->gsi < 0) {
-		int ret = irq__add_msix_route(kvm, &entry->config.msg,
+		int ret = irq__add_msix_route(kvm, &msg,
 					      device->dev_hdr.dev_num << 3);
 		if (ret < 0) {
 			pr_err("cannot create MSI-X route");
@@ -111,7 +131,7 @@ static void vfio_pci_msix_table_access(struct kvm_cpu *vcpu, u64 addr, u8 *data,
 		return;
 	}
 
-	irq__update_msix_route(kvm, entry->gsi, &entry->config.msg);
+	irq__update_msix_route(kvm, entry->gsi, &msg);
 }
 
 static void vfio_pci_msi_write(struct kvm *kvm, struct vfio_device *device,
@@ -122,6 +142,7 @@ static void vfio_pci_msi_write(struct kvm *kvm, struct vfio_device *device,
 	struct msi_msg msi;
 	struct vfio_pci_msix_entry *entry;
 	struct vfio_pci_device *pdev = &device->pci;
+	struct vfio_guest_container *container = device->group->container;
 	struct msi_cap_64 *msi_cap_64 = (void *)&pdev->hdr + pdev->msi.pos;
 
 	/* Only modify routes when guest sets the enable bit */
@@ -144,6 +165,9 @@ static void vfio_pci_msi_write(struct kvm *kvm, struct vfio_device *device,
 		msi.data = msi_cap_32->data;
 	}
 
+	if (container && iommu_translate_msi(container->msi_doorbells, &msi))
+		return;
+
 	for (i = 0; i < nr_vectors; i++) {
 		u32 devid = device->dev_hdr.dev_num << 3;
 
@@ -870,6 +894,154 @@ static int vfio_configure_dev_irqs(struct kvm *kvm, struct vfio_device *device)
 	return ret;
 }
 
+static struct iommu_properties vfio_viommu_props = {
+	.name				= "viommu-vfio",
+
+	.input_addr_size		= 64,
+};
+
+static const struct iommu_properties *
+vfio_viommu_get_properties(struct device_header *dev)
+{
+	return &vfio_viommu_props;
+}
+
+static void *vfio_viommu_alloc(struct device_header *dev_hdr)
+{
+	struct vfio_device *vdev = container_of(dev_hdr, struct vfio_device,
+						dev_hdr);
+	struct vfio_guest_container *container = vdev->group->container;
+
+	container->msi_doorbells = iommu_alloc_address_space(NULL);
+	if (!container->msi_doorbells) {
+		pr_err("Failed to create MSI address space");
+		return NULL;
+	}
+
+	return container;
+}
+
+static void vfio_viommu_free(void *priv)
+{
+	struct vfio_guest_container *container = priv;
+
+	/* Half the address space */
+	size_t size = 1UL << (BITS_PER_LONG - 1);
+	unsigned long virt_addr = 0;
+	int i;
+
+	/*
+	 * Remove all mappings in two times, since 2^64 doesn't fit in
+	 * unmap.size
+	 */
+	for (i = 0; i < 2; i++, virt_addr += size) {
+		struct vfio_iommu_type1_dma_unmap unmap = {
+			.argsz	= sizeof(unmap),
+			.iova	= virt_addr,
+			.size	= size,
+		};
+	}
+
+	iommu_free_address_space(container->msi_doorbells);
+	container->msi_doorbells = NULL;
+}
+
+static int vfio_viommu_attach(void *priv, struct device_header *dev_hdr, int flags)
+{
+	struct vfio_guest_container *container = priv;
+	struct vfio_device *vdev = container_of(dev_hdr, struct vfio_device,
+						dev_hdr);
+
+	if (!container)
+		return -ENODEV;
+
+	if (container->fd != vdev->group->container->fd)
+		/*
+		 * TODO: We don't support multiple devices in the same address
+		 * space at the moment. It should be easy to implement, just
+		 * create an address space structure that holds multiple
+		 * container fds and multiplex map/unmap requests.
+		 */
+		return -EINVAL;
+
+	return 0;
+}
+
+static int vfio_viommu_detach(void *priv, struct device_header *dev_hdr)
+{
+	return 0;
+}
+
+static int vfio_viommu_map(void *priv, u64 virt_addr, u64 phys_addr, u64 size,
+			   int prot)
+{
+	int ret;
+	struct vfio_guest_container *container = priv;
+	struct vfio_iommu_type1_dma_map map = {
+		.argsz	= sizeof(map),
+		.iova	= virt_addr,
+		.size	= size,
+	};
+
+	map.vaddr = (u64)guest_flat_to_host(container->kvm, phys_addr);
+	if (!map.vaddr) {
+		if (irq__addr_is_msi_doorbell(container->kvm, phys_addr)) {
+			ret = iommu_map(container->msi_doorbells, virt_addr,
+					phys_addr, size, prot);
+			if (ret) {
+				pr_err("could not map MSI");
+				return ret;
+			}
+
+			// TODO: silence guest_flat_to_host
+			pr_info("Nevermind, all is well. Mapped MSI %llx->%llx",
+				virt_addr, phys_addr);
+			return 0;
+		} else {
+			return -ERANGE;
+		}
+	}
+
+	if (prot & IOMMU_PROT_READ)
+		map.flags |= VFIO_DMA_MAP_FLAG_READ;
+
+	if (prot & IOMMU_PROT_WRITE)
+		map.flags |= VFIO_DMA_MAP_FLAG_WRITE;
+
+	if (prot & IOMMU_PROT_EXEC) {
+		pr_err("VFIO does not support PROT_EXEC");
+		return -ENOSYS;
+	}
+
+	return ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map);
+}
+
+static int vfio_viommu_unmap(void *priv, u64 virt_addr, u64 size, int flags)
+{
+	struct vfio_guest_container *container = priv;
+	struct vfio_iommu_type1_dma_unmap unmap = {
+		.argsz	= sizeof(unmap),
+		.iova	= virt_addr,
+		.size	= size,
+	};
+
+	if (!iommu_unmap(container->msi_doorbells, virt_addr, size,
+			 flags | IOMMU_UNMAP_SILENT))
+		return 0;
+
+	return ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap);
+}
+
+static struct iommu_ops vfio_iommu_ops = {
+	.get_properties		= vfio_viommu_get_properties,
+	.alloc_address_space	= vfio_viommu_alloc,
+	.free_address_space	= vfio_viommu_free,
+	.attach			= vfio_viommu_attach,
+	.detach			= vfio_viommu_detach,
+	.map			= vfio_viommu_map,
+	.unmap			= vfio_viommu_unmap,
+};
+
 static int vfio_configure_reserved_regions(struct kvm *kvm,
 					   struct vfio_group *group)
 {
@@ -912,6 +1084,8 @@ static int vfio_configure_device(struct kvm *kvm, struct vfio_group *group,
 		return -ENOMEM;
 	}
 
+	device->group = group;
+
 	device->fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, dirent->d_name);
 	if (device->fd < 0) {
 		pr_err("Failed to get FD for device %s in group %lu",
@@ -945,6 +1119,7 @@ static int vfio_configure_device(struct kvm *kvm, struct vfio_group *group,
 	device->dev_hdr = (struct device_header) {
 		.bus_type	= DEVICE_BUS_PCI,
 		.data		= &device->pci.hdr,
+		.iommu_ops	= viommu ? &vfio_iommu_ops : NULL,
 	};
 
 	ret = device__register(&device->dev_hdr);
@@ -1009,13 +1184,13 @@ static int vfio_configure_iommu_groups(struct kvm *kvm)
 /* TODO: this should be an arch callback, so arm can return HYP only if vsmmu */
 static int vfio_get_iommu_type(void)
 {
-	if (ioctl(vfio_container, VFIO_CHECK_EXTENSION, VFIO_TYPE1_NESTING_IOMMU))
+	if (ioctl(vfio_host_container, VFIO_CHECK_EXTENSION, VFIO_TYPE1_NESTING_IOMMU))
 		return VFIO_TYPE1_NESTING_IOMMU;
 
-	if (ioctl(vfio_container, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU))
+	if (ioctl(vfio_host_container, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU))
 		return VFIO_TYPE1v2_IOMMU;
 
-	if (ioctl(vfio_container, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU))
+	if (ioctl(vfio_host_container, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU))
 		return VFIO_TYPE1_IOMMU;
 
 	return -ENODEV;
@@ -1033,7 +1208,7 @@ static int vfio_map_mem_bank(struct kvm *kvm, struct kvm_mem_bank *bank, void *d
 	};
 
 	/* Map the guest memory for DMA (i.e. provide isolation) */
-	if (ioctl(vfio_container, VFIO_IOMMU_MAP_DMA, &dma_map)) {
+	if (ioctl(vfio_host_container, VFIO_IOMMU_MAP_DMA, &dma_map)) {
 		ret = -errno;
 		pr_err("Failed to map 0x%llx -> 0x%llx (%llu) for DMA",
 		       dma_map.iova, dma_map.vaddr, dma_map.size);
@@ -1050,14 +1225,15 @@ static int vfio_unmap_mem_bank(struct kvm *kvm, struct kvm_mem_bank *bank, void
 		.iova = bank->guest_phys_addr,
 	};
 
-	ioctl(vfio_container, VFIO_IOMMU_UNMAP_DMA, &dma_unmap);
+	ioctl(vfio_host_container, VFIO_IOMMU_UNMAP_DMA, &dma_unmap);
 
 	return 0;
 }
 
 static int vfio_group_init(struct kvm *kvm, struct vfio_group *group)
 {
-	int ret;
+	int ret = 0;
+	int container;
 	char group_node[VFIO_PATH_MAX_LEN];
 	struct vfio_group_status group_status = {
 		.argsz = sizeof(group_status),
@@ -1066,6 +1242,25 @@ static int vfio_group_init(struct kvm *kvm, struct vfio_group *group)
 	snprintf(group_node, VFIO_PATH_MAX_LEN, VFIO_DEV_DIR "/%lu",
 		 group->id);
 
+	if (kvm->cfg.viommu) {
+		container = open(VFIO_DEV_NODE, O_RDWR);
+		if (container < 0) {
+			ret = -errno;
+			pr_err("cannot initialize private container\n");
+			return ret;
+		}
+
+		group->container = malloc(sizeof(struct vfio_guest_container));
+		if (!group->container)
+			return -ENOMEM;
+
+		group->container->fd = container;
+		group->container->kvm = kvm;
+		group->container->msi_doorbells = NULL;
+	} else {
+		container = vfio_host_container;
+	}
+
 	group->fd = open(group_node, O_RDWR);
 	if (group->fd == -1) {
 		ret = -errno;
@@ -1085,29 +1280,52 @@ static int vfio_group_init(struct kvm *kvm, struct vfio_group *group)
 		return -EINVAL;
 	}
 
-	if (ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &vfio_container)) {
+	if (ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container)) {
 		ret = -errno;
 		pr_err("Failed to add IOMMU group %s to VFIO container",
 		       group_node);
 		return ret;
 	}
 
-	return 0;
+	if (container != vfio_host_container) {
+		struct vfio_iommu_type1_info info = {
+			.argsz = sizeof(info),
+		};
+
+		/* We really need v2 semantics for unmap-all */
+		ret = ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1v2_IOMMU);
+		if (ret) {
+			ret = -errno;
+			pr_err("Failed to set IOMMU");
+			return ret;
+		}
+
+		ret = ioctl(container, VFIO_IOMMU_GET_INFO, &info);
+		if (ret)
+			pr_err("Failed to get IOMMU info");
+		else if (info.flags & VFIO_IOMMU_INFO_PGSIZES)
+			vfio_viommu_props.pgsize_mask = info.iova_pgsizes;
+	}
+
+	return ret;
 }
 
-static int vfio_container_init(struct kvm *kvm)
+static int vfio_groups_init(struct kvm *kvm)
 {
 	int api, i, ret, iommu_type;;
 
-	/* Create a container for our IOMMU groups */
-	vfio_container = open(VFIO_DEV_NODE, O_RDWR);
-	if (vfio_container == -1) {
+	/*
+	 * Create a container for our IOMMU groups. Even when using a viommu, we
+	 * still use this one for probing capabilities.
+	 */
+	vfio_host_container = open(VFIO_DEV_NODE, O_RDWR);
+	if (vfio_host_container == -1) {
 		ret = errno;
 		pr_err("Failed to open %s", VFIO_DEV_NODE);
 		return ret;
 	}
 
-	api = ioctl(vfio_container, VFIO_GET_API_VERSION);
+	api = ioctl(vfio_host_container, VFIO_GET_API_VERSION);
 	if (api != VFIO_API_VERSION) {
 		pr_err("Unknown VFIO API version %d", api);
 		return -ENODEV;
@@ -1119,15 +1337,20 @@ static int vfio_container_init(struct kvm *kvm)
 		return iommu_type;
 	}
 
-	/* Sanity check our groups and add them to the container */
 	for (i = 0; i < kvm->cfg.num_vfio_groups; ++i) {
 		ret = vfio_group_init(kvm, &kvm->cfg.vfio_group[i]);
 		if (ret)
 			return ret;
 	}
 
+	if (kvm->cfg.viommu) {
+		close(vfio_host_container);
+		vfio_host_container = -1;
+		return 0;
+	}
+
 	/* Finalise the container */
-	if (ioctl(vfio_container, VFIO_SET_IOMMU, iommu_type)) {
+	if (ioctl(vfio_host_container, VFIO_SET_IOMMU, iommu_type)) {
 		ret = -errno;
 		pr_err("Failed to set IOMMU type %d for VFIO container",
 		       iommu_type);
@@ -1147,10 +1370,16 @@ static int vfio__init(struct kvm *kvm)
 	if (!kvm->cfg.num_vfio_groups)
 		return 0;
 
-	ret = vfio_container_init(kvm);
+	ret = vfio_groups_init(kvm);
 	if (ret)
 		return ret;
 
+	if (kvm->cfg.viommu) {
+		viommu = viommu_register(kvm, &vfio_viommu_props);
+		if (!viommu)
+			pr_err("could not register viommu");
+	}
+
 	ret = vfio_configure_iommu_groups(kvm);
 	if (ret)
 		return ret;
@@ -1162,17 +1391,27 @@ dev_base_init(vfio__init);
 static int vfio__exit(struct kvm *kvm)
 {
 	int i, fd;
+	struct vfio_guest_container *container;
 
 	if (!kvm->cfg.num_vfio_groups)
 		return 0;
 
 	for (i = 0; i < kvm->cfg.num_vfio_groups; ++i) {
+		container = kvm->cfg.vfio_group[i].container;
 		fd = kvm->cfg.vfio_group[i].fd;
 		ioctl(fd, VFIO_GROUP_UNSET_CONTAINER);
 		close(fd);
+
+		if (container != NULL) {
+			close(container->fd);
+			free(container);
+		}
 	}
 
+	if (vfio_host_container == -1)
+		return 0;
+
 	kvm__for_each_mem_bank(kvm, KVM_MEM_TYPE_RAM, vfio_unmap_mem_bank, NULL);
-	return close(vfio_container);
+	return close(vfio_host_container);
 }
 dev_base_exit(vfio__exit);
-- 
2.12.1
