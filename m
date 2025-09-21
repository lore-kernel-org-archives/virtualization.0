Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2527280C
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758476659; cv=none; b=KoKgPzFmbYLezg1/uOrrhS0mPRe5mPMVxcWW5cPtkrg9Eet2BcTw++BeZ314rmuPOEKd99S6sJdNE5JK85JXIdoc7ltKC5Zsjpn7ZmN72Q6XBwWy3QEiVhRHmxXUl5z7TYJ1Y/mec8ohhs4KJt9az7yU2OmPE/eYCD9V08EsU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758476659; c=relaxed/simple;
	bh=LvT8oGd5u6CH/ESo2P4mkZoxFwFx3wJMIuQOb+wu7tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=I83OMK8vSYCypdGa3tzJgDmxWWQvMsacXsZbZaCcbkpByVwUBWmZlUvBQJawUzn5RA/vRi5CtPCVdyuMPp0u3gbPMuBd6L3iBioast3ZJJ79ZZgu+PTAi/l9RTg/82ci93Iqh1Ffg4zUufyJndmr6Vvs6NU7ftB3KvOrZkR0lhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dBB6NL5s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBB6NL5s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758476654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ja6bk3OZIOMP0JkRTfcKTdTZycfJVtYVqkigNFQTRI=;
	b=dBB6NL5sEB29V+hOPp5KDxnEPoAPb9572+uIc+UI7FkJTOJGDIPnNbuhI+YsBR7KVOkbjR
	qBH3yIBk48BJ1IwTRD8ZXGYTn3AMeuc4ubZV+DVlzQ/JaAuazEwZGW9c9rfY0gkvLdOVAr
	EgcLWOUyvBZfthn1Ls+qKfe42dzHElo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-9tFBeiT0N5yXSXFEnzHFsw-1; Sun, 21 Sep 2025 13:44:07 -0400
X-MC-Unique: 9tFBeiT0N5yXSXFEnzHFsw-1
X-Mimecast-MFC-AGG-ID: 9tFBeiT0N5yXSXFEnzHFsw_1758476646
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45df7e734e0so36147865e9.0
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 10:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758476646; x=1759081446;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ja6bk3OZIOMP0JkRTfcKTdTZycfJVtYVqkigNFQTRI=;
        b=q4wUNOP5pPj2v06ONmtC/PYS3lm/bw1eHkwb9Ihhj3ygfJsoNjDf3/V1axJHx6gqNJ
         rewWJOyc+Mysj03i2ZyIi7RmSIRj8Qg+aUYKg4Og2DC1Q0uH332vwqif1+lZVnyhrqJy
         LiT6vkJdKu9vc5ibfqBWykw0440i1CJmQZVOwZNyQi19UWLsoVKo7sdUNurRwvgM6YQF
         d2Idxx1GxqprSEgPJBxXmsQUjTY9cQph56LE5lnilHAz3AYaq7+g26+Z61/LnyJwmOvw
         6FCxG9xmquxFbPHbmXU+3hZbutArkZqyeMG1CB0YeElyAwtXLDJpf2BCGWEw1NL5/gNN
         fuUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyxOrOr53RTmBl0B3a/eXMDxQA0mWDEzVeAuUst2KvmCW913WHTqbpkiSNmXgjkKFrh7N2TgPoy2SEUV6/Sg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMM1bA4gtfRRh5OoBZ+VwCKzu4gN28/1PmNCe8xxzOktrvrdWy
	KeJC07tr/vwLTsT4gGVSxXSC8OzrX0SkWxjuAEggUYgEVvo8AwgC+OIuPjMg8/wThttw28kMq7C
	jGxHk6oshJ/IWpWv+Y2Nn1WLYPIro61/RG7DMJRuztAaM7PA1gyDS9GyWZuM0jZx9ouY/
X-Gm-Gg: ASbGncs1CPyODZGV8tXCoNVFJHiNrvBSvUCJCRsQEJmcYTPdVZWFidTNZLYexYokW7P
	+wVKS86rmh9GOqsXbL+p4BmFSDhkJznyOeOXlAbLqlXCN6MMRK8CYEeEU+nN3PCGcZb2XLvcr1w
	McJD789eKTvM79KB/p5mQgLbHJOJzVBwwNl2sjRKy77mirDmXtFeGdMzdWix6MY9SawD3wqUX7u
	ARbKNz8eptUUIkTN62AyrCofs4Bj6ofa37AQ2uNv6GUhn/Y88RgpwEs3GZVqNMcCWX9jhKId99e
	a6hfXNqX9fLdrmWatveZXeieY7iQP3sxZTw=
X-Received: by 2002:a05:600c:8a16:10b0:468:1a3f:c4c7 with SMTP id 5b1f17b1804b1-4681a3fc4e6mr79590205e9.24.1758476645656;
        Sun, 21 Sep 2025 10:44:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH0xEwAxiicRk6Wh8us79HfrItFjr2zQbpgO1lL0QPCnZY66TW8UA4iOeJ32MywWIrxn1K+A==
X-Received: by 2002:a05:600c:8a16:10b0:468:1a3f:c4c7 with SMTP id 5b1f17b1804b1-4681a3fc4e6mr79590085e9.24.1758476645311;
        Sun, 21 Sep 2025 10:44:05 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-467fc818e00sm128532715e9.0.2025.09.21.10.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 10:44:04 -0700 (PDT)
Date: Sun, 21 Sep 2025 13:44:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 14/19] virtio_ring: determine descriptor flags at one
 time
Message-ID: <20250921134323-mutt-send-email-mst@kernel.org>
References: <20250919073154.49278-1-jasowang@redhat.com>
 <20250919073154.49278-15-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250919073154.49278-15-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rqbm00EEzuqSsNwBpLZ8N12uVcAmsf4qWdPwluqsF_c_1758476646
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 19, 2025 at 03:31:49PM +0800, Jason Wang wrote:
> Let's determine the last descriptor by counting the number of sg. This
> would be consistent with packed virtqueue implementation and ease the
> future in-order implementation.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 1045c553ee65..0949675a3d12 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -574,7 +574,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	struct vring_desc_extra *extra;
>  	struct scatterlist *sg;
>  	struct vring_desc *desc;
> -	unsigned int i, n, avail, descs_used, prev, err_idx;
> +	unsigned int i, n, avail, descs_used, err_idx, c = 0;
>  	int head;
>  	bool indirect;
>  
> @@ -631,6 +631,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	}
>  
>  	for (n = 0; n < out_sgs; n++) {
> +		sg = sgs[n];
>  		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
>  			dma_addr_t addr;
>  			u32 len;

How does this make any sense?

> @@ -638,12 +639,12 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr, &len, premapped))
>  				goto unmap_release;
>  
> -			prev = i;
>  			/* Note that we trust indirect descriptor
>  			 * table since it use stream DMA mapping.
>  			 */
>  			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
> -						     VRING_DESC_F_NEXT,
> +						     ++c == total_sg ?
> +						     0 : VRING_DESC_F_NEXT,
>  						     premapped);
>  		}
>  	}
> @@ -655,21 +656,15 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
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
> +			i = virtqueue_add_desc_split(vq, desc, extra,
> +				i, addr, len,
> +				(++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
> +				VRING_DESC_F_WRITE, premapped);
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

