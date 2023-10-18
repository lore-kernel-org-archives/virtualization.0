Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD8ECDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 07:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 101CB41E42;
	Wed, 18 Oct 2023 07:56:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 101CB41E42
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tVTO4ZhfKWln; Wed, 18 Oct 2023 07:56:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7CAC941E3E;
	Wed, 18 Oct 2023 07:56:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CAC941E3E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53BE6C0071;
	Wed, 18 Oct 2023 07:56:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC72EC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 07:56:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B286A41E42
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 07:56:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B286A41E42
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1nocox7bAdwW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 07:56:34 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 44F7141E3E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 07:56:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 44F7141E3E
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VuQ2b0W_1697615788; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VuQ2b0W_1697615788) by smtp.aliyun-inc.com;
 Wed, 18 Oct 2023 15:56:29 +0800
Message-ID: <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 02/22] virtio_ring: introduce
 virtqueue_dma_[un]map_page_attrs
Date: Wed, 18 Oct 2023 15:53:00 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231011092728.105904-3-xuanzhuo@linux.alibaba.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

Hi Michael,

Do you think it's appropriate to push the first two patches of this patch set to
linux 6.6?

Thanks.

On Wed, 11 Oct 2023 17:27:08 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> Introduce virtqueue_dma_[un]map_page_attrs() to do dma/unmap for pages.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 52 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  7 +++++
>  2 files changed, 59 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index b3ded56722f4..36aae63336b8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3111,6 +3111,58 @@ const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_vring);
>
> +/**
> + * virtqueue_dma_map_page_attrs - map page DMA for _vq
> + * @_vq: the struct virtqueue we're talking about.
> + * @page: the page to do dma
> + * @offset: the offset inside the page
> + * @size: the size of the page to do dma
> + * @dir: DMA direction
> + * @attrs: DMA Attrs
> + *
> + * The caller calls this to do dma mapping in advance. The DMA address can be
> + * passed to this _vq when it is in pre-mapped mode.
> + *
> + * return DMA address. Caller should check that by virtqueue_dma_mapping_error().
> + */
> +dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page,
> +					size_t offset, size_t size,
> +					enum dma_data_direction dir,
> +					unsigned long attrs)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	if (!vq->use_dma_api)
> +		return (dma_addr_t)(page_to_phys(page) + offset);
> +
> +	return dma_map_page_attrs(vring_dma_dev(vq), page, offset, size, dir, attrs);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_dma_map_page_attrs);
> +
> +/**
> + * virtqueue_dma_unmap_page_attrs - unmap page DMA for _vq
> + * @_vq: the struct virtqueue we're talking about.
> + * @addr: the dma address to unmap
> + * @size: the size of the buffer
> + * @dir: DMA direction
> + * @attrs: DMA Attrs
> + *
> + * Unmap the address that is mapped by the virtqueue_dma_map_* APIs.
> + *
> + */
> +void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t addr,
> +				    size_t size, enum dma_data_direction dir,
> +				    unsigned long attrs)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	if (!vq->use_dma_api)
> +		return;
> +
> +	dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_page_attrs);
> +
>  /**
>   * virtqueue_dma_map_single_attrs - map DMA for _vq
>   * @_vq: the struct virtqueue we're talking about.
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 1cf7b004348b..d7c7f4fdee2f 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -212,6 +212,13 @@ void unregister_virtio_driver(struct virtio_driver *drv);
>  	module_driver(__virtio_driver, register_virtio_driver, \
>  			unregister_virtio_driver)
>
> +dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page,
> +					size_t offset, size_t size,
> +					enum dma_data_direction dir,
> +					unsigned long attrs);
> +void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t addr,
> +				    size_t size, enum dma_data_direction dir,
> +				    unsigned long attrs);
>  dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr, size_t size,
>  					  enum dma_data_direction dir, unsigned long attrs);
>  void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
> --
> 2.32.0.3.g01195cf9f
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
