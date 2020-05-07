From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 03/15] virtio-mem: Allow to specify an ACPI PXM as nid
Date: Thu,  7 May 2020 16:01:27 +0200
Message-ID: <20200507140139.17083-4-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Jason Wang <jasowang@redhat.com>, Oscar Salvador <osalvador@suse.de>, Igor Mammedov <imammedo@redhat.com>, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

We want to allow to specify (similar as for a DIMM), to which node a
virtio-mem device (and, therefore, its memory) belongs. Add a new
virtio-mem feature flag and export pxm_to_node, so it can be used in kernel
module context.

Acked-by: Michal Hocko <mhocko@suse.com> # for the export
Acked-by: "Rafael J. Wysocki" <rafael@kernel.org> # for the export
Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Tested-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/acpi/numa/srat.c        |  1 +
 drivers/virtio/virtio_mem.c     | 39 +++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_mem.h | 10 ++++++++-
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 47b4969d9b93..5be5a977da1b 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -35,6 +35,7 @@ int pxm_to_node(int pxm)
 		return NUMA_NO_NODE;
 	return pxm_to_node_map[pxm];
 }
+EXPORT_SYMBOL(pxm_to_node);
 
 int node_to_pxm(int node)
 {
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 5d1dcaa6fc42..270ddeaec059 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -21,6 +21,8 @@
 #include <linux/bitmap.h>
 #include <linux/lockdep.h>
 
+#include <acpi/acpi_numa.h>
+
 enum virtio_mem_mb_state {
 	/* Unplugged, not added to Linux. Can be reused later. */
 	VIRTIO_MEM_MB_STATE_UNUSED = 0,
@@ -72,6 +74,8 @@ struct virtio_mem {
 
 	/* The device block size (for communicating with the device). */
 	uint32_t device_block_size;
+	/* The translated node id. NUMA_NO_NODE in case not specified. */
+	int nid;
 	/* Physical start address of the memory region. */
 	uint64_t addr;
 	/* Maximum region size in bytes. */
@@ -389,7 +393,10 @@ static int virtio_mem_sb_bitmap_prepare_next_mb(struct virtio_mem *vm)
 static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
-	int nid = memory_add_physaddr_to_nid(addr);
+	int nid = vm->nid;
+
+	if (nid == NUMA_NO_NODE)
+		nid = memory_add_physaddr_to_nid(addr);
 
 	dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
 	return add_memory(nid, addr, memory_block_size_bytes());
@@ -407,7 +414,10 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
-	int nid = memory_add_physaddr_to_nid(addr);
+	int nid = vm->nid;
+
+	if (nid == NUMA_NO_NODE)
+		nid = memory_add_physaddr_to_nid(addr);
 
 	dev_dbg(&vm->vdev->dev, "removing memory block: %lu\n", mb_id);
 	return remove_memory(nid, addr, memory_block_size_bytes());
@@ -426,6 +436,17 @@ static void virtio_mem_retry(struct virtio_mem *vm)
 	spin_unlock_irqrestore(&vm->removal_lock, flags);
 }
 
+static int virtio_mem_translate_node_id(struct virtio_mem *vm, uint16_t node_id)
+{
+	int node = NUMA_NO_NODE;
+
+#if defined(CONFIG_ACPI_NUMA)
+	if (virtio_has_feature(vm->vdev, VIRTIO_MEM_F_ACPI_PXM))
+		node = pxm_to_node(node_id);
+#endif
+	return node;
+}
+
 /*
  * Test if a virtio-mem device overlaps with the given range. Can be called
  * from (notifier) callbacks lockless.
@@ -1267,6 +1288,7 @@ static bool virtio_mem_any_memory_present(unsigned long start,
 static int virtio_mem_init(struct virtio_mem *vm)
 {
 	const uint64_t phys_limit = 1UL << MAX_PHYSMEM_BITS;
+	uint16_t node_id;
 
 	if (!vm->vdev->config->get) {
 		dev_err(&vm->vdev->dev, "config access disabled\n");
@@ -1287,6 +1309,9 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		     &vm->plugged_size);
 	virtio_cread(vm->vdev, struct virtio_mem_config, block_size,
 		     &vm->device_block_size);
+	virtio_cread(vm->vdev, struct virtio_mem_config, node_id,
+		     &node_id);
+	vm->nid = virtio_mem_translate_node_id(vm, node_id);
 	virtio_cread(vm->vdev, struct virtio_mem_config, addr, &vm->addr);
 	virtio_cread(vm->vdev, struct virtio_mem_config, region_size,
 		     &vm->region_size);
@@ -1365,6 +1390,8 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		 memory_block_size_bytes());
 	dev_info(&vm->vdev->dev, "subblock size: 0x%x",
 		 vm->subblock_size);
+	if (vm->nid != NUMA_NO_NODE)
+		dev_info(&vm->vdev->dev, "nid: %d", vm->nid);
 
 	return 0;
 }
@@ -1508,12 +1535,20 @@ static int virtio_mem_restore(struct virtio_device *vdev)
 }
 #endif
 
+static unsigned int virtio_mem_features[] = {
+#if defined(CONFIG_NUMA) && defined(CONFIG_ACPI_NUMA)
+	VIRTIO_MEM_F_ACPI_PXM,
+#endif
+};
+
 static struct virtio_device_id virtio_mem_id_table[] = {
 	{ VIRTIO_ID_MEM, VIRTIO_DEV_ANY_ID },
 	{ 0 },
 };
 
 static struct virtio_driver virtio_mem_driver = {
+	.feature_table = virtio_mem_features,
+	.feature_table_size = ARRAY_SIZE(virtio_mem_features),
 	.driver.name = KBUILD_MODNAME,
 	.driver.owner = THIS_MODULE,
 	.id_table = virtio_mem_id_table,
diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_mem.h
index 1bfade78bdfd..e0a9dc7397c3 100644
--- a/include/uapi/linux/virtio_mem.h
+++ b/include/uapi/linux/virtio_mem.h
@@ -83,6 +83,12 @@
  * device is busy.
  */
 
+/* --- virtio-mem: feature bits --- */
+
+/* node_id is an ACPI PXM and is valid */
+#define VIRTIO_MEM_F_ACPI_PXM		0
+
+
 /* --- virtio-mem: guest -> host requests --- */
 
 /* request to plug memory blocks */
@@ -177,7 +183,9 @@ struct virtio_mem_resp {
 struct virtio_mem_config {
 	/* Block size and alignment. Cannot change. */
 	__u32 block_size;
-	__u32 padding;
+	/* Valid with VIRTIO_MEM_F_ACPI_PXM. Cannot change. */
+	__u16 node_id;
+	__u16 padding;
 	/* Start address of the memory region. Cannot change. */
 	__u64 addr;
 	/* Region size (maximum). Cannot change. */
-- 
2.25.3
