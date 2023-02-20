Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077C7C05027
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 05:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A03DA4033A;
	Mon, 20 Feb 2023 05:38:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A03DA4033A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SbXOXeZ8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kxX48340oRbY; Mon, 20 Feb 2023 05:38:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BEE7140304;
	Mon, 20 Feb 2023 05:38:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BEE7140304
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9859DC0032;
	Mon, 20 Feb 2023 05:38:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16FFFC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E58358193E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E58358193E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SbXOXeZ8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BBO_qC-9541y
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1875B81767
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1875B81767
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676871514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s8rLke/9ghlXrMhE6LQICZqLl7APBW6WmFBqmEJiT4U=;
 b=SbXOXeZ8XMyIsI2q1XCMdQFMCTTcvA9Kc3+s3bSKgZIw8ws2e2e5tq+wv2y4Y7SYp52iQ9
 F3zXzFx8cX5R2T8Wsu7fkZVz5ziBLbKvMF51y2fY+5NaLEKEAXADJhegONB2x2dSXyJ1Ml
 wpnB/jlsphF3PO3XGbhrDnzqbfPvpV0=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-245-mKBqv3G9Ndam40FI1MCBIA-1; Mon, 20 Feb 2023 00:38:33 -0500
X-MC-Unique: mKBqv3G9Ndam40FI1MCBIA-1
Received: by mail-oi1-f198.google.com with SMTP id
 u6-20020a056808150600b0037d66f9772dso373971oiw.16
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Feb 2023 21:38:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s8rLke/9ghlXrMhE6LQICZqLl7APBW6WmFBqmEJiT4U=;
 b=jAXoaqO9UK68Iv8PVWR4YN19QDWpwDL0Y9G814/+fuwgyFHHvqNtCTnkcwSOpvgh3i
 ZwSxOpZCw2GfENb2TtWkeoPk1vYRXJPzhM0Y20/SlBKWD2Cbdrfo5hKaCI6IFgQzmCy9
 xqanO0YLuWUmKH3GQIMke2MVYLjkU5s80yZgIg9Yqh0iWW98252yjXf3jJc2NDablDCM
 kYNECor5A15V8HyCR+esJaHAk/8tC4aU1ld6DM/tY0KNN00ynf0egOkY4Qa6CUXqf2hB
 yb305U1s21o2AiwGmZE14MYYlIk1Na8JCITx656uWrKl+x1pWbHSYg1/6Ii/IgF/ea/9
 BoVQ==
X-Gm-Message-State: AO0yUKXImW1np0Nz21C4OE4mePgZDDq618c46es5LNDF2spJtnUJ/xn6
 Uk4NnakPdykEiFSisVC3mg5PW3EjcsgmU4c1jgvMyKLAzQrZH8nRHN90YnJwCUJp+8xxJ32BIeo
 zTNCuUsJVhG9O5+yB2iguYuLtGvoDkvBCLNOhFx46pE/f9if2aLm+TVYlIA==
X-Received: by 2002:a05:6808:1812:b0:37a:3ebc:d282 with SMTP id
 bh18-20020a056808181200b0037a3ebcd282mr920500oib.217.1676871512587; 
 Sun, 19 Feb 2023 21:38:32 -0800 (PST)
X-Google-Smtp-Source: AK7set9oHRQpKZwyzAJcPbj9bLi/07GJixSBhC1nnhhuSYFB/dll0RFP+60TQRjkarFHXfRKn31fI216GlIqJpfUFGM=
X-Received: by 2002:a05:6808:1812:b0:37a:3ebc:d282 with SMTP id
 bh18-20020a056808181200b0037a3ebcd282mr920499oib.217.1676871512327; Sun, 19
 Feb 2023 21:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <20230214072704.126660-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230214072704.126660-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Feb 2023 13:38:20 +0800
Message-ID: <CACGkMEukBaLBLv6JWTGT0CCD_x1SCVJQn-mrZ0niCCFSx2QRwA@mail.gmail.com>
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

On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> These API has been introduced:
>
> * virtio_dma_need_sync
> * virtio_dma_sync_single_range_for_cpu
> * virtio_dma_sync_single_range_for_device

What's the advantages of exporting internal logic like
virtio_dma_need_sync() over hiding it in
virtio_dma_sync_single_range_for_cpu() and
virtio_dma_sync_single_range_for_device()?

Thanks


>
> These APIs can be used together with the premapped mechanism to sync the
> DMA address.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 70 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  8 +++++
>  2 files changed, 78 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 855338609c7f..84129b8c3e2a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3264,4 +3264,74 @@ void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
>  }
>  EXPORT_SYMBOL_GPL(virtio_dma_unmap);
>
> +/**
> + * virtio_dma_need_sync - check a dma address needs sync
> + * @dev: virtio device
> + * @addr: DMA address
> + *
> + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> + * core handles DMA API internally.
> + */
> +bool virtio_dma_need_sync(struct device *dev, dma_addr_t addr)
> +{
> +       struct virtio_device *vdev = dev_to_virtio(dev);
> +
> +       if (!vring_use_dma_api(vdev))
> +               return 0;
> +
> +       return dma_need_sync(vdev->dev.parent, addr);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_need_sync);
> +
> +/**
> + * virtio_dma_sync_single_range_for_cpu - dma sync for cpu
> + * @dev: virtio device
> + * @addr: DMA address
> + * @offset: DMA address offset
> + * @size: mem size for sync
> + * @dir: DMA direction
> + *
> + * Before calling this function, use virtio_dma_need_sync() to confirm that the
> + * DMA address really needs to be synchronized
> + *
> + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> + * core handles DMA API internally.
> + */
> +void virtio_dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t addr,
> +                                         unsigned long offset, size_t size,
> +                                         enum dma_data_direction dir)
> +{
> +       struct virtio_device *vdev = dev_to_virtio(dev);
> +
> +       dma_sync_single_range_for_cpu(vdev->dev.parent, addr, offset,
> +                                     size, DMA_BIDIRECTIONAL);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_sync_single_range_for_cpu);
> +
> +/**
> + * virtio_dma_sync_single_range_for_device - dma sync for device
> + * @dev: virtio device
> + * @addr: DMA address
> + * @offset: DMA address offset
> + * @size: mem size for sync
> + * @dir: DMA direction
> + *
> + * Before calling this function, use virtio_dma_need_sync() to confirm that the
> + * DMA address really needs to be synchronized
> + *
> + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> + * core handles DMA API internally.
> + */
> +void virtio_dma_sync_single_range_for_device(struct device *dev,
> +                                            dma_addr_t addr,
> +                                            unsigned long offset, size_t size,
> +                                            enum dma_data_direction dir)
> +{
> +       struct virtio_device *vdev = dev_to_virtio(dev);
> +
> +       dma_sync_single_range_for_device(vdev->dev.parent, addr, offset,
> +                                        size, DMA_BIDIRECTIONAL);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_sync_single_range_for_device);
> +
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b5fa71476737..d0e707d744a0 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -225,4 +225,12 @@ dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
>  int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr);
>  void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
>                       enum dma_data_direction dir);
> +bool virtio_dma_need_sync(struct device *dev, dma_addr_t addr);
> +void virtio_dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t addr,
> +                                         unsigned long offset, size_t size,
> +                                         enum dma_data_direction dir);
> +void virtio_dma_sync_single_range_for_device(struct device *dev,
> +                                            dma_addr_t addr,
> +                                            unsigned long offset, size_t size,
> +                                            enum dma_data_direction dir);
>  #endif /* _LINUX_VIRTIO_H */
> --
> 2.32.0.3.g01195cf9f
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
