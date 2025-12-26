Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4E262A6
	for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766779033; cv=none; b=Pd2I3oxngaA7LNR45LMeIIAJy7YTIxzkmeytFnkkUtwuumtymfIOZNgghTRwRYJbp6OM57AnLbwMBHDKOkhVmvXlKbkUTX2llm7y+CkwKFveIVcbrrfC1QxuLVtXzXgcp5lSINOcAGO31k4W2Zc/LURHWQ0PS68oFGdMPXcnedE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766779033; c=relaxed/simple;
	bh=f6C++hA5QEitbI85uY/+YScClI9wEUCo1g7abZv3AWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MyVdTJmW51zM/1tPKI3HP+E9woSAEvCfI/xZvhbSvHcVGKIJPItLJlmgwSAqr+qjic8Dk8oOZtkOg8TikPZWXAkS00aW3GXghfBj1H0q0mT8yLGgz+xDBBs6qrmV7PmiD1bH296D51vEgpqgSMdNPzivoWgJqjzgmuSb+caKSVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KAV4A3j4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAV4A3j4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766779027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlcNjaWlGnA5hAC+Fi8HcaULXyoHG8M4ZUYRj7Qyzp0=;
	b=KAV4A3j4/t6UKQQXnxgvc1XjLT5TnDjdgRvmm2ZrRKo/vinHBEgpDmdHbfuBfMKH3wPEe7
	2CjWkyZCfSvlQari9HKI3/T5HGphXtjwVnrNgHQaYqy3hrD0FuU5e94nj8iHHtgl8qYWN+
	sN7JZnVlVZ8ENfCYyqW+C1qfew9DEAQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-_Q582GSiOHupviP94TuszQ-1; Fri, 26 Dec 2025 14:57:06 -0500
X-MC-Unique: _Q582GSiOHupviP94TuszQ-1
X-Mimecast-MFC-AGG-ID: _Q582GSiOHupviP94TuszQ_1766779025
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42fdbba545fso4566789f8f.0
        for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 11:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766779025; x=1767383825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlcNjaWlGnA5hAC+Fi8HcaULXyoHG8M4ZUYRj7Qyzp0=;
        b=EP9eL8mTE0es/xWTc268k+1XG9E4C5g+7HuN4Wx0OeSt9r+gb0JoRW4agYTqj1CX4L
         nC09ueBfQ1Zw7L0bvb79f71GV4uqX6bFE5NPHrA+BR4DB85Ivrefc3fmj/w2mGkSuWg1
         bGXYS18wzCq1apkgRuok9z1MftQXqVYksDcUYwGbvO+EtkT1Ej4B7CxOlpDHL6ZWNJgo
         a3JYjohwSqtBL6RMbZk+hyKI3ZosALmRkOob0AtU/XZkY7xWty9qDFnK0/J0S2raa+hI
         g4/T8yHHvtlgAI+R4xOv8I0sUsDhFoI6qWUWulIb5Uxpmfbb829vr3Eqm16qXwqvWuFP
         Unkg==
X-Forwarded-Encrypted: i=1; AJvYcCWa7Lv3tgLV3w/IxyHJAWZ3Ho6X9k0Wja5TcAKdGsmYTdBWSbJvaVfcF3kbXd1Ros75RI8lMlmUhSuj1JdHaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCFMkHV6XpGDvE/YUDNYzFB49uZbZklqo5w8kSXGQTtnLVuSfS
	ISNAP+uvqDRbsJ41GxkpIv8a0U9POlJwLoUBQ+IelsvEgiDzRSL5gPfFTNeDQj2DelCnd7Pyp5A
	k6rtP9jF7prpdoyeJBETbP9IEfMqv4UUl4Ii5+P9MR5+NRbeQdt7Lus+cxaS4B54RYbBZ
X-Gm-Gg: AY/fxX6IhA0H8S8iFDo7+CFrscfSiL/pYYi3zDNnQFaVqAH0WDwxbJp7cvc1qbMzGuA
	bOuTJ4adKshEZVVa4nEatsAon/OZAdGnEwLdHARQK8nCsdd1H+JGg7+j7yYUgKZu5e9W51OU5Tl
	tOBXQyYn/dHWwKj9QVAoj6jENU8TGofbsqzv1jwLy1LKsDwszQlMDBYeaXt+PVe68SYHxbuFc1t
	nfNoCucwuKO9HF3p+EEGzNaifQaFkZEbLaxc5GhoY3Td1IrZEVg7Bb5iJlSHwxaRXODI7G60bbw
	z0nByjRrhbjyvzf3gyjED0MZzZYHEyXKGz3rcdQ+Vz3HrJENJTusAA8AjW+VR0muh7cIrhqhyIg
	SM5zAV2cANMMUFtxvi30/fbEX3Yq720IH0Q==
X-Received: by 2002:a05:6000:420c:b0:431:8bf:f08c with SMTP id ffacd0b85a97d-4324e42e651mr29251248f8f.21.1766779024515;
        Fri, 26 Dec 2025 11:57:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgrB/Pi0QIVcJrduFuE61ljjR77Fc6mzO4WDTo8a1pWutXBCzFA6/GADTf5DMSS1JIh+jRXA==
X-Received: by 2002:a05:6000:420c:b0:431:8bf:f08c with SMTP id ffacd0b85a97d-4324e42e651mr29251221f8f.21.1766779023863;
        Fri, 26 Dec 2025 11:57:03 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1bdsm46077523f8f.8.2025.12.26.11.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 11:57:03 -0800 (PST)
Date: Fri, 26 Dec 2025 14:57:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V11 19/19] virtio_ring: add in order support
Message-ID: <20251226145001-mutt-send-email-mst@kernel.org>
References: <20251225042608.32350-1-jasowang@redhat.com>
 <20251225042608.32350-20-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251225042608.32350-20-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Iw0o3EYyiRLDJYbjeyhzKgKn3ynZR1193n2WUF21wf4_1766779025
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 25, 2025 at 12:26:08PM +0800, Jason Wang wrote:
> This patch implements in order support for both split virtqueue and
> packed virtqueue. Performance could be gained for the device where the
> memory access could be expensive (e.g vhost-net or a real PCI device):
> 
> Benchmark with KVM guest:
> 
> Vhost-net on the host: (pktgen + XDP_DROP):
> 
>          in_order=off | in_order=on | +%
>     TX:  4.51Mpps     | 5.30Mpps    | +17%
>     RX:  3.47Mpps     | 3.61Mpps    | + 4%
> 
> Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
> 
> For split virtqueue:
> 
>          in_order=off | in_order=on | +%
>     TX:  5.60Mpps     | 5.60Mpps    | +0.0%
>     RX:  9.16Mpps     | 9.61Mpps    | +4.9%
> 
> For packed virtqueue:
> 
>          in_order=off | in_order=on | +%
>     TX:  5.60Mpps     | 5.70Mpps    | +1.7%
>     RX:  10.6Mpps     | 10.8Mpps    | +1.8%
> 
> Benchmark also shows no performance impact for in_order=off for queue
> size with 256 and 1024.
> 
> Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 455 +++++++++++++++++++++++++++++++++--
>  1 file changed, 432 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 61884e031b94..d1bcd1d8c66b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -70,6 +70,8 @@
>  enum vq_layout {
>  	SPLIT = 0,
>  	PACKED,
> +	SPLIT_IN_ORDER,
> +	PACKED_IN_ORDER,
>  	VQ_TYPE_MAX,
>  };
>  
> @@ -80,6 +82,7 @@ struct vring_desc_state_split {
>  	 * allocated together. So we won't stress more to the memory allocator.
>  	 */
>  	struct vring_desc *indir_desc;
> +	u32 total_in_len;
>  };
>  
>  struct vring_desc_state_packed {
> @@ -91,6 +94,7 @@ struct vring_desc_state_packed {
>  	struct vring_packed_desc *indir_desc;
>  	u16 num;			/* Descriptor list length. */
>  	u16 last;			/* The last desc state in a list. */
> +	u32 total_in_len;
>  };
>  

So let's be clear. Is this the device-written length or the driver supplied
length?


>  struct vring_desc_extra {
> @@ -205,8 +209,24 @@ struct vring_virtqueue {
>  
>  	enum vq_layout layout;
>  
> -	/* Head of free buffer list. */
> +	/*
> +	 * Without IN_ORDER it's the head of free buffer list. With
> +	 * IN_ORDER and SPLIT, it's the next available buffer
> +	 * index. With IN_ORDER and PACKED, it's unused.
> +	 */
>  	unsigned int free_head;
> +
> +	/*
> +	 * With IN_ORDER, once we see an in-order batch, this stores
> +	 * this last entry, and until we return the last buffer.
> +	 * After this, id is set to UINT_MAX to mark it invalid.
> +	 * Unused without IN_ORDER.
> +	 */
> +	struct used_entry {
> +		u32 id;
> +		u32 len;
> +	} batch_last;
> +
>  	/* Number we've added since last sync. */
>  	unsigned int num_added;
>  
> @@ -218,6 +238,11 @@ struct vring_virtqueue {
>  	 */
>  	u16 last_used_idx;
>  
> +	/* With IN_ORDER and SPLIT, last descriptor id we used to
> +	 * detach buffer.
> +	 */
> +	u16 last_used;
> +
>  	/* Hint for event idx: already triggered no need to disable. */
>  	bool event_triggered;
>  
> @@ -259,7 +284,12 @@ static void vring_free(struct virtqueue *_vq);
>  
>  static inline bool virtqueue_is_packed(const struct vring_virtqueue *vq)
>  {
> -	return vq->layout == PACKED;
> +	return vq->layout == PACKED || vq->layout == PACKED_IN_ORDER;
> +}
> +
> +static inline bool virtqueue_is_in_order(const struct vring_virtqueue *vq)
> +{
> +	return vq->layout == SPLIT_IN_ORDER || vq->layout == PACKED_IN_ORDER;
>  }
>  
>  static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
> @@ -469,6 +499,8 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
>  	else
>  		vq->last_used_idx = 0;
>  
> +	vq->last_used = 0;
> +
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
>  
> @@ -576,6 +608,8 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	struct scatterlist *sg;
>  	struct vring_desc *desc;
>  	unsigned int i, n, avail, descs_used, err_idx, sg_count = 0;
> +	/* Total length for in-order */
> +	unsigned int total_in_len = 0;
>  	int head;
>  	bool indirect;
>  
> @@ -667,6 +701,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  			 */
>  			i = virtqueue_add_desc_split(vq, desc, extra, i, addr,
>  						     len, flags, premapped);
> +			total_in_len += len;
>  		}
>  	}
>  
> @@ -689,7 +724,12 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	vq->vq.num_free -= descs_used;
>  
>  	/* Update free pointer */
> -	if (indirect)
> +	if (virtqueue_is_in_order(vq)) {
> +		vq->free_head += descs_used;
> +		if (vq->free_head >= vq->split.vring.num)
> +			vq->free_head -= vq->split.vring.num;
> +		vq->split.desc_state[head].total_in_len = total_in_len;


Looks like total_in_len is the driver supplied length?

> +	} else if (indirect)
>  		vq->free_head = vq->split.desc_extra[head].next;
>  	else
>  		vq->free_head = i;
> @@ -862,6 +902,14 @@ static bool more_used_split(const struct vring_virtqueue *vq)
>  	return virtqueue_poll_split(vq, vq->last_used_idx);
>  }
>  
> +static bool more_used_split_in_order(const struct vring_virtqueue *vq)
> +{
> +	if (vq->batch_last.id != UINT_MAX)
> +		return true;
> +
> +	return virtqueue_poll_split(vq, vq->last_used_idx);
> +}
> +
>  static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>  					 unsigned int *len,
>  					 void **ctx)
> @@ -919,6 +967,76 @@ static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>  	return ret;
>  }
>  
> +static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtqueue *vq,
> +						  unsigned int *len,
> +						  void **ctx)
> +{
> +	void *ret;
> +	unsigned int num = vq->split.vring.num;
> +	unsigned int num_free = vq->vq.num_free;
> +	u16 last_used, last_used_idx;
> +
> +	START_USE(vq);
> +
> +	if (unlikely(vq->broken)) {
> +		END_USE(vq);
> +		return NULL;
> +	}
> +
> +	last_used = vq->last_used & (num - 1);
> +	last_used_idx = vq->last_used_idx & (num - 1);
> +
> +	if (vq->batch_last.id == UINT_MAX) {
> +		if (!more_used_split_in_order(vq)) {
> +			pr_debug("No more buffers in queue\n");
> +			END_USE(vq);
> +			return NULL;
> +		}
> +
> +		/*
> +		 * Only get used array entries after they have been
> +		 * exposed by host.
> +		 */
> +		virtio_rmb(vq->weak_barriers);
> +
> +		vq->batch_last.id = virtio32_to_cpu(vq->vq.vdev,
> +				    vq->split.vring.used->ring[last_used_idx].id);
> +		vq->batch_last.len = virtio32_to_cpu(vq->vq.vdev,
> +				     vq->split.vring.used->ring[last_used_idx].len);
> +	}
> +
> +	if (vq->batch_last.id == last_used) {
> +		vq->batch_last.id = UINT_MAX;
> +		*len = vq->batch_last.len;
> +	} else {
> +		*len = vq->split.desc_state[last_used].total_in_len;
> +	}


but now we return this as buffer length? I think the expected value
here is the used length, not the driver supplied one?



Same questions apply to packed.



> +
> +	if (unlikely(!vq->split.desc_state[last_used].data)) {
> +		BAD_RING(vq, "id %u is not a head!\n", last_used);
> +		return NULL;
> +	}
> +
> +	/* detach_buf_split clears data, so grab it now. */
> +	ret = vq->split.desc_state[last_used].data;
> +	detach_buf_split_in_order(vq, last_used, ctx);
> +
> +	vq->last_used_idx++;
> +	vq->last_used += (vq->vq.num_free - num_free);
> +	/* If we expect an interrupt for the next entry, tell host
> +	 * by writing event index and flush out the write before
> +	 * the read in the next get_buf call. */
> +	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> +		virtio_store_mb(vq->weak_barriers,
> +				&vring_used_event(&vq->split.vring),
> +				cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx));
> +
> +	LAST_ADD_TIME_INVALID(vq);
> +
> +	END_USE(vq);
> +	return ret;
> +}
> +
>  static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
>  {
>  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
> @@ -1012,7 +1130,10 @@ static void *virtqueue_detach_unused_buf_split(struct vring_virtqueue *vq)
>  			continue;
>  		/* detach_buf_split clears data, so grab it now. */
>  		buf = vq->split.desc_state[i].data;
> -		detach_buf_split(vq, i, NULL);
> +		if (virtqueue_is_in_order(vq))
> +			detach_buf_split_in_order(vq, i, NULL);
> +		else
> +			detach_buf_split(vq, i, NULL);
>  		vq->split.avail_idx_shadow--;
>  		vq->split.vring.avail->idx = cpu_to_virtio16(vq->vq.vdev,
>  				vq->split.avail_idx_shadow);
> @@ -1075,6 +1196,7 @@ static void virtqueue_vring_attach_split(struct vring_virtqueue *vq,
>  
>  	/* Put everything in free lists. */
>  	vq->free_head = 0;
> +	vq->batch_last.id = UINT_MAX;
>  }
>  
>  static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring_split)
> @@ -1186,7 +1308,6 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  	if (!vq)
>  		return NULL;
>  
> -	vq->layout = SPLIT;
>  	vq->vq.callback = callback;
>  	vq->vq.vdev = vdev;
>  	vq->vq.name = name;
> @@ -1206,6 +1327,8 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>  		!context;
>  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> +	vq->layout = virtio_has_feature(vdev, VIRTIO_F_IN_ORDER) ?
> +		     SPLIT_IN_ORDER : SPLIT;
>  
>  	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
>  		vq->weak_barriers = false;
> @@ -1363,13 +1486,14 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  					 unsigned int in_sgs,
>  					 void *data,
>  					 bool premapped,
> -					 gfp_t gfp)
> +					 gfp_t gfp,
> +					 u16 id)
>  {
>  	struct vring_desc_extra *extra;
>  	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
> -	unsigned int i, n, err_idx, len;
> -	u16 head, id;
> +	unsigned int i, n, err_idx, len, total_in_len = 0;
> +	u16 head;
>  	dma_addr_t addr;
>  
>  	head = vq->packed.next_avail_idx;
> @@ -1387,8 +1511,6 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	}
>  
>  	i = 0;
> -	id = vq->free_head;
> -	BUG_ON(id == vq->packed.vring.num);
>  
>  	for (n = 0; n < out_sgs + in_sgs; n++) {
>  		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> @@ -1408,6 +1530,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  				extra[i].flags = n < out_sgs ?  0 : VRING_DESC_F_WRITE;
>  			}
>  
> +			if (n >= out_sgs)
> +				total_in_len += len;
>  			i++;
>  		}
>  	}
> @@ -1454,13 +1578,15 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  				1 << VRING_PACKED_DESC_F_USED;
>  	}
>  	vq->packed.next_avail_idx = n;
> -	vq->free_head = vq->packed.desc_extra[id].next;
> +	if (!virtqueue_is_in_order(vq))
> +		vq->free_head = vq->packed.desc_extra[id].next;
>  
>  	/* Store token and indirect buffer state. */
>  	vq->packed.desc_state[id].num = 1;
>  	vq->packed.desc_state[id].data = data;
>  	vq->packed.desc_state[id].indir_desc = desc;
>  	vq->packed.desc_state[id].last = id;
> +	vq->packed.desc_state[id].total_in_len = total_in_len;
>  
>  	vq->num_added += 1;
>  
> @@ -1513,8 +1639,11 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>  	BUG_ON(total_sg == 0);
>  
>  	if (virtqueue_use_indirect(vq, total_sg)) {
> +		id = vq->free_head;
> +		BUG_ON(id == vq->packed.vring.num);
>  		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> -						    in_sgs, data, premapped, gfp);
> +						    in_sgs, data, premapped,
> +						    gfp, id);
>  		if (err != -ENOMEM) {
>  			END_USE(vq);
>  			return err;
> @@ -1635,6 +1764,157 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>  	return -EIO;
>  }
>  
> +static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *vq,
> +						struct scatterlist *sgs[],
> +						unsigned int total_sg,
> +						unsigned int out_sgs,
> +						unsigned int in_sgs,
> +						void *data,
> +						void *ctx,
> +						bool premapped,
> +						gfp_t gfp)
> +{
> +	struct vring_packed_desc *desc;
> +	struct scatterlist *sg;
> +	unsigned int i, n, sg_count, err_idx, total_in_len = 0;
> +	__le16 head_flags, flags;
> +	u16 head, avail_used_flags;
> +	int err;
> +
> +	START_USE(vq);
> +
> +	BUG_ON(data == NULL);
> +	BUG_ON(ctx && vq->indirect);
> +
> +	if (unlikely(vq->broken)) {
> +		END_USE(vq);
> +		return -EIO;
> +	}
> +
> +	LAST_ADD_TIME_UPDATE(vq);
> +
> +	BUG_ON(total_sg == 0);
> +
> +	if (virtqueue_use_indirect(vq, total_sg)) {
> +		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> +						    in_sgs, data, premapped, gfp,
> +						    vq->packed.next_avail_idx);
> +		if (err != -ENOMEM) {
> +			END_USE(vq);
> +			return err;
> +		}
> +
> +		/* fall back on direct */
> +	}
> +
> +	head = vq->packed.next_avail_idx;
> +	avail_used_flags = vq->packed.avail_used_flags;
> +
> +	WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect);
> +
> +	desc = vq->packed.vring.desc;
> +	i = head;
> +
> +	if (unlikely(vq->vq.num_free < total_sg)) {
> +		pr_debug("Can't add buf len %i - avail = %i\n",
> +			 total_sg, vq->vq.num_free);
> +		END_USE(vq);
> +		return -ENOSPC;
> +	}
> +
> +	sg_count = 0;
> +	for (n = 0; n < out_sgs + in_sgs; n++) {
> +		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> +			dma_addr_t addr;
> +			u32 len;
> +
> +			flags = 0;
> +			if (++sg_count != total_sg)
> +				flags |= cpu_to_le16(VRING_DESC_F_NEXT);
> +			if (n >= out_sgs)
> +				flags |= cpu_to_le16(VRING_DESC_F_WRITE);
> +
> +			if (vring_map_one_sg(vq, sg, n < out_sgs ?
> +					     DMA_TO_DEVICE : DMA_FROM_DEVICE,
> +					     &addr, &len, premapped))
> +				goto unmap_release;
> +
> +			flags |= cpu_to_le16(vq->packed.avail_used_flags);
> +
> +			if (i == head)
> +				head_flags = flags;
> +			else
> +				desc[i].flags = flags;
> +
> +			desc[i].addr = cpu_to_le64(addr);
> +			desc[i].len = cpu_to_le32(len);
> +			desc[i].id = cpu_to_le16(head);
> +
> +			if (unlikely(vq->use_map_api)) {
> +				vq->packed.desc_extra[i].addr = premapped ?
> +				      DMA_MAPPING_ERROR: addr;
> +				vq->packed.desc_extra[i].len = len;
> +				vq->packed.desc_extra[i].flags =
> +					le16_to_cpu(flags);
> +			}
> +
> +			if ((unlikely(++i >= vq->packed.vring.num))) {
> +				i = 0;
> +				vq->packed.avail_used_flags ^=
> +					1 << VRING_PACKED_DESC_F_AVAIL |
> +					1 << VRING_PACKED_DESC_F_USED;
> +				vq->packed.avail_wrap_counter ^= 1;
> +			}
> +
> +			if (n >= out_sgs)
> +				total_in_len += len;
> +		}
> +	}
> +
> +	/* We're using some buffers from the free list. */
> +	vq->vq.num_free -= total_sg;
> +
> +	/* Update free pointer */
> +	vq->packed.next_avail_idx = i;
> +
> +	/* Store token. */
> +	vq->packed.desc_state[head].num = total_sg;
> +	vq->packed.desc_state[head].data = data;
> +	vq->packed.desc_state[head].indir_desc = ctx;
> +	vq->packed.desc_state[head].total_in_len = total_in_len;
> +
> +	/*
> +	 * A driver MUST NOT make the first descriptor in the list
> +	 * available before all subsequent descriptors comprising
> +	 * the list are made available.
> +	 */
> +	virtio_wmb(vq->weak_barriers);
> +	vq->packed.vring.desc[head].flags = head_flags;
> +	vq->num_added += total_sg;
> +
> +	pr_debug("Added buffer head %i to %p\n", head, vq);
> +	END_USE(vq);
> +
> +	return 0;
> +
> +unmap_release:
> +	err_idx = i;
> +	i = head;
> +	vq->packed.avail_used_flags = avail_used_flags;

Hmm. But this does not roll back packed.avail_wrap_counter.
Shouldn't it?




> +
> +	for (n = 0; n < total_sg; n++) {
> +		if (i == err_idx)
> +			break;
> +		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[i]);
> +		i++;
> +		if (i >= vq->packed.vring.num)
> +			i = 0;
> +	}
> +
> +	END_USE(vq);
> +	return -EIO;
> +}
> +
>  static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
>  {
>  	u16 new, old, off_wrap, flags, wrap_counter, event_idx;
> @@ -1796,10 +2076,82 @@ static void update_last_used_idx_packed(struct vring_virtqueue *vq,
>  				cpu_to_le16(vq->last_used_idx));
>  }
>  
> +static bool more_used_packed_in_order(const struct vring_virtqueue *vq)
> +{
> +	if (vq->batch_last.id != UINT_MAX)
> +		return true;
> +
> +	return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
> +}
> +
> +static void *virtqueue_get_buf_ctx_packed_in_order(struct vring_virtqueue *vq,
> +						   unsigned int *len,
> +						   void **ctx)
> +{
> +	unsigned int num = vq->packed.vring.num;
> +	u16 last_used, last_used_idx;
> +	bool used_wrap_counter;
> +	void *ret;
> +
> +	START_USE(vq);
> +
> +	if (unlikely(vq->broken)) {
> +		END_USE(vq);
> +		return NULL;
> +	}
> +
> +	last_used_idx = vq->last_used_idx;
> +	used_wrap_counter = packed_used_wrap_counter(last_used_idx);
> +	last_used = packed_last_used(last_used_idx);
> +
> +	if (vq->batch_last.id == UINT_MAX) {
> +		if (!more_used_packed_in_order(vq)) {
> +			pr_debug("No more buffers in queue\n");
> +			END_USE(vq);
> +			return NULL;
> +		}
> +		/* Only get used elements after they have been exposed by host. */
> +		virtio_rmb(vq->weak_barriers);
> +		vq->batch_last.id =
> +			le16_to_cpu(vq->packed.vring.desc[last_used].id);
> +		vq->batch_last.len =
> +			le32_to_cpu(vq->packed.vring.desc[last_used].len);
> +	}
> +
> +	if (vq->batch_last.id == last_used) {
> +		vq->batch_last.id = UINT_MAX;
> +		*len = vq->batch_last.len;
> +	} else {
> +		*len = vq->packed.desc_state[last_used].total_in_len;
> +	}
> +
> +	if (unlikely(last_used >= num)) {
> +		BAD_RING(vq, "id %u out of range\n", last_used);
> +		return NULL;
> +	}
> +	if (unlikely(!vq->packed.desc_state[last_used].data)) {
> +		BAD_RING(vq, "id %u is not a head!\n", last_used);
> +		return NULL;
> +	}
> +
> +	/* detach_buf_packed clears data, so grab it now. */
> +	ret = vq->packed.desc_state[last_used].data;
> +	detach_buf_packed_in_order(vq, last_used, ctx);
> +
> +	update_last_used_idx_packed(vq, last_used, last_used,
> +				    used_wrap_counter);
> +
> +	LAST_ADD_TIME_INVALID(vq);
> +
> +	END_USE(vq);
> +	return ret;
> +}
> +
>  static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
>  					  unsigned int *len,
>  					  void **ctx)
>  {
> +	unsigned int num = vq->packed.vring.num;
>  	u16 last_used, id, last_used_idx;
>  	bool used_wrap_counter;
>  	void *ret;
> @@ -1826,7 +2178,7 @@ static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
>  	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
>  	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
>  
> -	if (unlikely(id >= vq->packed.vring.num)) {
> +	if (unlikely(id >= num)) {
>  		BAD_RING(vq, "id %u out of range\n", id);
>  		return NULL;
>  	}
> @@ -1967,7 +2319,10 @@ static void *virtqueue_detach_unused_buf_packed(struct vring_virtqueue *vq)
>  			continue;
>  		/* detach_buf clears data, so grab it now. */
>  		buf = vq->packed.desc_state[i].data;
> -		detach_buf_packed(vq, i, NULL);
> +		if (virtqueue_is_in_order(vq))
> +			detach_buf_packed_in_order(vq, i, NULL);
> +		else
> +			detach_buf_packed(vq, i, NULL);
>  		END_USE(vq);
>  		return buf;
>  	}
> @@ -1993,6 +2348,8 @@ static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
>  	for (i = 0; i < num - 1; i++)
>  		desc_extra[i].next = i + 1;
>  
> +	desc_extra[num - 1].next = 0;
> +
>  	return desc_extra;
>  }
>  
> @@ -2124,10 +2481,17 @@ static void virtqueue_vring_attach_packed(struct vring_virtqueue *vq,
>  {
>  	vq->packed = *vring_packed;
>  
> -	/* Put everything in free lists. */
> -	vq->free_head = 0;
> +	if (virtqueue_is_in_order(vq)) {
> +		vq->batch_last.id = UINT_MAX;
> +	} else {
> +		/*
> +		 * Put everything in free lists. Note that
> +		 * next_avail_idx is sufficient with IN_ORDER so
> +		 * free_head is unused.
> +		 */
> +		vq->free_head = 0;
> +	}
>  }
> -
>  static void virtqueue_reset_packed(struct vring_virtqueue *vq)
>  {
>  	memset(vq->packed.vring.device, 0, vq->packed.event_size_in_bytes);
> @@ -2172,13 +2536,14 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
>  #else
>  	vq->broken = false;
>  #endif
> -	vq->layout = PACKED;
>  	vq->map = map;
>  	vq->use_map_api = vring_use_map_api(vdev);
>  
>  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>  		!context;
>  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> +	vq->layout = virtio_has_feature(vdev, VIRTIO_F_IN_ORDER) ?
> +		     PACKED_IN_ORDER : PACKED;
>  
>  	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
>  		vq->weak_barriers = false;
> @@ -2288,9 +2653,39 @@ static const struct virtqueue_ops packed_ops = {
>  	.reset = virtqueue_reset_packed,
>  };
>  
> +static const struct virtqueue_ops split_in_order_ops = {
> +	.add = virtqueue_add_split,
> +	.get = virtqueue_get_buf_ctx_split_in_order,
> +	.kick_prepare = virtqueue_kick_prepare_split,
> +	.disable_cb = virtqueue_disable_cb_split,
> +	.enable_cb_delayed = virtqueue_enable_cb_delayed_split,
> +	.enable_cb_prepare = virtqueue_enable_cb_prepare_split,
> +	.poll = virtqueue_poll_split,
> +	.detach_unused_buf = virtqueue_detach_unused_buf_split,
> +	.more_used = more_used_split_in_order,
> +	.resize = virtqueue_resize_split,
> +	.reset = virtqueue_reset_split,
> +};
> +
> +static const struct virtqueue_ops packed_in_order_ops = {
> +	.add = virtqueue_add_packed_in_order,
> +	.get = virtqueue_get_buf_ctx_packed_in_order,
> +	.kick_prepare = virtqueue_kick_prepare_packed,
> +	.disable_cb = virtqueue_disable_cb_packed,
> +	.enable_cb_delayed = virtqueue_enable_cb_delayed_packed,
> +	.enable_cb_prepare = virtqueue_enable_cb_prepare_packed,
> +	.poll = virtqueue_poll_packed,
> +	.detach_unused_buf = virtqueue_detach_unused_buf_packed,
> +	.more_used = more_used_packed_in_order,
> +	.resize = virtqueue_resize_packed,
> +	.reset = virtqueue_reset_packed,
> +};
> +
>  static const struct virtqueue_ops *const all_ops[VQ_TYPE_MAX] = {
>  	[SPLIT] = &split_ops,
> -	[PACKED] = &packed_ops
> +	[PACKED] = &packed_ops,
> +	[SPLIT_IN_ORDER] = &split_in_order_ops,
> +	[PACKED_IN_ORDER] = &packed_in_order_ops,
>  };
>  
>  static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
> @@ -2346,6 +2741,12 @@ static int virtqueue_enable_after_reset(struct virtqueue *_vq)
>  	case PACKED:							\
>  		ret = all_ops[PACKED]->op(vq, ##__VA_ARGS__);		\
>  		break;							\
> +	case SPLIT_IN_ORDER:						\
> +		ret = all_ops[SPLIT_IN_ORDER]->op(vq, ##__VA_ARGS__);	\
> +		break;							\
> +	case PACKED_IN_ORDER:						\
> +		ret = all_ops[PACKED_IN_ORDER]->op(vq, ##__VA_ARGS__);	\
> +		break;							\
>  	default:							\
>  		BUG();							\
>  		break;							\
> @@ -2362,10 +2763,16 @@ static int virtqueue_enable_after_reset(struct virtqueue *_vq)
>  	case PACKED:					\
>  		all_ops[PACKED]->op(vq, ##__VA_ARGS__);	\
>  		break;					\
> -	default:					\
> -		BUG();					\
> -		break;					\
> -	}						\
> +	case SPLIT_IN_ORDER:						\
> +		all_ops[SPLIT_IN_ORDER]->op(vq, ##__VA_ARGS__);	\
> +		break;							\
> +	case PACKED_IN_ORDER:						\
> +		all_ops[PACKED_IN_ORDER]->op(vq, ##__VA_ARGS__);	\
> +		break;							\
> +	default:							\
> +		BUG();							\
> +		break;							\
> +	}								\
>  })
>  
>  static inline int virtqueue_add(struct virtqueue *_vq,
> @@ -3081,6 +3488,8 @@ void vring_transport_features(struct virtio_device *vdev)
>  			break;
>  		case VIRTIO_F_NOTIFICATION_DATA:
>  			break;
> +		case VIRTIO_F_IN_ORDER:
> +			break;
>  		default:
>  			/* We don't understand this bit. */
>  			__virtio_clear_bit(vdev, i);
> -- 
> 2.31.1

