Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE512BDC3F
	for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951349; cv=none; b=saGEOI5hw//JK3hDUtnFbyuXi/2rDYz6Vhdh/oDj4rQJfPIbnaDw6lgCXDVq0pfGVG9SxtPGgEI3eTrOdwGkcXIdIr5zA6VRM0kaQyy8I/Y3ls1XL9GGUsuAVZp69MivVR4CMPworiTz/VVX/Gz1pQsg4M/U+9fVHlvxV15oVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951349; c=relaxed/simple;
	bh=1kMtzy3Lk5trNTpOoaHuwbn9RlEpvJ8NodAIVgpTacY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kJCbjcobGUCi3qk2cxIZrKmst+pQHgj2dJ1kufgjA7fDgMM9rHBr2TUweRnSV+25Wp9AEoW2wUJebFNuRXd5p99HaM3NJ9LfFVXI6x8DEpe7vzkrQKNt2B/J1/0WtCXIH8OszbI62EzEOadkxYT5dyqVNnV5Za6tk+dFgqkxZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W60DhOhx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W60DhOhx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760951344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mc66IMppP2LfUFIodSsG5hh2RkJ+uA926Go93eGlER8=;
	b=W60DhOhxQ/WL0fIbkU0x61wZTr04KduYjjAuDDmA1c+31H1pXukiwb6Nc+Zsdj3m9EVnig
	+YtEJjICPT+XuK9kEW2cgundq5c7g3XLHWWxlk06QituGjumrrdznYepTaZie6DyYqjheO
	lEK3cYzBcYCj4yEX4CEMlvMboUmu11Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-0DvACJdcN1OyBgwMWityeA-1; Mon, 20 Oct 2025 05:09:02 -0400
X-MC-Unique: 0DvACJdcN1OyBgwMWityeA-1
X-Mimecast-MFC-AGG-ID: 0DvACJdcN1OyBgwMWityeA_1760951341
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4270a273b6eso2075211f8f.0
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 02:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760951341; x=1761556141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc66IMppP2LfUFIodSsG5hh2RkJ+uA926Go93eGlER8=;
        b=rIJrIG+urxrpzrc3TfeszRmlZz5eK8ZDbPAULsL0UL0nhmmNwtDc5c5h5NPjmI1K/0
         VdnaXjq7gofEbFWg4+vXQBDK6lshHuFCSbYaMZ51wXwa0mVRxuAJc6YWKjgu8I1js7WZ
         ikus/EPjQBYe5H0t/6WexT+l32hwTl447plqDOYrHidr17xJJ67R0hlbWH1F8aG9+E9W
         Vvkqzm58xq/8rKhXKT0zGS+sblnCEfDjXIhEu2GVdPtzYpt2QMWUllfXbFYghc3WgGJe
         VHkeuA37CcHw0JplTPakUW/2g9KvY1UYSI1x6V/Nh4K/qr03vE7C5wdZrgv69ysEARL3
         W74w==
X-Forwarded-Encrypted: i=1; AJvYcCVaPwQmnLWwnPsYuXxHUyHotYamGGxViQj3XiuJf0D9nqa6lxqG1yH2Thst9Dk9Kg26cmQ6XPqdyIfmGQJHmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywlifxl/7FFkEenlQYHoOITsvJNm6HbfaAUMaTg3MFft81bzhvn
	kCRNx49iIfaAJ8zPYmoFxrt4XTRzYjRWfukwdHBoXi87ISK7eUFsArhODtYVDasK6ZWfiqteB5p
	+F4lvodC9ACE9tGK32bmYcWlP1JKMqZfPYQgO4B3V830CilRhcblGtGax0bKVfAVcSEyI
X-Gm-Gg: ASbGncvI6QJ47HBdDlOUOn9UOdgy53nMkejjQTCi1Y61gZlBRn/oXLy2OoExC5lr/Jz
	gTFacPrbIPekpBKndLg3bOCYEt6W9m51X7HqIUZ5OezDLfQfE7lhOYX4+TVL7uHt5bfnCLgoxbx
	NZR+ktAt1mPAroFdR/zdtANk/lKledNaszYnCfY5EcsR9J6mjRLa85Gc8EbaZvg+STOAdqZGH+U
	eUnadE1dcHEiB1adw6uUs/UnTOyQUu5xzSZfVN1fMmxcKBn72QnKQACkXH8RccA2qUF+SY4VmU+
	PNJzf3ErI5B/oBzVsNyNMUF7CoYFxNreT1XnwvYcaqsJrqCWPi8A+0cXFjJ3teGPP7ur
X-Received: by 2002:a05:6000:1789:b0:427:5e3:7d74 with SMTP id ffacd0b85a97d-42705e37d97mr7183492f8f.23.1760951340878;
        Mon, 20 Oct 2025 02:09:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl+z/dEKGukbrZPPIaHKhj5DYUGR/4tth3v2EjBycd3HxRzlLedwCzHFsFTW01zqGaS43+Dg==
X-Received: by 2002:a05:6000:1789:b0:427:5e3:7d74 with SMTP id ffacd0b85a97d-42705e37d97mr7183462f8f.23.1760951340095;
        Mon, 20 Oct 2025 02:09:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce06bsm14038968f8f.45.2025.10.20.02.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:08:59 -0700 (PDT)
Date: Mon, 20 Oct 2025 05:08:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 19/19] virtio_ring: add in order support
Message-ID: <20251020043646-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-20-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251020071003.28834-20-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WnKiopM2W5JqaYI6I9urOWFf7GNQf65-atFQVprPGQo_1760951341
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2025 at 03:10:03PM +0800, Jason Wang wrote:
> This patch implements in order support for both split virtqueue and
> packed virtqueue. Performance could be gained for the device where the
> memory access could be expensive (e.g vhost-net or a real PCI device):
> 
> Benchmark with KVM guest:
> 
> Vhost-net on the host: (pktgen + XDP_DROP):
> 
>          in_order=off | in_order=on | +%
>     TX:  5.20Mpps     | 6.20Mpps    | +19%
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
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 440 +++++++++++++++++++++++++++++++++--
>  1 file changed, 416 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 96d7f165ec88..411bfa31707d 100644
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
> +	u32 total_len;			/* Buffer Length */
>  };
>  
>  struct vring_desc_state_packed {
> @@ -91,6 +94,7 @@ struct vring_desc_state_packed {
>  	struct vring_packed_desc *indir_desc;
>  	u16 num;			/* Descriptor list length. */
>  	u16 last;			/* The last desc state in a list. */
> +	u32 total_len;			/* Buffer Length */
>  };
>  
>  struct vring_desc_extra {
> @@ -168,7 +172,7 @@ struct vring_virtqueue_packed {
>  struct vring_virtqueue;
>  
>  struct virtqueue_ops {
> -	int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[],
> +	int (*add)(struct vring_virtqueue *vq, struct scatterlist *sgs[],
>  		   unsigned int total_sg, unsigned int out_sgs,
>  		   unsigned int in_sgs,	void *data,
>  		   void *ctx, bool premapped, gfp_t gfp);
> @@ -205,8 +209,23 @@ struct vring_virtqueue {
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
> +	 * With IN_ORDER, devices write a single used ring entry with
> +	 * the id corresponding to the head entry of the descriptor chain
> +	 * describing the last buffer in the batch

In the spec, yes, but I don't get it, so what does this field do?
This should say something like:
"once we see an in-order batch, this stores this last
 entry, and until we return the last buffer.
 After this, id is set to vq.num to mark it invalid.
 Unused without IN_ORDER.
"




> +	 */
> +	struct used_entry {
> +		u32 id;
> +		u32 len;
> +	} batch_last;
> +
>  	/* Number we've added since last sync. */
>  	unsigned int num_added;
>  
> @@ -259,7 +278,12 @@ static void vring_free(struct virtqueue *_vq);
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
> @@ -576,6 +600,8 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	struct scatterlist *sg;
>  	struct vring_desc *desc;
>  	unsigned int i, n, avail, descs_used, err_idx, c = 0;
> +	/* Total length for in-order */
> +	unsigned int total_len = 0;
>  	int head;
>  	bool indirect;
>  
> @@ -645,6 +671,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
>  						     ++c == total_sg ? 0 : VRING_DESC_F_NEXT,
>  						     premapped);
> +			total_len += len;
>  		}
>  	}
>  	for (; n < (out_sgs + in_sgs); n++) {
> @@ -662,6 +689,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  				i, addr, len,
>  				(++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
>  				VRING_DESC_F_WRITE, premapped);
> +			total_len += len;
>  		}
>  	}
>  
> @@ -684,7 +712,12 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	vq->vq.num_free -= descs_used;
>  
>  	/* Update free pointer */
> -	if (indirect)
> +	if (virtqueue_is_in_order(vq)) {
> +		vq->free_head += descs_used;
> +		if (vq->free_head >= vq->split.vring.num)
> +			vq->free_head -= vq->split.vring.num;
> +		vq->split.desc_state[head].total_len = total_len;;

what's with ;; ?


> +	} else if (indirect)
>  		vq->free_head = vq->split.desc_extra[head].next;
>  	else
>  		vq->free_head = i;
> @@ -858,6 +891,14 @@ static bool more_used_split(const struct vring_virtqueue *vq)
>  	return virtqueue_poll_split(vq, vq->last_used_idx);
>  }
>  
> +static bool more_used_split_in_order(const struct vring_virtqueue *vq)
> +{
> +	if (vq->batch_last.id != vq->split.vring.num)

So why not use ~0x0 to mark the id invalid?
Will save a vring num read making the code a bit
more compact, no? worth trying.


> +		return true;
> +
> +	return virtqueue_poll_split(vq, vq->last_used_idx);
> +}
> +
>  static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>  					 unsigned int *len,
>  					 void **ctx)

So now we have both more_used_split and more_used_split_in_order
and it's confusing that more_used_split is not a superset
of more_used_split_in_order.

I think fundamentally out of order code will have to be
renamed with _ooo suffix.


Not a blocker for now.



> @@ -915,6 +956,73 @@ static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>  	return ret;
>  }
>  
> +static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtqueue *vq,
> +						  unsigned int *len,
> +						  void **ctx)
> +{
> +	void *ret;
> +	unsigned int num = vq->split.vring.num;
> +	u16 last_used;
> +
> +	START_USE(vq);
> +
> +	if (unlikely(vq->broken)) {
> +		END_USE(vq);
> +		return NULL;
> +	}
> +
> +	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));

just (num - 1) ?


> +
> +	if (vq->batch_last.id == num) {
> +		if (!more_used_split(vq)) {


Well this works technically but it is really confusing.
Better to call more_used_split_in_order consistently.


> +			pr_debug("No more buffers in queue\n");
> +			END_USE(vq);
> +			return NULL;
> +		}
> +
> +		/* Only get used array entries after they have been
> +		 * exposed by host. */

/*
 * Always format multiline comments
 * like this.
 */

/* Never
 * like this */



> +		virtio_rmb(vq->weak_barriers);
> +		vq->batch_last.id = virtio32_to_cpu(vq->vq.vdev,
> +				    vq->split.vring.used->ring[last_used].id);
> +		vq->batch_last.len = virtio32_to_cpu(vq->vq.vdev,
> +				     vq->split.vring.used->ring[last_used].len);
> +	}
> +
> +	if (vq->batch_last.id == last_used) {
> +		vq->batch_last.id = num;
> +		*len = vq->batch_last.len;
> +	} else
> +		*len = vq->split.desc_state[last_used].total_len;
> +
> +	if (unlikely(last_used >= num)) {
> +		BAD_RING(vq, "id %u out of range\n", last_used);
> +		return NULL;
> +	}
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
> @@ -1008,7 +1116,10 @@ static void *virtqueue_detach_unused_buf_split(struct vring_virtqueue *vq)
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
> @@ -1071,6 +1182,7 @@ static void virtqueue_vring_attach_split(struct vring_virtqueue *vq,
>  
>  	/* Put everything in free lists. */
>  	vq->free_head = 0;
> +	vq->batch_last.id = vq->split.vring.num;
>  }
>  
>  static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring_split)
> @@ -1182,7 +1294,6 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  	if (!vq)
>  		return NULL;
>  
> -	vq->layout = SPLIT;
>  	vq->vq.callback = callback;
>  	vq->vq.vdev = vdev;
>  	vq->vq.name = name;
> @@ -1202,6 +1313,8 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>  		!context;
>  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> +	vq->layout = virtio_has_feature(vdev, VIRTIO_F_IN_ORDER) ?
> +		     SPLIT_IN_ORDER : SPLIT;
>  
>  	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
>  		vq->weak_barriers = false;

Same comments for packed below, I don't repeat them.




> @@ -1359,13 +1472,14 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
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
> +	unsigned int i, n, err_idx, len, total_len = 0;
> +	u16 head;
>  	dma_addr_t addr;
>  
>  	head = vq->packed.next_avail_idx;
> @@ -1383,8 +1497,6 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	}
>  
>  	i = 0;
> -	id = vq->free_head;
> -	BUG_ON(id == vq->packed.vring.num);
>  
>  	for (n = 0; n < out_sgs + in_sgs; n++) {
>  		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> @@ -1404,6 +1516,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  				extra[i].flags = n < out_sgs ?  0 : VRING_DESC_F_WRITE;
>  			}
>  
> +			total_len += len;
>  			i++;
>  		}
>  	}
> @@ -1450,13 +1563,15 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
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
> +	vq->packed.desc_state[id].total_len = total_len;
>  
>  	vq->num_added += 1;
>  
> @@ -1509,8 +1624,11 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
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
> @@ -1631,6 +1749,152 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
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
> +	unsigned int i, n, c, err_idx, total_len = 0;
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
> +	c = 0;
> +	for (n = 0; n < out_sgs + in_sgs; n++) {
> +		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> +			dma_addr_t addr;
> +			u32 len;
> +
> +			if (vring_map_one_sg(vq, sg, n < out_sgs ?
> +					     DMA_TO_DEVICE : DMA_FROM_DEVICE,
> +					     &addr, &len, premapped))
> +				goto unmap_release;
> +
> +			flags = cpu_to_le16(vq->packed.avail_used_flags |
> +				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
> +				    (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
> +			if (i == head)
> +				head_flags = flags;
> +			else
> +				desc[i].flags = flags;
> +
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
> +			total_len += len;
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
> +	vq->packed.desc_state[head].total_len = total_len;
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
> @@ -1792,10 +2056,81 @@ static void update_last_used_idx_packed(struct vring_virtqueue *vq,
>  				cpu_to_le16(vq->last_used_idx));
>  }
>  
> +static bool more_used_packed_in_order(const struct vring_virtqueue *vq)
> +{
> +	if (vq->batch_last.id != vq->packed.vring.num)
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
> +	if (vq->batch_last.id == num) {
> +		if (!more_used_packed(vq)) {
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
> +		vq->batch_last.id = num;
> +		*len = vq->batch_last.len;
> +	} else
> +		*len = vq->packed.desc_state[last_used].total_len;
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
> @@ -1822,7 +2157,7 @@ static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
>  	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
>  	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
>  
> -	if (unlikely(id >= vq->packed.vring.num)) {
> +	if (unlikely(id >= num)) {
>  		BAD_RING(vq, "id %u out of range\n", id);
>  		return NULL;
>  	}
> @@ -1963,7 +2298,10 @@ static void *virtqueue_detach_unused_buf_packed(struct vring_virtqueue *vq)
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
> @@ -1989,6 +2327,8 @@ static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
>  	for (i = 0; i < num - 1; i++)
>  		desc_extra[i].next = i + 1;
>  
> +	desc_extra[num - 1].next = 0;
> +
>  	return desc_extra;
>  }
>  
> @@ -2120,10 +2460,17 @@ static void virtqueue_vring_attach_packed(struct vring_virtqueue *vq,
>  {
>  	vq->packed = *vring_packed;
>  
> -	/* Put everything in free lists. */
> -	vq->free_head = 0;
> +	if (virtqueue_is_in_order(vq))
> +		vq->batch_last.id = vq->packed.vring.num;
> +	else {

coding style violation:

	This does not apply if only one branch of a conditional statement is a single
	statement; in the latter case use braces in both branches:

	.. code-block:: c

		if (condition) {
			do_this();
			do_that();
		} else {
			otherwise();
		}





> +		/*
> +		 * Put everything in free lists. Note that
> +		 * next_avail_idx is sufficient with IN_ORDER so
> +		 * free_head is unused.
> +		 */
> +		vq->free_head = 0 ;

extra space here



> +	}
>  }
> -
>  static void virtqueue_reset_packed(struct vring_virtqueue *vq)
>  {
>  	memset(vq->packed.vring.device, 0, vq->packed.event_size_in_bytes);
> @@ -2168,13 +2515,14 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
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
> @@ -2284,9 +2632,39 @@ static const struct virtqueue_ops packed_ops = {
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
> @@ -2342,6 +2720,12 @@ static int virtqueue_enable_after_reset(struct virtqueue *_vq)
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
> @@ -2358,10 +2742,16 @@ static int virtqueue_enable_after_reset(struct virtqueue *_vq)
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
> @@ -3078,6 +3468,8 @@ void vring_transport_features(struct virtio_device *vdev)
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

