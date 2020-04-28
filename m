From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: [PATCH 5/5] virtio: Add bounce DMA ops
Date: Tue, 28 Apr 2020 17:09:18 +0530
Message-ID: <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com, jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, vatsa@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

For better security, its desirable that a guest VM's memory is
not accessible to any entity that executes outside the context of
guest VM. In case of virtio, backend drivers execute outside the
context of guest VM and in general will need access to complete
guest VM memory.  One option to restrict the access provided to
backend driver is to make use of a bounce buffer. The bounce
buffer is accessible to both backend and frontend drivers. All IO
buffers that are in private space of guest VM are bounced to be
accessible to backend.

This patch proposes a new memory pool to be used for this bounce
purpose, rather than the default swiotlb memory pool. That will
avoid any conflicts that may arise in situations where a VM needs
to use swiotlb pool for driving any pass-through devices (in
which case swiotlb memory needs not be shared with another VM) as
well as virtio devices (which will require swiotlb memory to be
shared with backend VM). As a possible extension to this patch,
we can provide an option for virtio to make use of default
swiotlb memory pool itself, where no such conflicts may exist in
a given deployment.

Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
---
 drivers/virtio/Makefile        |   2 +-
 drivers/virtio/virtio.c        |   2 +
 drivers/virtio/virtio_bounce.c | 150 +++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h         |   4 ++
 4 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virtio/virtio_bounce.c

diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 29a1386e..3fd3515 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
+obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o virtio_bounce.o
 obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
 virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a977e32..bc2f779 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -329,6 +329,7 @@ int register_virtio_device(struct virtio_device *dev)
 
 	dev->index = err;
 	dev_set_name(&dev->dev, "virtio%u", dev->index);
+	virtio_bounce_set_dma_ops(dev);
 
 	spin_lock_init(&dev->config_lock);
 	dev->config_enabled = false;
@@ -431,6 +432,7 @@ EXPORT_SYMBOL_GPL(virtio_device_restore);
 
 static int virtio_init(void)
 {
+	virtio_map_bounce_buffer();
 	if (bus_register(&virtio_bus) != 0)
 		panic("virtio bus registration failed");
 	return 0;
diff --git a/drivers/virtio/virtio_bounce.c b/drivers/virtio/virtio_bounce.c
new file mode 100644
index 0000000..3de8e0e
--- /dev/null
+++ b/drivers/virtio/virtio_bounce.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Virtio DMA ops to bounce buffers
+ *
+ *  Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ *
+ * This module allows bouncing of IO buffers to a region which will be
+ * accessible to backend drivers.
+ */
+
+#include <linux/virtio.h>
+#include <linux/io.h>
+#include <linux/swiotlb.h>
+#include <linux/dma-mapping.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+
+static phys_addr_t bounce_buf_paddr;
+static void *bounce_buf_vaddr;
+static size_t bounce_buf_size;
+struct swiotlb_pool *virtio_pool;
+
+#define VIRTIO_MAX_BOUNCE_SIZE	(16*4096)
+
+static void *virtio_alloc_coherent(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp_flags, unsigned long attrs)
+{
+	phys_addr_t addr;
+
+	if (!virtio_pool)
+		return NULL;
+
+	addr = swiotlb_alloc(virtio_pool, size, bounce_buf_paddr, ULONG_MAX);
+	if (addr == DMA_MAPPING_ERROR)
+		return NULL;
+
+	*dma_handle = (addr - bounce_buf_paddr);
+
+	return bounce_buf_vaddr + (addr - bounce_buf_paddr);
+}
+
+static void virtio_free_coherent(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_handle, unsigned long attrs)
+{
+	phys_addr_t addr = (dma_handle + bounce_buf_paddr);
+
+	swiotlb_free(virtio_pool, addr, size);
+}
+
+static dma_addr_t virtio_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	void *ptr = page_address(page) + offset;
+	phys_addr_t paddr = virt_to_phys(ptr);
+	dma_addr_t handle;
+
+	if (!virtio_pool)
+		return DMA_MAPPING_ERROR;
+
+	handle = _swiotlb_tbl_map_single(virtio_pool, dev, bounce_buf_paddr,
+					 paddr, size, size, dir, attrs);
+	if (handle == (phys_addr_t)DMA_MAPPING_ERROR)
+		return DMA_MAPPING_ERROR;
+
+	return handle - bounce_buf_paddr;
+}
+
+static void virtio_unmap_page(struct device *dev, dma_addr_t dev_addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	phys_addr_t addr = dev_addr + bounce_buf_paddr;
+
+	_swiotlb_tbl_unmap_single(virtio_pool, dev, addr, size,
+					size, dir, attrs);
+}
+
+size_t virtio_max_mapping_size(struct device *dev)
+{
+	return VIRTIO_MAX_BOUNCE_SIZE;
+}
+
+static const struct dma_map_ops virtio_dma_ops = {
+	.alloc			= virtio_alloc_coherent,
+	.free			= virtio_free_coherent,
+	.map_page		= virtio_map_page,
+	.unmap_page		= virtio_unmap_page,
+	.max_mapping_size	= virtio_max_mapping_size,
+};
+
+void virtio_bounce_set_dma_ops(struct virtio_device *vdev)
+{
+	if (!bounce_buf_paddr)
+		return;
+
+	set_dma_ops(vdev->dev.parent, &virtio_dma_ops);
+}
+
+int virtio_map_bounce_buffer(void)
+{
+	int ret;
+
+	if (!bounce_buf_paddr)
+		return 0;
+
+	/*
+	 * Map region as 'cacheable' memory. This will reduce access latency for
+	 * backend.
+	 */
+	bounce_buf_vaddr = memremap(bounce_buf_paddr,
+				bounce_buf_size, MEMREMAP_WB);
+	if (!bounce_buf_vaddr)
+		return -ENOMEM;
+
+	memset(bounce_buf_vaddr, 0, bounce_buf_size);
+	virtio_pool = swiotlb_register_pool("virtio_swiotlb", bounce_buf_paddr,
+				bounce_buf_vaddr, bounce_buf_size);
+	if (IS_ERR(virtio_pool)) {
+		ret = PTR_ERR(virtio_pool);
+		virtio_pool = NULL;
+		memunmap(bounce_buf_vaddr);
+		return ret;
+	}
+
+	return 0;
+}
+
+int virtio_register_bounce_buffer(phys_addr_t base, size_t size)
+{
+	if (bounce_buf_paddr || !base || size < PAGE_SIZE)
+		return -EINVAL;
+
+	bounce_buf_paddr = base;
+	bounce_buf_size = size;
+
+	return 0;
+}
+
+static int __init virtio_bounce_setup(struct reserved_mem *rmem)
+{
+	unsigned long node = rmem->fdt_node;
+
+	if (!of_get_flat_dt_prop(node, "no-map", NULL))
+		return -EINVAL;
+
+	return virtio_register_bounce_buffer(rmem->base, rmem->size);
+}
+
+RESERVEDMEM_OF_DECLARE(virtio, "virtio_bounce_pool", virtio_bounce_setup);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index a493eac..c4970c5 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -134,12 +134,16 @@ void virtio_config_changed(struct virtio_device *dev);
 void virtio_config_disable(struct virtio_device *dev);
 void virtio_config_enable(struct virtio_device *dev);
 int virtio_finalize_features(struct virtio_device *dev);
+int virtio_register_bounce_buffer(phys_addr_t base, size_t size);
+
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
 #endif
 
 size_t virtio_max_dma_size(struct virtio_device *vdev);
+extern int virtio_map_bounce_buffer(void);
+extern void virtio_bounce_set_dma_ops(struct virtio_device *dev);
 
 #define virtio_device_for_each_vq(vdev, vq) \
 	list_for_each_entry(vq, &vdev->vqs, list)
-- 
2.7.4

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
