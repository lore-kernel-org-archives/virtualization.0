Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1041397
	for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766777614; cv=none; b=uSkM16AzMU0Ok91VVOgwK6WVptHVjwGmRJnLQzaR6WVMzNm1qoedz60zVxHkewP0ZibZ6gpmDnEGxZTeV8YZfaTJBfJv/23oESiByL60JqCFLaQk9yD9sTJDbsjLNmNdtrwles2uMzOJxBkQ0i6ymkOQN8LZwPMOsInYUNqqPNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766777614; c=relaxed/simple;
	bh=5fVnAIeZHthLRORMu0oztvCUwm7xHuaXIFzj7J4LDu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=adB3B9/IyEDuQ/yxpJ95C9lmvV0XpEVfhTemqzp6GgKoSHXkv6AjFpiWaf4e2gNI2SfKokmwCRapHNn0rVLVyuWYcURHDSrlzuXU8FCiM8tpCSQW7s3jTyqkj+3FTaTKE3fkZuTnHFQ683cjK7oMJ8LGg7rOsXQAdBwtY0sHJyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YxFV6mTZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxFV6mTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766777611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZflj0ypuZMjd4aOAPAMll6XFz/uRsOFnhPNAPsy618=;
	b=YxFV6mTZ6skxwvhSOBO9VIjPgnDzliLLgzGK8bvtP7tWRJupxWz5RHcgUkk2OBEcXUqB9B
	O6QZfk+tl5H/U1+P48TiWCpJgOc7BzwTk8XUOzAVbyKuk2EHMbkAPuAocAx8pj3gZnAbcn
	l5qNpVbcubHh5bNeu6j7YAmMjQgXQOQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-PrEnVQ-HMhC8pd0l7YxJ_A-1; Fri, 26 Dec 2025 14:33:30 -0500
X-MC-Unique: PrEnVQ-HMhC8pd0l7YxJ_A-1
X-Mimecast-MFC-AGG-ID: PrEnVQ-HMhC8pd0l7YxJ_A_1766777609
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d3ffa98fcso12708275e9.3
        for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 11:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766777609; x=1767382409;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZflj0ypuZMjd4aOAPAMll6XFz/uRsOFnhPNAPsy618=;
        b=l6G1Dmk3taOoj0LuXabJiFVf5VkdIVzMe031pl/ntQvMDBJY26JwKwhccwe9G7odsn
         WP9oYvcFun6r/hpN1IDKNZlCfnFORncqlOZQXkvmPCPwKjYEoTzaf1Z4dvko8UW5a2QH
         iBQP5d/evu8c6QKQrj4wR7O+2pcBACWmslvBIBf+xLKHKeEL7SwGOpsJxUwYCJzm1Hfo
         FiklpwLEMT5R1wEJoJleZx7Riqfm0rJbGtpxJIt62hg2WOixrzuY09HSmqusi9Ghp4+Y
         +/hzo6xcFnlQjfLBoHrpcWPD5RgOmkl/H02nGrSEVUoDuGwHKg0S4I3Ckwl6OTUIDoZ0
         1uyA==
X-Forwarded-Encrypted: i=1; AJvYcCVYsON06+xsocBd2bUVBl1Xj67NoX+ZH6/WzDy95wV7tvUw/0NinTtHALSJgXUjqPyOIX3odm5GLuIrhmHE4g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzy8vqnNWsn4w8jkh8KhUDo0wj0ovXSs+jkhpiLTPI1oJPZxzig
	oUyj/5lPtK2LAxcqvadSHAlxHfE2Vgae2udx9z1mdwwUIH9plU9DeSi711GJeEL0nNa9fJ7YjR8
	ytzlF+VQInQCjZnPYd9vU/MqTetsG/CwJb/WhTa7pXzvW+c09Yg100R4efTPPq890OzaJ
X-Gm-Gg: AY/fxX5YZJdWHnyKtjURaYNLH/sGNZ/4k7SMkihCitahaJA/7ft00mkJOHKHNqccBCG
	PApUaVAzZx9UZEwptxSWYXK3uGWBOVseywkpOttjPDfC5pBzAhqTrjMJWfZqHRmUdkSI5Xb63pE
	o6qSlYX/CgfPkphnFg3SwKvhf9rZoF5OxahpFuDIYQLZC7fNjJadqLyMtG+lwkpXk+OSHwzrhyL
	zTsnDaFgLr+ydRxyN+cDWCaCiHnVitLSur8Jw/g4TBkePlr15y1ng64wVReoYMKxRfBI+uF1Svc
	EqElQlxsHXIFUYefn1TI7U1032sJ3Mj24+zt0lrzV34C3S8hesLZtJHl8LwWgvkz3FXsKEadvVo
	bLV+vp5YFHOHSp/XFgNCBdjFAgBRmiZwL4g==
X-Received: by 2002:a05:600c:8719:b0:471:114e:5894 with SMTP id 5b1f17b1804b1-47d1958575amr247219695e9.25.1766777609106;
        Fri, 26 Dec 2025 11:33:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBZx0PZwJpXdtLqCjfrlLsx3P1IV5TV8i8HHRefbTs7XqxfTkvlvX2rgTd7fN9hlHElI6fGA==
X-Received: by 2002:a05:600c:8719:b0:471:114e:5894 with SMTP id 5b1f17b1804b1-47d1958575amr247219525e9.25.1766777608688;
        Fri, 26 Dec 2025 11:33:28 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm460396025e9.13.2025.12.26.11.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 11:33:28 -0800 (PST)
Date: Fri, 26 Dec 2025 14:33:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V11 14/19] virtio_ring: determine descriptor flags at one
 time
Message-ID: <20251226143309-mutt-send-email-mst@kernel.org>
References: <20251225042608.32350-1-jasowang@redhat.com>
 <20251225042608.32350-15-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251225042608.32350-15-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0tQH4B_gPp-3dgi_PcmkOTMjP54OR_RjtHoEkg8ZfMA_1766777609
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 25, 2025 at 12:26:03PM +0800, Jason Wang wrote:
> Let's determine the last descriptor by counting the number of sg. This
> would be consistent with packed virtqueue implementation and ease the
> future in-order implementation.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 4e905dc7b6cb..dbcd6f26df7d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -575,7 +575,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	struct vring_desc_extra *extra;
>  	struct scatterlist *sg;
>  	struct vring_desc *desc;
> -	unsigned int i, n, avail, descs_used, prev, err_idx;
> +	unsigned int i, n, avail, descs_used, err_idx, sg_count = 0;
>  	int head;
>  	bool indirect;
>  
> @@ -635,42 +635,40 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
>  			dma_addr_t addr;
>  			u32 len;
> +			u16 flags = 0;
> +
> +			if (++sg_count != total_sg)
> +				flags |= VRING_DESC_F_NEXT;
>  
>  			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr, &len, premapped))
>  				goto unmap_release;
>  
> -			prev = i;
>  			/* Note that we trust indirect descriptor
>  			 * table since it use stream DMA mapping.
>  			 */
> -			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
> -						     VRING_DESC_F_NEXT,
> -						     premapped);
> +			i = virtqueue_add_desc_split(vq, desc, extra, i, addr,
> +						     len, flags ,premapped);

coding style violation.

>  		}
>  	}
>  	for (; n < (out_sgs + in_sgs); n++) {
>  		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
>  			dma_addr_t addr;
>  			u32 len;
> +			u16 flags = VRING_DESC_F_WRITE;
> +
> +			if (++sg_count != total_sg)
> +				flags |= VRING_DESC_F_NEXT;
>  
>  			if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr, &len, premapped))
>  				goto unmap_release;
>  
> -			prev = i;
>  			/* Note that we trust indirect descriptor
>  			 * table since it use stream DMA mapping.
>  			 */
> -			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
> -						     VRING_DESC_F_NEXT |
> -						     VRING_DESC_F_WRITE,
> -						     premapped);
> +			i = virtqueue_add_desc_split(vq, desc, extra, i, addr,
> +						     len, flags, premapped);
>  		}
>  	}
> -	/* Last one doesn't continue. */
> -	desc[prev].flags &= cpu_to_virtio16(vq->vq.vdev, ~VRING_DESC_F_NEXT);
> -	if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
> -		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
> -			~VRING_DESC_F_NEXT;
>  
>  	if (indirect) {
>  		/* Now that the indirect table is filled in, map it. */
> -- 
> 2.31.1

