Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A976DC47096
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 00:41:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C62D613EA
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 00:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C62D613EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E7D54053B;
	Thu,  3 Jun 2021 00:41:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GrMf87gIkzkd; Thu,  3 Jun 2021 00:41:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A4A340533;
	Thu,  3 Jun 2021 00:41:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A432BC0025;
	Thu,  3 Jun 2021 00:41:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26A5EC0001;
 Thu,  3 Jun 2021 00:41:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1016383D47;
 Thu,  3 Jun 2021 00:41:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bHz8lGW9uuDT; Thu,  3 Jun 2021 00:41:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3249683D39;
 Thu,  3 Jun 2021 00:41:46 +0000 (UTC)
IronPort-SDR: hHDnAIfNZO1b5+8PMK9zQpOdUa4OtfAc+6T7aKnYiQ3KiacznI9oaN2HYaUsqHXWLQDEXiSCnb
 GRBO7Gzon39A==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="191281573"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="191281573"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 17:41:44 -0700
IronPort-SDR: GZIRmM+2WIEuOj7sEEVm9Qwh0VotpMIbndySGLgjjwSJlNLzbZ3UOb6csRnGFU1QiQReoRv8ms
 IQK10R19ZY4A==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="549686681"
Received: from tassilo.jf.intel.com ([10.54.74.11])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 17:41:44 -0700
From: Andi Kleen <ak@linux.intel.com>
To: mst@redhat.com
Subject: [PATCH v1 6/8] dma: Add return value to dma_unmap_page
Date: Wed,  2 Jun 2021 17:41:31 -0700
Message-Id: <20210603004133.4079390-7-ak@linux.intel.com>
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

In some situations when we know swiotlb is forced and we have
to deal with untrusted hosts, it's useful to know if a mapping
was in the swiotlb or not. This allows us to abort any IO
operation that would access memory outside the swiotlb.

Otherwise it might be possible for a malicious host to inject
any guest page in a read operation. While it couldn't directly
access the results of the read() inside the guest, there
might scenarios where data is echoed back with a write(),
and that would then leak guest memory.

Add a return value to dma_unmap_single/page. Most users
of course will ignore it. The return value is set to EIO
if we're in forced swiotlb mode and the buffer is not inside
the swiotlb buffer. Otherwise it's always 0.

A new callback is used to avoid changing all the IOMMU drivers.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/iommu/dma-iommu.c   | 17 +++++++++++------
 include/linux/dma-map-ops.h |  3 +++
 include/linux/dma-mapping.h |  7 ++++---
 kernel/dma/mapping.c        |  6 +++++-
 4 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7ef13198721b..babe46f2ae3a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -491,7 +491,8 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 	iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
 }
 
-static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
+static int __iommu_dma_unmap_swiotlb_check(struct device *dev,
+		dma_addr_t dma_addr,
 		size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
 {
@@ -500,12 +501,15 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
 
 	phys = iommu_iova_to_phys(domain, dma_addr);
 	if (WARN_ON(!phys))
-		return;
+		return -EIO;
 
 	__iommu_dma_unmap(dev, dma_addr, size);
 
 	if (unlikely(is_swiotlb_buffer(phys, size)))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
+	else if (swiotlb_force == SWIOTLB_FORCE)
+		return -EIO;
+	return 0;
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
@@ -856,12 +860,13 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	return dma_handle;
 }
 
-static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
+static int iommu_dma_unmap_page_check(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
-	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
+	return __iommu_dma_unmap_swiotlb_check(dev, dma_handle, size, dir,
+					       attrs);
 }
 
 /*
@@ -946,7 +951,7 @@ static void iommu_dma_unmap_sg_swiotlb(struct device *dev, struct scatterlist *s
 	int i;
 
 	for_each_sg(sg, s, nents, i)
-		__iommu_dma_unmap_swiotlb(dev, sg_dma_address(s),
+		__iommu_dma_unmap_swiotlb_check(dev, sg_dma_address(s),
 				sg_dma_len(s), dir, attrs);
 }
 
@@ -1291,7 +1296,7 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.mmap			= iommu_dma_mmap,
 	.get_sgtable		= iommu_dma_get_sgtable,
 	.map_page		= iommu_dma_map_page,
-	.unmap_page		= iommu_dma_unmap_page,
+	.unmap_page_check	= iommu_dma_unmap_page_check,
 	.map_sg			= iommu_dma_map_sg,
 	.unmap_sg		= iommu_dma_unmap_sg,
 	.sync_single_for_cpu	= iommu_dma_sync_single_for_cpu,
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 0d53a96a3d64..0ed0190f7949 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -69,6 +69,9 @@ struct dma_map_ops {
 	u64 (*get_required_mask)(struct device *dev);
 	size_t (*max_mapping_size)(struct device *dev);
 	unsigned long (*get_merge_boundary)(struct device *dev);
+	int (*unmap_page_check)(struct device *dev, dma_addr_t dma_handle,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs);
 };
 
 #ifdef CONFIG_DMA_OPS
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 37fbd12bd4ab..25b8382f8601 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -103,7 +103,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		size_t offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs);
-void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
+int dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs);
 int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
@@ -160,9 +160,10 @@ static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 {
 	return DMA_MAPPING_ERROR;
 }
-static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
+static inline int dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
+	return 0;
 }
 static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
@@ -323,7 +324,7 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 			size, dir, attrs);
 }
 
-static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
+static inline int dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	return dma_unmap_page_attrs(dev, addr, size, dir, attrs);
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 9bf02c8d7d1b..dc0ce649d1f9 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -162,18 +162,22 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 }
 EXPORT_SYMBOL(dma_map_page_attrs);
 
-void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
+int dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
+	int ret = 0;
 
 	BUG_ON(!valid_dma_direction(dir));
 	if (dma_map_direct(dev, ops) ||
 	    arch_dma_unmap_page_direct(dev, addr + size))
 		dma_direct_unmap_page(dev, addr, size, dir, attrs);
+	else if (ops->unmap_page_check)
+		ret = ops->unmap_page_check(dev, addr, size, dir, attrs);
 	else if (ops->unmap_page)
 		ops->unmap_page(dev, addr, size, dir, attrs);
 	debug_dma_unmap_page(dev, addr, size, dir);
+	return ret;
 }
 EXPORT_SYMBOL(dma_unmap_page_attrs);
 
-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
