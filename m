Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BED0E545
	for <virtualization@lists.linux.dev>; Mon, 11 Nov 2024 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731310227; cv=none; b=jLO6mxwIU7YufyPkNbrTF4n/XSqWWS81LbZmoBlDSVcymVBJEkPggzQ07OrYczKYRRUAX5i1syh1eB5dNhG1jwEAhfM8NcMeLaORgLITKazmMqjyB1p+KFvs6vJbj+r5EoN5KR/WXE4ZJnzCjjMdaSnE0RRm2uJd6KZTt3TdvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731310227; c=relaxed/simple;
	bh=y7m+qe/6Hk9OqmIwKPFA2Ws457l9mrlbLZfBIIaqhx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kbkXuvIfZXS34lR1K9YetSTQeeqOj++VVy52JNjQI80auIq1GI/SVKOXkMRSsfUEimYhl/9l/dplrSwhdCP6AgOkGtRGnDoia7VEXNgEKmoB3ncNinGHdFcuXKxOZBA8GVVwPpoz3ps0H0DVwHppnM+gOGx2OJBGj5SO+JzQHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQM9QBYB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQM9QBYB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731310224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YXJTAPJRJSE40v52va9xJnnCxZQQit5rD5JjIYG43lo=;
	b=WQM9QBYBIUdZWainUdzyGyLjAb5J0OCD4y/o3zdjJaGxNFRzesD4DCxtcOhQO6vkAWM6qe
	WOLR9W1nTGp+2sMrQDQr1Hvo1aM+9Mm6CfXgMgxfzavh9f4T2csQV7Y4xQWCUKDAjX2NaZ
	zKRMvEzeLX8idihLpmSyy3zHnMaJ2vs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-ZZtFY4gxNtS6ToKRvM87vg-1; Mon, 11 Nov 2024 02:30:22 -0500
X-MC-Unique: ZZtFY4gxNtS6ToKRvM87vg-1
X-Mimecast-MFC-AGG-ID: ZZtFY4gxNtS6ToKRvM87vg
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-539fe4e75c4so3549974e87.0
        for <virtualization@lists.linux.dev>; Sun, 10 Nov 2024 23:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731310221; x=1731915021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXJTAPJRJSE40v52va9xJnnCxZQQit5rD5JjIYG43lo=;
        b=aeyqTuYIyJZul4gi4ocfOLfbsO5eWbGW7H3a7Zu+pFDOQsgua5K0aE5srfvOGg324i
         tuhufpNt5LyDMpunv3lOSG/ix6Bg0T7gi8M02pGi9mhAcWNXg8TRZ1Och2NJcR6FJrrl
         LJid5hX6oXhBlpPVF6jLHSPVARybVhWVlzym3paxM5XzD8JgWTM1xb0lpHIM9WFYi1Jk
         mFYe9njGV4VHOvQq6l0d6j0Ct90Q5A31hy3PWhkgEFcavy6EBp7U5AelYwxiVjXcTHbF
         FBSi7XECOHamQVDbdEMF2/noNBNi2njJihg/6MdSPcoqlXpAdwP9kTbVuZxJbsn1zByf
         mwPA==
X-Forwarded-Encrypted: i=1; AJvYcCU4tux8VhoJ2eaPzmZZEpYMkdbbjibggLtfdSr3d3ZuCn5IGWZMU+2gQkIpSYYWPLHaL2TZw6x+ncSvr7fFdQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzB/ghUnvZ3Y4nzBN0MiCDFP2T28D2NIvfIZXa8aHvKQwdvhq5d
	it73WIedGB05RQb+YfhVdsJ8cvsEVlEHmJySyiIupKeg5+AeSzIrDyZQ1+DgtHUgPJ+inbDdWxc
	oc/by600XNjUc9cCZ9TKF53YLrADPXm4+ACcvtsvctahViV/5jVuDnczZPw4XZi55k6+wo3MRGH
	0=
X-Received: by 2002:a05:6512:1108:b0:539:89a8:600f with SMTP id 2adb3069b0e04-53d862c7292mr7325557e87.23.1731310220804;
        Sun, 10 Nov 2024 23:30:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbA8GHrAoHhI8IG5qB5I52hrPURR4gyZorTCm5EgyxcOpYDfczigvh0oECQWwPpX6q7xCCzw==
X-Received: by 2002:a05:6512:1108:b0:539:89a8:600f with SMTP id 2adb3069b0e04-53d862c7292mr7325532e87.23.1731310220304;
        Sun, 10 Nov 2024 23:30:20 -0800 (PST)
Received: from redhat.com ([2.52.135.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a176d6sm564756866b.13.2024.11.10.23.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 23:30:19 -0800 (PST)
Date: Mon, 11 Nov 2024 02:30:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: skip cpu sync when mapping fails
Message-ID: <20241111022931-mutt-send-email-mst@kernel.org>
References: <20241111025538.2837-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241111025538.2837-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rZK8Xh2AAd4mhLSbj7FAxgLqDg9NTOMMlgMupgVTc98_1731310221
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 11, 2024 at 10:55:38AM +0800, Jason Wang wrote:
> There's no need to sync DMA for CPU on mapping errors. So this patch
> skips the CPU sync in the error handling path of DMA mapping.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

DMA sync is idempotent.
Extra work for slow path.  Why do we bother?

> ---
>  drivers/virtio/virtio_ring.c | 98 +++++++++++++++++++++---------------
>  1 file changed, 57 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index be7309b1e860..b422b5fb22db 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -441,8 +441,10 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
>   */
>  
>  static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
> -					   const struct vring_desc *desc)
> +					   const struct vring_desc *desc,
> +					   bool skip_sync)
>  {
> +	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
>  	u16 flags;
>  
>  	if (!vq->do_unmap)
> @@ -450,16 +452,18 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
>  
>  	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
>  
> -	dma_unmap_page(vring_dma_dev(vq),
> -		       virtio64_to_cpu(vq->vq.vdev, desc->addr),
> -		       virtio32_to_cpu(vq->vq.vdev, desc->len),
> -		       (flags & VRING_DESC_F_WRITE) ?
> -		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +	dma_unmap_page_attrs(vring_dma_dev(vq),
> +			     virtio64_to_cpu(vq->vq.vdev, desc->addr),
> +			     virtio32_to_cpu(vq->vq.vdev, desc->len),
> +			     (flags & VRING_DESC_F_WRITE) ?
> +			     DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +			     attrs);
>  }
>  
>  static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
> -					  unsigned int i)
> +					  unsigned int i, bool skip_sync)
>  {
> +	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
>  	struct vring_desc_extra *extra = vq->split.desc_extra;
>  	u16 flags;
>  
> @@ -469,20 +473,22 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
>  		if (!vq->use_dma_api)
>  			goto out;
>  
> -		dma_unmap_single(vring_dma_dev(vq),
> -				 extra[i].addr,
> -				 extra[i].len,
> -				 (flags & VRING_DESC_F_WRITE) ?
> -				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +		dma_unmap_single_attrs(vring_dma_dev(vq),
> +				       extra[i].addr,
> +				       extra[i].len,
> +				       (flags & VRING_DESC_F_WRITE) ?
> +				       DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +				       attrs);
>  	} else {
>  		if (!vq->do_unmap)
>  			goto out;
>  
> -		dma_unmap_page(vring_dma_dev(vq),
> -			       extra[i].addr,
> -			       extra[i].len,
> -			       (flags & VRING_DESC_F_WRITE) ?
> -			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +		dma_unmap_page_attrs(vring_dma_dev(vq),
> +				     extra[i].addr,
> +				     extra[i].len,
> +				     (flags & VRING_DESC_F_WRITE) ?
> +				     DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +				     attrs);
>  	}
>  
>  out:
> @@ -717,10 +723,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  		if (i == err_idx)
>  			break;
>  		if (indirect) {
> -			vring_unmap_one_split_indirect(vq, &desc[i]);
> +			vring_unmap_one_split_indirect(vq, &desc[i], true);
>  			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
>  		} else
> -			i = vring_unmap_one_split(vq, i);
> +			i = vring_unmap_one_split(vq, i, true);
>  	}
>  
>  free_indirect:
> @@ -775,12 +781,12 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	i = head;
>  
>  	while (vq->split.vring.desc[i].flags & nextflag) {
> -		vring_unmap_one_split(vq, i);
> +		vring_unmap_one_split(vq, i, false);
>  		i = vq->split.desc_extra[i].next;
>  		vq->vq.num_free++;
>  	}
>  
> -	vring_unmap_one_split(vq, i);
> +	vring_unmap_one_split(vq, i, false);
>  	vq->split.desc_extra[i].next = vq->free_head;
>  	vq->free_head = head;
>  
> @@ -804,7 +810,8 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  
>  		if (vq->do_unmap) {
>  			for (j = 0; j < len / sizeof(struct vring_desc); j++)
> -				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
> +				vring_unmap_one_split_indirect(vq,
> +							&indir_desc[j], false);
>  		}
>  
>  		kfree(indir_desc);
> @@ -1221,8 +1228,10 @@ static u16 packed_last_used(u16 last_used_idx)
>  }
>  
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> -				     const struct vring_desc_extra *extra)
> +				     const struct vring_desc_extra *extra,
> +				     bool skip_sync)
>  {
> +	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
>  	u16 flags;
>  
>  	flags = extra->flags;
> @@ -1231,24 +1240,28 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>  		if (!vq->use_dma_api)
>  			return;
>  
> -		dma_unmap_single(vring_dma_dev(vq),
> -				 extra->addr, extra->len,
> -				 (flags & VRING_DESC_F_WRITE) ?
> -				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +		dma_unmap_single_attrs(vring_dma_dev(vq),
> +				       extra->addr, extra->len,
> +				       (flags & VRING_DESC_F_WRITE) ?
> +				       DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +				       attrs);
>  	} else {
>  		if (!vq->do_unmap)
>  			return;
>  
> -		dma_unmap_page(vring_dma_dev(vq),
> -			       extra->addr, extra->len,
> -			       (flags & VRING_DESC_F_WRITE) ?
> -			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +		dma_unmap_page_attrs(vring_dma_dev(vq),
> +				     extra->addr, extra->len,
> +				     (flags & VRING_DESC_F_WRITE) ?
> +				     DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +				     attrs);
>  	}
>  }
>  
>  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
> -				    const struct vring_packed_desc *desc)
> +				    const struct vring_packed_desc *desc,
> +				    bool skip_sync)
>  {
> +	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
>  	u16 flags;
>  
>  	if (!vq->do_unmap)
> @@ -1256,11 +1269,12 @@ static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
>  
>  	flags = le16_to_cpu(desc->flags);
>  
> -	dma_unmap_page(vring_dma_dev(vq),
> -		       le64_to_cpu(desc->addr),
> -		       le32_to_cpu(desc->len),
> -		       (flags & VRING_DESC_F_WRITE) ?
> -		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +	dma_unmap_page_attrs(vring_dma_dev(vq),
> +			     le64_to_cpu(desc->addr),
> +			     le32_to_cpu(desc->len),
> +			     (flags & VRING_DESC_F_WRITE) ?
> +			     DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +			     attrs);
>  }
>  
>  static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
> @@ -1389,7 +1403,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	err_idx = i;
>  
>  	for (i = 0; i < err_idx; i++)
> -		vring_unmap_desc_packed(vq, &desc[i]);
> +		vring_unmap_desc_packed(vq, &desc[i], true);
>  
>  free_desc:
>  	kfree(desc);
> @@ -1539,7 +1553,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	for (n = 0; n < total_sg; n++) {
>  		if (i == err_idx)
>  			break;
> -		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
> +		vring_unmap_extra_packed(vq,
> +					 &vq->packed.desc_extra[curr], true);
>  		curr = vq->packed.desc_extra[curr].next;
>  		i++;
>  		if (i >= vq->packed.vring.num)
> @@ -1619,7 +1634,8 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  		curr = id;
>  		for (i = 0; i < state->num; i++) {
>  			vring_unmap_extra_packed(vq,
> -						 &vq->packed.desc_extra[curr]);
> +						 &vq->packed.desc_extra[curr],
> +						 false);
>  			curr = vq->packed.desc_extra[curr].next;
>  		}
>  	}
> @@ -1636,7 +1652,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  			len = vq->packed.desc_extra[id].len;
>  			for (i = 0; i < len / sizeof(struct vring_packed_desc);
>  					i++)
> -				vring_unmap_desc_packed(vq, &desc[i]);
> +				vring_unmap_desc_packed(vq, &desc[i], false);
>  		}
>  		kfree(desc);
>  		state->indir_desc = NULL;
> -- 
> 2.31.1

