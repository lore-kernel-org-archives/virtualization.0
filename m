Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E58AC05027
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 07:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98E1D60F69;
	Mon, 20 Feb 2023 07:05:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 98E1D60F69
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TgjoD1L7gg4H; Mon, 20 Feb 2023 07:05:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1AE03605E9;
	Mon, 20 Feb 2023 07:05:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AE03605E9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F00C4C0032;
	Mon, 20 Feb 2023 07:05:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 482FFC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 07:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F13241831
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 07:05:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F13241831
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AyJJ1pkW031L
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 07:05:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DAF241806
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DAF241806
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 07:05:25 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0Vc0iUP8_1676876721; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vc0iUP8_1676876721) by smtp.aliyun-inc.com;
 Mon, 20 Feb 2023 15:05:21 +0800
Message-ID: <1676876689.931435-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 08/10] virtio_ring: introduce dma sync api for virtio
Date: Mon, 20 Feb 2023 15:04:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <20230214072704.126660-9-xuanzhuo@linux.alibaba.com>
 <CACGkMEukBaLBLv6JWTGT0CCD_x1SCVJQn-mrZ0niCCFSx2QRwA@mail.gmail.com>
In-Reply-To: <CACGkMEukBaLBLv6JWTGT0CCD_x1SCVJQn-mrZ0niCCFSx2QRwA@mail.gmail.com>
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

On Mon, 20 Feb 2023 13:38:20 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > These API has been introduced:
> >
> > * virtio_dma_need_sync
> > * virtio_dma_sync_single_range_for_cpu
> > * virtio_dma_sync_single_range_for_device
>
> What's the advantages of exporting internal logic like
> virtio_dma_need_sync() over hiding it in
> virtio_dma_sync_single_range_for_cpu() and
> virtio_dma_sync_single_range_for_device()?

Sorry, I didn't understand it.

Thanks.

>
> Thanks
>
>
> >
> > These APIs can be used together with the premapped mechanism to sync the
> > DMA address.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 70 ++++++++++++++++++++++++++++++++++++
> >  include/linux/virtio.h       |  8 +++++
> >  2 files changed, 78 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 855338609c7f..84129b8c3e2a 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -3264,4 +3264,74 @@ void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_dma_unmap);
> >
> > +/**
> > + * virtio_dma_need_sync - check a dma address needs sync
> > + * @dev: virtio device
> > + * @addr: DMA address
> > + *
> > + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> > + * core handles DMA API internally.
> > + */
> > +bool virtio_dma_need_sync(struct device *dev, dma_addr_t addr)
> > +{
> > +       struct virtio_device *vdev = dev_to_virtio(dev);
> > +
> > +       if (!vring_use_dma_api(vdev))
> > +               return 0;
> > +
> > +       return dma_need_sync(vdev->dev.parent, addr);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_dma_need_sync);
> > +
> > +/**
> > + * virtio_dma_sync_single_range_for_cpu - dma sync for cpu
> > + * @dev: virtio device
> > + * @addr: DMA address
> > + * @offset: DMA address offset
> > + * @size: mem size for sync
> > + * @dir: DMA direction
> > + *
> > + * Before calling this function, use virtio_dma_need_sync() to confirm that the
> > + * DMA address really needs to be synchronized
> > + *
> > + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> > + * core handles DMA API internally.
> > + */
> > +void virtio_dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t addr,
> > +                                         unsigned long offset, size_t size,
> > +                                         enum dma_data_direction dir)
> > +{
> > +       struct virtio_device *vdev = dev_to_virtio(dev);
> > +
> > +       dma_sync_single_range_for_cpu(vdev->dev.parent, addr, offset,
> > +                                     size, DMA_BIDIRECTIONAL);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_dma_sync_single_range_for_cpu);
> > +
> > +/**
> > + * virtio_dma_sync_single_range_for_device - dma sync for device
> > + * @dev: virtio device
> > + * @addr: DMA address
> > + * @offset: DMA address offset
> > + * @size: mem size for sync
> > + * @dir: DMA direction
> > + *
> > + * Before calling this function, use virtio_dma_need_sync() to confirm that the
> > + * DMA address really needs to be synchronized
> > + *
> > + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> > + * core handles DMA API internally.
> > + */
> > +void virtio_dma_sync_single_range_for_device(struct device *dev,
> > +                                            dma_addr_t addr,
> > +                                            unsigned long offset, size_t size,
> > +                                            enum dma_data_direction dir)
> > +{
> > +       struct virtio_device *vdev = dev_to_virtio(dev);
> > +
> > +       dma_sync_single_range_for_device(vdev->dev.parent, addr, offset,
> > +                                        size, DMA_BIDIRECTIONAL);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_dma_sync_single_range_for_device);
> > +
> >  MODULE_LICENSE("GPL");
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index b5fa71476737..d0e707d744a0 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -225,4 +225,12 @@ dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
> >  int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr);
> >  void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
> >                       enum dma_data_direction dir);
> > +bool virtio_dma_need_sync(struct device *dev, dma_addr_t addr);
> > +void virtio_dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t addr,
> > +                                         unsigned long offset, size_t size,
> > +                                         enum dma_data_direction dir);
> > +void virtio_dma_sync_single_range_for_device(struct device *dev,
> > +                                            dma_addr_t addr,
> > +                                            unsigned long offset, size_t size,
> > +                                            enum dma_data_direction dir);
> >  #endif /* _LINUX_VIRTIO_H */
> > --
> > 2.32.0.3.g01195cf9f
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
