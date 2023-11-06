Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413C4C4167B
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 07:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5C37822A6;
	Mon,  6 Nov 2023 07:14:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D5C37822A6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a1qCtoE2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9eSxWv5NMnN0; Mon,  6 Nov 2023 07:14:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E41D38229C;
	Mon,  6 Nov 2023 07:14:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E41D38229C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB717C0071;
	Mon,  6 Nov 2023 07:14:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6A72C0DD9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F91661043
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F91661043
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=a1qCtoE2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pJWKai52CJKM
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8FC8610BF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8FC8610BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699254844; x=1730790844;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=S7SongTvx/p0pTy8okzpB1bVkyF2tFwb7xoxlsuTkxM=;
 b=a1qCtoE2Ieor2z5id0XlQi9RpyZ4vMSXb6MD9YURfRsCY7cCkSJuWk5S
 RuDjTsvm+uNO3+/uXlHK+sR+/hOvWVrg7Nn3cx5sMgl6Q5hYLDBOAJVhw
 z1K9CqunG7PJRWZgQTMQO88lxOV24U2qSMzraxBOvkktYaQNqb2/XKher
 IQRRbcbw3F1zJwW4JXHtk54yntRMDUMt/Odbsr8Cm5xRwPd+TwxI9f+5r
 t1FeP9utGfFxgjJRHmeQgg5Etz/KZ8BssHfvOQm5juqhm47yV2hUje+vu
 gpteEVAZLJN39CJqfpUPsCpCFNj5F6bfBtNzVRc2fVx9nSnFNHbdeIwDM w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="10759054"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; d="scan'208";a="10759054"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2023 23:14:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1093690884"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; d="scan'208";a="1093690884"
Received: from sqa-gate.sh.intel.com (HELO localhost.localdomain)
 ([10.239.48.212])
 by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2023 23:14:00 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 joro@8bytes.org, will@kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: [RFC PATCH 2/5] iommu/vt-d: Add generic IO page table support
Date: Mon,  6 Nov 2023 02:12:23 -0500
Message-Id: <20231106071226.9656-3-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231106071226.9656-1-tina.zhang@intel.com>
References: <20231106071226.9656-1-tina.zhang@intel.com>
MIME-Version: 1.0
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

Add basic hook up code to implement generic IO page table framework.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/Kconfig |  1 +
 drivers/iommu/intel/iommu.c | 94 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.h |  7 +++
 drivers/iommu/io-pgtable.c  |  3 ++
 include/linux/io-pgtable.h  |  2 +
 5 files changed, 107 insertions(+)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 2e56bd79f589..8334e7e50e69 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -15,6 +15,7 @@ config INTEL_IOMMU
 	select DMA_OPS
 	select IOMMU_API
 	select IOMMU_IOVA
+	select IOMMU_IO_PGTABLE
 	select NEED_DMA_MAP_STATE
 	select DMAR_TABLE
 	select SWIOTLB
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index dbcdf7b95b9f..80bd1993861c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -23,6 +23,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/tboot.h>
 #include <uapi/linux/iommufd.h>
+#include <linux/io-pgtable.h>
 
 #include "iommu.h"
 #include "../dma-iommu.h"
@@ -67,6 +68,20 @@
 #define LEVEL_STRIDE		(9)
 #define LEVEL_MASK		(((u64)1 << LEVEL_STRIDE) - 1)
 
+#define io_pgtable_cfg_to_dmar_pgtable(x) \
+	container_of((x), struct dmar_io_pgtable, pgtbl_cfg)
+
+#define io_pgtable_to_dmar_pgtable(x) \
+	container_of((x), struct dmar_io_pgtable, iop)
+
+#define io_pgtable_to_dmar_domain(x) \
+	container_of(io_pgtable_to_dmar_pgtable(x), \
+		struct dmar_domain, dmar_iop)
+
+#define io_pgtable_ops_to_dmar_domain(x) \
+	container_of(io_pgtable_to_dmar_pgtable(io_pgtable_ops_to_pgtable(x)), \
+		struct dmar_domain, dmar_iop)
+
 static inline int agaw_to_level(int agaw)
 {
 	return agaw + 2;
@@ -5171,3 +5186,82 @@ int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd, u64 oa, u64 ob)
 
 	return ret;
 }
+
+static void flush_all(void *cookie)
+{
+}
+
+static void flush_walk(unsigned long iova, size_t size,
+		       size_t granule, void *cookie)
+{
+}
+
+static void add_page(struct iommu_iotlb_gather *gather,
+		     unsigned long iova, size_t granule,
+		     void *cookie)
+{
+}
+
+static const struct iommu_flush_ops flush_ops = {
+	.tlb_flush_all  = flush_all,
+	.tlb_flush_walk = flush_walk,
+	.tlb_add_page   = add_page,
+};
+
+static void free_pgtable(struct io_pgtable *iop)
+{
+	struct dmar_domain *dmar_domain = io_pgtable_to_dmar_domain(iop);
+
+	if (dmar_domain->pgd) {
+		LIST_HEAD(freelist);
+
+		domain_unmap(dmar_domain, 0, DOMAIN_MAX_PFN(dmar_domain->gaw), &freelist);
+		put_pages_list(&freelist);
+	}
+}
+
+static int pgtable_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
+			     phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			     int iommu_prot, gfp_t gfp, size_t *mapped)
+{
+	struct dmar_domain *dmar_domain = io_pgtable_ops_to_dmar_domain(ops);
+
+	return intel_iommu_map_pages(&dmar_domain->domain, iova, paddr, pgsize,
+				     pgcount, iommu_prot, gfp, mapped);
+}
+
+static size_t pgtable_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
+				  size_t pgsize, size_t pgcount,
+				  struct iommu_iotlb_gather *gather)
+{
+	struct dmar_domain *dmar_domain = io_pgtable_ops_to_dmar_domain(ops);
+
+	return intel_iommu_unmap_pages(&dmar_domain->domain, iova, pgsize,
+				       pgcount, gather);
+}
+
+static phys_addr_t pgtable_iova_to_phys(struct io_pgtable_ops *ops,
+					unsigned long iova)
+{
+	struct dmar_domain *dmar_domain = io_pgtable_ops_to_dmar_domain(ops);
+
+	return intel_iommu_iova_to_phys(&dmar_domain->domain, iova);
+}
+
+static struct io_pgtable *alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
+{
+	struct dmar_io_pgtable *pgtable = io_pgtable_cfg_to_dmar_pgtable(cfg);
+
+	pgtable->iop.ops.map_pages = pgtable_map_pages;
+	pgtable->iop.ops.unmap_pages = pgtable_unmap_pages;
+	pgtable->iop.ops.iova_to_phys = pgtable_iova_to_phys;
+
+	cfg->tlb = &flush_ops;
+
+	return &pgtable->iop;
+}
+
+struct io_pgtable_init_fns io_pgtable_intel_iommu_init_fns = {
+	.alloc = alloc_pgtable,
+	.free  = free_pgtable,
+};
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 8d0aac71c135..5207fea6477a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -18,6 +18,7 @@
 #include <linux/list.h>
 #include <linux/iommu.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/io-pgtable.h>
 #include <linux/dmar.h>
 #include <linux/bitfield.h>
 #include <linux/xarray.h>
@@ -579,6 +580,11 @@ struct iommu_domain_info {
 					 * to VT-d spec, section 9.3 */
 };
 
+struct dmar_io_pgtable {
+	struct io_pgtable_cfg   pgtbl_cfg;
+	struct io_pgtable       iop;
+};
+
 struct dmar_domain {
 	int	nid;			/* node id */
 	struct xarray iommu_array;	/* Attached IOMMU array */
@@ -633,6 +639,7 @@ struct dmar_domain {
 
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
+	struct dmar_io_pgtable dmar_iop;
 };
 
 /*
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 5755dee96a68..533b27557290 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -35,6 +35,9 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #ifdef CONFIG_IOMMU_IO_PGTABLE_VIRT
 	[VIRT_IO_PGTABLE] = &io_pgtable_virt_init_fns,
 #endif
+#ifdef CONFIG_INTEL_IOMMU
+	[INTEL_IOMMU] = &io_pgtable_intel_iommu_init_fns,
+#endif
 };
 
 struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index bdcade2c4844..b2857c18f963 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -20,6 +20,7 @@ enum io_pgtable_fmt {
 	APPLE_DART,
 	APPLE_DART2,
 	VIRT_IO_PGTABLE,
+	INTEL_IOMMU,
 	IO_PGTABLE_NUM_FMTS,
 };
 
@@ -281,5 +282,6 @@ extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v2_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_virt_init_fns;
+extern struct io_pgtable_init_fns io_pgtable_intel_iommu_init_fns;
 
 #endif /* __IO_PGTABLE_H */
-- 
2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
