Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E29DC433F5
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 08:36:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A8160E98
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 08:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 33A8160E98
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06CC380C93;
	Mon,  1 Nov 2021 08:36:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wBKXdzx8Q9oI; Mon,  1 Nov 2021 08:36:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CF55E80B58;
	Mon,  1 Nov 2021 08:36:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B55E2C0019;
	Mon,  1 Nov 2021 08:36:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EFA3C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B8B180B58
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:36:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CWabp6Qkkvst
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:36:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E6DA280C9B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635755761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvMAv1JmogT2pdGKCg+cKGmtodCq66w0VTwtJ11GrsI=;
 b=cDE+PeqJisJeNl7oDZ4nj0sn4J7Q8zgd9NASdeOgG0LFBiAsFhT6B49wEJF9hlvpv1x3iU
 A9n5izdyLFPjinOvC7UTZDvyump/g0zIB4KE762Tdezg70GRXo9kxfAxqUQsi6EnDhimQp
 91HWuQ7pbkeOhR/abnX+YT++pmloSuo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-UmfKWT8-MIiWy-Uro8rA5w-1; Mon, 01 Nov 2021 04:36:00 -0400
X-MC-Unique: UmfKWT8-MIiWy-Uro8rA5w-1
Received: by mail-ed1-f69.google.com with SMTP id
 y12-20020a056402270c00b003e28de6e995so1433995edd.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 01:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pvMAv1JmogT2pdGKCg+cKGmtodCq66w0VTwtJ11GrsI=;
 b=zc90b/uOk1Rh7p1thsd34kf35cq/COkqckHybLR6gwk/u5Y7YM16kAjQ1Byyi2c7t1
 nubfBs8UJ94Do1gFULw5QJOegE9z7tdXE6oE3fbrEc1pFkIdIlShljh6yF1jIMBhvxAw
 nWHvMljNQ7VT3WAJSns/Pm8XPdSJX+Xt6bjUhHtsfdny+WW84nsw91UOXeXfROB3n2/D
 HpIY/tYopfUHqE1z/X5yV53GXB7y4ZdkCP53DA53bUPlKG28OyNwRiQj+eUjsbYTdmdA
 n36VPvcCzAZkcNPevaTuSfKMF3JrX59cpRarlbMAlSt6iR856BmJK4p1h2DgbOIwvM4H
 6kzg==
X-Gm-Message-State: AOAM533eTi2JWNaMVyOHik6UKl69Asg0S8pe6QhIdyyNzUrbULyvs6+4
 2RevVrl4+4yQVxwKT34ILtgQ0wgMiCH8yFnaIQbizp4N/ycG5CHASq0MdAUc3lgST4ZWJDmbq4n
 27G7ZKAMxVekZFRUBztE6GErmAxk2NqWRqWVtgc2zOw==
X-Received: by 2002:a17:907:6d29:: with SMTP id
 sa41mr24683171ejc.522.1635755759181; 
 Mon, 01 Nov 2021 01:35:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqO3yc4Sb4sNSiylTqw4/RaaGYtPEbE7vxJFBMIUw0T1hAMIFuDi8sGeK1Ybp87AVCbacQpg==
X-Received: by 2002:a17:907:6d29:: with SMTP id
 sa41mr24683147ejc.522.1635755758971; 
 Mon, 01 Nov 2021 01:35:58 -0700 (PDT)
Received: from redhat.com ([176.12.204.186])
 by smtp.gmail.com with ESMTPSA id n2sm6519114ejl.92.2021.11.01.01.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 01:35:58 -0700 (PDT)
Date: Mon, 1 Nov 2021 04:35:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 1/3] virtio: cache indirect desc for split
Message-ID: <20211101043402-mutt-send-email-mst@kernel.org>
References: <20211028104919.3393-1-xuanzhuo@linux.alibaba.com>
 <20211028104919.3393-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20211028104919.3393-2-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org
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

On Thu, Oct 28, 2021 at 06:49:17PM +0800, Xuan Zhuo wrote:
> In the case of using indirect, indirect desc must be allocated and
> released each time, which increases a lot of cpu overhead.
> 
> Here, a cache is added for indirect. If the number of indirect desc to be
> applied for is less than VIRT_QUEUE_CACHE_DESC_NUM, the desc array with
> the size of VIRT_QUEUE_CACHE_DESC_NUM is fixed and cached for reuse.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio.c      |  6 +++
>  drivers/virtio/virtio_ring.c | 77 ++++++++++++++++++++++++++++++++----
>  include/linux/virtio.h       | 14 +++++++
>  3 files changed, 89 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 0a5b54034d4b..1047149ac2a4 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -431,6 +431,12 @@ bool is_virtio_device(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(is_virtio_device);
>  
> +void virtio_set_desc_cache(struct virtio_device *dev, u32 thr)
> +{
> +	dev->desc_cache_thr = thr;
> +}
> +EXPORT_SYMBOL_GPL(virtio_set_desc_cache);
> +
>  void unregister_virtio_device(struct virtio_device *dev)
>  {
>  	int index = dev->index; /* save for after device release */
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index dd95dfd85e98..0ebcd4f12d3b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -117,6 +117,15 @@ struct vring_virtqueue {
>  	/* Hint for event idx: already triggered no need to disable. */
>  	bool event_triggered;
>  
> +	/* desc cache threshold
> +	 *    0   - disable desc cache
> +	 *    > 0 - enable desc cache. As the threshold of the desc cache.
> +	 */
> +	u32 desc_cache_thr;
> +
> +	/* desc cache chain */
> +	struct list_head desc_cache;
> +
>  	union {
>  		/* Available for split ring */
>  		struct {
> @@ -423,7 +432,53 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
>  	return extra[i].next;
>  }
>  
> -static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> +static void desc_cache_free(struct list_head *head)
> +{
> +	struct list_head *n, *pos;
> +
> +	BUILD_BUG_ON(sizeof(struct list_head) > sizeof(struct vring_desc));
> +	BUILD_BUG_ON(sizeof(struct list_head) > sizeof(struct vring_packed_desc));
> +
> +	list_for_each_prev_safe(pos, n, head)
> +		kfree(pos);
> +}
> +
> +static void __desc_cache_put(struct vring_virtqueue *vq,
> +			     struct list_head *node, int n)
> +{
> +	if (n <= vq->desc_cache_thr)
> +		list_add(node, &vq->desc_cache);
> +	else
> +		kfree(node);
> +}
> +
> +#define desc_cache_put(vq, desc, n) \
> +	__desc_cache_put(vq, (struct list_head *)desc, n)
> +
> +static void *desc_cache_get(struct vring_virtqueue *vq,
> +			    int size, int n, gfp_t gfp)
> +{
> +	struct list_head *node;
> +
> +	if (n > vq->desc_cache_thr)
> +		return kmalloc_array(n, size, gfp);
> +
> +	if (!list_empty(&vq->desc_cache)) {
> +		node = vq->desc_cache.next;
> +		list_del(node);
> +		return node;
> +	}
> +
> +	return kmalloc_array(vq->desc_cache_thr, size, gfp);
> +}
> +
> +#define _desc_cache_get(vq, n, gfp, tp) \
> +	((tp *)desc_cache_get(vq, (sizeof(tp)), n, gfp))
> +
> +#define desc_cache_get_split(vq, n, gfp) \
> +	_desc_cache_get(vq, n, gfp, struct vring_desc)
> +
> +static struct vring_desc *alloc_indirect_split(struct vring_virtqueue *vq,
>  					       unsigned int total_sg,
>  					       gfp_t gfp)
>  {
> @@ -437,12 +492,12 @@ static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
>  	 */
>  	gfp &= ~__GFP_HIGHMEM;
>  
> -	desc = kmalloc_array(total_sg, sizeof(struct vring_desc), gfp);
> +	desc = desc_cache_get_split(vq, total_sg, gfp);
>  	if (!desc)
>  		return NULL;
>  
>  	for (i = 0; i < total_sg; i++)
> -		desc[i].next = cpu_to_virtio16(_vq->vdev, i + 1);
> +		desc[i].next = cpu_to_virtio16(vq->vq.vdev, i + 1);
>  	return desc;
>  }
>  
> @@ -508,7 +563,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	head = vq->free_head;
>  
>  	if (virtqueue_use_indirect(_vq, total_sg))
> -		desc = alloc_indirect_split(_vq, total_sg, gfp);
> +		desc = alloc_indirect_split(vq, total_sg, gfp);
>  	else {
>  		desc = NULL;
>  		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> @@ -652,7 +707,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	}
>  
>  	if (indirect)
> -		kfree(desc);
> +		desc_cache_put(vq, desc, total_sg);
>  
>  	END_USE(vq);
>  	return -ENOMEM;
> @@ -717,7 +772,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	if (vq->indirect) {
>  		struct vring_desc *indir_desc =
>  				vq->split.desc_state[head].indir_desc;
> -		u32 len;
> +		u32 len, n;
>  
>  		/* Free the indirect table, if any, now that it's unmapped. */
>  		if (!indir_desc)
> @@ -729,10 +784,12 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  				VRING_DESC_F_INDIRECT));
>  		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
>  
> -		for (j = 0; j < len / sizeof(struct vring_desc); j++)
> +		n = len / sizeof(struct vring_desc);
> +
> +		for (j = 0; j < n; j++)
>  			vring_unmap_one_split_indirect(vq, &indir_desc[j]);
>  
> -		kfree(indir_desc);
> +		desc_cache_put(vq, indir_desc, n);
>  		vq->split.desc_state[head].indir_desc = NULL;
>  	} else if (ctx) {
>  		*ctx = vq->split.desc_state[head].indir_desc;
> @@ -2199,6 +2256,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>  		!context;
>  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> +	vq->desc_cache_thr = vdev->desc_cache_thr;
> +
> +	INIT_LIST_HEAD(&vq->desc_cache);
>  
>  	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
>  		vq->weak_barriers = false;
> @@ -2329,6 +2389,7 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>  	if (!vq->packed_ring) {
>  		kfree(vq->split.desc_state);
>  		kfree(vq->split.desc_extra);
> +		desc_cache_free(&vq->desc_cache);
>  	}
>  	kfree(vq);
>  }
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 41edbc01ffa4..bda6f9853e97 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -118,6 +118,7 @@ struct virtio_device {
>  	struct list_head vqs;
>  	u64 features;
>  	void *priv;
> +	u32 desc_cache_thr;
>  };
>  
>  static inline struct virtio_device *dev_to_virtio(struct device *_dev)
> @@ -130,6 +131,19 @@ int register_virtio_device(struct virtio_device *dev);
>  void unregister_virtio_device(struct virtio_device *dev);
>  bool is_virtio_device(struct device *dev);
>  
> +/**
> + * virtio_set_desc_cache - set virtio ring desc cache threshold
> + *
> + * virtio will cache the allocated indirect desc.
> + *
> + * This function must be called before find_vqs.
> + *
> + * @thr:
> + *    0   - disable desc cache
> + *    > 0 - enable desc cache. As the threshold of the desc cache.
> + */
> +void virtio_set_desc_cache(struct virtio_device *dev, u32 thr);
> +

Would a better API be a cache size in bytes? This controls how much
memory is spent after all.

>  void virtio_break_device(struct virtio_device *dev);
>  
>  void virtio_config_changed(struct virtio_device *dev);
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
