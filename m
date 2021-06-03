Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6BDC4709B
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 00:41:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D850613EA
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 00:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D850613EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 76195404CA;
	Thu,  3 Jun 2021 00:41:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9fW7ugK14Krt; Thu,  3 Jun 2021 00:41:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id D039B404CE;
	Thu,  3 Jun 2021 00:41:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA9D9C000E;
	Thu,  3 Jun 2021 00:41:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BB37C0011;
 Thu,  3 Jun 2021 00:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB3C983D4A;
 Thu,  3 Jun 2021 00:41:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lsyShE1mvt1C; Thu,  3 Jun 2021 00:41:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B8B5B83D34;
 Thu,  3 Jun 2021 00:41:46 +0000 (UTC)
IronPort-SDR: Zg4YtbxnPZpB32xN5XamZGZJredgAOPbYD5G/+mJxI+EJC7tQv0ohK1udTwMPxMGh3c8CXI5Nu
 1+9TAU/oCzLA==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="191281571"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="191281571"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 17:41:44 -0700
IronPort-SDR: JDUmEcjqrAH9CeDk89linSm2Pj1LPAXJGnfy/iVNbpSrnXWweqPzpqdKqZJTwMMvLOnrmsJBj/
 xooeB7jPrSIQ==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="549686680"
Received: from tassilo.jf.intel.com ([10.54.74.11])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 17:41:44 -0700
From: Andi Kleen <ak@linux.intel.com>
To: mst@redhat.com
Subject: [PATCH v1 5/8] dma: Use size for swiotlb boundary checks
Date: Wed,  2 Jun 2021 17:41:30 -0700
Message-Id: <20210603004133.4079390-6-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210603004133.4079390-1-ak@linux.intel.com>
References: <20210603004133.4079390-1-ak@linux.intel.com>
MIME-Version: 1.0
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 jpoimboe@redhat.com, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

swiotlb currently only uses the start address of a DMA to check if something
is in the swiotlb or not. But with virtio and untrusted hosts the host
could give some DMA mapping that crosses the swiotlb boundaries,
potentially leaking or corrupting data. Add size checks to all the swiotlb
checks and reject any DMAs that cross the swiotlb buffer boundaries.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/iommu/dma-iommu.c   | 13 ++++++-------
 drivers/xen/swiotlb-xen.c   | 11 ++++++-----
 include/linux/dma-mapping.h |  4 ++--
 include/linux/swiotlb.h     |  8 +++++---
 kernel/dma/direct.c         |  8 ++++----
 kernel/dma/direct.h         |  8 ++++----
 kernel/dma/mapping.c        |  4 ++--
 net/xdp/xsk_buff_pool.c     |  2 +-
 8 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7bcdd1205535..7ef13198721b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -504,7 +504,7 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
 
 	__iommu_dma_unmap(dev, dma_addr, size);
 
-	if (unlikely(is_swiotlb_buffer(phys)))
+	if (unlikely(is_swiotlb_buffer(phys, size)))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 }
 
@@ -575,7 +575,7 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 	}
 
 	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
-	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
+	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys, org_size))
 		swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
 	return iova;
 }
@@ -781,7 +781,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_cpu(phys, size, dir);
 
-	if (is_swiotlb_buffer(phys))
+	if (is_swiotlb_buffer(phys, size))
 		swiotlb_sync_single_for_cpu(dev, phys, size, dir);
 }
 
@@ -794,7 +794,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
-	if (is_swiotlb_buffer(phys))
+	if (is_swiotlb_buffer(phys, size))
 		swiotlb_sync_single_for_device(dev, phys, size, dir);
 
 	if (!dev_is_dma_coherent(dev))
@@ -815,7 +815,7 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 		if (!dev_is_dma_coherent(dev))
 			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
 
-		if (is_swiotlb_buffer(sg_phys(sg)))
+		if (is_swiotlb_buffer(sg_phys(sg), sg->length))
 			swiotlb_sync_single_for_cpu(dev, sg_phys(sg),
 						    sg->length, dir);
 	}
@@ -832,10 +832,9 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 		return;
 
 	for_each_sg(sgl, sg, nelems, i) {
-		if (is_swiotlb_buffer(sg_phys(sg)))
+		if (is_swiotlb_buffer(sg_phys(sg), sg->length))
 			swiotlb_sync_single_for_device(dev, sg_phys(sg),
 						       sg->length, dir);
-
 		if (!dev_is_dma_coherent(dev))
 			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
 	}
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 24d11861ac7d..333846af8d35 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -89,7 +89,8 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 	return 0;
 }
 
-static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
+static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr,
+				 size_t size)
 {
 	unsigned long bfn = XEN_PFN_DOWN(dma_to_phys(dev, dma_addr));
 	unsigned long xen_pfn = bfn_to_local_pfn(bfn);
@@ -100,7 +101,7 @@ static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
 	 * in our domain. Therefore _only_ check address within our domain.
 	 */
 	if (pfn_valid(PFN_DOWN(paddr)))
-		return is_swiotlb_buffer(paddr);
+		return is_swiotlb_buffer(paddr, size);
 	return 0;
 }
 
@@ -431,7 +432,7 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 	}
 
 	/* NOTE: We use dev_addr here, not paddr! */
-	if (is_xen_swiotlb_buffer(hwdev, dev_addr))
+	if (is_xen_swiotlb_buffer(hwdev, dev_addr, size))
 		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
 }
 
@@ -448,7 +449,7 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 			xen_dma_sync_for_cpu(dev, dma_addr, size, dir);
 	}
 
-	if (is_xen_swiotlb_buffer(dev, dma_addr))
+	if (is_xen_swiotlb_buffer(dev, dma_addr, size))
 		swiotlb_sync_single_for_cpu(dev, paddr, size, dir);
 }
 
@@ -458,7 +459,7 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
 {
 	phys_addr_t paddr = xen_dma_to_phys(dev, dma_addr);
 
-	if (is_xen_swiotlb_buffer(dev, dma_addr))
+	if (is_xen_swiotlb_buffer(dev, dma_addr, size))
 		swiotlb_sync_single_for_device(dev, paddr, size, dir);
 
 	if (!dev_is_dma_coherent(dev)) {
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 183e7103a66d..37fbd12bd4ab 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -142,7 +142,7 @@ int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 u64 dma_get_required_mask(struct device *dev);
 size_t dma_max_mapping_size(struct device *dev);
-bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
+bool dma_need_sync(struct device *dev, dma_addr_t dma_addr, size_t size);
 unsigned long dma_get_merge_boundary(struct device *dev);
 struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs);
@@ -258,7 +258,7 @@ static inline size_t dma_max_mapping_size(struct device *dev)
 {
 	return 0;
 }
-static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
+static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr, size_t size)
 {
 	return false;
 }
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 216854a5e513..3e447f722d81 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -101,11 +101,13 @@ struct io_tlb_mem {
 };
 extern struct io_tlb_mem *io_tlb_default_mem;
 
-static inline bool is_swiotlb_buffer(phys_addr_t paddr)
+static inline bool is_swiotlb_buffer(phys_addr_t paddr, size_t size)
 {
 	struct io_tlb_mem *mem = io_tlb_default_mem;
 
-	return mem && paddr >= mem->start && paddr < mem->end;
+	if (paddr + size <= paddr) /* wrapping */
+		return false;
+	return mem && paddr >= mem->start && paddr + size <= mem->end;
 }
 
 void __init swiotlb_exit(void);
@@ -115,7 +117,7 @@ bool is_swiotlb_active(void);
 void __init swiotlb_adjust_size(unsigned long size);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
-static inline bool is_swiotlb_buffer(phys_addr_t paddr)
+static inline bool is_swiotlb_buffer(phys_addr_t paddr, size_t size)
 {
 	return false;
 }
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index f737e3347059..9ae6f94e868f 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -343,7 +343,7 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 	for_each_sg(sgl, sg, nents, i) {
 		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
 
-		if (unlikely(is_swiotlb_buffer(paddr)))
+		if (unlikely(is_swiotlb_buffer(paddr, sg->length)))
 			swiotlb_sync_single_for_device(dev, paddr, sg->length,
 						       dir);
 
@@ -369,7 +369,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		if (!dev_is_dma_coherent(dev))
 			arch_sync_dma_for_cpu(paddr, sg->length, dir);
 
-		if (unlikely(is_swiotlb_buffer(paddr)))
+		if (unlikely(is_swiotlb_buffer(paddr, sg->length)))
 			swiotlb_sync_single_for_cpu(dev, paddr, sg->length,
 						    dir);
 
@@ -501,10 +501,10 @@ size_t dma_direct_max_mapping_size(struct device *dev)
 	return SIZE_MAX;
 }
 
-bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr)
+bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr, size_t size)
 {
 	return !dev_is_dma_coherent(dev) ||
-		is_swiotlb_buffer(dma_to_phys(dev, dma_addr));
+		is_swiotlb_buffer(dma_to_phys(dev, dma_addr), size);
 }
 
 /**
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 50afc05b6f1d..4a17e431ae56 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -16,7 +16,7 @@ bool dma_direct_can_mmap(struct device *dev);
 int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs);
-bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
+bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr, size_t size);
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
 size_t dma_direct_max_mapping_size(struct device *dev);
@@ -56,7 +56,7 @@ static inline void dma_direct_sync_single_for_device(struct device *dev,
 {
 	phys_addr_t paddr = dma_to_phys(dev, addr);
 
-	if (unlikely(is_swiotlb_buffer(paddr)))
+	if (unlikely(is_swiotlb_buffer(paddr, size)))
 		swiotlb_sync_single_for_device(dev, paddr, size, dir);
 
 	if (!dev_is_dma_coherent(dev))
@@ -73,7 +73,7 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 		arch_sync_dma_for_cpu_all();
 	}
 
-	if (unlikely(is_swiotlb_buffer(paddr)))
+	if (unlikely(is_swiotlb_buffer(paddr, size)))
 		swiotlb_sync_single_for_cpu(dev, paddr, size, dir);
 
 	if (dir == DMA_FROM_DEVICE)
@@ -113,7 +113,7 @@ static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
 
-	if (unlikely(is_swiotlb_buffer(phys)))
+	if (unlikely(is_swiotlb_buffer(phys, size)))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 }
 #endif /* _KERNEL_DMA_DIRECT_H */
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 2b06a809d0b9..9bf02c8d7d1b 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -716,12 +716,12 @@ size_t dma_max_mapping_size(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_max_mapping_size);
 
-bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
+bool dma_need_sync(struct device *dev, dma_addr_t dma_addr, size_t size)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	if (dma_map_direct(dev, ops))
-		return dma_direct_need_sync(dev, dma_addr);
+		return dma_direct_need_sync(dev, dma_addr, size);
 	return ops->sync_single_for_cpu || ops->sync_single_for_device;
 }
 EXPORT_SYMBOL_GPL(dma_need_sync);
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 8de01aaac4a0..c1e404fe0cf4 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -399,7 +399,7 @@ int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 			__xp_dma_unmap(dma_map, attrs);
 			return -ENOMEM;
 		}
-		if (dma_need_sync(dev, dma))
+		if (dma_need_sync(dev, dma, PAGE_SIZE))
 			dma_map->dma_need_sync = true;
 		dma_map->dma_pages[i] = dma;
 	}
-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
