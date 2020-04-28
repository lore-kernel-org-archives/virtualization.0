From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: [PATCH 2/5] swiotlb: Allow for non-linear mapping between paddr and vaddr
Date: Tue, 28 Apr 2020 17:09:15 +0530
Message-ID: <1588073958-1793-3-git-send-email-vatsa@codeaurora.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com, jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, vatsa@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Some of the memory pool managed by swiotlb driver could fall
outside the direct-mapped range, made accessible via memremap()
routine. To facilitate easy conversion between virtual and
physical address of such memory, store the virtual address of
memory pool in addition to its physical address.

Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
---
 include/linux/swiotlb.h |  2 ++
 kernel/dma/swiotlb.c    | 20 ++++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 8c7843f..c634b4d 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -61,6 +61,8 @@ struct swiotlb_pool {
 
 	phys_addr_t io_tlb_start, io_tlb_end;
 
+	void *io_tlb_vstart;
+
 	/*
 	 * The number of IO TLB blocks (in groups of 64) between io_tlb_start
 	 * and io_tlb_end.  This is command line adjustable via
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9c504d3..8cf0b57 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -178,6 +178,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 	default_swiotlb_pool.io_tlb_start = __pa(tlb);
 	default_swiotlb_pool.io_tlb_end =
 			default_swiotlb_pool.io_tlb_start + bytes;
+	default_swiotlb_pool.io_tlb_vstart = tlb;
 
 	/*
 	 * Allocate and initialize the free list array.  This array is used
@@ -307,6 +308,7 @@ static void swiotlb_cleanup(void)
 	default_swiotlb_pool.io_tlb_start = 0;
 	default_swiotlb_pool.io_tlb_nslabs = 0;
 	default_swiotlb_pool.max_segment = 0;
+	default_swiotlb_pool.io_tlb_vstart = NULL;
 }
 
 int
@@ -320,6 +322,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	default_swiotlb_pool.io_tlb_start = virt_to_phys(tlb);
 	default_swiotlb_pool.io_tlb_end =
 			default_swiotlb_pool.io_tlb_start + bytes;
+	default_swiotlb_pool.io_tlb_vstart = tlb;
 
 	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
 	memset(tlb, 0, bytes);
@@ -400,11 +403,10 @@ void __init swiotlb_exit(void)
 /*
  * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
-static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
+static void swiotlb_bounce(phys_addr_t orig_addr, void *vaddr,
 			   size_t size, enum dma_data_direction dir)
 {
 	unsigned long pfn = PFN_DOWN(orig_addr);
-	unsigned char *vaddr = phys_to_virt(tlb_addr);
 
 	if (PageHighMem(pfn_to_page(pfn))) {
 		/* The buffer does not have a mapping.  Map it in and copy */
@@ -437,6 +439,11 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 	}
 }
 
+static inline void *tlb_vaddr(struct swiotlb_pool *pool, phys_addr_t tlb_addr)
+{
+	return pool->io_tlb_vstart + (tlb_addr - pool->io_tlb_start);
+}
+
 phys_addr_t _swiotlb_tbl_map_single(struct swiotlb_pool *pool,
 				   struct device *hwdev,
 				   dma_addr_t tbl_dma_addr,
@@ -569,7 +576,7 @@ phys_addr_t _swiotlb_tbl_map_single(struct swiotlb_pool *pool,
 						(i << IO_TLB_SHIFT);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-		swiotlb_bounce(orig_addr, tlb_addr,
+		swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
 					mapping_size, DMA_TO_DEVICE);
 
 	return tlb_addr;
@@ -594,7 +601,8 @@ void _swiotlb_tbl_unmap_single(struct swiotlb_pool *pool,
 	if (orig_addr != INVALID_PHYS_ADDR &&
 	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
-		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
+		swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
+						mapping_size, DMA_FROM_DEVICE);
 
 	/*
 	 * Return the buffer to the free list by setting the corresponding
@@ -643,14 +651,14 @@ void _swiotlb_tbl_sync_single(struct swiotlb_pool *pool,
 	switch (target) {
 	case SYNC_FOR_CPU:
 		if (likely(dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
-			swiotlb_bounce(orig_addr, tlb_addr,
+			swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
 				       size, DMA_FROM_DEVICE);
 		else
 			BUG_ON(dir != DMA_TO_DEVICE);
 		break;
 	case SYNC_FOR_DEVICE:
 		if (likely(dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-			swiotlb_bounce(orig_addr, tlb_addr,
+			swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
 				       size, DMA_TO_DEVICE);
 		else
 			BUG_ON(dir != DMA_FROM_DEVICE);
-- 
2.7.4

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
