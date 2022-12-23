Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5290CC4332F
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 06:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E897781E66;
	Fri, 23 Dec 2022 06:00:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E897781E66
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H+sBxmFa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jvNfJAKBUlSJ; Fri, 23 Dec 2022 06:00:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5169781E6D;
	Fri, 23 Dec 2022 06:00:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5169781E6D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A696C0071;
	Fri, 23 Dec 2022 06:00:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67B83C0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 06:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4EE6281E6D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 06:00:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4EE6281E6D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K5BV998uaYdf
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 06:00:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D3D781E66
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D3D781E66
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 06:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671775231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tV0aITuMxX7JXMP8l/mhTvmsIIk8GUyyDmCSCHHJZEE=;
 b=H+sBxmFaUedHVdtmRujiWiZSIGGRmf2Rx4fBaQyh070B1NLFn+ue1Erx2/d+LluLnYP/kQ
 M8etJRmdgnn2gzxekXDNmKU1YJCQ30kzOcED7je02U4E2oCYGulELletBpQiHVn+z4Z/OD
 UUiwIJV4c0V47VEk4C7z4XvohQcm4Tw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-QWPt_bOKN46b2cPvy3DvJw-1; Fri, 23 Dec 2022 01:00:27 -0500
X-MC-Unique: QWPt_bOKN46b2cPvy3DvJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0424129ABA32;
 Fri, 23 Dec 2022 06:00:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-204.pek2.redhat.com
 [10.72.12.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F8532026D4B;
 Fri, 23 Dec 2022 06:00:23 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH] vdpa_sim: get rid of DMA ops
Date: Fri, 23 Dec 2022 14:00:21 +0800
Message-Id: <20221223060021.28011-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Cc: xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com, hch@lst.de
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

We used to (ab)use the DMA ops for setting up identical mappings in
the IOTLB. This patch tries to get rid of the those unnecessary DMA
ops by maintaining a simple identical/passthrough mappings by
default. When bound to virtio_vdpa driver, DMA API will simply use PA
as the IOVA and we will be all fine. When the vDPA bus tries to setup
customized mapping (e.g when bound to vhost-vDPA), the
identical/passthrough mapping will be removed.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Note:
- This patch depends on the series "[PATCH V3 0/4] Vendor stats
  support in vdpasim_net"
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 170 ++++---------------------------
 drivers/vdpa/vdpa_sim/vdpa_sim.h |   2 +-
 2 files changed, 22 insertions(+), 150 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 45d3f84b7937..187fa3a0e5d5 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -17,7 +17,6 @@
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
 #include <linux/vhost_iotlb.h>
-#include <linux/iova.h>
 #include <uapi/linux/vdpa.h>
 
 #include "vdpa_sim.h"
@@ -45,13 +44,6 @@ static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
 	return container_of(vdpa, struct vdpasim, vdpa);
 }
 
-static struct vdpasim *dev_to_sim(struct device *dev)
-{
-	struct vdpa_device *vdpa = dev_to_vdpa(dev);
-
-	return vdpa_to_sim(vdpa);
-}
-
 static void vdpasim_vq_notify(struct vringh *vring)
 {
 	struct vdpasim_virtqueue *vq =
@@ -104,8 +96,12 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
 				 &vdpasim->iommu_lock);
 	}
 
-	for (i = 0; i < vdpasim->dev_attr.nas; i++)
+	for (i = 0; i < vdpasim->dev_attr.nas; i++) {
 		vhost_iotlb_reset(&vdpasim->iommu[i]);
+		vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX,
+				      0, VHOST_MAP_RW);
+		vdpasim->iommu_pt[i] = true;
+	}
 
 	vdpasim->running = true;
 	spin_unlock(&vdpasim->iommu_lock);
@@ -115,133 +111,6 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
 	++vdpasim->generation;
 }
 
-static int dir_to_perm(enum dma_data_direction dir)
-{
-	int perm = -EFAULT;
-
-	switch (dir) {
-	case DMA_FROM_DEVICE:
-		perm = VHOST_MAP_WO;
-		break;
-	case DMA_TO_DEVICE:
-		perm = VHOST_MAP_RO;
-		break;
-	case DMA_BIDIRECTIONAL:
-		perm = VHOST_MAP_RW;
-		break;
-	default:
-		break;
-	}
-
-	return perm;
-}
-
-static dma_addr_t vdpasim_map_range(struct vdpasim *vdpasim, phys_addr_t paddr,
-				    size_t size, unsigned int perm)
-{
-	struct iova *iova;
-	dma_addr_t dma_addr;
-	int ret;
-
-	/* We set the limit_pfn to the maximum (ULONG_MAX - 1) */
-	iova = alloc_iova(&vdpasim->iova, size >> iova_shift(&vdpasim->iova),
-			  ULONG_MAX - 1, true);
-	if (!iova)
-		return DMA_MAPPING_ERROR;
-
-	dma_addr = iova_dma_addr(&vdpasim->iova, iova);
-
-	spin_lock(&vdpasim->iommu_lock);
-	ret = vhost_iotlb_add_range(&vdpasim->iommu[0], (u64)dma_addr,
-				    (u64)dma_addr + size - 1, (u64)paddr, perm);
-	spin_unlock(&vdpasim->iommu_lock);
-
-	if (ret) {
-		__free_iova(&vdpasim->iova, iova);
-		return DMA_MAPPING_ERROR;
-	}
-
-	return dma_addr;
-}
-
-static void vdpasim_unmap_range(struct vdpasim *vdpasim, dma_addr_t dma_addr,
-				size_t size)
-{
-	spin_lock(&vdpasim->iommu_lock);
-	vhost_iotlb_del_range(&vdpasim->iommu[0], (u64)dma_addr,
-			      (u64)dma_addr + size - 1);
-	spin_unlock(&vdpasim->iommu_lock);
-
-	free_iova(&vdpasim->iova, iova_pfn(&vdpasim->iova, dma_addr));
-}
-
-static dma_addr_t vdpasim_map_page(struct device *dev, struct page *page,
-				   unsigned long offset, size_t size,
-				   enum dma_data_direction dir,
-				   unsigned long attrs)
-{
-	struct vdpasim *vdpasim = dev_to_sim(dev);
-	phys_addr_t paddr = page_to_phys(page) + offset;
-	int perm = dir_to_perm(dir);
-
-	if (perm < 0)
-		return DMA_MAPPING_ERROR;
-
-	return vdpasim_map_range(vdpasim, paddr, size, perm);
-}
-
-static void vdpasim_unmap_page(struct device *dev, dma_addr_t dma_addr,
-			       size_t size, enum dma_data_direction dir,
-			       unsigned long attrs)
-{
-	struct vdpasim *vdpasim = dev_to_sim(dev);
-
-	vdpasim_unmap_range(vdpasim, dma_addr, size);
-}
-
-static void *vdpasim_alloc_coherent(struct device *dev, size_t size,
-				    dma_addr_t *dma_addr, gfp_t flag,
-				    unsigned long attrs)
-{
-	struct vdpasim *vdpasim = dev_to_sim(dev);
-	phys_addr_t paddr;
-	void *addr;
-
-	addr = kmalloc(size, flag);
-	if (!addr) {
-		*dma_addr = DMA_MAPPING_ERROR;
-		return NULL;
-	}
-
-	paddr = virt_to_phys(addr);
-
-	*dma_addr = vdpasim_map_range(vdpasim, paddr, size, VHOST_MAP_RW);
-	if (*dma_addr == DMA_MAPPING_ERROR) {
-		kfree(addr);
-		return NULL;
-	}
-
-	return addr;
-}
-
-static void vdpasim_free_coherent(struct device *dev, size_t size,
-				  void *vaddr, dma_addr_t dma_addr,
-				  unsigned long attrs)
-{
-	struct vdpasim *vdpasim = dev_to_sim(dev);
-
-	vdpasim_unmap_range(vdpasim, dma_addr, size);
-
-	kfree(vaddr);
-}
-
-static const struct dma_map_ops vdpasim_dma_ops = {
-	.map_page = vdpasim_map_page,
-	.unmap_page = vdpasim_unmap_page,
-	.alloc = vdpasim_alloc_coherent,
-	.free = vdpasim_free_coherent,
-};
-
 static const struct vdpa_config_ops vdpasim_config_ops;
 static const struct vdpa_config_ops vdpasim_batch_config_ops;
 
@@ -289,7 +158,6 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	dev->dma_mask = &dev->coherent_dma_mask;
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
 		goto err_iommu;
-	set_dma_ops(dev, &vdpasim_dma_ops);
 	vdpasim->vdpa.mdev = dev_attr->mgmt_dev;
 
 	vdpasim->config = kzalloc(dev_attr->config_size, GFP_KERNEL);
@@ -306,6 +174,11 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	if (!vdpasim->iommu)
 		goto err_iommu;
 
+	vdpasim->iommu_pt = kmalloc_array(vdpasim->dev_attr.nas,
+					  sizeof(*vdpasim->iommu_pt), GFP_KERNEL);
+	if (!vdpasim->iommu_pt)
+		goto err_iommu;
+
 	for (i = 0; i < vdpasim->dev_attr.nas; i++)
 		vhost_iotlb_init(&vdpasim->iommu[i], max_iotlb_entries, 0);
 
@@ -317,13 +190,6 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 		vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
 				 &vdpasim->iommu_lock);
 
-	ret = iova_cache_get();
-	if (ret)
-		goto err_iommu;
-
-	/* For simplicity we use an IOVA allocator with byte granularity */
-	init_iova_domain(&vdpasim->iova, 1, 0);
-
 	vdpasim->vdpa.dma_dev = dev;
 
 	return vdpasim;
@@ -639,6 +505,7 @@ static int vdpasim_set_map(struct vdpa_device *vdpa, unsigned int asid,
 
 	iommu = &vdpasim->iommu[asid];
 	vhost_iotlb_reset(iommu);
+	vdpasim->iommu_pt[asid] = false;
 
 	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
 	     map = vhost_iotlb_itree_next(map, start, last)) {
@@ -667,6 +534,10 @@ static int vdpasim_dma_map(struct vdpa_device *vdpa, unsigned int asid,
 		return -EINVAL;
 
 	spin_lock(&vdpasim->iommu_lock);
+	if (vdpasim->iommu_pt[asid]) {
+		vhost_iotlb_reset(&vdpasim->iommu[asid]);
+		vdpasim->iommu_pt[asid] = false;
+	}
 	ret = vhost_iotlb_add_range_ctx(&vdpasim->iommu[asid], iova,
 					iova + size - 1, pa, perm, opaque);
 	spin_unlock(&vdpasim->iommu_lock);
@@ -682,6 +553,11 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
 	if (asid >= vdpasim->dev_attr.nas)
 		return -EINVAL;
 
+	if (vdpasim->iommu_pt[asid]) {
+		vhost_iotlb_reset(&vdpasim->iommu[asid]);
+		vdpasim->iommu_pt[asid] = false;
+	}
+
 	spin_lock(&vdpasim->iommu_lock);
 	vhost_iotlb_del_range(&vdpasim->iommu[asid], iova, iova + size - 1);
 	spin_unlock(&vdpasim->iommu_lock);
@@ -701,15 +577,11 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 		vringh_kiov_cleanup(&vdpasim->vqs[i].in_iov);
 	}
 
-	if (vdpa_get_dma_dev(vdpa)) {
-		put_iova_domain(&vdpasim->iova);
-		iova_cache_put();
-	}
-
 	kvfree(vdpasim->buffer);
 	for (i = 0; i < vdpasim->dev_attr.nas; i++)
 		vhost_iotlb_reset(&vdpasim->iommu[i]);
 	kfree(vdpasim->iommu);
+	kfree(vdpasim->iommu_pt);
 	kfree(vdpasim->vqs);
 	kfree(vdpasim->config);
 }
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index d2a08c0abad7..770ef3408619 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -64,7 +64,7 @@ struct vdpasim {
 	/* virtio config according to device type */
 	void *config;
 	struct vhost_iotlb *iommu;
-	struct iova_domain iova;
+	bool *iommu_pt;
 	void *buffer;
 	u32 status;
 	u32 generation;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
