Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923B1C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 07:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44866813A9;
	Mon, 10 Jan 2022 07:31:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Se7mFkgWRCen; Mon, 10 Jan 2022 07:31:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B282981382;
	Mon, 10 Jan 2022 07:31:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89FC8C0030;
	Mon, 10 Jan 2022 07:31:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74150C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 49FCA400BF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:31:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fgFbwz0eatWz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:31:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0170040004
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:31:25 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V1OfcTA_1641799881; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V1OfcTA_1641799881) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 10 Jan 2022 15:31:21 +0800
MIME-Version: 1.0
message-id: <1641799490.6420898-3-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH 6/6] virtio: add api virtio_dma_map() for advance dma
date: Mon, 10 Jan 2022 15:24:50 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Michael S. Tsirkin <mst@redhat.com>
in-reply-to: <20220110020739-mutt-send-email-mst@kernel.org>
Cc: virtualization@lists.linux-foundation.org
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

On Mon, 10 Jan 2022 02:12:23 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, Jan 07, 2022 at 02:33:06PM +0800, Xuan Zhuo wrote:
> > Added virtio_dma_map() to map DMA addresses for virtual memory in
> > advance. The purpose of adding this function is to check
> > vring_use_dma_api() for virtio dma operation and get vdev->dev.parent as
> > the parameter of dma_map_page().
> >
> > Added virtio_dma_unmap() for unmap DMA address.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
>
> OK but where are the users for this new API?

My subsequent patch set (virtio net supports AF_XDP) will use this API.

>
>
> > ---
> >  drivers/virtio/virtio_ring.c | 47 ++++++++++++++++++++++++++++++++++++
> >  include/linux/virtio.h       |  9 +++++++
> >  2 files changed, 56 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index e165bc2e1344..f4a0fb85df27 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2472,4 +2472,51 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_get_vring);
> >
> > +/**
> > + * virtio_dma_map - get the DMA addr of the memory for virtio device
> > + * @vdev: virtio device
> > + * @page: the page of the memory to DMA
> > + * @offset: the offset of the memory inside page
> > + * @length: memory length
> > + * @dir: DMA direction
> > + *
> > + * Returns the DMA addr. Zero means error.
>
> Should not drivers use a variant of dma_mapping_error to check?

The purpose of this is to wrap vdev->dev.parent. Otherwise, the driver will
directly access vdev->dev.parent.

>
> > + */
> > +dma_addr_t virtio_dma_map(struct virtio_device *vdev,
> > +			  struct page *page, size_t offset,
> > +			  unsigned int length,
> > +			  enum dma_data_direction dir)
> > +{
> > +	dma_addr_t addr;
> > +
> > +	if (!vring_use_dma_api(vdev))
> > +		return page_to_phys(page) + offset;
> > +
> > +	addr = dma_map_page(vdev->dev.parent, page, offset, length, dir);
> > +
> > +	if (dma_mapping_error(vdev->dev.parent, addr))
> > +		return 0;
> > +
> > +	return addr;
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_dma_map);
>
>
> Yes it's 0, but you should really use DMA_MAPPING_ERROR.

Yes, I should use DMA_MAPPING_ERROR.

Thanks.


>
> > +
> > +/**
> > + * virtio_dma_unmap - unmap DMA addr
> > + * @vdev: virtio device
> > + * @dma: DMA address
> > + * @length: memory length
> > + * @dir: DMA direction
> > + */
> > +void virtio_dma_unmap(struct virtio_device *vdev,
> > +		      dma_addr_t dma, unsigned int length,
> > +		      enum dma_data_direction dir)
> > +{
> > +	if (!vring_use_dma_api(vdev))
> > +		return;
> > +
> > +	dma_unmap_page(vdev->dev.parent, dma, length, dir);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_dma_unmap);
> > +
> >  MODULE_LICENSE("GPL");
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 41edbc01ffa4..6e6c6e18ecf8 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -9,6 +9,7 @@
> >  #include <linux/device.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/gfp.h>
> > +#include <linux/dma-mapping.h>
> >
> >  /**
> >   * virtqueue - a queue to register buffers for sending or receiving.
> > @@ -195,4 +196,12 @@ void unregister_virtio_driver(struct virtio_driver *drv);
> >  #define module_virtio_driver(__virtio_driver) \
> >  	module_driver(__virtio_driver, register_virtio_driver, \
> >  			unregister_virtio_driver)
> > +
> > +dma_addr_t virtio_dma_map(struct virtio_device *vdev,
> > +			  struct page *page, size_t offset,
> > +			  unsigned int length,
> > +			  enum dma_data_direction dir);
> > +void virtio_dma_unmap(struct virtio_device *vdev,
> > +		      dma_addr_t dma, unsigned int length,
> > +		      enum dma_data_direction dir);
> >  #endif /* _LINUX_VIRTIO_H */
> > --
> > 2.31.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
