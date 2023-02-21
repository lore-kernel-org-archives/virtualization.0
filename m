Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D90BC636D6
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 01:51:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 18ED940AF7;
	Tue, 21 Feb 2023 01:51:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 18ED940AF7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QYejNKwc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SRwRXPRWr-eL; Tue, 21 Feb 2023 01:51:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 57D6A40286;
	Tue, 21 Feb 2023 01:51:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57D6A40286
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33456C0033;
	Tue, 21 Feb 2023 01:51:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 453EBC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 01:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 127C6409D6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 01:51:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 127C6409D6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dBgHg3MJo9k2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 01:51:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1947540286
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1947540286
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 01:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676944281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BKuL1iO3A0jvTYhiS6Md3ZdRpaYoe7zLFGJmYdFE+A8=;
 b=QYejNKwc0QQxb1c9efUAOdEyGf0vJNO6OvYluQErawUbN/kx8IIwgO78i/9BTgd8QxiVJO
 TmS9bYonV22VZw7pcYrbMhAuORHMe1UfQKqvvmfwQdQxXbyxDGN+6V2NKuFXPQJS4e+Bm+
 4vbHg7w/8NLqS1dXLJ7DKO8CVCsEX88=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-1QKfeHISMnK7WOV6BrWBgQ-1; Mon, 20 Feb 2023 20:51:19 -0500
X-MC-Unique: 1QKfeHISMnK7WOV6BrWBgQ-1
Received: by mail-ot1-f72.google.com with SMTP id
 k5-20020a056830168500b00690d1e0d27dso942472otr.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 17:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BKuL1iO3A0jvTYhiS6Md3ZdRpaYoe7zLFGJmYdFE+A8=;
 b=Nam6/01RPciPUMJYuHJB8qbNmwwW9FfkSxcLGhojqbl2EWcF37Ou7V3QD3llVXRI4v
 FVjyDRWjj+A8UrDxmCAXkz0HcOpeaGI0jpvqAXcV9rKQeGulJdyWaDzbhge2dD1HLLHd
 OdkR/kj1PWiYQuoqldxEWOSde5kGVeCjqdLkIqDHHGisPnxXJhvmNlFIiga3aSPF6c1b
 70+gDr/O3VbeEKJcUnqziKyow1XR+WomvIRz6IKnM6LwgNmz4OL3LVFH+wrLiTSFf3/p
 ciS4yXWNqOUiY887VtRH0AtVw+ZZVyaTDhYWN6GhEg3Cf9aBU60rte3cvVWZqCR/EipS
 7mVg==
X-Gm-Message-State: AO0yUKWRuBjpxy0qtgS8bmPDEnycNY8r/e+61KLwBnU5AfnJH7Ra9jjc
 S1t7V2lucOWaPJ8L4EKAx8UcHn7UoUFq8H2CEbfiGgqM5h/Kl17D4pudiLhuxIGM+YotVb2fnqS
 oFnkqZyzET+VQroIuhagMTfaGboqxBiagOu1F3RS8DiqxdZ0NCwv+KDsNpg==
X-Received: by 2002:a05:6870:610c:b0:171:d1a1:c5cb with SMTP id
 s12-20020a056870610c00b00171d1a1c5cbmr467954oae.217.1676944279210; 
 Mon, 20 Feb 2023 17:51:19 -0800 (PST)
X-Google-Smtp-Source: AK7set+vG1e+WHAhG3r3iUWzJUSXuxeWYYmXOXDDd0Z9H0lrGo2JAnWy/1JU2cks+/KV7g+19QyvKhccnUKLIO3zM4c=
X-Received: by 2002:a05:6870:610c:b0:171:d1a1:c5cb with SMTP id
 s12-20020a056870610c00b00171d1a1c5cbmr467951oae.217.1676944278748; Mon, 20
 Feb 2023 17:51:18 -0800 (PST)
MIME-Version: 1.0
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <20230214072704.126660-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEs_jQd84LSC5F_at0+G_D=JnBWOJH71B5=RQFPYQKwtBg@mail.gmail.com>
 <1676876377.4263525-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1676876377.4263525-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Feb 2023 09:51:07 +0800
Message-ID: <CACGkMEvxyV9fAyN1L_vqRvQGzA5XnmhviVFKZdNJS6oKqGLpBA@mail.gmail.com>
Subject: Re: [PATCH vhost 07/10] virtio_ring: add api virtio_dma_map() for
 advance dma
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Feb 20, 2023 at 3:02 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Mon, 20 Feb 2023 13:38:24 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > Added virtio_dma_map() to map DMA addresses for virtual memory in
> > > advance. The purpose is to keep memory mapped across multiple add/get
> > > buf operations.
> >
> > I wonder if instead of exporting helpers like this, it might be simple
> > to just export dma_dev then the upper layer can use DMA API at will?
>
>
> The reason for not doing this, Virtio is not just using DMA_DEV to mapp, but
> also check whether DMA is used.

We should let the DMA API decide by exporting a correct dma_dev. E.g
when ACCESS_PLATFORM is not negotiated, advertising a DMA dev without
dma_ops.

Thanks

>
>
> >
> > (Otherwise the DMA helpers need to grow/shrink as the DMA API evolves?)
> >
> > >
> > > Added virtio_dma_unmap() for unmap DMA address.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 92 ++++++++++++++++++++++++++++++++++++
> > >  include/linux/virtio.h       |  9 ++++
> > >  2 files changed, 101 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index cd9364eb2345..855338609c7f 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -3172,4 +3172,96 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_get_vring);
> > >
> > > +/**
> > > + * virtio_dma_map_page - get the DMA addr of the memory for virtio device
> > > + * @dev: virtio device
> > > + * @page: the page of the memory to DMA
> > > + * @offset: the offset of the memory inside page
> > > + * @length: memory length
> > > + * @dir: DMA direction
> > > + *
> > > + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> > > + * core handles DMA API internally.
> > > + *
> > > + * Returns the DMA addr. DMA_MAPPING_ERROR means error.
> > > + */
> > > +dma_addr_t virtio_dma_map_page(struct device *dev, struct page *page, size_t offset,
> > > +                              unsigned int length, enum dma_data_direction dir)
> > > +{
> >
> > This (and the reset) needs to be done per virtqueue instead per device
> > after b0e504e5505d184b0be248b7dcdbe50b79f03758 ("virtio_ring: per
> > virtqueue dma device").
>
>
> YES.
>
>
> >
> > > +       struct virtio_device *vdev = dev_to_virtio(dev);
> > > +
> > > +       if (!vring_use_dma_api(vdev))
> > > +               return page_to_phys(page) + offset;
> > > +
> > > +       return dma_map_page(vdev->dev.parent, page, offset, length, dir);
> > > +}
> >
> > Need either inline or EXPORT_SYMBOL_GPL() here.
>
> Because I did not use this interface, I did not  export it.
>
> Thanks.
>
>
> >
> > Thanks
> >
> >
> > > +
> > > +/**
> > > + * virtio_dma_map - get the DMA addr of the memory for virtio device
> > > + * @dev: virtio device
> > > + * @addr: the addr to DMA
> > > + * @length: memory length
> > > + * @dir: DMA direction
> > > + *
> > > + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> > > + * core handles DMA API internally.
> > > + *
> > > + * Returns the DMA addr.
> > > + */
> > > +dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
> > > +                         enum dma_data_direction dir)
> > > +{
> > > +       struct page *page;
> > > +       size_t offset;
> > > +
> > > +       page = virt_to_page(addr);
> > > +       offset = offset_in_page(addr);
> > > +
> > > +       return virtio_dma_map_page(dev, page, offset, length, dir);
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtio_dma_map);
> > > +
> > > +/**
> > > + * virtio_dma_mapping_error - check dma address
> > > + * @dev: virtio device
> > > + * @addr: DMA address
> > > + *
> > > + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> > > + * core handles DMA API internally.
> > > + *
> > > + * Returns 0 means dma valid. Other means invalid dma address.
> > > + */
> > > +int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr)
> > > +{
> > > +       struct virtio_device *vdev = dev_to_virtio(dev);
> > > +
> > > +       if (!vring_use_dma_api(vdev))
> > > +               return 0;
> > > +
> > > +       return dma_mapping_error(vdev->dev.parent, addr);
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtio_dma_mapping_error);
> > > +
> > > +/**
> > > + * virtio_dma_unmap - unmap DMA addr
> > > + * @dev: virtio device
> > > + * @dma: DMA address
> > > + * @length: memory length
> > > + * @dir: DMA direction
> > > + *
> > > + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> > > + * core handles DMA API internally.
> > > + */
> > > +void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
> > > +                     enum dma_data_direction dir)
> > > +{
> > > +       struct virtio_device *vdev = dev_to_virtio(dev);
> > > +
> > > +       if (!vring_use_dma_api(vdev))
> > > +               return;
> > > +
> > > +       dma_unmap_page(vdev->dev.parent, dma, length, dir);
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtio_dma_unmap);
> > > +
> > >  MODULE_LICENSE("GPL");
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index 3ebb346ebb7c..b5fa71476737 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/device.h>
> > >  #include <linux/mod_devicetable.h>
> > >  #include <linux/gfp.h>
> > > +#include <linux/dma-mapping.h>
> > >
> > >  /**
> > >   * struct virtqueue - a queue to register buffers for sending or receiving.
> > > @@ -216,4 +217,12 @@ void unregister_virtio_driver(struct virtio_driver *drv);
> > >  #define module_virtio_driver(__virtio_driver) \
> > >         module_driver(__virtio_driver, register_virtio_driver, \
> > >                         unregister_virtio_driver)
> > > +
> > > +dma_addr_t virtio_dma_map_page(struct device *dev, struct page *page, size_t offset,
> > > +                              unsigned int length, enum dma_data_direction dir);
> > > +dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
> > > +                         enum dma_data_direction dir);
> > > +int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr);
> > > +void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
> > > +                     enum dma_data_direction dir);
> > >  #endif /* _LINUX_VIRTIO_H */
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
