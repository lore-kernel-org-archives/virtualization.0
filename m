Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B9FC636D6
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 01:52:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF52D7000A;
	Tue, 21 Feb 2023 01:52:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF52D7000A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZPboCIfW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BJqWYrc1Bq3D; Tue, 21 Feb 2023 01:52:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2E0AC70196;
	Tue, 21 Feb 2023 01:52:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E0AC70196
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDBCBC0033;
	Tue, 21 Feb 2023 01:52:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 751E7C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 01:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4FE8582477
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 01:52:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FE8582477
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZPboCIfW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IOPuy7kM579i
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 01:52:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A91A81345
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A91A81345
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 01:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676944367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7wpEYDc8/QOzCGKZmBYsnZMWqSktADW2VORo+uKR34k=;
 b=ZPboCIfWpavr2tWFXVb2lweEFbOqy8r5Ff135yGlDn09+fTbv3WzuJUw654WsKWNO5upsM
 5ULLixxA3QQMEMfj7PBBSsf87u/Gx7Fz+FyxNF/umBtHDs0fjpc7dOpxaglqxrzWuN4KAg
 ewvhA3m5ytVP9Gr1h/YcMKVb7T0ECQQ=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-546-TCnRnvrUOnyXk5UnQrvW9A-1; Mon, 20 Feb 2023 20:52:45 -0500
X-MC-Unique: TCnRnvrUOnyXk5UnQrvW9A-1
Received: by mail-oo1-f70.google.com with SMTP id
 w1-20020a4ab6c1000000b00517667097ffso511163ooo.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 17:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7wpEYDc8/QOzCGKZmBYsnZMWqSktADW2VORo+uKR34k=;
 b=aQ2bO4nXReFeRoZ94hciGJnlffBOjZgLGdq8YHT5roWV47P8wAekXR9IiFe7PYBx8c
 yN34El+MiQk3eK5DvVpyL34PMdZaW0uLTgzDlfLt8sfGpwzCCClYpume1mtJuFrkel4j
 I9t9rpLupaC+vtIY4AdGapunWlhu57v+E4LjMyrdxyuQl54BWD//bS6TqVrwyESVslHV
 RO8YE3ri7MdVYaSSU0AO3l7cMrWiopw3zBjXSOSEmLlElInqwjn/sgkvmTizlxPiLPdH
 kTWeLbLehm2LcOpvBHnvhBIrRxkXlHXkY3odKUYQT9SzbdfqvfiTdQFbbnpcqVgk4lyK
 NW+w==
X-Gm-Message-State: AO0yUKXR5R+li2JxU3fn+ZMNdtNWdE1LM1OvGnqxvOxVYeoLwG3bz3n5
 NtuwpiIbjR7F+bkDf89wvaSCjzyLicofnR+Ep5Jj1HT2cRi3Iu9QknI/dZ1BGHCrRZ6JE8t2GJX
 c76DrWMndPNM21oLpDRTWh5RD41RUmclURoJo67PJ3b3/qSE4l+Ai6Qtbjg==
X-Received: by 2002:a05:6870:610c:b0:171:d1a1:c5cb with SMTP id
 s12-20020a056870610c00b00171d1a1c5cbmr468113oae.217.1676944365110; 
 Mon, 20 Feb 2023 17:52:45 -0800 (PST)
X-Google-Smtp-Source: AK7set8AeElOJznQdhkZQ+/SniCE8FtVyKngQrIDwsFRPY6abKMpO2QjwO324ORg/m6VPgKZQ2w9NOUJ2ffk0PZ0jeQ=
X-Received: by 2002:a05:6870:610c:b0:171:d1a1:c5cb with SMTP id
 s12-20020a056870610c00b00171d1a1c5cbmr468109oae.217.1676944364870; Mon, 20
 Feb 2023 17:52:44 -0800 (PST)
MIME-Version: 1.0
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <20230214072704.126660-9-xuanzhuo@linux.alibaba.com>
 <CACGkMEukBaLBLv6JWTGT0CCD_x1SCVJQn-mrZ0niCCFSx2QRwA@mail.gmail.com>
 <1676876689.931435-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1676876689.931435-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Feb 2023 09:52:33 +0800
Message-ID: <CACGkMEv3wgOojH4oww3Zpe7yq0BoOKfJZzu-ywo_a+fZAWC1Rw@mail.gmail.com>
Subject: Re: [PATCH vhost 08/10] virtio_ring: introduce dma sync api for virtio
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

On Mon, Feb 20, 2023 at 3:05 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Mon, 20 Feb 2023 13:38:20 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > These API has been introduced:
> > >
> > > * virtio_dma_need_sync
> > > * virtio_dma_sync_single_range_for_cpu
> > > * virtio_dma_sync_single_range_for_device
> >
> > What's the advantages of exporting internal logic like
> > virtio_dma_need_sync() over hiding it in
> > virtio_dma_sync_single_range_for_cpu() and
> > virtio_dma_sync_single_range_for_device()?
>
> Sorry, I didn't understand it.

I meant:

virtio_dma_sync_single_range_for_cpu()
{
    if (!virtio_dma_need_sync())
        return;
    ......
}

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> >
> > >
> > > These APIs can be used together with the premapped mechanism to sync the
> > > DMA address.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 70 ++++++++++++++++++++++++++++++++++++
> > >  include/linux/virtio.h       |  8 +++++
> > >  2 files changed, 78 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 855338609c7f..84129b8c3e2a 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -3264,4 +3264,74 @@ void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtio_dma_unmap);
> > >
> > > +/**
> > > + * virtio_dma_need_sync - check a dma address needs sync
> > > + * @dev: virtio device
> > > + * @addr: DMA address
> > > + *
> > > + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> > > + * core handles DMA API internally.
> > > + */
> > > +bool virtio_dma_need_sync(struct device *dev, dma_addr_t addr)
> > > +{
> > > +       struct virtio_device *vdev = dev_to_virtio(dev);
> > > +
> > > +       if (!vring_use_dma_api(vdev))
> > > +               return 0;
> > > +
> > > +       return dma_need_sync(vdev->dev.parent, addr);
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtio_dma_need_sync);
> > > +
> > > +/**
> > > + * virtio_dma_sync_single_range_for_cpu - dma sync for cpu
> > > + * @dev: virtio device
> > > + * @addr: DMA address
> > > + * @offset: DMA address offset
> > > + * @size: mem size for sync
> > > + * @dir: DMA direction
> > > + *
> > > + * Before calling this function, use virtio_dma_need_sync() to confirm that the
> > > + * DMA address really needs to be synchronized
> > > + *
> > > + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> > > + * core handles DMA API internally.
> > > + */
> > > +void virtio_dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t addr,
> > > +                                         unsigned long offset, size_t size,
> > > +                                         enum dma_data_direction dir)
> > > +{
> > > +       struct virtio_device *vdev = dev_to_virtio(dev);
> > > +
> > > +       dma_sync_single_range_for_cpu(vdev->dev.parent, addr, offset,
> > > +                                     size, DMA_BIDIRECTIONAL);
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtio_dma_sync_single_range_for_cpu);
> > > +
> > > +/**
> > > + * virtio_dma_sync_single_range_for_device - dma sync for device
> > > + * @dev: virtio device
> > > + * @addr: DMA address
> > > + * @offset: DMA address offset
> > > + * @size: mem size for sync
> > > + * @dir: DMA direction
> > > + *
> > > + * Before calling this function, use virtio_dma_need_sync() to confirm that the
> > > + * DMA address really needs to be synchronized
> > > + *
> > > + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> > > + * core handles DMA API internally.
> > > + */
> > > +void virtio_dma_sync_single_range_for_device(struct device *dev,
> > > +                                            dma_addr_t addr,
> > > +                                            unsigned long offset, size_t size,
> > > +                                            enum dma_data_direction dir)
> > > +{
> > > +       struct virtio_device *vdev = dev_to_virtio(dev);
> > > +
> > > +       dma_sync_single_range_for_device(vdev->dev.parent, addr, offset,
> > > +                                        size, DMA_BIDIRECTIONAL);
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtio_dma_sync_single_range_for_device);
> > > +
> > >  MODULE_LICENSE("GPL");
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index b5fa71476737..d0e707d744a0 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -225,4 +225,12 @@ dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
> > >  int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr);
> > >  void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
> > >                       enum dma_data_direction dir);
> > > +bool virtio_dma_need_sync(struct device *dev, dma_addr_t addr);
> > > +void virtio_dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t addr,
> > > +                                         unsigned long offset, size_t size,
> > > +                                         enum dma_data_direction dir);
> > > +void virtio_dma_sync_single_range_for_device(struct device *dev,
> > > +                                            dma_addr_t addr,
> > > +                                            unsigned long offset, size_t size,
> > > +                                            enum dma_data_direction dir);
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
