Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93937156D1
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11AFE801ED
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 09:51:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 11AFE801ED
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZgXqmLXsyXoi
	for <virtualization@lists.linux-foundation.org>;
	Thu, 30 Nov 2023 09:51:42 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 42B6E80AF3
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 09:51:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42B6E80AF3
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VxRA8F1_1701337891;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VxRA8F1_1701337891)
          by smtp.aliyun-inc.com;
          Thu, 30 Nov 2023 17:51:32 +0800
Message-ID: <1701337778.899533-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v13 11/12] virtio_ring: introduce dma sync api for virtqueue
Date: Thu, 30 Nov 2023 17:49:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-12-xuanzhuo@linux.alibaba.com>
 <20231130044512-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231130044512-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 30 Nov 2023 04:45:58 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Aug 10, 2023 at 08:30:56PM +0800, Xuan Zhuo wrote:
> > These API has been introduced:
> >
> > * virtqueue_dma_need_sync
> > * virtqueue_dma_sync_single_range_for_cpu
> > * virtqueue_dma_sync_single_range_for_device
> >
> > These APIs can be used together with the premapped mechanism to sync the
> > DMA address.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 76 ++++++++++++++++++++++++++++++++++++
> >  include/linux/virtio.h       |  8 ++++
> >  2 files changed, 84 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 916479c9c72c..81ecb29c88f1 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -3175,4 +3175,80 @@ int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
> >
> > +/**
> > + * virtqueue_dma_need_sync - check a dma address needs sync
> > + * @_vq: the struct virtqueue we're talking about.
> > + * @addr: DMA address
> > + *
> > + * Check if the dma address mapped by the virtqueue_dma_map_* APIs needs to be
> > + * synchronized
> > + *
> > + * return bool
> > + */
> > +bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr)
> > +{
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +	if (!vq->use_dma_api)
> > +		return false;
> > +
> > +	return dma_need_sync(vring_dma_dev(vq), addr);
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_dma_need_sync);
> > +
> > +/**
> > + * virtqueue_dma_sync_single_range_for_cpu - dma sync for cpu
> > + * @_vq: the struct virtqueue we're talking about.
> > + * @addr: DMA address
> > + * @offset: DMA address offset
> > + * @size: buf size for sync
> > + * @dir: DMA direction
> > + *
> > + * Before calling this function, use virtqueue_dma_need_sync() to confirm that
> > + * the DMA address really needs to be synchronized
> > + *
> > + */
> > +void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq,
> > +					     dma_addr_t addr,
> > +					     unsigned long offset, size_t size,
> > +					     enum dma_data_direction dir)
> > +{
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	struct device *dev = vring_dma_dev(vq);
> > +
> > +	if (!vq->use_dma_api)
> > +		return;
> > +
> > +	dma_sync_single_range_for_cpu(dev, addr, offset, size,
> > +				      DMA_BIDIRECTIONAL);
> > +}
>
>
> Why did you use DMA_BIDIRECTIONAL here?
> Why is "dir" ignored?

This is a mistake.

I see Jason has a fix patch.

How can I help?

Thanks.


>
>
> > +EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
> > +
> > +/**
> > + * virtqueue_dma_sync_single_range_for_device - dma sync for device
> > + * @_vq: the struct virtqueue we're talking about.
> > + * @addr: DMA address
> > + * @offset: DMA address offset
> > + * @size: buf size for sync
> > + * @dir: DMA direction
> > + *
> > + * Before calling this function, use virtqueue_dma_need_sync() to confirm that
> > + * the DMA address really needs to be synchronized
> > + */
> > +void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
> > +						dma_addr_t addr,
> > +						unsigned long offset, size_t size,
> > +						enum dma_data_direction dir)
> > +{
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	struct device *dev = vring_dma_dev(vq);
> > +
> > +	if (!vq->use_dma_api)
> > +		return;
> > +
> > +	dma_sync_single_range_for_device(dev, addr, offset, size,
> > +					 DMA_BIDIRECTIONAL);
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_device);
> > +
> >  MODULE_LICENSE("GPL");
>
> same question here.
>
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 79e3c74391e0..1311a7fbe675 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -220,4 +220,12 @@ void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
> >  				      size_t size, enum dma_data_direction dir,
> >  				      unsigned long attrs);
> >  int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
> > +
> > +bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
> > +void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t addr,
> > +					     unsigned long offset, size_t size,
> > +					     enum dma_data_direction dir);
> > +void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq, dma_addr_t addr,
> > +						unsigned long offset, size_t size,
> > +						enum dma_data_direction dir);
> >  #endif /* _LINUX_VIRTIO_H */
> > --
> > 2.32.0.3.g01195cf9f
>
>
