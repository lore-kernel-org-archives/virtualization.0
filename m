Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB4DC05027
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 07:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0F42040B9C;
	Mon, 20 Feb 2023 07:02:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F42040B9C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 96TMFOqA-2A3; Mon, 20 Feb 2023 07:02:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 54598400F3;
	Mon, 20 Feb 2023 07:02:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54598400F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 373CEC0033;
	Mon, 20 Feb 2023 07:02:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9666FC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 07:02:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70F8260F44
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 07:02:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70F8260F44
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q_yXtRtxnmFu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 07:02:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D7F95605E3
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D7F95605E3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 07:02:29 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0Vc0klYk_1676876543; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vc0klYk_1676876543) by smtp.aliyun-inc.com;
 Mon, 20 Feb 2023 15:02:24 +0800
Message-ID: <1676876377.4263525-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 07/10] virtio_ring: add api virtio_dma_map() for
 advance dma
Date: Mon, 20 Feb 2023 14:59:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <20230214072704.126660-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEs_jQd84LSC5F_at0+G_D=JnBWOJH71B5=RQFPYQKwtBg@mail.gmail.com>
In-Reply-To: <CACGkMEs_jQd84LSC5F_at0+G_D=JnBWOJH71B5=RQFPYQKwtBg@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, 20 Feb 2023 13:38:24 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > Added virtio_dma_map() to map DMA addresses for virtual memory in
> > advance. The purpose is to keep memory mapped across multiple add/get
> > buf operations.
>
> I wonder if instead of exporting helpers like this, it might be simple
> to just export dma_dev then the upper layer can use DMA API at will?


The reason for not doing this, Virtio is not just using DMA_DEV to mapp, but
also check whether DMA is used.


>
> (Otherwise the DMA helpers need to grow/shrink as the DMA API evolves?)
>
> >
> > Added virtio_dma_unmap() for unmap DMA address.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 92 ++++++++++++++++++++++++++++++++++++
> >  include/linux/virtio.h       |  9 ++++
> >  2 files changed, 101 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index cd9364eb2345..855338609c7f 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -3172,4 +3172,96 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_get_vring);
> >
> > +/**
> > + * virtio_dma_map_page - get the DMA addr of the memory for virtio device
> > + * @dev: virtio device
> > + * @page: the page of the memory to DMA
> > + * @offset: the offset of the memory inside page
> > + * @length: memory length
> > + * @dir: DMA direction
> > + *
> > + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> > + * core handles DMA API internally.
> > + *
> > + * Returns the DMA addr. DMA_MAPPING_ERROR means error.
> > + */
> > +dma_addr_t virtio_dma_map_page(struct device *dev, struct page *page, size_t offset,
> > +                              unsigned int length, enum dma_data_direction dir)
> > +{
>
> This (and the reset) needs to be done per virtqueue instead per device
> after b0e504e5505d184b0be248b7dcdbe50b79f03758 ("virtio_ring: per
> virtqueue dma device").


YES.


>
> > +       struct virtio_device *vdev = dev_to_virtio(dev);
> > +
> > +       if (!vring_use_dma_api(vdev))
> > +               return page_to_phys(page) + offset;
> > +
> > +       return dma_map_page(vdev->dev.parent, page, offset, length, dir);
> > +}
>
> Need either inline or EXPORT_SYMBOL_GPL() here.

Because I did not use this interface, I did not  export it.

Thanks.


>
> Thanks
>
>
> > +
> > +/**
> > + * virtio_dma_map - get the DMA addr of the memory for virtio device
> > + * @dev: virtio device
> > + * @addr: the addr to DMA
> > + * @length: memory length
> > + * @dir: DMA direction
> > + *
> > + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> > + * core handles DMA API internally.
> > + *
> > + * Returns the DMA addr.
> > + */
> > +dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
> > +                         enum dma_data_direction dir)
> > +{
> > +       struct page *page;
> > +       size_t offset;
> > +
> > +       page = virt_to_page(addr);
> > +       offset = offset_in_page(addr);
> > +
> > +       return virtio_dma_map_page(dev, page, offset, length, dir);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_dma_map);
> > +
> > +/**
> > + * virtio_dma_mapping_error - check dma address
> > + * @dev: virtio device
> > + * @addr: DMA address
> > + *
> > + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> > + * core handles DMA API internally.
> > + *
> > + * Returns 0 means dma valid. Other means invalid dma address.
> > + */
> > +int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr)
> > +{
> > +       struct virtio_device *vdev = dev_to_virtio(dev);
> > +
> > +       if (!vring_use_dma_api(vdev))
> > +               return 0;
> > +
> > +       return dma_mapping_error(vdev->dev.parent, addr);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_dma_mapping_error);
> > +
> > +/**
> > + * virtio_dma_unmap - unmap DMA addr
> > + * @dev: virtio device
> > + * @dma: DMA address
> > + * @length: memory length
> > + * @dir: DMA direction
> > + *
> > + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> > + * core handles DMA API internally.
> > + */
> > +void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
> > +                     enum dma_data_direction dir)
> > +{
> > +       struct virtio_device *vdev = dev_to_virtio(dev);
> > +
> > +       if (!vring_use_dma_api(vdev))
> > +               return;
> > +
> > +       dma_unmap_page(vdev->dev.parent, dma, length, dir);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_dma_unmap);
> > +
> >  MODULE_LICENSE("GPL");
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 3ebb346ebb7c..b5fa71476737 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -9,6 +9,7 @@
> >  #include <linux/device.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/gfp.h>
> > +#include <linux/dma-mapping.h>
> >
> >  /**
> >   * struct virtqueue - a queue to register buffers for sending or receiving.
> > @@ -216,4 +217,12 @@ void unregister_virtio_driver(struct virtio_driver *drv);
> >  #define module_virtio_driver(__virtio_driver) \
> >         module_driver(__virtio_driver, register_virtio_driver, \
> >                         unregister_virtio_driver)
> > +
> > +dma_addr_t virtio_dma_map_page(struct device *dev, struct page *page, size_t offset,
> > +                              unsigned int length, enum dma_data_direction dir);
> > +dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
> > +                         enum dma_data_direction dir);
> > +int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr);
> > +void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
> > +                     enum dma_data_direction dir);
> >  #endif /* _LINUX_VIRTIO_H */
> > --
> > 2.32.0.3.g01195cf9f
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
