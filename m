Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3ADC4332F
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 09:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 047C161131;
	Fri, 23 Dec 2022 09:27:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 047C161131
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZJMGYVpu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gx-b_2GB4ORW; Fri, 23 Dec 2022 09:27:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4EC3F61132;
	Fri, 23 Dec 2022 09:27:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4EC3F61132
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 203A7C0071;
	Fri, 23 Dec 2022 09:27:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C53AC0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 09:27:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 265C061132
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 09:27:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 265C061132
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gqJulQP7IEJ4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 09:27:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CB7261131
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CB7261131
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 09:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671787626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zfgFr0NaikqYgGNWSJvZuZ6wiSdO/uissAoWRpapsXA=;
 b=ZJMGYVpuJaHPtzDgDIOcsuig35H8XacYUfTN2C24ctyBNz72aIaZhOyy2W9mG1Suah2vrn
 3jDmcOFtMqUdOn7gbiYXSPPziQF5r3iM2WXu3xqFlpw2g0pIunWD+sxoCGFj59iwrttblC
 PJ5bMNRPJFMbRMSYzE10owawCnJ6cR4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-570-u9zTKhhHP06VHp02GG1eNA-1; Fri, 23 Dec 2022 04:27:04 -0500
X-MC-Unique: u9zTKhhHP06VHp02GG1eNA-1
Received: by mail-qk1-f198.google.com with SMTP id
 bl3-20020a05620a1a8300b0070240ff36a0so2854661qkb.19
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 01:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfgFr0NaikqYgGNWSJvZuZ6wiSdO/uissAoWRpapsXA=;
 b=ZbyUHHRx/w7uQ4tQJ8ioxS5KJK8SWFmSt9jBsOMw6aYE6CwYv4lI1KLBgNNeNG2Qor
 4+CIz2p372twtIJgzxrBpfQXidCbKusp6SSyxhq52WKXlzZUFe+w2E7PN5fq1BVSMtwN
 4nzYuVGMDZjnOdLwFWdZMa3VIe3R28PbzQOaSliIcqWwnifTKUwY2P6lAW3nRBL3fT1E
 pgv58offNZ5+kpTk2tBIT2p5ltF5NPhYpetHhs6F1cV0+In6JBev9SOythlLh5vBdl1j
 CeiM7R3zm++eZq8v3QVfLl3hF007OvVvXl4gX6ii+feBqYfb3UWtj3Ca9DJDuZgKbMZ+
 KW9w==
X-Gm-Message-State: AFqh2kqxXH1bdCjZXXT34B8HhRjUyImk9tO0E9ldeFn5lUbLsEf567Kw
 8dMr//yQrrx/k5fGYJy5D/ezFWHoCu5EhIFWO4drf+goX4XtADZg2vxgbfW8tCmaTJbS3qSd5W1
 AN22YJRg+lBSCo9WGnZXmFuIJHXx9SFCdlgj9aOd/fw==
X-Received: by 2002:ac8:4a88:0:b0:3a8:15e2:a068 with SMTP id
 l8-20020ac84a88000000b003a815e2a068mr10731294qtq.4.1671787623713; 
 Fri, 23 Dec 2022 01:27:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtbV8g5DO5Rr8LIGFMJJACh4CQSMOPfUTbHosiEEmnU0wQNHiaIRlPpfgoUFfXE3+sANc59dA==
X-Received: by 2002:ac8:4a88:0:b0:3a8:15e2:a068 with SMTP id
 l8-20020ac84a88000000b003a815e2a068mr10731284qtq.4.1671787623440; 
 Fri, 23 Dec 2022 01:27:03 -0800 (PST)
Received: from sgarzare-redhat (host-79-34-11-215.business.telecomitalia.it.
 [79.34.11.215]) by smtp.gmail.com with ESMTPSA id
 o6-20020ac872c6000000b003a57a317c17sm1693485qtp.74.2022.12.23.01.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Dec 2022 01:27:02 -0800 (PST)
Date: Fri, 23 Dec 2022 10:26:56 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa_sim: get rid of DMA ops
Message-ID: <20221223092656.ccs2fwwysu2gqzjo@sgarzare-redhat>
References: <20221223060021.28011-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221223060021.28011-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xieyongji@bytedance.com, mst@redhat.com, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Dec 23, 2022 at 02:00:21PM +0800, Jason Wang wrote:
>We used to (ab)use the DMA ops for setting up identical mappings in
>the IOTLB. This patch tries to get rid of the those unnecessary DMA
>ops by maintaining a simple identical/passthrough mappings by
>default. When bound to virtio_vdpa driver, DMA API will simply use PA
>as the IOVA and we will be all fine. When the vDPA bus tries to setup
>customized mapping (e.g when bound to vhost-vDPA), the
>identical/passthrough mapping will be removed.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
>Note:
>- This patch depends on the series "[PATCH V3 0/4] Vendor stats
>  support in vdpasim_net"
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 170 ++++---------------------------
> drivers/vdpa/vdpa_sim/vdpa_sim.h |   2 +-
> 2 files changed, 22 insertions(+), 150 deletions(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 45d3f84b7937..187fa3a0e5d5 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -17,7 +17,6 @@
> #include <linux/vringh.h>
> #include <linux/vdpa.h>
> #include <linux/vhost_iotlb.h>
>-#include <linux/iova.h>
> #include <uapi/linux/vdpa.h>
>
> #include "vdpa_sim.h"
>@@ -45,13 +44,6 @@ static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
> 	return container_of(vdpa, struct vdpasim, vdpa);
> }
>
>-static struct vdpasim *dev_to_sim(struct device *dev)
>-{
>-	struct vdpa_device *vdpa = dev_to_vdpa(dev);
>-
>-	return vdpa_to_sim(vdpa);
>-}
>-
> static void vdpasim_vq_notify(struct vringh *vring)
> {
> 	struct vdpasim_virtqueue *vq =
>@@ -104,8 +96,12 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
> 				 &vdpasim->iommu_lock);
> 	}
>
>-	for (i = 0; i < vdpasim->dev_attr.nas; i++)
>+	for (i = 0; i < vdpasim->dev_attr.nas; i++) {
> 		vhost_iotlb_reset(&vdpasim->iommu[i]);
>+		vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX,
>+				      0, VHOST_MAP_RW);
>+		vdpasim->iommu_pt[i] = true;
>+	}
>
> 	vdpasim->running = true;
> 	spin_unlock(&vdpasim->iommu_lock);
>@@ -115,133 +111,6 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
> 	++vdpasim->generation;
> }
>
>-static int dir_to_perm(enum dma_data_direction dir)
>-{
>-	int perm = -EFAULT;
>-
>-	switch (dir) {
>-	case DMA_FROM_DEVICE:
>-		perm = VHOST_MAP_WO;
>-		break;
>-	case DMA_TO_DEVICE:
>-		perm = VHOST_MAP_RO;
>-		break;
>-	case DMA_BIDIRECTIONAL:
>-		perm = VHOST_MAP_RW;
>-		break;
>-	default:
>-		break;
>-	}
>-
>-	return perm;
>-}
>-
>-static dma_addr_t vdpasim_map_range(struct vdpasim *vdpasim, phys_addr_t paddr,
>-				    size_t size, unsigned int perm)
>-{
>-	struct iova *iova;
>-	dma_addr_t dma_addr;
>-	int ret;
>-
>-	/* We set the limit_pfn to the maximum (ULONG_MAX - 1) */
>-	iova = alloc_iova(&vdpasim->iova, size >> iova_shift(&vdpasim->iova),
>-			  ULONG_MAX - 1, true);
>-	if (!iova)
>-		return DMA_MAPPING_ERROR;
>-
>-	dma_addr = iova_dma_addr(&vdpasim->iova, iova);
>-
>-	spin_lock(&vdpasim->iommu_lock);
>-	ret = vhost_iotlb_add_range(&vdpasim->iommu[0], (u64)dma_addr,
>-				    (u64)dma_addr + size - 1, (u64)paddr, perm);
>-	spin_unlock(&vdpasim->iommu_lock);
>-
>-	if (ret) {
>-		__free_iova(&vdpasim->iova, iova);
>-		return DMA_MAPPING_ERROR;
>-	}
>-
>-	return dma_addr;
>-}
>-
>-static void vdpasim_unmap_range(struct vdpasim *vdpasim, dma_addr_t dma_addr,
>-				size_t size)
>-{
>-	spin_lock(&vdpasim->iommu_lock);
>-	vhost_iotlb_del_range(&vdpasim->iommu[0], (u64)dma_addr,
>-			      (u64)dma_addr + size - 1);
>-	spin_unlock(&vdpasim->iommu_lock);
>-
>-	free_iova(&vdpasim->iova, iova_pfn(&vdpasim->iova, dma_addr));
>-}
>-
>-static dma_addr_t vdpasim_map_page(struct device *dev, struct page *page,
>-				   unsigned long offset, size_t size,
>-				   enum dma_data_direction dir,
>-				   unsigned long attrs)
>-{
>-	struct vdpasim *vdpasim = dev_to_sim(dev);
>-	phys_addr_t paddr = page_to_phys(page) + offset;
>-	int perm = dir_to_perm(dir);
>-
>-	if (perm < 0)
>-		return DMA_MAPPING_ERROR;
>-
>-	return vdpasim_map_range(vdpasim, paddr, size, perm);
>-}
>-
>-static void vdpasim_unmap_page(struct device *dev, dma_addr_t dma_addr,
>-			       size_t size, enum dma_data_direction dir,
>-			       unsigned long attrs)
>-{
>-	struct vdpasim *vdpasim = dev_to_sim(dev);
>-
>-	vdpasim_unmap_range(vdpasim, dma_addr, size);
>-}
>-
>-static void *vdpasim_alloc_coherent(struct device *dev, size_t size,
>-				    dma_addr_t *dma_addr, gfp_t flag,
>-				    unsigned long attrs)
>-{
>-	struct vdpasim *vdpasim = dev_to_sim(dev);
>-	phys_addr_t paddr;
>-	void *addr;
>-
>-	addr = kmalloc(size, flag);
>-	if (!addr) {
>-		*dma_addr = DMA_MAPPING_ERROR;
>-		return NULL;
>-	}
>-
>-	paddr = virt_to_phys(addr);
>-
>-	*dma_addr = vdpasim_map_range(vdpasim, paddr, size, VHOST_MAP_RW);
>-	if (*dma_addr == DMA_MAPPING_ERROR) {
>-		kfree(addr);
>-		return NULL;
>-	}
>-
>-	return addr;
>-}
>-
>-static void vdpasim_free_coherent(struct device *dev, size_t size,
>-				  void *vaddr, dma_addr_t dma_addr,
>-				  unsigned long attrs)
>-{
>-	struct vdpasim *vdpasim = dev_to_sim(dev);
>-
>-	vdpasim_unmap_range(vdpasim, dma_addr, size);
>-
>-	kfree(vaddr);
>-}
>-
>-static const struct dma_map_ops vdpasim_dma_ops = {
>-	.map_page = vdpasim_map_page,
>-	.unmap_page = vdpasim_unmap_page,
>-	.alloc = vdpasim_alloc_coherent,
>-	.free = vdpasim_free_coherent,
>-};
>-
> static const struct vdpa_config_ops vdpasim_config_ops;
> static const struct vdpa_config_ops vdpasim_batch_config_ops;
>
>@@ -289,7 +158,6 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> 	dev->dma_mask = &dev->coherent_dma_mask;
> 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
> 		goto err_iommu;
>-	set_dma_ops(dev, &vdpasim_dma_ops);
> 	vdpasim->vdpa.mdev = dev_attr->mgmt_dev;
>
> 	vdpasim->config = kzalloc(dev_attr->config_size, GFP_KERNEL);
>@@ -306,6 +174,11 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> 	if (!vdpasim->iommu)
> 		goto err_iommu;
>
>+	vdpasim->iommu_pt = kmalloc_array(vdpasim->dev_attr.nas,
>+					  sizeof(*vdpasim->iommu_pt), GFP_KERNEL);
>+	if (!vdpasim->iommu_pt)
>+		goto err_iommu;
>+
> 	for (i = 0; i < vdpasim->dev_attr.nas; i++)
> 		vhost_iotlb_init(&vdpasim->iommu[i], max_iotlb_entries, 0);
>
>@@ -317,13 +190,6 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> 		vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
> 				 &vdpasim->iommu_lock);
>
>-	ret = iova_cache_get();
>-	if (ret)
>-		goto err_iommu;
>-
>-	/* For simplicity we use an IOVA allocator with byte granularity */
>-	init_iova_domain(&vdpasim->iova, 1, 0);
>-
> 	vdpasim->vdpa.dma_dev = dev;
>
> 	return vdpasim;
>@@ -639,6 +505,7 @@ static int vdpasim_set_map(struct vdpa_device *vdpa, unsigned int asid,
>
> 	iommu = &vdpasim->iommu[asid];
> 	vhost_iotlb_reset(iommu);
>+	vdpasim->iommu_pt[asid] = false;
>
> 	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
> 	     map = vhost_iotlb_itree_next(map, start, last)) {
>@@ -667,6 +534,10 @@ static int vdpasim_dma_map(struct vdpa_device *vdpa, unsigned int asid,
> 		return -EINVAL;
>
> 	spin_lock(&vdpasim->iommu_lock);
>+	if (vdpasim->iommu_pt[asid]) {
>+		vhost_iotlb_reset(&vdpasim->iommu[asid]);
>+		vdpasim->iommu_pt[asid] = false;
>+	}
> 	ret = vhost_iotlb_add_range_ctx(&vdpasim->iommu[asid], iova,
> 					iova + size - 1, pa, perm, opaque);
> 	spin_unlock(&vdpasim->iommu_lock);
>@@ -682,6 +553,11 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
> 	if (asid >= vdpasim->dev_attr.nas)
> 		return -EINVAL;
>
>+	if (vdpasim->iommu_pt[asid]) {

We are in the vdpasim_dma_unmap, so if vdpasim->iommu_pt[asid] is true, 
should be better to return an error, since this case should not happen?

The rest LGTM!

Thanks,
Stefano

>+		vhost_iotlb_reset(&vdpasim->iommu[asid]);
>+		vdpasim->iommu_pt[asid] = false;
>+	}
>+
> 	spin_lock(&vdpasim->iommu_lock);
> 	vhost_iotlb_del_range(&vdpasim->iommu[asid], iova, iova + size - 1);
> 	spin_unlock(&vdpasim->iommu_lock);
>@@ -701,15 +577,11 @@ static void vdpasim_free(struct vdpa_device *vdpa)
> 		vringh_kiov_cleanup(&vdpasim->vqs[i].in_iov);
> 	}
>
>-	if (vdpa_get_dma_dev(vdpa)) {
>-		put_iova_domain(&vdpasim->iova);
>-		iova_cache_put();
>-	}
>-
> 	kvfree(vdpasim->buffer);
> 	for (i = 0; i < vdpasim->dev_attr.nas; i++)
> 		vhost_iotlb_reset(&vdpasim->iommu[i]);
> 	kfree(vdpasim->iommu);
>+	kfree(vdpasim->iommu_pt);
> 	kfree(vdpasim->vqs);
> 	kfree(vdpasim->config);
> }
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>index d2a08c0abad7..770ef3408619 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>@@ -64,7 +64,7 @@ struct vdpasim {
> 	/* virtio config according to device type */
> 	void *config;
> 	struct vhost_iotlb *iommu;
>-	struct iova_domain iova;
>+	bool *iommu_pt;
> 	void *buffer;
> 	u32 status;
> 	u32 generation;
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
