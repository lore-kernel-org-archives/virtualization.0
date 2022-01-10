Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37258C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 07:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2CDC824B4;
	Mon, 10 Jan 2022 07:12:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 910oMSdQxQuZ; Mon, 10 Jan 2022 07:12:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 65B6F8141A;
	Mon, 10 Jan 2022 07:12:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 434F8C0030;
	Mon, 10 Jan 2022 07:12:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B3F4C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 181BC60C01
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:12:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f3lK6A_-t2Bp
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:12:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62F0360AB1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641798774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wVDsDvt3aInCP5/DiyTU8VlQMgkXFVxLACSN7sUhxd4=;
 b=Tb/0Juz7VkfwLw6N3VBoAHWsaWyPdRyb2QmobHXgkkrwvjL+xqgeqXq3xSVCJpM/Cf4NTL
 vTMSlpTdR/M1HLiBlQUDq8KUM2FpwMKGLQYUNhrjP6NUPCGvD8CxWaA6fEyPkpus04IXaA
 ME7XWawIjPtGvx2drrj8FBgMZH5M0WY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-MZymLkEHMNCpb6tZbao2VA-1; Mon, 10 Jan 2022 02:12:29 -0500
X-MC-Unique: MZymLkEHMNCpb6tZbao2VA-1
Received: by mail-wm1-f72.google.com with SMTP id
 n3-20020a05600c3b8300b00345c3fc40b0so8411796wms.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jan 2022 23:12:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wVDsDvt3aInCP5/DiyTU8VlQMgkXFVxLACSN7sUhxd4=;
 b=jGdM20fzVh+MsvFNrZ1EY9p9wvVjIm1SNyddYRoI7SZfd8kXy6E6hO5U/fJoLHuBIH
 3KJ0hjkFyVo97BxexQdWRxF3aswhu3HT0DdyxLLXbE2b1Yi411CrcmPyJmCRat1DUa/B
 LtnlAseTcXMN/Wb6XOPJT+uJVI1zm19fsciOi5vna6L+quDlImZvysNXRPYULWCncTxe
 JEzSpDgL7ptMpvioJXy2vvEew+CahzZDoXjGujkAVpdSNk/N4XJOgXf9yqZR/geDzh++
 GoqaZse1tk0t1eJNItzlG8SGJaRVF7sxbXhsCD9+DIKwMWlN5w1Tp8nxJN/BCSS52Lhv
 aSGw==
X-Gm-Message-State: AOAM531f3y7z6nj1ukuUQTNFsQGjWqiV1O0hdji4XGGEv/EVNqsuJxZJ
 KmYNc2PF7ZgnizSrzFBuCzm3WJOmkvZeVeDkF/jW4AErSnfetu9APLZvAKlOfJr+FnTjbQAve6J
 blCJ4GoU9nMa+aCZmRIWkfWCotk2StLpMfQn53UsWwA==
X-Received: by 2002:a1c:a5c2:: with SMTP id
 o185mr13042881wme.177.1641798747436; 
 Sun, 09 Jan 2022 23:12:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsG+kIRwOA3uVyiZoFEEGAHDWXHsMPlWM2l7JspRKap1oAjlEfzpK3BYugoPIKNVNYzaO1Sg==
X-Received: by 2002:a1c:a5c2:: with SMTP id
 o185mr13042870wme.177.1641798747246; 
 Sun, 09 Jan 2022 23:12:27 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107d:b60c:c297:16fe:7528:e989])
 by smtp.gmail.com with ESMTPSA id y8sm5728689wma.19.2022.01.09.23.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jan 2022 23:12:26 -0800 (PST)
Date: Mon, 10 Jan 2022 02:12:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 6/6] virtio: add api virtio_dma_map() for advance dma
Message-ID: <20220110020739-mutt-send-email-mst@kernel.org>
References: <20220107063306.23240-1-xuanzhuo@linux.alibaba.com>
 <20220107063306.23240-7-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220107063306.23240-7-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Fri, Jan 07, 2022 at 02:33:06PM +0800, Xuan Zhuo wrote:
> Added virtio_dma_map() to map DMA addresses for virtual memory in
> advance. The purpose of adding this function is to check
> vring_use_dma_api() for virtio dma operation and get vdev->dev.parent as
> the parameter of dma_map_page().
> 
> Added virtio_dma_unmap() for unmap DMA address.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


OK but where are the users for this new API?


> ---
>  drivers/virtio/virtio_ring.c | 47 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  9 +++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index e165bc2e1344..f4a0fb85df27 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2472,4 +2472,51 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_vring);
>  
> +/**
> + * virtio_dma_map - get the DMA addr of the memory for virtio device
> + * @vdev: virtio device
> + * @page: the page of the memory to DMA
> + * @offset: the offset of the memory inside page
> + * @length: memory length
> + * @dir: DMA direction
> + *
> + * Returns the DMA addr. Zero means error.

Should not drivers use a variant of dma_mapping_error to check?

> + */
> +dma_addr_t virtio_dma_map(struct virtio_device *vdev,
> +			  struct page *page, size_t offset,
> +			  unsigned int length,
> +			  enum dma_data_direction dir)
> +{
> +	dma_addr_t addr;
> +
> +	if (!vring_use_dma_api(vdev))
> +		return page_to_phys(page) + offset;
> +
> +	addr = dma_map_page(vdev->dev.parent, page, offset, length, dir);
> +
> +	if (dma_mapping_error(vdev->dev.parent, addr))
> +		return 0;
> +
> +	return addr;
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_map);


Yes it's 0, but you should really use DMA_MAPPING_ERROR.

> +
> +/**
> + * virtio_dma_unmap - unmap DMA addr
> + * @vdev: virtio device
> + * @dma: DMA address
> + * @length: memory length
> + * @dir: DMA direction
> + */
> +void virtio_dma_unmap(struct virtio_device *vdev,
> +		      dma_addr_t dma, unsigned int length,
> +		      enum dma_data_direction dir)
> +{
> +	if (!vring_use_dma_api(vdev))
> +		return;
> +
> +	dma_unmap_page(vdev->dev.parent, dma, length, dir);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_unmap);
> +
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 41edbc01ffa4..6e6c6e18ecf8 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -9,6 +9,7 @@
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/gfp.h>
> +#include <linux/dma-mapping.h>
>  
>  /**
>   * virtqueue - a queue to register buffers for sending or receiving.
> @@ -195,4 +196,12 @@ void unregister_virtio_driver(struct virtio_driver *drv);
>  #define module_virtio_driver(__virtio_driver) \
>  	module_driver(__virtio_driver, register_virtio_driver, \
>  			unregister_virtio_driver)
> +
> +dma_addr_t virtio_dma_map(struct virtio_device *vdev,
> +			  struct page *page, size_t offset,
> +			  unsigned int length,
> +			  enum dma_data_direction dir);
> +void virtio_dma_unmap(struct virtio_device *vdev,
> +		      dma_addr_t dma, unsigned int length,
> +		      enum dma_data_direction dir);
>  #endif /* _LINUX_VIRTIO_H */
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
