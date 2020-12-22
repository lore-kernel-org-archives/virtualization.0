Return-Path: <SRS0=Q5yb=F2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E837C433DB
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 17:46:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3C922D73
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 17:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3C922D73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6EA4086887;
	Tue, 22 Dec 2020 17:46:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PScLbEhWajW0; Tue, 22 Dec 2020 17:46:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EF77786884;
	Tue, 22 Dec 2020 17:46:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD163C1787;
	Tue, 22 Dec 2020 17:46:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34485C0893
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 17:46:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2889686884
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 17:46:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OFH4XZsPMdGC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 17:46:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 01B2286887
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 17:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608659160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=l9SVkQKAOlF+MY6s8nEkw0ucYFi5cV3lIaBb/ejD2tY=;
 b=M5B88vr0nl4k0GaXznPFllFjJe8dD+wlTSqa/JttCf/xSeWaxUn+GWO4SGdAa9fT4iWEym
 m4JoEwSmTmtGEumjWO6l3YkKMpQSaLmNmxL3jt0377NzbTrHT8v7cYU9A5YwfePjb9/YEo
 5Bf5WkCkUAIupAx1l/mCb6KUWokh6m4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-LIpumfm8OS-_F5id10lDsA-1; Tue, 22 Dec 2020 12:45:59 -0500
X-MC-Unique: LIpumfm8OS-_F5id10lDsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3935800D53;
 Tue, 22 Dec 2020 17:45:57 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-112-116.ams2.redhat.com
 [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB74C5D6A8;
 Tue, 22 Dec 2020 17:45:52 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] vdpa_sim: use iova module to allocate IOVA addresses
Date: Tue, 22 Dec 2020 18:45:51 +0100
Message-Id: <20201222174551.133678-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
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

The identical mapping used until now created issues when mapping
different virtual pages with the same physical address.
To solve this issue, we can use the iova module, to handle the IOVA
allocation.
For semplicity we use an IOVA allocator with byte granularity.

We add two new functions, vdpasim_map_range() and vdpasim_unmap_range(),
to handle the IOVA allocation and the registration into the IOMMU/IOTLB.
These functions are used by dma_map_ops callbacks.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h |   2 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 108 +++++++++++++++++++------------
 drivers/vdpa/Kconfig             |   1 +
 3 files changed, 69 insertions(+), 42 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index b02142293d5b..6efe205e583e 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -6,6 +6,7 @@
 #ifndef _VDPA_SIM_H
 #define _VDPA_SIM_H
 
+#include <linux/iova.h>
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
 #include <linux/virtio_byteorder.h>
@@ -55,6 +56,7 @@ struct vdpasim {
 	/* virtio config according to device type */
 	void *config;
 	struct vhost_iotlb *iommu;
+	struct iova_domain iova;
 	void *buffer;
 	u32 status;
 	u32 generation;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index b3fcc67bfdf0..341b9daf2ea4 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -17,6 +17,7 @@
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
 #include <linux/vhost_iotlb.h>
+#include <linux/iova.h>
 
 #include "vdpa_sim.h"
 
@@ -128,30 +129,57 @@ static int dir_to_perm(enum dma_data_direction dir)
 	return perm;
 }
 
+static dma_addr_t vdpasim_map_range(struct vdpasim *vdpasim, phys_addr_t paddr,
+				    size_t size, unsigned int perm)
+{
+	struct iova *iova;
+	dma_addr_t dma_addr;
+	int ret;
+
+	/* We set the limit_pfn to the maximum (~0UL - 1) */
+	iova = alloc_iova(&vdpasim->iova, size, ~0UL - 1, true);
+	if (!iova)
+		return DMA_MAPPING_ERROR;
+
+	dma_addr = iova_dma_addr(&vdpasim->iova, iova);
+
+	spin_lock(&vdpasim->iommu_lock);
+	ret = vhost_iotlb_add_range(vdpasim->iommu, (u64)dma_addr,
+				    (u64)dma_addr + size - 1, (u64)paddr, perm);
+	spin_unlock(&vdpasim->iommu_lock);
+
+	if (ret) {
+		__free_iova(&vdpasim->iova, iova);
+		return DMA_MAPPING_ERROR;
+	}
+
+	return dma_addr;
+}
+
+static void vdpasim_unmap_range(struct vdpasim *vdpasim, dma_addr_t dma_addr,
+				size_t size)
+{
+	spin_lock(&vdpasim->iommu_lock);
+	vhost_iotlb_del_range(vdpasim->iommu, (u64)dma_addr,
+			      (u64)dma_addr + size - 1);
+	spin_unlock(&vdpasim->iommu_lock);
+
+	free_iova(&vdpasim->iova, iova_pfn(&vdpasim->iova, dma_addr));
+}
+
 static dma_addr_t vdpasim_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
 				   enum dma_data_direction dir,
 				   unsigned long attrs)
 {
 	struct vdpasim *vdpasim = dev_to_sim(dev);
-	struct vhost_iotlb *iommu = vdpasim->iommu;
-	u64 pa = (page_to_pfn(page) << PAGE_SHIFT) + offset;
-	int ret, perm = dir_to_perm(dir);
+	phys_addr_t paddr = page_to_phys(page) + offset;
+	int perm = dir_to_perm(dir);
 
 	if (perm < 0)
 		return DMA_MAPPING_ERROR;
 
-	/* For simplicity, use identical mapping to avoid e.g iova
-	 * allocator.
-	 */
-	spin_lock(&vdpasim->iommu_lock);
-	ret = vhost_iotlb_add_range(iommu, pa, pa + size - 1,
-				    pa, dir_to_perm(dir));
-	spin_unlock(&vdpasim->iommu_lock);
-	if (ret)
-		return DMA_MAPPING_ERROR;
-
-	return (dma_addr_t)(pa);
+	return vdpasim_map_range(vdpasim, paddr, size, perm);
 }
 
 static void vdpasim_unmap_page(struct device *dev, dma_addr_t dma_addr,
@@ -159,12 +187,8 @@ static void vdpasim_unmap_page(struct device *dev, dma_addr_t dma_addr,
 			       unsigned long attrs)
 {
 	struct vdpasim *vdpasim = dev_to_sim(dev);
-	struct vhost_iotlb *iommu = vdpasim->iommu;
 
-	spin_lock(&vdpasim->iommu_lock);
-	vhost_iotlb_del_range(iommu, (u64)dma_addr,
-			      (u64)dma_addr + size - 1);
-	spin_unlock(&vdpasim->iommu_lock);
+	vdpasim_unmap_range(vdpasim, dma_addr, size);
 }
 
 static void *vdpasim_alloc_coherent(struct device *dev, size_t size,
@@ -172,27 +196,22 @@ static void *vdpasim_alloc_coherent(struct device *dev, size_t size,
 				    unsigned long attrs)
 {
 	struct vdpasim *vdpasim = dev_to_sim(dev);
-	struct vhost_iotlb *iommu = vdpasim->iommu;
-	void *addr = kmalloc(size, flag);
-	int ret;
+	phys_addr_t paddr;
+	void *addr;
 
-	spin_lock(&vdpasim->iommu_lock);
+	addr = kmalloc(size, flag);
 	if (!addr) {
 		*dma_addr = DMA_MAPPING_ERROR;
-	} else {
-		u64 pa = virt_to_phys(addr);
-
-		ret = vhost_iotlb_add_range(iommu, (u64)pa,
-					    (u64)pa + size - 1,
-					    pa, VHOST_MAP_RW);
-		if (ret) {
-			*dma_addr = DMA_MAPPING_ERROR;
-			kfree(addr);
-			addr = NULL;
-		} else
-			*dma_addr = (dma_addr_t)pa;
+		return NULL;
+	}
+
+	paddr = virt_to_phys(addr);
+
+	*dma_addr = vdpasim_map_range(vdpasim, paddr, size, VHOST_MAP_RW);
+	if (*dma_addr == DMA_MAPPING_ERROR) {
+		kfree(addr);
+		return NULL;
 	}
-	spin_unlock(&vdpasim->iommu_lock);
 
 	return addr;
 }
@@ -202,14 +221,10 @@ static void vdpasim_free_coherent(struct device *dev, size_t size,
 				  unsigned long attrs)
 {
 	struct vdpasim *vdpasim = dev_to_sim(dev);
-	struct vhost_iotlb *iommu = vdpasim->iommu;
 
-	spin_lock(&vdpasim->iommu_lock);
-	vhost_iotlb_del_range(iommu, (u64)dma_addr,
-			      (u64)dma_addr + size - 1);
-	spin_unlock(&vdpasim->iommu_lock);
+	vdpasim_unmap_range(vdpasim, dma_addr, size);
 
-	kfree(phys_to_virt((uintptr_t)dma_addr));
+	kfree(vaddr);
 }
 
 static const struct dma_map_ops vdpasim_dma_ops = {
@@ -270,6 +285,13 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 	for (i = 0; i < dev_attr->nvqs; i++)
 		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu);
 
+	ret = iova_cache_get();
+	if (ret)
+		goto err_iommu;
+
+	/* For semplicity we use an IOVA allocator with byte granularity */
+	init_iova_domain(&vdpasim->iova, 1, 0);
+
 	vdpasim->vdpa.dma_dev = dev;
 
 	return vdpasim;
@@ -540,6 +562,8 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
 	cancel_work_sync(&vdpasim->work);
+	put_iova_domain(&vdpasim->iova);
+	iova_cache_put();
 	kvfree(vdpasim->buffer);
 	if (vdpasim->iommu)
 		vhost_iotlb_free(vdpasim->iommu);
diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 92a6396f8a73..8965e3717231 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -13,6 +13,7 @@ config VDPA_SIM
 	depends on RUNTIME_TESTING_MENU && HAS_DMA
 	select DMA_OPS
 	select VHOST_RING
+	select IOMMU_IOVA
 	help
 	  Enable this module to support vDPA device simulators. These devices
 	  are used for testing, prototyping and development of vDPA.
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
