Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0ED1F8AC5
	for <virtualization@lists.linux.dev>; Wed,  8 Jan 2025 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336136; cv=none; b=jtCY6dlG8IHOLKv9a9Ja+55hFKPTYyb5YaCZ9JoV4sj4Hg6sPOHa6xb2gCLiyuytypeDtP06fi7qhC1n45UuSo7Rl36x4VGbnlodvG8ELXcX8cxTKwcfBE04/5N0AWmo5GL0ZXMJ/4ZwEdMakmT554Vku6yCugjzKqG85Kui3e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336136; c=relaxed/simple;
	bh=U0y7FwcwyD44HJYQrcVy1dEqp8zW7hw0F2XTaKo2RxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UFl0oahL7tf6QnD7rSGQwDRmWUDLarQnoQuzkONnukBBH/4WL7XuT1PdWZyzKRbTFjqBxK/wE34yUq1AaC1kGR4DNjRhltYGwRP4wB/M5ckIYRlUqstzl/fwTbfKmzCyitCg5f83RUqKRyFDWTuJfEfYpaoDZ2+a6QFtRScr3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzPlvj1s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzPlvj1s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736336125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+XOF/Yu0g2fsX7t9xPysH0JaEinWV6AydJhgfHcaq0=;
	b=YzPlvj1s+RCEeOuWI3HNwRE8+Ro9iQJvWZXr/c39o9j07SNeFpwVbHTh5eTobPbsoIpSF5
	ij+ccWDYwLK5LJzggRH0CYhNyNQ+yefO1btQ+ykaYEzHULNRi+PbYaLlKf470EMKlDwAoA
	2DIz0ErYainBXEmWx2oT7b/sR/n3lHo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-txlkZ8sRMb-bU4kS46CylQ-1; Wed, 08 Jan 2025 06:35:24 -0500
X-MC-Unique: txlkZ8sRMb-bU4kS46CylQ-1
X-Mimecast-MFC-AGG-ID: txlkZ8sRMb-bU4kS46CylQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so120427765e9.3
        for <virtualization@lists.linux.dev>; Wed, 08 Jan 2025 03:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736336122; x=1736940922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+XOF/Yu0g2fsX7t9xPysH0JaEinWV6AydJhgfHcaq0=;
        b=D4+iOYKMwEBlcd+ne3TT83qF+5Gx7JH4/pGR0o6JL9z4Hl/PflIxQEWYKcEFqIZg6Y
         qdOJdJ85XufmVY60lsemWRfjxTxEcYvrqaFmLAKRFveSHu7zp8gTW97ZpHs4ZxqgbCfS
         OLiUr4ySw5myAfblU23QbYs9PK9hpE/mEhhQTJNt0rFI7APgtQZAbfUGUzOvSO9UOCnr
         rrBLpz7/I6H1C0pIuy23wCnfvT7qcVRzTYYe1VgiuoWdCBeOxlLMo98blGendPIuntbX
         Q2Sb6d50RtB6KvqMHBu5NCBO1jT3iW7Rr4d571ByYIq1dv1HYRkIl00HBhJy9pxhfSqo
         RgAA==
X-Forwarded-Encrypted: i=1; AJvYcCULxaNhTefhMJwxW3N8xn4HR4Uc6fvxYqDyr5gxySnWIS6i1ffO4y573iUYN2RYQIz89OwYSWDg3CQznQPgCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUnsfZyG1OsKaYpcfmXv2ME2JNrI/Ca19cQEEHn4fzZwnohWeZ
	CviWANJJKewRmkkLIVqEQVodxl16DrAr+r9zTOfqNQbEqc0iEK64ZPLPkngeczlQKQl0pUcyDOY
	6aQ4jjvri1QbVNUi+7QznF2eEux9OCzDu4Jjwybr3LYNNSazPKoCF4x/IQE5s6KegLay4tiLT
X-Gm-Gg: ASbGncv9jT2RkZZeEFBVA9Xp320nrPIGjpxe5cAxUsOk/uSTBE/HO9Dprk5P2C8HHo2
	hyFFfdJ+JYv95B0Pviqdozgu2rgRkWTRdVYHcqroZk7xZQ6YWUmLO4ryIt0TbnIUCe2y6F0Pdh7
	u7EcVCjGB0x6oKDJ4YQXLIWqfbIIOVdYqeUsbszyIhWlK6xE+r4joA2y6P4QN6WMBE/qaCHAHQC
	NDU+6ibV3uthcs3JfwWJsaYSnOYBE08TJivChnru+RKQE5ES6E=
X-Received: by 2002:a5d:6da4:0:b0:386:3356:f3ac with SMTP id ffacd0b85a97d-38a8730cf2cmr2072562f8f.26.1736336122484;
        Wed, 08 Jan 2025 03:35:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSxEwNeaWY0iq88jJcFtUsYY7LdG5hvMnzg7jF1DNAqRGfd3L2Ij4vGfuJoUWTe6dQ/ngDfw==
X-Received: by 2002:a5d:6da4:0:b0:386:3356:f3ac with SMTP id ffacd0b85a97d-38a8730cf2cmr2072534f8f.26.1736336122037;
        Wed, 08 Jan 2025 03:35:22 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc12dasm17964855e9.10.2025.01.08.03.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 03:35:21 -0800 (PST)
Date: Wed, 8 Jan 2025 06:35:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: skip cpu sync when mapping fails
Message-ID: <20250108063310-mutt-send-email-mst@kernel.org>
References: <20241111025538.2837-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241111025538.2837-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vsO8QZiR8pErhbsm1CHGxA-z_9v9_eOPTBbYaDuhOUY_1736336123
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 11, 2024 at 10:55:38AM +0800, Jason Wang wrote:
> There's no need to sync DMA for CPU on mapping errors. So this patch
> skips the CPU sync in the error handling path of DMA mapping.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


So as I said, I do not get why we are optimizing error paths.
The commit log at least needs to be improved to document
the motivation.




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


If you really feel we must do it, just pass attrs directly so
we do not get an extra branch. Also makes for a more readable code.

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

