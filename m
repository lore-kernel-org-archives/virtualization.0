Return-Path: <SRS0=vMKq=G7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6F0C433DB
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 14:41:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC8764DE2
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 14:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC8764DE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7511F867BD;
	Thu, 28 Jan 2021 14:41:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7etii0pg2FPB; Thu, 28 Jan 2021 14:41:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 97F038679B;
	Thu, 28 Jan 2021 14:41:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82BABC08A1;
	Thu, 28 Jan 2021 14:41:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25675C08A1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:41:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E49D02043A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:41:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5ia9c9XHOubp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:41:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 14CD920362
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611844901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=047Q+kHFTMwlZxZSB0OK+gVEKt1Ugj8Uih+TOE9Lvzk=;
 b=Auh3lBdCwWGDCmBA1axUTwEsTiJKMKBxBV2Lj1HoYHimWlBZtCVtFJ1y6EVOPu/WnWxc5K
 fpuPlWiRdhnXhd8JLmL4ug+8TL/S5VlYpri0lMyVZzJob3rkbIw+Z2s+9UbFNKUdlDyK++
 EFUwYW9LSZLy0pFeOYMp2z441Xs0VWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-l6v_Hj7jNeG3bOxw4CGzMA-1; Thu, 28 Jan 2021 09:41:40 -0500
X-MC-Unique: l6v_Hj7jNeG3bOxw4CGzMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0023B8015DA;
 Thu, 28 Jan 2021 14:41:39 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-219.ams2.redhat.com
 [10.36.113.219])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA6EC60875;
 Thu, 28 Jan 2021 14:41:36 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v2 01/10] vdpa_sim: use iova module to allocate IOVA
 addresses
Date: Thu, 28 Jan 2021 15:41:18 +0100
Message-Id: <20210128144127.113245-2-sgarzare@redhat.com>
In-Reply-To: <20210128144127.113245-1-sgarzare@redhat.com>
References: <20210128144127.113245-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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
For simplicity we use an IOVA allocator with byte granularity.

We add two new functions, vdpasim_map_range() and vdpasim_unmap_range(),
to handle the IOVA allocation and the registration into the IOMMU/IOTLB.
These functions are used by dma_map_ops callbacks.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- used ULONG_MAX instead of ~0UL [Jason]
- fixed typos in comment and patch description [Jason]
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h |   2 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 108 +++++++++++++++++++------------
 drivers/vdpa/Kconfig             |   1 +
 3 files changed, 69 insertions(+), 42 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 6d75444f9948..cd58e888bcf3 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -6,6 +6,7 @@
 #ifndef _VDPA_SIM_H
 #define _VDPA_SIM_H
 
+#include <linux/iova.h>
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
 #include <linux/virtio_byteorder.h>
@@ -57,6 +58,7 @@ struct vdpasim {
 	/* virtio config according to device type */
 	void *config;
 	struct vhost_iotlb *iommu;
+	struct iova_domain iova;
 	void *buffer;
 	u32 status;
 	u32 generation;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index d5942842432d..2183a833fcf4 100644
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
+	/* We set the limit_pfn to the maximum (ULONG_MAX - 1) */
+	iova = alloc_iova(&vdpasim->iova, size, ULONG_MAX - 1, true);
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
@@ -271,6 +286,13 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 	for (i = 0; i < dev_attr->nvqs; i++)
 		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu);
 
+	ret = iova_cache_get();
+	if (ret)
+		goto err_iommu;
+
+	/* For simplicity we use an IOVA allocator with byte granularity */
+	init_iova_domain(&vdpasim->iova, 1, 0);
+
 	vdpasim->vdpa.dma_dev = dev;
 
 	return vdpasim;
@@ -541,6 +563,8 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
 	cancel_work_sync(&vdpasim->work);
+	put_iova_domain(&vdpasim->iova);
+	iova_cache_put();
 	kvfree(vdpasim->buffer);
 	if (vdpasim->iommu)
 		vhost_iotlb_free(vdpasim->iommu);
diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index ffd1e098bfd2..21a23500f430 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -14,6 +14,7 @@ config VDPA_SIM
 	depends on RUNTIME_TESTING_MENU && HAS_DMA
 	select DMA_OPS
 	select VHOST_RING
+	select IOMMU_IOVA
 	help
 	  Enable this module to support vDPA device simulators. These devices
 	  are used for testing, prototyping and development of vDPA.
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
