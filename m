Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7C4C05027
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 05:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C2EA60E73;
	Mon, 20 Feb 2023 05:38:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C2EA60E73
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W7Z4tv28
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ufPekdHFGSag; Mon, 20 Feb 2023 05:38:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F1FD360C2C;
	Mon, 20 Feb 2023 05:38:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F1FD360C2C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE09BC0032;
	Mon, 20 Feb 2023 05:38:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 355CCC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F26C340B86
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F26C340B86
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=W7Z4tv28
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id twugoTjO_B2U
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 20D1240B8D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20D1240B8D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676871519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KnUNPSk01ObvSkLW4Xt/fcLLo81cWI0b/V6sr5UdRdE=;
 b=W7Z4tv281obRqw+Irx5ltQ/U/ktCgZl/Gj2n5+kzGqYy8mUfIM21SFfTVxx1tSaiSh91y/
 xcYsSxzQyPpMcl5zcLWAOiGyJ7KhLmfcYp8E6Cg0rJ1LDh0WfosU1hBqD9C05m5FGQagpV
 29kWyPIabwIzZPs+Nbj2k/gphhnOt9w=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-16-EdKi0lS9Oj65OvsK4LN6gw-1; Mon, 20 Feb 2023 00:38:36 -0500
X-MC-Unique: EdKi0lS9Oj65OvsK4LN6gw-1
Received: by mail-ot1-f69.google.com with SMTP id
 y13-20020a056830108d00b00690e6d4743aso657260oto.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Feb 2023 21:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KnUNPSk01ObvSkLW4Xt/fcLLo81cWI0b/V6sr5UdRdE=;
 b=RmxOBvv7M5f87NDC5V64Dntae6fbHgalq3pj0GB7kNw8HvdiL5cEO5Rd6MkWbZao5L
 HlPUxcK5klWwOaINWt5UCeZ6LVG857j0hVtOZHM/Ock/UhhN2/S29XM+/J4OWH71ic2P
 tTSThUkvfpUSWfAsHo8zuV6FKfY+IXYXpYoLpUV3/OivgYlOvt0DaBS72xnnqYbKXgQs
 //JV2bPoxRDNVVn35VO1ub3TM3zla2Ffv2o1nGe/hrPuZxpm/Zmpu3b9Yj0bKDuszlNy
 2KoMLUi02wUmXI35h2YdHqe8zwDQ2GLEOVOrRelFSI4JOa1dQ8G5tFDnZqOE7yEreaUt
 2BVg==
X-Gm-Message-State: AO0yUKU7NTwq5w45L9muRvtszFMviw87KvTdgsh7wvjSeDZvEfj5jGcx
 59KkHdQbKWgco9ihy1JRzP4JN577ZEeCicK9G5ob4B6bI5GUBhj++7xiz31LQOomqbETaiODXMX
 y7tEFTYWUysina+vqgKFAwBvV/0hoc5S0pGlmiyjTR0hajUGhEnMsqy7ZUJFtTfMWlA==
X-Received: by 2002:a05:6808:1812:b0:37a:3ebc:d282 with SMTP id
 bh18-20020a056808181200b0037a3ebcd282mr920510oib.217.1676871515564; 
 Sun, 19 Feb 2023 21:38:35 -0800 (PST)
X-Google-Smtp-Source: AK7set/dV/KTwWh4VlHq/tlE4osn087PMxGe1nrTSe2+2EEJTjzUdNZ3oxbo4r9DZPh6Jsi0AEDtTmxIzwWoJnvtmAM=
X-Received: by 2002:a05:6808:1812:b0:37a:3ebc:d282 with SMTP id
 bh18-20020a056808181200b0037a3ebcd282mr920508oib.217.1676871515356; Sun, 19
 Feb 2023 21:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <20230214072704.126660-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230214072704.126660-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Feb 2023 13:38:24 +0800
Message-ID: <CACGkMEs_jQd84LSC5F_at0+G_D=JnBWOJH71B5=RQFPYQKwtBg@mail.gmail.com>
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

On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Added virtio_dma_map() to map DMA addresses for virtual memory in
> advance. The purpose is to keep memory mapped across multiple add/get
> buf operations.

I wonder if instead of exporting helpers like this, it might be simple
to just export dma_dev then the upper layer can use DMA API at will?

(Otherwise the DMA helpers need to grow/shrink as the DMA API evolves?)

>
> Added virtio_dma_unmap() for unmap DMA address.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 92 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  9 ++++
>  2 files changed, 101 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cd9364eb2345..855338609c7f 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3172,4 +3172,96 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_vring);
>
> +/**
> + * virtio_dma_map_page - get the DMA addr of the memory for virtio device
> + * @dev: virtio device
> + * @page: the page of the memory to DMA
> + * @offset: the offset of the memory inside page
> + * @length: memory length
> + * @dir: DMA direction
> + *
> + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> + * core handles DMA API internally.
> + *
> + * Returns the DMA addr. DMA_MAPPING_ERROR means error.
> + */
> +dma_addr_t virtio_dma_map_page(struct device *dev, struct page *page, size_t offset,
> +                              unsigned int length, enum dma_data_direction dir)
> +{

This (and the reset) needs to be done per virtqueue instead per device
after b0e504e5505d184b0be248b7dcdbe50b79f03758 ("virtio_ring: per
virtqueue dma device").

> +       struct virtio_device *vdev = dev_to_virtio(dev);
> +
> +       if (!vring_use_dma_api(vdev))
> +               return page_to_phys(page) + offset;
> +
> +       return dma_map_page(vdev->dev.parent, page, offset, length, dir);
> +}

Need either inline or EXPORT_SYMBOL_GPL() here.

Thanks


> +
> +/**
> + * virtio_dma_map - get the DMA addr of the memory for virtio device
> + * @dev: virtio device
> + * @addr: the addr to DMA
> + * @length: memory length
> + * @dir: DMA direction
> + *
> + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> + * core handles DMA API internally.
> + *
> + * Returns the DMA addr.
> + */
> +dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
> +                         enum dma_data_direction dir)
> +{
> +       struct page *page;
> +       size_t offset;
> +
> +       page = virt_to_page(addr);
> +       offset = offset_in_page(addr);
> +
> +       return virtio_dma_map_page(dev, page, offset, length, dir);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_map);
> +
> +/**
> + * virtio_dma_mapping_error - check dma address
> + * @dev: virtio device
> + * @addr: DMA address
> + *
> + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> + * core handles DMA API internally.
> + *
> + * Returns 0 means dma valid. Other means invalid dma address.
> + */
> +int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr)
> +{
> +       struct virtio_device *vdev = dev_to_virtio(dev);
> +
> +       if (!vring_use_dma_api(vdev))
> +               return 0;
> +
> +       return dma_mapping_error(vdev->dev.parent, addr);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_mapping_error);
> +
> +/**
> + * virtio_dma_unmap - unmap DMA addr
> + * @dev: virtio device
> + * @dma: DMA address
> + * @length: memory length
> + * @dir: DMA direction
> + *
> + * This API is only for pre-mapped buffers, for non premapped buffers virtio
> + * core handles DMA API internally.
> + */
> +void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
> +                     enum dma_data_direction dir)
> +{
> +       struct virtio_device *vdev = dev_to_virtio(dev);
> +
> +       if (!vring_use_dma_api(vdev))
> +               return;
> +
> +       dma_unmap_page(vdev->dev.parent, dma, length, dir);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_unmap);
> +
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 3ebb346ebb7c..b5fa71476737 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -9,6 +9,7 @@
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/gfp.h>
> +#include <linux/dma-mapping.h>
>
>  /**
>   * struct virtqueue - a queue to register buffers for sending or receiving.
> @@ -216,4 +217,12 @@ void unregister_virtio_driver(struct virtio_driver *drv);
>  #define module_virtio_driver(__virtio_driver) \
>         module_driver(__virtio_driver, register_virtio_driver, \
>                         unregister_virtio_driver)
> +
> +dma_addr_t virtio_dma_map_page(struct device *dev, struct page *page, size_t offset,
> +                              unsigned int length, enum dma_data_direction dir);
> +dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
> +                         enum dma_data_direction dir);
> +int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr);
> +void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
> +                     enum dma_data_direction dir);
>  #endif /* _LINUX_VIRTIO_H */
> --
> 2.32.0.3.g01195cf9f
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
