Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F83C3DA79
	for <virtualization@archiver.kernel.org>; Mon, 26 Dec 2022 04:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0D21812CA;
	Mon, 26 Dec 2022 04:13:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B0D21812CA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZAeMYMvE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KZQek99JbJK2; Mon, 26 Dec 2022 04:13:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E65FC812CB;
	Mon, 26 Dec 2022 04:12:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E65FC812CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDF94C0032;
	Mon, 26 Dec 2022 04:12:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4611C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 04:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A9DD40357
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 04:12:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A9DD40357
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZAeMYMvE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S7RDKSGevzb6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 04:12:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04C3B40319
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04C3B40319
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 04:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672027975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1xbwdMuKGP8PlsQI1dD5J5S50UOs/R2WOB6z3bdkzG4=;
 b=ZAeMYMvEmDeeszwQtW7r0DxEadhykAWvVwp++HobVXO/ATHVlwuEb8ZoysqE1br02SfCQs
 C7YcQ86h9G4PAiivR4sdPknGOd8660iGR8tHUzHOX+m7SfIrWjYZHmWnpSIqiKAFIrAWBw
 H8Q6G4dIpBnbTLlH0z00c8blGfu7ax8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-191-rBvAZ5nsN6i9k8VH17F3iA-1; Sun, 25 Dec 2022 23:12:54 -0500
X-MC-Unique: rBvAZ5nsN6i9k8VH17F3iA-1
Received: by mail-oo1-f69.google.com with SMTP id
 n30-20020a4a345e000000b004ac99b461b5so4694604oof.19
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Dec 2022 20:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1xbwdMuKGP8PlsQI1dD5J5S50UOs/R2WOB6z3bdkzG4=;
 b=Ak2BsEOQkDC34AtvfFP7z/8jLtYdLiOzdtuoprgdMfPVv6UIt+Wea5qBSuz+P7slta
 EQS8Vu1NCQ1uYmsFItQPucOxnvZkUD0T41GfeqDCCxEo87y2riJO6QJeTFCEX05N+Bta
 dGBd0b89fcmu39lVoc6Dl9YqWYvrel3ZagrCGx/YFQIopDYG1L2Ilo8Gym1LPkWJzq0u
 ezFYTi7A1pChavGUmqA4QIUr6GUYbvchLPhLIGTnVIouaBofqkZVRXmOEiRrqHTL89o9
 LUufZxI5bvJ1TPz03WLNXxxn9xCDwX62lmBfsCh6OTXxEApFpgN0bRm86IGr9pKAS4tl
 hmlw==
X-Gm-Message-State: AFqh2ko9BUH3bfKIFydOH26Rcau02aopI1zZPoQfQI9cxqpqH97bBBfY
 gVXp5qJhjwBgaymuR1Q+aO5+MZxdCn558jnBUjvPNN2z4vGng+NV79yFCiPo/e60yMJDA3CeHmO
 Io0f/S0fExUw7yBWZS3gcFmwGwIxDdmX3lkKSVXdjFMxaW7ECDMPTIKNraw==
X-Received: by 2002:a05:6870:3d97:b0:144:b22a:38d3 with SMTP id
 lm23-20020a0568703d9700b00144b22a38d3mr1116691oab.280.1672027973443; 
 Sun, 25 Dec 2022 20:12:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvOxYIKKPtEjS2uXMNjFn0C3JnkB7XGH2lpKLEHI+PC2if2hYhErIcKXJkXHdrzMYh4r2bqreHjb4eTaSLQ6Ro=
X-Received: by 2002:a05:6870:3d97:b0:144:b22a:38d3 with SMTP id
 lm23-20020a0568703d9700b00144b22a38d3mr1116690oab.280.1672027973219; Sun, 25
 Dec 2022 20:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20221223060021.28011-1-jasowang@redhat.com>
 <20221223092656.ccs2fwwysu2gqzjo@sgarzare-redhat>
In-Reply-To: <20221223092656.ccs2fwwysu2gqzjo@sgarzare-redhat>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Dec 2022 12:12:42 +0800
Message-ID: <CACGkMEsjEJyrZvKus8rWNw4zgi-8FeWGBU+LYm6p41K7-j5gpQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: get rid of DMA ops
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Dec 23, 2022 at 5:27 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Dec 23, 2022 at 02:00:21PM +0800, Jason Wang wrote:
> >We used to (ab)use the DMA ops for setting up identical mappings in
> >the IOTLB. This patch tries to get rid of the those unnecessary DMA
> >ops by maintaining a simple identical/passthrough mappings by
> >default. When bound to virtio_vdpa driver, DMA API will simply use PA
> >as the IOVA and we will be all fine. When the vDPA bus tries to setup
> >customized mapping (e.g when bound to vhost-vDPA), the
> >identical/passthrough mapping will be removed.
> >
> >Signed-off-by: Jason Wang <jasowang@redhat.com>
> >---
> >Note:
> >- This patch depends on the series "[PATCH V3 0/4] Vendor stats
> >  support in vdpasim_net"
> >---
> > drivers/vdpa/vdpa_sim/vdpa_sim.c | 170 ++++---------------------------
> > drivers/vdpa/vdpa_sim/vdpa_sim.h |   2 +-
> > 2 files changed, 22 insertions(+), 150 deletions(-)
> >
> >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >index 45d3f84b7937..187fa3a0e5d5 100644
> >--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >@@ -17,7 +17,6 @@
> > #include <linux/vringh.h>
> > #include <linux/vdpa.h>
> > #include <linux/vhost_iotlb.h>
> >-#include <linux/iova.h>
> > #include <uapi/linux/vdpa.h>
> >
> > #include "vdpa_sim.h"
> >@@ -45,13 +44,6 @@ static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
> >       return container_of(vdpa, struct vdpasim, vdpa);
> > }
> >
> >-static struct vdpasim *dev_to_sim(struct device *dev)
> >-{
> >-      struct vdpa_device *vdpa = dev_to_vdpa(dev);
> >-
> >-      return vdpa_to_sim(vdpa);
> >-}
> >-
> > static void vdpasim_vq_notify(struct vringh *vring)
> > {
> >       struct vdpasim_virtqueue *vq =
> >@@ -104,8 +96,12 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
> >                                &vdpasim->iommu_lock);
> >       }
> >
> >-      for (i = 0; i < vdpasim->dev_attr.nas; i++)
> >+      for (i = 0; i < vdpasim->dev_attr.nas; i++) {
> >               vhost_iotlb_reset(&vdpasim->iommu[i]);
> >+              vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX,
> >+                                    0, VHOST_MAP_RW);
> >+              vdpasim->iommu_pt[i] = true;
> >+      }
> >
> >       vdpasim->running = true;
> >       spin_unlock(&vdpasim->iommu_lock);
> >@@ -115,133 +111,6 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
> >       ++vdpasim->generation;
> > }
> >
> >-static int dir_to_perm(enum dma_data_direction dir)
> >-{
> >-      int perm = -EFAULT;
> >-
> >-      switch (dir) {
> >-      case DMA_FROM_DEVICE:
> >-              perm = VHOST_MAP_WO;
> >-              break;
> >-      case DMA_TO_DEVICE:
> >-              perm = VHOST_MAP_RO;
> >-              break;
> >-      case DMA_BIDIRECTIONAL:
> >-              perm = VHOST_MAP_RW;
> >-              break;
> >-      default:
> >-              break;
> >-      }
> >-
> >-      return perm;
> >-}
> >-
> >-static dma_addr_t vdpasim_map_range(struct vdpasim *vdpasim, phys_addr_t paddr,
> >-                                  size_t size, unsigned int perm)
> >-{
> >-      struct iova *iova;
> >-      dma_addr_t dma_addr;
> >-      int ret;
> >-
> >-      /* We set the limit_pfn to the maximum (ULONG_MAX - 1) */
> >-      iova = alloc_iova(&vdpasim->iova, size >> iova_shift(&vdpasim->iova),
> >-                        ULONG_MAX - 1, true);
> >-      if (!iova)
> >-              return DMA_MAPPING_ERROR;
> >-
> >-      dma_addr = iova_dma_addr(&vdpasim->iova, iova);
> >-
> >-      spin_lock(&vdpasim->iommu_lock);
> >-      ret = vhost_iotlb_add_range(&vdpasim->iommu[0], (u64)dma_addr,
> >-                                  (u64)dma_addr + size - 1, (u64)paddr, perm);
> >-      spin_unlock(&vdpasim->iommu_lock);
> >-
> >-      if (ret) {
> >-              __free_iova(&vdpasim->iova, iova);
> >-              return DMA_MAPPING_ERROR;
> >-      }
> >-
> >-      return dma_addr;
> >-}
> >-
> >-static void vdpasim_unmap_range(struct vdpasim *vdpasim, dma_addr_t dma_addr,
> >-                              size_t size)
> >-{
> >-      spin_lock(&vdpasim->iommu_lock);
> >-      vhost_iotlb_del_range(&vdpasim->iommu[0], (u64)dma_addr,
> >-                            (u64)dma_addr + size - 1);
> >-      spin_unlock(&vdpasim->iommu_lock);
> >-
> >-      free_iova(&vdpasim->iova, iova_pfn(&vdpasim->iova, dma_addr));
> >-}
> >-
> >-static dma_addr_t vdpasim_map_page(struct device *dev, struct page *page,
> >-                                 unsigned long offset, size_t size,
> >-                                 enum dma_data_direction dir,
> >-                                 unsigned long attrs)
> >-{
> >-      struct vdpasim *vdpasim = dev_to_sim(dev);
> >-      phys_addr_t paddr = page_to_phys(page) + offset;
> >-      int perm = dir_to_perm(dir);
> >-
> >-      if (perm < 0)
> >-              return DMA_MAPPING_ERROR;
> >-
> >-      return vdpasim_map_range(vdpasim, paddr, size, perm);
> >-}
> >-
> >-static void vdpasim_unmap_page(struct device *dev, dma_addr_t dma_addr,
> >-                             size_t size, enum dma_data_direction dir,
> >-                             unsigned long attrs)
> >-{
> >-      struct vdpasim *vdpasim = dev_to_sim(dev);
> >-
> >-      vdpasim_unmap_range(vdpasim, dma_addr, size);
> >-}
> >-
> >-static void *vdpasim_alloc_coherent(struct device *dev, size_t size,
> >-                                  dma_addr_t *dma_addr, gfp_t flag,
> >-                                  unsigned long attrs)
> >-{
> >-      struct vdpasim *vdpasim = dev_to_sim(dev);
> >-      phys_addr_t paddr;
> >-      void *addr;
> >-
> >-      addr = kmalloc(size, flag);
> >-      if (!addr) {
> >-              *dma_addr = DMA_MAPPING_ERROR;
> >-              return NULL;
> >-      }
> >-
> >-      paddr = virt_to_phys(addr);
> >-
> >-      *dma_addr = vdpasim_map_range(vdpasim, paddr, size, VHOST_MAP_RW);
> >-      if (*dma_addr == DMA_MAPPING_ERROR) {
> >-              kfree(addr);
> >-              return NULL;
> >-      }
> >-
> >-      return addr;
> >-}
> >-
> >-static void vdpasim_free_coherent(struct device *dev, size_t size,
> >-                                void *vaddr, dma_addr_t dma_addr,
> >-                                unsigned long attrs)
> >-{
> >-      struct vdpasim *vdpasim = dev_to_sim(dev);
> >-
> >-      vdpasim_unmap_range(vdpasim, dma_addr, size);
> >-
> >-      kfree(vaddr);
> >-}
> >-
> >-static const struct dma_map_ops vdpasim_dma_ops = {
> >-      .map_page = vdpasim_map_page,
> >-      .unmap_page = vdpasim_unmap_page,
> >-      .alloc = vdpasim_alloc_coherent,
> >-      .free = vdpasim_free_coherent,
> >-};
> >-
> > static const struct vdpa_config_ops vdpasim_config_ops;
> > static const struct vdpa_config_ops vdpasim_batch_config_ops;
> >
> >@@ -289,7 +158,6 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> >       dev->dma_mask = &dev->coherent_dma_mask;
> >       if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
> >               goto err_iommu;
> >-      set_dma_ops(dev, &vdpasim_dma_ops);
> >       vdpasim->vdpa.mdev = dev_attr->mgmt_dev;
> >
> >       vdpasim->config = kzalloc(dev_attr->config_size, GFP_KERNEL);
> >@@ -306,6 +174,11 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> >       if (!vdpasim->iommu)
> >               goto err_iommu;
> >
> >+      vdpasim->iommu_pt = kmalloc_array(vdpasim->dev_attr.nas,
> >+                                        sizeof(*vdpasim->iommu_pt), GFP_KERNEL);
> >+      if (!vdpasim->iommu_pt)
> >+              goto err_iommu;
> >+
> >       for (i = 0; i < vdpasim->dev_attr.nas; i++)
> >               vhost_iotlb_init(&vdpasim->iommu[i], max_iotlb_entries, 0);
> >
> >@@ -317,13 +190,6 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> >               vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
> >                                &vdpasim->iommu_lock);
> >
> >-      ret = iova_cache_get();
> >-      if (ret)
> >-              goto err_iommu;
> >-
> >-      /* For simplicity we use an IOVA allocator with byte granularity */
> >-      init_iova_domain(&vdpasim->iova, 1, 0);
> >-
> >       vdpasim->vdpa.dma_dev = dev;
> >
> >       return vdpasim;
> >@@ -639,6 +505,7 @@ static int vdpasim_set_map(struct vdpa_device *vdpa, unsigned int asid,
> >
> >       iommu = &vdpasim->iommu[asid];
> >       vhost_iotlb_reset(iommu);
> >+      vdpasim->iommu_pt[asid] = false;
> >
> >       for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
> >            map = vhost_iotlb_itree_next(map, start, last)) {
> >@@ -667,6 +534,10 @@ static int vdpasim_dma_map(struct vdpa_device *vdpa, unsigned int asid,
> >               return -EINVAL;
> >
> >       spin_lock(&vdpasim->iommu_lock);
> >+      if (vdpasim->iommu_pt[asid]) {
> >+              vhost_iotlb_reset(&vdpasim->iommu[asid]);
> >+              vdpasim->iommu_pt[asid] = false;
> >+      }
> >       ret = vhost_iotlb_add_range_ctx(&vdpasim->iommu[asid], iova,
> >                                       iova + size - 1, pa, perm, opaque);
> >       spin_unlock(&vdpasim->iommu_lock);
> >@@ -682,6 +553,11 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
> >       if (asid >= vdpasim->dev_attr.nas)
> >               return -EINVAL;
> >
> >+      if (vdpasim->iommu_pt[asid]) {
>
> We are in the vdpasim_dma_unmap, so if vdpasim->iommu_pt[asid] is true,
> should be better to return an error, since this case should not happen?

So it's a question of how to behave when unmap is called without a
map. I think we can leave the code as is or if we wish, it needs a
separate patch.

(We didn't error this previously anyhow).

Thanks

>
> The rest LGTM!
>
> Thanks,
> Stefano
>
> >+              vhost_iotlb_reset(&vdpasim->iommu[asid]);
> >+              vdpasim->iommu_pt[asid] = false;
> >+      }
> >+
> >       spin_lock(&vdpasim->iommu_lock);
> >       vhost_iotlb_del_range(&vdpasim->iommu[asid], iova, iova + size - 1);
> >       spin_unlock(&vdpasim->iommu_lock);
> >@@ -701,15 +577,11 @@ static void vdpasim_free(struct vdpa_device *vdpa)
> >               vringh_kiov_cleanup(&vdpasim->vqs[i].in_iov);
> >       }
> >
> >-      if (vdpa_get_dma_dev(vdpa)) {
> >-              put_iova_domain(&vdpasim->iova);
> >-              iova_cache_put();
> >-      }
> >-
> >       kvfree(vdpasim->buffer);
> >       for (i = 0; i < vdpasim->dev_attr.nas; i++)
> >               vhost_iotlb_reset(&vdpasim->iommu[i]);
> >       kfree(vdpasim->iommu);
> >+      kfree(vdpasim->iommu_pt);
> >       kfree(vdpasim->vqs);
> >       kfree(vdpasim->config);
> > }
> >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> >index d2a08c0abad7..770ef3408619 100644
> >--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> >@@ -64,7 +64,7 @@ struct vdpasim {
> >       /* virtio config according to device type */
> >       void *config;
> >       struct vhost_iotlb *iommu;
> >-      struct iova_domain iova;
> >+      bool *iommu_pt;
> >       void *buffer;
> >       u32 status;
> >       u32 generation;
> >--
> >2.25.1
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
