Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91062C433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 15:00:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068B523381
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 15:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068B523381
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9812485F5E;
	Wed, 20 Jan 2021 15:00:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Jd807WJsBsg; Wed, 20 Jan 2021 15:00:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DB89685F77;
	Wed, 20 Jan 2021 15:00:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C79F1C08A1;
	Wed, 20 Jan 2021 15:00:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CC03C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 15:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 39C8A86410
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 15:00:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r6fkRrOl5RgU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 15:00:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D564A85D21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611154818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9pDvwWZLbTOJS6GMMwEHxHLJ6cBw1mbVBDvHP/BK4iw=;
 b=YYtpOMPX2cAnOuWYC/hISAbzsYfS4tfaZtOBdnQqwzGnCVkUBpbqkGBlGAxE12I5gC9vh3
 DGLumtLX7PBjnXxKFBz9xEL5WO1f6UyUysATU94sGKVd3I6NAqBws3ebWeYJQdiUyy5icy
 jS2eZiMQ8cvCq9govAhogcickO4m8Do=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-PQxwWoCQOLOZNx21ffkFdA-1; Wed, 20 Jan 2021 10:00:16 -0500
X-MC-Unique: PQxwWoCQOLOZNx21ffkFdA-1
Received: by mail-wr1-f72.google.com with SMTP id w5so11551588wrl.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 07:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9pDvwWZLbTOJS6GMMwEHxHLJ6cBw1mbVBDvHP/BK4iw=;
 b=trScyfP2pgtyRVXZfh7JeOhTt9MUo1RKVM0la77pbM+oLWIrLebw510uF8ZrHNt4pq
 PNZNN9HjJiBxJNP54kkwPWkeUO83DNC6neWJOhWvC5A3c5s+JYiDnzlwSKhGANdBEcHX
 5G6r9KwUCb29laZNb4VcAJ2dyqa+mbEYyp1I8q+tE7yz2AwBg5FlWKyeGekdHdfV1HuK
 LU2xAUFf71pl5AAET+MRtbf52tt37hfpEskNh2ODAhjWM5guyeEHUFUWxC29BBuTz6dx
 tdcb1ts0rOyqoH5G13piKfhMNB4GRiZB3rVntBqkVnaM0sDQzOK9x2YB/pCoUKiKqOJ6
 hUvg==
X-Gm-Message-State: AOAM5332pC0Vp5drFr1zH7UzcD3nXFAkgTyRzFhq6o0igBDSyJPX5dso
 Qw+5ElUu47IGFoTFKTFYmw2CUBUWoDb3S2gMrUaR4bzIjMLYSmKKdhw1D+Qskc2elbrw/vT0sGG
 zXwG/L/6VSYNGLnYXzGSGMjwz0yWnoDRLCqk7oWNsrA==
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr9998566wrb.105.1611154815133; 
 Wed, 20 Jan 2021 07:00:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0QOeG2rwtzdFS2q5IkPnDfNwnd37D/c1xEe4LIR954SOp4UKw2bGMW6TQ4t2nxv76OnMmYQ==
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr9998535wrb.105.1611154814870; 
 Wed, 20 Jan 2021 07:00:14 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id a16sm3671045wrr.89.2021.01.20.07.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jan 2021 07:00:14 -0800 (PST)
Date: Wed, 20 Jan 2021 16:00:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2] vdpa_sim: use iova module to allocate IOVA addresses
Message-ID: <20210120150011.dzzvzi6t4dvfy2w3@steredhat>
References: <20201223090608.24163-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201223090608.24163-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Laurent Vivier <lvivier@redhat.com>,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

Hi Michael,
I'm restarting the work on vdpa-blk simulator, and this patch is needed 
to have it working properly.

Do you plan to queue this patch or would you prefer that I include it in 
my next vdpa-blk-sim series?

Thanks,
Stefano

On Wed, Dec 23, 2020 at 10:06:08AM +0100, Stefano Garzarella wrote:
>The identical mapping used until now created issues when mapping
>different virtual pages with the same physical address.
>To solve this issue, we can use the iova module, to handle the IOVA
>allocation.
>For simplicity we use an IOVA allocator with byte granularity.
>
>We add two new functions, vdpasim_map_range() and vdpasim_unmap_range(),
>to handle the IOVA allocation and the registration into the IOMMU/IOTLB.
>These functions are used by dma_map_ops callbacks.
>
>Acked-by: Jason Wang <jasowang@redhat.com>
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
>v2:
>- used ULONG_MAX instead of ~0UL [Jason]
>- fixed typos in comment and patch description [Jason]
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.h |   2 +
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 108 +++++++++++++++++++------------
> drivers/vdpa/Kconfig             |   1 +
> 3 files changed, 69 insertions(+), 42 deletions(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>index b02142293d5b..6efe205e583e 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>@@ -6,6 +6,7 @@
> #ifndef _VDPA_SIM_H
> #define _VDPA_SIM_H
>
>+#include <linux/iova.h>
> #include <linux/vringh.h>
> #include <linux/vdpa.h>
> #include <linux/virtio_byteorder.h>
>@@ -55,6 +56,7 @@ struct vdpasim {
> 	/* virtio config according to device type */
> 	void *config;
> 	struct vhost_iotlb *iommu;
>+	struct iova_domain iova;
> 	void *buffer;
> 	u32 status;
> 	u32 generation;
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index b3fcc67bfdf0..edc930719fb8 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -17,6 +17,7 @@
> #include <linux/vringh.h>
> #include <linux/vdpa.h>
> #include <linux/vhost_iotlb.h>
>+#include <linux/iova.h>
>
> #include "vdpa_sim.h"
>
>@@ -128,30 +129,57 @@ static int dir_to_perm(enum dma_data_direction dir)
> 	return perm;
> }
>
>+static dma_addr_t vdpasim_map_range(struct vdpasim *vdpasim, phys_addr_t paddr,
>+				    size_t size, unsigned int perm)
>+{
>+	struct iova *iova;
>+	dma_addr_t dma_addr;
>+	int ret;
>+
>+	/* We set the limit_pfn to the maximum (ULONG_MAX - 1) */
>+	iova = alloc_iova(&vdpasim->iova, size, ULONG_MAX - 1, true);
>+	if (!iova)
>+		return DMA_MAPPING_ERROR;
>+
>+	dma_addr = iova_dma_addr(&vdpasim->iova, iova);
>+
>+	spin_lock(&vdpasim->iommu_lock);
>+	ret = vhost_iotlb_add_range(vdpasim->iommu, (u64)dma_addr,
>+				    (u64)dma_addr + size - 1, (u64)paddr, perm);
>+	spin_unlock(&vdpasim->iommu_lock);
>+
>+	if (ret) {
>+		__free_iova(&vdpasim->iova, iova);
>+		return DMA_MAPPING_ERROR;
>+	}
>+
>+	return dma_addr;
>+}
>+
>+static void vdpasim_unmap_range(struct vdpasim *vdpasim, dma_addr_t dma_addr,
>+				size_t size)
>+{
>+	spin_lock(&vdpasim->iommu_lock);
>+	vhost_iotlb_del_range(vdpasim->iommu, (u64)dma_addr,
>+			      (u64)dma_addr + size - 1);
>+	spin_unlock(&vdpasim->iommu_lock);
>+
>+	free_iova(&vdpasim->iova, iova_pfn(&vdpasim->iova, dma_addr));
>+}
>+
> static dma_addr_t vdpasim_map_page(struct device *dev, struct page *page,
> 				   unsigned long offset, size_t size,
> 				   enum dma_data_direction dir,
> 				   unsigned long attrs)
> {
> 	struct vdpasim *vdpasim = dev_to_sim(dev);
>-	struct vhost_iotlb *iommu = vdpasim->iommu;
>-	u64 pa = (page_to_pfn(page) << PAGE_SHIFT) + offset;
>-	int ret, perm = dir_to_perm(dir);
>+	phys_addr_t paddr = page_to_phys(page) + offset;
>+	int perm = dir_to_perm(dir);
>
> 	if (perm < 0)
> 		return DMA_MAPPING_ERROR;
>
>-	/* For simplicity, use identical mapping to avoid e.g iova
>-	 * allocator.
>-	 */
>-	spin_lock(&vdpasim->iommu_lock);
>-	ret = vhost_iotlb_add_range(iommu, pa, pa + size - 1,
>-				    pa, dir_to_perm(dir));
>-	spin_unlock(&vdpasim->iommu_lock);
>-	if (ret)
>-		return DMA_MAPPING_ERROR;
>-
>-	return (dma_addr_t)(pa);
>+	return vdpasim_map_range(vdpasim, paddr, size, perm);
> }
>
> static void vdpasim_unmap_page(struct device *dev, dma_addr_t dma_addr,
>@@ -159,12 +187,8 @@ static void vdpasim_unmap_page(struct device *dev, dma_addr_t dma_addr,
> 			       unsigned long attrs)
> {
> 	struct vdpasim *vdpasim = dev_to_sim(dev);
>-	struct vhost_iotlb *iommu = vdpasim->iommu;
>
>-	spin_lock(&vdpasim->iommu_lock);
>-	vhost_iotlb_del_range(iommu, (u64)dma_addr,
>-			      (u64)dma_addr + size - 1);
>-	spin_unlock(&vdpasim->iommu_lock);
>+	vdpasim_unmap_range(vdpasim, dma_addr, size);
> }
>
> static void *vdpasim_alloc_coherent(struct device *dev, size_t size,
>@@ -172,27 +196,22 @@ static void *vdpasim_alloc_coherent(struct device *dev, size_t size,
> 				    unsigned long attrs)
> {
> 	struct vdpasim *vdpasim = dev_to_sim(dev);
>-	struct vhost_iotlb *iommu = vdpasim->iommu;
>-	void *addr = kmalloc(size, flag);
>-	int ret;
>+	phys_addr_t paddr;
>+	void *addr;
>
>-	spin_lock(&vdpasim->iommu_lock);
>+	addr = kmalloc(size, flag);
> 	if (!addr) {
> 		*dma_addr = DMA_MAPPING_ERROR;
>-	} else {
>-		u64 pa = virt_to_phys(addr);
>-
>-		ret = vhost_iotlb_add_range(iommu, (u64)pa,
>-					    (u64)pa + size - 1,
>-					    pa, VHOST_MAP_RW);
>-		if (ret) {
>-			*dma_addr = DMA_MAPPING_ERROR;
>-			kfree(addr);
>-			addr = NULL;
>-		} else
>-			*dma_addr = (dma_addr_t)pa;
>+		return NULL;
>+	}
>+
>+	paddr = virt_to_phys(addr);
>+
>+	*dma_addr = vdpasim_map_range(vdpasim, paddr, size, VHOST_MAP_RW);
>+	if (*dma_addr == DMA_MAPPING_ERROR) {
>+		kfree(addr);
>+		return NULL;
> 	}
>-	spin_unlock(&vdpasim->iommu_lock);
>
> 	return addr;
> }
>@@ -202,14 +221,10 @@ static void vdpasim_free_coherent(struct device *dev, size_t size,
> 				  unsigned long attrs)
> {
> 	struct vdpasim *vdpasim = dev_to_sim(dev);
>-	struct vhost_iotlb *iommu = vdpasim->iommu;
>
>-	spin_lock(&vdpasim->iommu_lock);
>-	vhost_iotlb_del_range(iommu, (u64)dma_addr,
>-			      (u64)dma_addr + size - 1);
>-	spin_unlock(&vdpasim->iommu_lock);
>+	vdpasim_unmap_range(vdpasim, dma_addr, size);
>
>-	kfree(phys_to_virt((uintptr_t)dma_addr));
>+	kfree(vaddr);
> }
>
> static const struct dma_map_ops vdpasim_dma_ops = {
>@@ -270,6 +285,13 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
> 	for (i = 0; i < dev_attr->nvqs; i++)
> 		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu);
>
>+	ret = iova_cache_get();
>+	if (ret)
>+		goto err_iommu;
>+
>+	/* For simplicity we use an IOVA allocator with byte granularity */
>+	init_iova_domain(&vdpasim->iova, 1, 0);
>+
> 	vdpasim->vdpa.dma_dev = dev;
>
> 	return vdpasim;
>@@ -540,6 +562,8 @@ static void vdpasim_free(struct vdpa_device *vdpa)
> 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>
> 	cancel_work_sync(&vdpasim->work);
>+	put_iova_domain(&vdpasim->iova);
>+	iova_cache_put();
> 	kvfree(vdpasim->buffer);
> 	if (vdpasim->iommu)
> 		vhost_iotlb_free(vdpasim->iommu);
>diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
>index 92a6396f8a73..8965e3717231 100644
>--- a/drivers/vdpa/Kconfig
>+++ b/drivers/vdpa/Kconfig
>@@ -13,6 +13,7 @@ config VDPA_SIM
> 	depends on RUNTIME_TESTING_MENU && HAS_DMA
> 	select DMA_OPS
> 	select VHOST_RING
>+	select IOMMU_IOVA
> 	help
> 	  Enable this module to support vDPA device simulators. These devices
> 	  are used for testing, prototyping and development of vDPA.
>-- 
>2.26.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
