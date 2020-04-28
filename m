From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: [PATCH 4/5] swiotlb: Add API to register new pool
Date: Tue, 28 Apr 2020 17:09:17 +0530
Message-ID: <1588073958-1793-5-git-send-email-vatsa@codeaurora.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com, jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, vatsa@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This patch adds an interface for the swiotlb driver to recognize
a new memory pool. Upon successful initialization of the pool,
swiotlb returns a handle, which needs to be passed as an argument
for any future operations on the pool (map/unmap/alloc/free).

Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
---
 include/linux/swiotlb.h |  9 ++++++++
 kernel/dma/swiotlb.c    | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 957697e..97ac82a 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -182,6 +182,9 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 	return paddr >= swiotlb_start() && paddr < swiotlb_end();
 }
 
+extern struct swiotlb_pool *swiotlb_register_pool(char *name,
+		phys_addr_t start, void *vstart, size_t size);
+
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
@@ -236,6 +239,12 @@ static inline void swiotlb_free(struct swiotlb_pool *pool,
 {
 }
 
+static struct swiotlb_pool *swiotlb_register_pool(char *name,
+		phys_addr_t start, void *vstart, size_t size)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7411ce5..9883744 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -36,6 +36,7 @@
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
 #include <linux/set_memory.h>
+#include <linux/slab.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #endif
@@ -736,6 +737,65 @@ size_t swiotlb_max_mapping_size(struct device *dev)
 	return ((size_t)1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
 }
 
+struct swiotlb_pool *swiotlb_register_pool(char *name, phys_addr_t start,
+			void *vstart, size_t size)
+{
+	struct swiotlb_pool *pool;
+	unsigned long i, bytes;
+	unsigned long nslabs;
+
+	nslabs = size >> IO_TLB_SHIFT;
+	if (!nslabs)
+		return ERR_PTR(-EINVAL);
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	bytes = nslabs << IO_TLB_SHIFT;
+
+	strncpy(pool->name, name, sizeof(pool->name));
+	spin_lock_init(&pool->io_tlb_lock);
+	pool->late_alloc = 1;
+	pool->io_tlb_start = start;
+	pool->io_tlb_end = start + bytes;
+	pool->io_tlb_vstart = vstart;
+	pool->io_tlb_nslabs = nslabs;
+	pool->max_segment = rounddown(bytes, PAGE_SIZE);
+
+	/*
+	 * Allocate and initialize the free list array.  This array is used
+	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
+	 * between io_tlb_start and io_tlb_end.
+	 */
+	pool->io_tlb_list = (unsigned int *)__get_free_pages(GFP_KERNEL,
+			get_order(pool->io_tlb_nslabs * sizeof(int)));
+	if (!pool->io_tlb_list)
+		goto cleanup;
+
+	pool->io_tlb_orig_addr = (phys_addr_t *)
+		__get_free_pages(GFP_KERNEL,
+				 get_order(pool->io_tlb_nslabs *
+					   sizeof(phys_addr_t)));
+	if (!pool->io_tlb_orig_addr)
+		goto cleanup;
+
+	for (i = 0; i < pool->io_tlb_nslabs; i++) {
+		pool->io_tlb_list[i] = IO_TLB_SEGSIZE -
+						OFFSET(i, IO_TLB_SEGSIZE);
+		pool->io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
+	}
+
+	return pool;
+
+cleanup:
+	kfree(pool->io_tlb_list);
+	kfree(pool->io_tlb_orig_addr);
+	kfree(pool);
+
+	return ERR_PTR(-ENOMEM);
+}
+
 bool is_swiotlb_active(void)
 {
 	/*
-- 
2.7.4

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
