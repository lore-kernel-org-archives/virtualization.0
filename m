Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912BBC61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 09:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 06000404DB;
	Fri,  3 Feb 2023 09:07:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06000404DB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QonDO71I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sPKMqjlgWqpr; Fri,  3 Feb 2023 09:07:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7056240105;
	Fri,  3 Feb 2023 09:07:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7056240105
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B683C0032;
	Fri,  3 Feb 2023 09:07:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE504C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CAA8B405B5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:07:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CAA8B405B5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kgzF3XYmkgAY
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:07:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0035C404DB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0035C404DB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675415239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lcpnbERMPxMIk4rSMsJPyxbYfxtUlhTSWcolKETapCs=;
 b=QonDO71I+IC38McjLdJn0LyvUsulYFwgWVF/c6081rfwhCkoWFPWNbuXyha1o7RmFimrMz
 XZAwCL29Igx8Y9HuDt9irMfiHyiw0VVhpzdzWQcLO9q2Yr32BvfGTDqtxQsznoG9da/HjU
 A/7/v+h7UVMj/i+n8+XNscxJK9PcB0c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-315-GxEb-jLBP6G5rTlgMUPXnw-1; Fri, 03 Feb 2023 04:07:17 -0500
X-MC-Unique: GxEb-jLBP6G5rTlgMUPXnw-1
Received: by mail-ed1-f71.google.com with SMTP id
 bq13-20020a056402214d00b004a25d8d7593so3159766edb.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 01:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcpnbERMPxMIk4rSMsJPyxbYfxtUlhTSWcolKETapCs=;
 b=S4v+r3JlFSDSovRu81/vWEm3xCYG3qmwPiWSupXqBgqecXd1gIpTEf+FHaZp+oBz1J
 EVltKzmV/4O+NgAECfKym5HObTS6UMGfAGlvg6XmSVNixkFzMcRgT7EqQmc/wGedvmhx
 KQmGNYpaligoe3QM63jlKvnHx16asT/GenV87IN8nUtu/cdtcy9fZfo0zFzY7oj7ewhN
 DMil6DVgguJuDZgZCuHuFWURGC8skaPTmCuSfPPLpkohdZx1uWyKaXIeJAvimr1LWjeH
 5+R6Si/Ii+P8p4Uqd3BVSh0xcnpNk0LhRrccsEWPxnVkXYu5i3MdT4KbjmZzNevSsH/i
 mDrw==
X-Gm-Message-State: AO0yUKVgnaLhj3yvaiuUzscnji5tHQIpaVkiinlxRLt+dtsfTu7fFzqh
 swDaaIp1gYdy3eOrBM97FpZFPhLVnrmakQiDGLoFg+Rx4ItrHQYgS90ShkKExf+49PaZM+HM7Gx
 Vt/p5PsJvSEk9DB8aFzXZOnwtVvflnq4V5vMWZGWdXA==
X-Received: by 2002:a50:d088:0:b0:4a2:3d3d:a3d9 with SMTP id
 v8-20020a50d088000000b004a23d3da3d9mr9092221edd.2.1675415236394; 
 Fri, 03 Feb 2023 01:07:16 -0800 (PST)
X-Google-Smtp-Source: AK7set/JGZiQysBGfBbJ3E1QUQsRtGGsv7wF/0eyNNTeOrg2il3rlRP8/URTnNDtbpX9I5F+ED6I/Q==
X-Received: by 2002:a50:d088:0:b0:4a2:3d3d:a3d9 with SMTP id
 v8-20020a50d088000000b004a23d3da3d9mr9092201edd.2.1675415236167; 
 Fri, 03 Feb 2023 01:07:16 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 b9-20020a0564021f0900b004a21304f5a0sm799006edb.72.2023.02.03.01.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 01:07:15 -0800 (PST)
Date: Fri, 3 Feb 2023 04:07:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 07/33] virtio_ring: add api virtio_dma_map() for advance
 dma
Message-ID: <20230203040621-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-8-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230202110058.130695-8-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Thu, Feb 02, 2023 at 07:00:32PM +0800, Xuan Zhuo wrote:
> Added virtio_dma_map() to map DMA addresses for virtual memory in
> advance. The purpose of adding this function is to check
> vring_use_dma_api() for virtio dma operation and get vdev->dev.parent as
> the parameter of dma_map_page().

No this looks like the implementation not the purpose.
I am guessing the purpose is to keep memory mapped
across multiple add/get buf operations right?

> Added virtio_dma_unmap() for unmap DMA address.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 80 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  9 ++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 7dfce7001f9f..67eda7bc23ea 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3022,4 +3022,84 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
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
> + * Returns the DMA addr. DMA_MAPPING_ERROR means error.
> + */
> +dma_addr_t virtio_dma_map_page(struct device *dev, struct page *page, size_t offset,
> +			       unsigned int length, enum dma_data_direction dir)
> +{
> +	struct virtio_device *vdev = dev_to_virtio(dev);
> +
> +	if (!vring_use_dma_api(vdev))
> +		return page_to_phys(page) + offset;
> +
> +	return dma_map_page(vdev->dev.parent, page, offset, length, dir);
> +}
> +
> +/**
> + * virtio_dma_map - get the DMA addr of the memory for virtio device
> + * @dev: virtio device
> + * @addr: the addr to DMA
> + * @length: memory length
> + * @dir: DMA direction
> + *
> + * Returns the DMA addr.
> + */
> +dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
> +			  enum dma_data_direction dir)
> +{
> +	struct page *page;
> +	size_t offset;
> +
> +	page = virt_to_page(addr);
> +	offset = offset_in_page(addr);
> +
> +	return virtio_dma_map_page(dev, page, offset, length, dir);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_map);
> +
> +/**
> + * virtio_dma_mapping_error - check dma address
> + * @dev: virtio device
> + * @addr: DMA address
> + *
> + * Returns 0 means dma valid. Other means invalid dma address.
> + */
> +int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr)
> +{
> +	struct virtio_device *vdev = dev_to_virtio(dev);
> +
> +	if (!vring_use_dma_api(vdev))
> +		return 0;
> +
> +	return dma_mapping_error(vdev->dev.parent, addr);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_mapping_error);
> +
> +/**
> + * virtio_dma_unmap - unmap DMA addr
> + * @dev: virtio device
> + * @dma: DMA address
> + * @length: memory length
> + * @dir: DMA direction
> + */
> +void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
> +		      enum dma_data_direction dir)
> +{
> +	struct virtio_device *vdev = dev_to_virtio(dev);
> +
> +	if (!vring_use_dma_api(vdev))
> +		return;
> +
> +	dma_unmap_page(vdev->dev.parent, dma, length, dir);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_unmap);
> +
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 3ca2edb1aef3..ce89126becc5 100644
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
> @@ -218,4 +219,12 @@ void unregister_virtio_driver(struct virtio_driver *drv);
>  #define module_virtio_driver(__virtio_driver) \
>  	module_driver(__virtio_driver, register_virtio_driver, \
>  			unregister_virtio_driver)
> +
> +dma_addr_t virtio_dma_map_page(struct device *dev, struct page *page, size_t offset,
> +			       unsigned int length, enum dma_data_direction dir);
> +dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
> +			  enum dma_data_direction dir);
> +int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr);
> +void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
> +		      enum dma_data_direction dir);
>  #endif /* _LINUX_VIRTIO_H */
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
