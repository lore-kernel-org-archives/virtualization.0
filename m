Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C910366
	for <virtualization@lists.linux.dev>; Mon,  7 Apr 2025 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014047; cv=none; b=rgLRm84wMtrrsv2kaIN5MDjH7G2l7GMzHFhNRKMz0M61nvES2fwPeO1S9POO2XFUVN9kAx18b4Hp9q8OpKf/Y6hjpgRhm/DscQm8x5rfFeNZ82WCB96vCdINvTRrUiLNjmLXUnCATX8xdV9dv5deEvR1pZYg/RYQ9Lf8ujsgPA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014047; c=relaxed/simple;
	bh=PMQfT6d4GwVVZrwpYw6jFUFyMMDe7NT6bma1//9QBR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VQLvHO8+y4BbVcoc6AX/G2+ZS1M3BmCwWpsqaRB0e1kKrf/EEwqoE3fXXKu3ItdS5PtehghxNE2cKCU2Keke9/zB6j2KTR0gkfZw1x+j/SITfgIyh/wi3A5X9/xe4MNeiwO41Ccc6OVwEfNPmhZfc2slqf2DO5VvPclXo1SLQLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DmJw7gpq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmJw7gpq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744014044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6foLXJiT89sSwqOs3tgZWdAu5yXlYl8zLUUJZt72hn8=;
	b=DmJw7gpqmmVmDcc4bwpCI3LKmttX9zVUra9cP5hDuz9PeoHSW1JGab0WXG9qEIbwvfMMq0
	V6ET5njSQYyREoK8z8C3yJl7yYfSs+FMmabMYkmEaYu/PmDoDkF311+JtHWp62Cf2oIKhK
	Di+WJfG/sI9OqdgoLQvfuAShYnRAPEk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-JFpcaFsiMcOoRFgCdbuZiQ-1; Mon, 07 Apr 2025 04:20:42 -0400
X-MC-Unique: JFpcaFsiMcOoRFgCdbuZiQ-1
X-Mimecast-MFC-AGG-ID: JFpcaFsiMcOoRFgCdbuZiQ_1744014041
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39123912ff0so1676587f8f.2
        for <virtualization@lists.linux.dev>; Mon, 07 Apr 2025 01:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744014041; x=1744618841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6foLXJiT89sSwqOs3tgZWdAu5yXlYl8zLUUJZt72hn8=;
        b=NpxDVp0dnRwdidYGMu7DpPVtj/qjbRX1sAnXkdAipCPGd1ijuDDC+WUvWQ02oICt3n
         TCUZ3S77oU4UisZ79kBgG/LnS4eqZ5CSukevPCn5KKzjP38qpd6DkHC3RmghLKAkHE+3
         m9SJxhGuyWs96miXvO5ODCtkIl0MNF2aZyQlrxXsT8Xis2oEnwcMrnt9AN+ZLb3NMlV4
         KnCKc3t32GFQmB2PVpMSs/vqgu/rv2urPEZPSAVAa6i2U3+RM5arBqJXmI+n0CyMDShg
         YZCqbNEpfDApOPvF6+HL3+O7gqfG6EW+yV2vp37Y7HtjS0DaTh4z1hk5TGkDaIqR9JT7
         9eKg==
X-Forwarded-Encrypted: i=1; AJvYcCVbQcdxjAUP8449btt2dx+1tv34clt1Qo00nG+3tfv6JvvQGnR7h94GDS0ukAkYTjOmu6V7rs9Vnl1cKH5+sA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1aXqxxIPADsIpkXL1/34KO7/ry9JIwGDy04DZ5KOkx6b1zOh2
	FuE0tTy/oo35Q2BM3ZLICymXUuok1bpe8VBnu1DeSSUAuA/J8hMBLUoiVzbfzKkVlzHmIP8UgKX
	ybrC7X10e0YDMDUEEBft33TVQMUG5O4Oy6ceYxOqSJLFq/D0KrpsZFRgs3+mrnKq2
X-Gm-Gg: ASbGncuxq1Ehq5Q+Io7TOv9M/SA5dmD2du9HQb7sKYJTfQx9i3S9kFQXR7ncPVdxXyS
	ULB26YFogqOEzLMM42edZilPjOkUIlLM2wKIJSi7dCk3Gi9zFf5DbEf1o5Wk/0iw4QnHW57hdxS
	NHcX9bcO9/q8Yp/jree30R3GXW6VnJv1tDUOBS143vMNPT1M26XWa9hUrG9x+2taJyMiCagoUvk
	6UJBLF6cmyNw+NH6C6PrSrdyNx0z/w1VkwCFqm1AJ2qqzjUHHfc5eG1H7XCHjLFP3es4WOmaTul
	FK4zfdwbGg==
X-Received: by 2002:a05:6000:270d:b0:39c:1257:dbaa with SMTP id ffacd0b85a97d-39d14762f71mr5721175f8f.58.1744014041283;
        Mon, 07 Apr 2025 01:20:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK6VXPWY67VKNhdqGQZzAkm7nKVVM4QZ8CIZIcBYFmMD455PZ0i6KwRn5CDCLA0GlDi04kKw==
X-Received: by 2002:a05:6000:270d:b0:39c:1257:dbaa with SMTP id ffacd0b85a97d-39d14762f71mr5721161f8f.58.1744014040796;
        Mon, 07 Apr 2025 01:20:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d64dsm11537661f8f.70.2025.04.07.01.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:20:40 -0700 (PDT)
Date: Mon, 7 Apr 2025 04:20:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/19] virtio_ring: introduce virtqueue ops
Message-ID: <20250407041729-mutt-send-email-mst@kernel.org>
References: <20250324054333.1954-1-jasowang@redhat.com>
 <20250324060127.2358-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250324060127.2358-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TCh2MUV_rCaaGtBoOlotqWo5Qba4IQB6sOLpdUL-5uo_1744014041
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 24, 2025 at 02:01:21PM +0800, Jason Wang wrote:
> This patch introduces virtqueue ops which is a set of the callbacks
> that will be called for different queue layout or features. This would
> help to avoid branches for split/packed and will ease the future
> implementation like in order.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>




> ---
>  drivers/virtio/virtio_ring.c | 96 +++++++++++++++++++++++++-----------
>  1 file changed, 67 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a2884eae14d9..ce1dc90ee89d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -159,9 +159,30 @@ struct vring_virtqueue_packed {
>  	size_t event_size_in_bytes;
>  };
>  
> +struct vring_virtqueue;
> +
> +struct virtqueue_ops {
> +	int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[],
> +		   unsigned int total_sg, unsigned int out_sgs,
> +		   unsigned int in_sgs,	void *data,
> +		   void *ctx, bool premapped, gfp_t gfp);
> +	void *(*get)(struct vring_virtqueue *vq, unsigned int *len, void **ctx);
> +	bool (*kick_prepare)(struct vring_virtqueue *vq);
> +	void (*disable_cb)(struct vring_virtqueue *vq);
> +	bool (*enable_cb_delayed)(struct vring_virtqueue *vq);
> +	unsigned int (*enable_cb_prepare)(struct vring_virtqueue *vq);
> +	bool (*poll)(const struct vring_virtqueue *vq, u16 last_used_idx);
> +	void *(*detach_unused_buf)(struct vring_virtqueue *vq);
> +	bool (*more_used)(const struct vring_virtqueue *vq);
> +	int (*resize)(struct vring_virtqueue *vq, u32 num);
> +	void (*reset)(struct vring_virtqueue *vq);
> +};

I like it that it's organized but
I worry about the overhead of indirect calls here.
How about a switch statement instead?

struct vring_virtqueue {
	enum vring_virtqueue_ops ops;

}


@@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 {
      struct vring_virtqueue *vq = to_vvq(_vq);

	switch (vq->ops) {
	 VQ_PACKED:
	 VQ_SPLIT:
	 VQ_IN_ORDER:
	}


}


What do you think?



> +
>  struct vring_virtqueue {
>  	struct virtqueue vq;
>  
> +	struct virtqueue_ops *ops;
> +
>  	/* Is this a packed ring? */
>  	bool packed_ring;
>  
> @@ -1116,6 +1137,8 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
>  	return 0;
>  }
>  
> +struct virtqueue_ops split_ops;
> +
>  static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  					       struct vring_virtqueue_split *vring_split,
>  					       struct virtio_device *vdev,
> @@ -1134,6 +1157,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  		return NULL;
>  
>  	vq->packed_ring = false;
> +	vq->ops = &split_ops;
>  	vq->vq.callback = callback;
>  	vq->vq.vdev = vdev;
>  	vq->vq.name = name;
> @@ -2076,6 +2100,8 @@ static void virtqueue_reset_packed(struct vring_virtqueue *vq)
>  	virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
>  }
>  
> +struct virtqueue_ops packed_ops;
> +
>  static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
>  					       struct vring_virtqueue_packed *vring_packed,
>  					       struct virtio_device *vdev,
> @@ -2107,6 +2133,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
>  	vq->broken = false;
>  #endif
>  	vq->packed_ring = true;
> +	vq->ops = &packed_ops;
>  	vq->dma_dev = dma_dev;
>  	vq->use_dma_api = vring_use_dma_api(vdev);
>  
> @@ -2194,6 +2221,34 @@ static int virtqueue_resize_packed(struct vring_virtqueue *vq, u32 num)
>  	return -ENOMEM;
>  }
>  
> +struct virtqueue_ops split_ops = {
> +	.add = virtqueue_add_split,
> +	.get = virtqueue_get_buf_ctx_split,
> +	.kick_prepare = virtqueue_kick_prepare_split,
> +	.disable_cb = virtqueue_disable_cb_split,
> +	.enable_cb_delayed = virtqueue_enable_cb_delayed_split,
> +	.enable_cb_prepare = virtqueue_enable_cb_prepare_split,
> +	.poll = virtqueue_poll_split,
> +	.detach_unused_buf = virtqueue_detach_unused_buf_split,
> +	.more_used = more_used_split,
> +	.resize = virtqueue_resize_split,
> +	.reset = virtqueue_reset_split,
> +};
> +
> +struct virtqueue_ops packed_ops = {
> +	.add = virtqueue_add_packed,
> +	.get = virtqueue_get_buf_ctx_packed,
> +	.kick_prepare = virtqueue_kick_prepare_packed,
> +	.disable_cb = virtqueue_disable_cb_packed,
> +	.enable_cb_delayed = virtqueue_enable_cb_delayed_packed,
> +	.enable_cb_prepare = virtqueue_enable_cb_prepare_packed,
> +	.poll = virtqueue_poll_packed,
> +	.detach_unused_buf = virtqueue_detach_unused_buf_packed,
> +	.more_used = more_used_packed,
> +	.resize = virtqueue_resize_packed,
> +	.reset = virtqueue_reset_packed,
> +};
> +
>  static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
>  					 void (*recycle)(struct virtqueue *vq, void *buf))
>  {
> @@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_add_packed(vq, sgs, total_sg,
> -					out_sgs, in_sgs, data, ctx, premapped, gfp) :
> -				 virtqueue_add_split(vq, sgs, total_sg,
> -					out_sgs, in_sgs, data, ctx, premapped, gfp);
> +	return vq->ops->add(vq, sgs, total_sg,
> +			    out_sgs, in_sgs, data, ctx, premapped, gfp);
>  }
>  
>  /**
> @@ -2437,8 +2490,7 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
> -				 virtqueue_kick_prepare_split(vq);
> +	return vq->ops->kick_prepare(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
>  
> @@ -2508,8 +2560,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ctx) :
> -				 virtqueue_get_buf_ctx_split(vq, len, ctx);
> +	return vq->ops->get(vq, len, ctx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
>  
> @@ -2531,10 +2582,7 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	if (vq->packed_ring)
> -		virtqueue_disable_cb_packed(vq);
> -	else
> -		virtqueue_disable_cb_split(vq);
> +	return vq->ops->disable_cb(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>  
> @@ -2557,8 +2605,7 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
>  	if (vq->event_triggered)
>  		vq->event_triggered = false;
>  
> -	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
> -				 virtqueue_enable_cb_prepare_split(vq);
> +	return vq->ops->enable_cb_prepare(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>  
> @@ -2579,8 +2626,7 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
>  		return false;
>  
>  	virtio_mb(vq->weak_barriers);
> -	return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx) :
> -				 virtqueue_poll_split(vq, last_used_idx);
> +	return vq->ops->poll(vq, last_used_idx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
>  
> @@ -2623,8 +2669,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
>  	if (vq->event_triggered)
>  		vq->event_triggered = false;
>  
> -	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
> -				 virtqueue_enable_cb_delayed_split(vq);
> +	return vq->ops->enable_cb_delayed(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
>  
> @@ -2640,14 +2685,13 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
> -				 virtqueue_detach_unused_buf_split(vq);
> +	return vq->ops->detach_unused_buf(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
>  
>  static inline bool more_used(const struct vring_virtqueue *vq)
>  {
> -	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
> +	return vq->ops->more_used(vq);
>  }
>  
>  /**
> @@ -2785,10 +2829,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>  	if (recycle_done)
>  		recycle_done(_vq);
>  
> -	if (vq->packed_ring)
> -		err = virtqueue_resize_packed(vq, num);
> -	else
> -		err = virtqueue_resize_split(vq, num);
> +	err = vq->ops->resize(vq, num);
>  
>  	return virtqueue_enable_after_reset(_vq);
>  }
> @@ -2822,10 +2863,7 @@ int virtqueue_reset(struct virtqueue *_vq,
>  	if (recycle_done)
>  		recycle_done(_vq);
>  
> -	if (vq->packed_ring)
> -		virtqueue_reset_packed(vq);
> -	else
> -		virtqueue_reset_split(vq);
> +	vq->ops->reset(vq);
>  
>  	return virtqueue_enable_after_reset(_vq);
>  }
> -- 
> 2.42.0

