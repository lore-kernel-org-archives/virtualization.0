From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: [PATCH 1/5] swiotlb: Introduce concept of swiotlb_pool
Date: Tue, 28 Apr 2020 17:09:14 +0530
Message-ID: <1588073958-1793-2-git-send-email-vatsa@codeaurora.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com, jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, vatsa@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Currently swiotlb driver manages a global pool of memory which
acts as bounce buffers for memory that is not accessible to some
devices. The core functions provides by this driver to
allocate/free/bounce memory chunks will be more
useful if this driver can manage more than one pool. An immediate
application of such extension to swiotlb driver is to bounce
virtio buffers between private and shared space of a VM.

This patch introduces the concept of a swiotlb memory pool and
reorganizes current driver to work with the default global pool.
There is no functional change introduced by this patch.
Subsequent patches allow the swiotlb driver to work with more
than one pool of memory.

Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
---
 drivers/xen/swiotlb-xen.c |   4 +-
 include/linux/swiotlb.h   | 129 ++++++++++++++++-
 kernel/dma/swiotlb.c      | 359 +++++++++++++++++++++++-----------------------
 3 files changed, 307 insertions(+), 185 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index b6d2776..c2dc9c8 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -190,8 +190,8 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 	/*
 	 * IO TLB memory already allocated. Just use it.
 	 */
-	if (io_tlb_start != 0) {
-		xen_io_tlb_start = phys_to_virt(io_tlb_start);
+	if (swiotlb_start()) {
+		xen_io_tlb_start = phys_to_virt(swiotlb_start());
 		goto end;
 	}
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 046bb94..8c7843f 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -44,7 +44,59 @@ enum dma_sync_target {
 	SYNC_FOR_DEVICE = 1,
 };
 
-extern phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
+#define MAX_POOL_NAME_SIZE	16
+
+struct swiotlb_pool {
+	char name[MAX_POOL_NAME_SIZE];
+	bool no_iotlb_memory;
+	int late_alloc;
+
+	spinlock_t io_tlb_lock;
+
+	/*
+	 * Used to do a quick range check in swiotlb_tbl_unmap_single and
+	 * swiotlb_tbl_sync_single_*, to see if the memory was in fact allocated
+	 * by this API.
+	 */
+
+	phys_addr_t io_tlb_start, io_tlb_end;
+
+	/*
+	 * The number of IO TLB blocks (in groups of 64) between io_tlb_start
+	 * and io_tlb_end.  This is command line adjustable via
+	 * setup_io_tlb_npages.
+	 */
+	unsigned long io_tlb_nslabs;
+
+	/*
+	 * The number of used IO TLB block
+	 */
+	unsigned long io_tlb_used;
+
+	/*
+	 * This is a free list describing the number of free entries available
+	 * from each index
+	 */
+	unsigned int *io_tlb_list;
+	unsigned int io_tlb_index;
+
+	/*
+	 * We need to save away the original address corresponding to a mapped
+	 * entry for the sync operations.
+	 */
+	phys_addr_t *io_tlb_orig_addr;
+
+	/*
+	 * Max segment that we can provide which (if pages are contingous) will
+	 * not be bounced (unless SWIOTLB_FORCE is set).
+	 */
+	unsigned int max_segment;
+};
+
+extern struct swiotlb_pool default_swiotlb_pool;
+
+extern phys_addr_t _swiotlb_tbl_map_single(struct swiotlb_pool *pool,
+					  struct device *hwdev,
 					  dma_addr_t tbl_dma_addr,
 					  phys_addr_t phys,
 					  size_t mapping_size,
@@ -52,28 +104,80 @@ extern phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 					  enum dma_data_direction dir,
 					  unsigned long attrs);
 
-extern void swiotlb_tbl_unmap_single(struct device *hwdev,
+extern void _swiotlb_tbl_unmap_single(struct swiotlb_pool *pool,
+				     struct device *hwdev,
 				     phys_addr_t tlb_addr,
 				     size_t mapping_size,
 				     size_t alloc_size,
 				     enum dma_data_direction dir,
 				     unsigned long attrs);
 
-extern void swiotlb_tbl_sync_single(struct device *hwdev,
+extern void _swiotlb_tbl_sync_single(struct swiotlb_pool *pool,
+				    struct device *hwdev,
 				    phys_addr_t tlb_addr,
 				    size_t size, enum dma_data_direction dir,
 				    enum dma_sync_target target);
 
-dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
-		size_t size, enum dma_data_direction dir, unsigned long attrs);
+dma_addr_t _swiotlb_map(struct swiotlb_pool *pool, struct device *dev,
+		phys_addr_t phys, size_t size, enum dma_data_direction dir,
+		unsigned long attrs);
+
+static inline phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
+					  dma_addr_t tbl_dma_addr,
+					  phys_addr_t phys,
+					  size_t mapping_size,
+					  size_t alloc_size,
+					  enum dma_data_direction dir,
+					  unsigned long attrs)
+{
+	return _swiotlb_tbl_map_single(&default_swiotlb_pool, hwdev,
+			tbl_dma_addr, phys, mapping_size,
+			alloc_size, dir, attrs);
+}
+
+static inline void swiotlb_tbl_unmap_single(struct device *hwdev,
+				     phys_addr_t tlb_addr,
+				     size_t mapping_size,
+				     size_t alloc_size,
+				     enum dma_data_direction dir,
+				     unsigned long attrs)
+{
+	_swiotlb_tbl_unmap_single(&default_swiotlb_pool, hwdev, tlb_addr,
+		mapping_size, alloc_size, dir, attrs);
+}
+
+static inline void swiotlb_tbl_sync_single(struct device *hwdev,
+				    phys_addr_t tlb_addr,
+				    size_t size, enum dma_data_direction dir,
+				    enum dma_sync_target target)
+{
+	return _swiotlb_tbl_sync_single(&default_swiotlb_pool, hwdev, tlb_addr,
+			size, dir, target);
+}
+
+static inline dma_addr_t swiotlb_map(struct device *dev,
+		phys_addr_t phys, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	return _swiotlb_map(&default_swiotlb_pool, dev, phys, size, dir, attrs);
+}
 
 #ifdef CONFIG_SWIOTLB
 extern enum swiotlb_force swiotlb_force;
-extern phys_addr_t io_tlb_start, io_tlb_end;
+
+static inline phys_addr_t swiotlb_start(void)
+{
+	return default_swiotlb_pool.io_tlb_start;
+}
+
+static inline phys_addr_t swiotlb_end(void)
+{
+	return default_swiotlb_pool.io_tlb_end;
+}
 
 static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 {
-	return paddr >= io_tlb_start && paddr < io_tlb_end;
+	return paddr >= swiotlb_start() && paddr < swiotlb_end();
 }
 
 void __init swiotlb_exit(void);
@@ -82,6 +186,17 @@ size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(void);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
+
+static inline unsigned long swiotlb_start(void)
+{
+	return 0;
+}
+
+static inline phys_addr_t swiotlb_end(void)
+{
+	return 0;
+}
+
 static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 {
 	return false;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c19379fa..9c504d3 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -64,58 +64,24 @@
 
 enum swiotlb_force swiotlb_force;
 
-/*
- * Used to do a quick range check in swiotlb_tbl_unmap_single and
- * swiotlb_tbl_sync_single_*, to see if the memory was in fact allocated by this
- * API.
- */
-phys_addr_t io_tlb_start, io_tlb_end;
-
-/*
- * The number of IO TLB blocks (in groups of 64) between io_tlb_start and
- * io_tlb_end.  This is command line adjustable via setup_io_tlb_npages.
- */
-static unsigned long io_tlb_nslabs;
-
-/*
- * The number of used IO TLB block
- */
-static unsigned long io_tlb_used;
-
-/*
- * This is a free list describing the number of free entries available from
- * each index
- */
-static unsigned int *io_tlb_list;
-static unsigned int io_tlb_index;
-
-/*
- * Max segment that we can provide which (if pages are contingous) will
- * not be bounced (unless SWIOTLB_FORCE is set).
- */
-unsigned int max_segment;
-
-/*
- * We need to save away the original address corresponding to a mapped entry
- * for the sync operations.
- */
 #define INVALID_PHYS_ADDR (~(phys_addr_t)0)
-static phys_addr_t *io_tlb_orig_addr;
-
-/*
- * Protect the above data structures in the map and unmap calls
- */
-static DEFINE_SPINLOCK(io_tlb_lock);
 
-static int late_alloc;
+struct swiotlb_pool default_swiotlb_pool = {
+		.name	= "default_pool",
+		.io_tlb_lock =
+			__SPIN_LOCK_UNLOCKED(default_swiotlb_pool.io_tlb_lock),
+};
 
 static int __init
 setup_io_tlb_npages(char *str)
 {
+	unsigned long nslabs;
+
 	if (isdigit(*str)) {
-		io_tlb_nslabs = simple_strtoul(str, &str, 0);
+		nslabs = simple_strtoul(str, &str, 0);
 		/* avoid tail segment of size < IO_TLB_SEGSIZE */
-		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
+		nslabs = ALIGN(nslabs, IO_TLB_SEGSIZE);
+		default_swiotlb_pool.io_tlb_nslabs = nslabs;
 	}
 	if (*str == ',')
 		++str;
@@ -123,33 +89,33 @@ setup_io_tlb_npages(char *str)
 		swiotlb_force = SWIOTLB_FORCE;
 	} else if (!strcmp(str, "noforce")) {
 		swiotlb_force = SWIOTLB_NO_FORCE;
-		io_tlb_nslabs = 1;
+		default_swiotlb_pool.io_tlb_nslabs = 1;
 	}
 
 	return 0;
 }
 early_param("swiotlb", setup_io_tlb_npages);
 
-static bool no_iotlb_memory;
-
 unsigned long swiotlb_nr_tbl(void)
 {
-	return unlikely(no_iotlb_memory) ? 0 : io_tlb_nslabs;
+	return unlikely(default_swiotlb_pool.no_iotlb_memory) ?
+				0 : default_swiotlb_pool.io_tlb_nslabs;
 }
 EXPORT_SYMBOL_GPL(swiotlb_nr_tbl);
 
 unsigned int swiotlb_max_segment(void)
 {
-	return unlikely(no_iotlb_memory) ? 0 : max_segment;
+	return unlikely(default_swiotlb_pool.no_iotlb_memory) ?
+					 0 : default_swiotlb_pool.max_segment;
 }
 EXPORT_SYMBOL_GPL(swiotlb_max_segment);
 
 void swiotlb_set_max_segment(unsigned int val)
 {
 	if (swiotlb_force == SWIOTLB_FORCE)
-		max_segment = 1;
+		default_swiotlb_pool.max_segment = 1;
 	else
-		max_segment = rounddown(val, PAGE_SIZE);
+		default_swiotlb_pool.max_segment = rounddown(val, PAGE_SIZE);
 }
 
 /* default to 64MB */
@@ -158,23 +124,25 @@ unsigned long swiotlb_size_or_default(void)
 {
 	unsigned long size;
 
-	size = io_tlb_nslabs << IO_TLB_SHIFT;
+	size = default_swiotlb_pool.io_tlb_nslabs << IO_TLB_SHIFT;
 
 	return size ? size : (IO_TLB_DEFAULT_SIZE);
 }
 
 void swiotlb_print_info(void)
 {
-	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
+	unsigned long bytes;
+
+	bytes = default_swiotlb_pool.io_tlb_nslabs << IO_TLB_SHIFT;
 
-	if (no_iotlb_memory) {
+	if (default_swiotlb_pool.no_iotlb_memory) {
 		pr_warn("No low mem\n");
 		return;
 	}
 
 	pr_info("mapped [mem %#010llx-%#010llx] (%luMB)\n",
-	       (unsigned long long)io_tlb_start,
-	       (unsigned long long)io_tlb_end,
+	       (unsigned long long)default_swiotlb_pool.io_tlb_start,
+	       (unsigned long long)default_swiotlb_pool.io_tlb_end,
 	       bytes >> 20);
 }
 
@@ -189,11 +157,12 @@ void __init swiotlb_update_mem_attributes(void)
 	void *vaddr;
 	unsigned long bytes;
 
-	if (no_iotlb_memory || late_alloc)
+	if (default_swiotlb_pool.no_iotlb_memory ||
+				default_swiotlb_pool.late_alloc)
 		return;
 
-	vaddr = phys_to_virt(io_tlb_start);
-	bytes = PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT);
+	vaddr = phys_to_virt(default_swiotlb_pool.io_tlb_start);
+	bytes = PAGE_ALIGN(default_swiotlb_pool.io_tlb_nslabs << IO_TLB_SHIFT);
 	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
 	memset(vaddr, 0, bytes);
 }
@@ -205,37 +174,44 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 
 	bytes = nslabs << IO_TLB_SHIFT;
 
-	io_tlb_nslabs = nslabs;
-	io_tlb_start = __pa(tlb);
-	io_tlb_end = io_tlb_start + bytes;
+	default_swiotlb_pool.io_tlb_nslabs = nslabs;
+	default_swiotlb_pool.io_tlb_start = __pa(tlb);
+	default_swiotlb_pool.io_tlb_end =
+			default_swiotlb_pool.io_tlb_start + bytes;
 
 	/*
 	 * Allocate and initialize the free list array.  This array is used
 	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
 	 * between io_tlb_start and io_tlb_end.
 	 */
-	alloc_size = PAGE_ALIGN(io_tlb_nslabs * sizeof(int));
-	io_tlb_list = memblock_alloc(alloc_size, PAGE_SIZE);
-	if (!io_tlb_list)
+	alloc_size = PAGE_ALIGN(default_swiotlb_pool.io_tlb_nslabs *
+								sizeof(int));
+	default_swiotlb_pool.io_tlb_list =
+				memblock_alloc(alloc_size, PAGE_SIZE);
+	if (!default_swiotlb_pool.io_tlb_list)
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
 
-	alloc_size = PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t));
-	io_tlb_orig_addr = memblock_alloc(alloc_size, PAGE_SIZE);
-	if (!io_tlb_orig_addr)
+	alloc_size = PAGE_ALIGN(default_swiotlb_pool.io_tlb_nslabs *
+						sizeof(phys_addr_t));
+	default_swiotlb_pool.io_tlb_orig_addr =
+				memblock_alloc(alloc_size, PAGE_SIZE);
+	if (!default_swiotlb_pool.io_tlb_orig_addr)
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
 
-	for (i = 0; i < io_tlb_nslabs; i++) {
-		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
-		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
+	for (i = 0; i < default_swiotlb_pool.io_tlb_nslabs; i++) {
+		default_swiotlb_pool.io_tlb_list[i] = IO_TLB_SEGSIZE -
+						OFFSET(i, IO_TLB_SEGSIZE);
+		default_swiotlb_pool.io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
 	}
-	io_tlb_index = 0;
+	default_swiotlb_pool.io_tlb_index = 0;
 
 	if (verbose)
 		swiotlb_print_info();
 
-	swiotlb_set_max_segment(io_tlb_nslabs << IO_TLB_SHIFT);
+	swiotlb_set_max_segment(default_swiotlb_pool.io_tlb_nslabs <<
+								IO_TLB_SHIFT);
 	return 0;
 }
 
@@ -249,24 +225,28 @@ swiotlb_init(int verbose)
 	size_t default_size = IO_TLB_DEFAULT_SIZE;
 	unsigned char *vstart;
 	unsigned long bytes;
+	unsigned long nslabs;
 
-	if (!io_tlb_nslabs) {
-		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
-		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
+	if (!default_swiotlb_pool.io_tlb_nslabs) {
+		nslabs = (default_size >> IO_TLB_SHIFT);
+		nslabs = ALIGN(nslabs, IO_TLB_SEGSIZE);
+		default_swiotlb_pool.io_tlb_nslabs = nslabs;
 	}
 
-	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
+	bytes = default_swiotlb_pool.io_tlb_nslabs << IO_TLB_SHIFT;
 
 	/* Get IO TLB memory from the low pages */
 	vstart = memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
-	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose))
+	if (vstart && !swiotlb_init_with_tbl(vstart,
+				default_swiotlb_pool.io_tlb_nslabs, verbose))
 		return;
 
-	if (io_tlb_start)
-		memblock_free_early(io_tlb_start,
-				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
+	if (default_swiotlb_pool.io_tlb_start)
+		memblock_free_early(default_swiotlb_pool.io_tlb_start,
+			PAGE_ALIGN(default_swiotlb_pool.io_tlb_nslabs <<
+								IO_TLB_SHIFT));
 	pr_warn("Cannot allocate buffer");
-	no_iotlb_memory = true;
+	default_swiotlb_pool.no_iotlb_memory = true;
 }
 
 /*
@@ -277,22 +257,24 @@ swiotlb_init(int verbose)
 int
 swiotlb_late_init_with_default_size(size_t default_size)
 {
-	unsigned long bytes, req_nslabs = io_tlb_nslabs;
+	unsigned long bytes, req_nslabs = default_swiotlb_pool.io_tlb_nslabs;
 	unsigned char *vstart = NULL;
 	unsigned int order;
+	unsigned long nslabs;
 	int rc = 0;
 
-	if (!io_tlb_nslabs) {
-		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
-		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
+	if (!default_swiotlb_pool.io_tlb_nslabs) {
+		nslabs = (default_size >> IO_TLB_SHIFT);
+		nslabs = ALIGN(nslabs, IO_TLB_SEGSIZE);
+		default_swiotlb_pool.io_tlb_nslabs = nslabs;
 	}
 
 	/*
 	 * Get IO TLB memory from the low pages
 	 */
-	order = get_order(io_tlb_nslabs << IO_TLB_SHIFT);
-	io_tlb_nslabs = SLABS_PER_PAGE << order;
-	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
+	order = get_order(default_swiotlb_pool.io_tlb_nslabs << IO_TLB_SHIFT);
+	default_swiotlb_pool.io_tlb_nslabs = SLABS_PER_PAGE << order;
+	bytes = default_swiotlb_pool.io_tlb_nslabs << IO_TLB_SHIFT;
 
 	while ((SLABS_PER_PAGE << order) > IO_TLB_MIN_SLABS) {
 		vstart = (void *)__get_free_pages(GFP_DMA | __GFP_NOWARN,
@@ -303,15 +285,16 @@ swiotlb_late_init_with_default_size(size_t default_size)
 	}
 
 	if (!vstart) {
-		io_tlb_nslabs = req_nslabs;
+		default_swiotlb_pool.io_tlb_nslabs = req_nslabs;
 		return -ENOMEM;
 	}
 	if (order != get_order(bytes)) {
 		pr_warn("only able to allocate %ld MB\n",
 			(PAGE_SIZE << order) >> 20);
-		io_tlb_nslabs = SLABS_PER_PAGE << order;
+		default_swiotlb_pool.io_tlb_nslabs = SLABS_PER_PAGE << order;
 	}
-	rc = swiotlb_late_init_with_tbl(vstart, io_tlb_nslabs);
+	rc = swiotlb_late_init_with_tbl(vstart,
+					default_swiotlb_pool.io_tlb_nslabs);
 	if (rc)
 		free_pages((unsigned long)vstart, order);
 
@@ -320,10 +303,10 @@ swiotlb_late_init_with_default_size(size_t default_size)
 
 static void swiotlb_cleanup(void)
 {
-	io_tlb_end = 0;
-	io_tlb_start = 0;
-	io_tlb_nslabs = 0;
-	max_segment = 0;
+	default_swiotlb_pool.io_tlb_end = 0;
+	default_swiotlb_pool.io_tlb_start = 0;
+	default_swiotlb_pool.io_tlb_nslabs = 0;
+	default_swiotlb_pool.max_segment = 0;
 }
 
 int
@@ -333,9 +316,10 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 
 	bytes = nslabs << IO_TLB_SHIFT;
 
-	io_tlb_nslabs = nslabs;
-	io_tlb_start = virt_to_phys(tlb);
-	io_tlb_end = io_tlb_start + bytes;
+	default_swiotlb_pool.io_tlb_nslabs = nslabs;
+	default_swiotlb_pool.io_tlb_start = virt_to_phys(tlb);
+	default_swiotlb_pool.io_tlb_end =
+			default_swiotlb_pool.io_tlb_start + bytes;
 
 	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
 	memset(tlb, 0, bytes);
@@ -345,36 +329,39 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
 	 * between io_tlb_start and io_tlb_end.
 	 */
-	io_tlb_list = (unsigned int *)__get_free_pages(GFP_KERNEL,
-	                              get_order(io_tlb_nslabs * sizeof(int)));
-	if (!io_tlb_list)
+	default_swiotlb_pool.io_tlb_list =
+		(unsigned int *)__get_free_pages(GFP_KERNEL,
+		get_order(default_swiotlb_pool.io_tlb_nslabs * sizeof(int)));
+	if (!default_swiotlb_pool.io_tlb_list)
 		goto cleanup3;
 
-	io_tlb_orig_addr = (phys_addr_t *)
+	default_swiotlb_pool.io_tlb_orig_addr = (phys_addr_t *)
 		__get_free_pages(GFP_KERNEL,
-				 get_order(io_tlb_nslabs *
+				 get_order(default_swiotlb_pool.io_tlb_nslabs *
 					   sizeof(phys_addr_t)));
-	if (!io_tlb_orig_addr)
+	if (!default_swiotlb_pool.io_tlb_orig_addr)
 		goto cleanup4;
 
-	for (i = 0; i < io_tlb_nslabs; i++) {
-		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
-		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
+	for (i = 0; i < default_swiotlb_pool.io_tlb_nslabs; i++) {
+		default_swiotlb_pool.io_tlb_list[i] = IO_TLB_SEGSIZE -
+						OFFSET(i, IO_TLB_SEGSIZE);
+		default_swiotlb_pool.io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
 	}
-	io_tlb_index = 0;
+	default_swiotlb_pool.io_tlb_index = 0;
 
 	swiotlb_print_info();
 
-	late_alloc = 1;
+	default_swiotlb_pool.late_alloc = 1;
 
-	swiotlb_set_max_segment(io_tlb_nslabs << IO_TLB_SHIFT);
+	swiotlb_set_max_segment(default_swiotlb_pool.io_tlb_nslabs <<
+								IO_TLB_SHIFT);
 
 	return 0;
 
 cleanup4:
-	free_pages((unsigned long)io_tlb_list, get_order(io_tlb_nslabs *
-	                                                 sizeof(int)));
-	io_tlb_list = NULL;
+	free_pages((unsigned long)default_swiotlb_pool.io_tlb_list,
+		get_order(default_swiotlb_pool.io_tlb_nslabs * sizeof(int)));
+	default_swiotlb_pool.io_tlb_list = NULL;
 cleanup3:
 	swiotlb_cleanup();
 	return -ENOMEM;
@@ -382,23 +369,30 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 
 void __init swiotlb_exit(void)
 {
-	if (!io_tlb_orig_addr)
+	if (!default_swiotlb_pool.io_tlb_orig_addr)
 		return;
 
-	if (late_alloc) {
-		free_pages((unsigned long)io_tlb_orig_addr,
-			   get_order(io_tlb_nslabs * sizeof(phys_addr_t)));
-		free_pages((unsigned long)io_tlb_list, get_order(io_tlb_nslabs *
-								 sizeof(int)));
-		free_pages((unsigned long)phys_to_virt(io_tlb_start),
-			   get_order(io_tlb_nslabs << IO_TLB_SHIFT));
+	if (default_swiotlb_pool.late_alloc) {
+		free_pages((unsigned long)default_swiotlb_pool.io_tlb_orig_addr,
+			   get_order(default_swiotlb_pool.io_tlb_nslabs *
+							sizeof(phys_addr_t)));
+		free_pages((unsigned long)default_swiotlb_pool.io_tlb_list,
+			get_order(default_swiotlb_pool.io_tlb_nslabs *
+								sizeof(int)));
+		free_pages((unsigned long)
+			phys_to_virt(default_swiotlb_pool.io_tlb_start),
+			get_order(default_swiotlb_pool.io_tlb_nslabs <<
+								IO_TLB_SHIFT));
 	} else {
-		memblock_free_late(__pa(io_tlb_orig_addr),
-				   PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)));
-		memblock_free_late(__pa(io_tlb_list),
-				   PAGE_ALIGN(io_tlb_nslabs * sizeof(int)));
-		memblock_free_late(io_tlb_start,
-				   PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
+		memblock_free_late(__pa(default_swiotlb_pool.io_tlb_orig_addr),
+			   PAGE_ALIGN(default_swiotlb_pool.io_tlb_nslabs *
+							sizeof(phys_addr_t)));
+		memblock_free_late(__pa(default_swiotlb_pool.io_tlb_list),
+			   PAGE_ALIGN(default_swiotlb_pool.io_tlb_nslabs *
+								sizeof(int)));
+		memblock_free_late(default_swiotlb_pool.io_tlb_start,
+		   PAGE_ALIGN(default_swiotlb_pool.io_tlb_nslabs <<
+								IO_TLB_SHIFT));
 	}
 	swiotlb_cleanup();
 }
@@ -443,7 +437,8 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 	}
 }
 
-phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
+phys_addr_t _swiotlb_tbl_map_single(struct swiotlb_pool *pool,
+				   struct device *hwdev,
 				   dma_addr_t tbl_dma_addr,
 				   phys_addr_t orig_addr,
 				   size_t mapping_size,
@@ -460,7 +455,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	unsigned long max_slots;
 	unsigned long tmp_io_tlb_used;
 
-	if (no_iotlb_memory)
+	if (pool->no_iotlb_memory)
 		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
 
 	if (mem_encrypt_active())
@@ -501,13 +496,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	 * Find suitable number of IO TLB entries size that will fit this
 	 * request and allocate a buffer from that IO TLB pool.
 	 */
-	spin_lock_irqsave(&io_tlb_lock, flags);
+	spin_lock_irqsave(&pool->io_tlb_lock, flags);
 
-	if (unlikely(nslots > io_tlb_nslabs - io_tlb_used))
+	if (unlikely(nslots > pool->io_tlb_nslabs - pool->io_tlb_used))
 		goto not_found;
 
-	index = ALIGN(io_tlb_index, stride);
-	if (index >= io_tlb_nslabs)
+	index = ALIGN(pool->io_tlb_index, stride);
+	if (index >= pool->io_tlb_nslabs)
 		index = 0;
 	wrap = index;
 
@@ -515,7 +510,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		while (iommu_is_span_boundary(index, nslots, offset_slots,
 					      max_slots)) {
 			index += stride;
-			if (index >= io_tlb_nslabs)
+			if (index >= pool->io_tlb_nslabs)
 				index = 0;
 			if (index == wrap)
 				goto not_found;
@@ -526,40 +521,43 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		 * contiguous buffers, we allocate the buffers from that slot
 		 * and mark the entries as '0' indicating unavailable.
 		 */
-		if (io_tlb_list[index] >= nslots) {
+		if (pool->io_tlb_list[index] >= nslots) {
 			int count = 0;
 
 			for (i = index; i < (int) (index + nslots); i++)
-				io_tlb_list[i] = 0;
-			for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE - 1) && io_tlb_list[i]; i--)
-				io_tlb_list[i] = ++count;
-			tlb_addr = io_tlb_start + (index << IO_TLB_SHIFT);
+				pool->io_tlb_list[i] = 0;
+			for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) !=
+					IO_TLB_SEGSIZE - 1) &&
+					pool->io_tlb_list[i]; i--)
+				pool->io_tlb_list[i] = ++count;
+			tlb_addr = pool->io_tlb_start + (index << IO_TLB_SHIFT);
 
 			/*
 			 * Update the indices to avoid searching in the next
 			 * round.
 			 */
-			io_tlb_index = ((index + nslots) < io_tlb_nslabs
-					? (index + nslots) : 0);
+			pool->io_tlb_index = ((index + nslots) <
+					pool->io_tlb_nslabs ?
+						(index + nslots) : 0);
 
 			goto found;
 		}
 		index += stride;
-		if (index >= io_tlb_nslabs)
+		if (index >= pool->io_tlb_nslabs)
 			index = 0;
 	} while (index != wrap);
 
 not_found:
-	tmp_io_tlb_used = io_tlb_used;
+	tmp_io_tlb_used = pool->io_tlb_used;
 
-	spin_unlock_irqrestore(&io_tlb_lock, flags);
+	spin_unlock_irqrestore(&pool->io_tlb_lock, flags);
 	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
-			 alloc_size, io_tlb_nslabs, tmp_io_tlb_used);
+			 alloc_size, pool->io_tlb_nslabs, tmp_io_tlb_used);
 	return (phys_addr_t)DMA_MAPPING_ERROR;
 found:
-	io_tlb_used += nslots;
-	spin_unlock_irqrestore(&io_tlb_lock, flags);
+	pool->io_tlb_used += nslots;
+	spin_unlock_irqrestore(&pool->io_tlb_lock, flags);
 
 	/*
 	 * Save away the mapping from the original address to the DMA address.
@@ -567,10 +565,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	 * needed.
 	 */
 	for (i = 0; i < nslots; i++)
-		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
+		pool->io_tlb_orig_addr[index+i] = orig_addr +
+						(i << IO_TLB_SHIFT);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
+		swiotlb_bounce(orig_addr, tlb_addr,
+					mapping_size, DMA_TO_DEVICE);
 
 	return tlb_addr;
 }
@@ -578,14 +578,15 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 /*
  * tlb_addr is the physical address of the bounce buffer to unmap.
  */
-void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
-			      size_t mapping_size, size_t alloc_size,
-			      enum dma_data_direction dir, unsigned long attrs)
+void _swiotlb_tbl_unmap_single(struct swiotlb_pool *pool,
+			struct device *hwdev, phys_addr_t tlb_addr,
+			size_t mapping_size, size_t alloc_size,
+			enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long flags;
 	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
-	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
-	phys_addr_t orig_addr = io_tlb_orig_addr[index];
+	int index = (tlb_addr - pool->io_tlb_start) >> IO_TLB_SHIFT;
+	phys_addr_t orig_addr = pool->io_tlb_orig_addr[index];
 
 	/*
 	 * First, sync the memory before unmapping the entry
@@ -601,36 +602,39 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	 * While returning the entries to the free list, we merge the entries
 	 * with slots below and above the pool being returned.
 	 */
-	spin_lock_irqsave(&io_tlb_lock, flags);
+	spin_lock_irqsave(&pool->io_tlb_lock, flags);
 	{
 		count = ((index + nslots) < ALIGN(index + 1, IO_TLB_SEGSIZE) ?
-			 io_tlb_list[index + nslots] : 0);
+			 pool->io_tlb_list[index + nslots] : 0);
 		/*
 		 * Step 1: return the slots to the free list, merging the
 		 * slots with superceeding slots
 		 */
 		for (i = index + nslots - 1; i >= index; i--) {
-			io_tlb_list[i] = ++count;
-			io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
+			pool->io_tlb_list[i] = ++count;
+			pool->io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
 		}
 		/*
 		 * Step 2: merge the returned slots with the preceding slots,
 		 * if available (non zero)
 		 */
-		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
-			io_tlb_list[i] = ++count;
+		for (i = index - 1;
+			(OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE - 1) &&
+					pool->io_tlb_list[i]; i--)
+			pool->io_tlb_list[i] = ++count;
 
-		io_tlb_used -= nslots;
+		pool->io_tlb_used -= nslots;
 	}
-	spin_unlock_irqrestore(&io_tlb_lock, flags);
+	spin_unlock_irqrestore(&pool->io_tlb_lock, flags);
 }
 
-void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
-			     size_t size, enum dma_data_direction dir,
-			     enum dma_sync_target target)
+void _swiotlb_tbl_sync_single(struct swiotlb_pool *pool,
+			struct device *hwdev, phys_addr_t tlb_addr,
+			size_t size, enum dma_data_direction dir,
+			enum dma_sync_target target)
 {
-	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
-	phys_addr_t orig_addr = io_tlb_orig_addr[index];
+	int index = (tlb_addr - pool->io_tlb_start) >> IO_TLB_SHIFT;
+	phys_addr_t orig_addr = pool->io_tlb_orig_addr[index];
 
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
@@ -660,7 +664,8 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
  * Create a swiotlb mapping for the buffer at @paddr, and in case of DMAing
  * to the device copy the data into it as well.
  */
-dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
+dma_addr_t _swiotlb_map(struct swiotlb_pool *pool,
+		struct device *dev, phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	phys_addr_t swiotlb_addr;
@@ -669,8 +674,8 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size,
 			      swiotlb_force);
 
-	swiotlb_addr = swiotlb_tbl_map_single(dev,
-			__phys_to_dma(dev, io_tlb_start),
+	swiotlb_addr = _swiotlb_tbl_map_single(pool, dev,
+			__phys_to_dma(dev, pool->io_tlb_start),
 			paddr, size, size, dir, attrs);
 	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
@@ -678,8 +683,8 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 	/* Ensure that the address returned is DMA'ble */
 	dma_addr = __phys_to_dma(dev, swiotlb_addr);
 	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
-		swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, size, dir,
-			attrs | DMA_ATTR_SKIP_CPU_SYNC);
+		_swiotlb_tbl_unmap_single(pool, dev, swiotlb_addr, size, size,
+				dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
 		dev_WARN_ONCE(dev, 1,
 			"swiotlb addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
 			&dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
@@ -702,7 +707,7 @@ bool is_swiotlb_active(void)
 	 * When SWIOTLB is initialized, even if io_tlb_start points to physical
 	 * address zero, io_tlb_end surely doesn't.
 	 */
-	return io_tlb_end != 0;
+	return default_swiotlb_pool.io_tlb_end != 0;
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -712,8 +717,10 @@ static int __init swiotlb_create_debugfs(void)
 	struct dentry *root;
 
 	root = debugfs_create_dir("swiotlb", NULL);
-	debugfs_create_ulong("io_tlb_nslabs", 0400, root, &io_tlb_nslabs);
-	debugfs_create_ulong("io_tlb_used", 0400, root, &io_tlb_used);
+	debugfs_create_ulong("io_tlb_nslabs", 0400, root,
+				&default_swiotlb_pool.io_tlb_nslabs);
+	debugfs_create_ulong("io_tlb_used", 0400, root,
+				&default_swiotlb_pool.io_tlb_used);
 	return 0;
 }
 
-- 
2.7.4

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
