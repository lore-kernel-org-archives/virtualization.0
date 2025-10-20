Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F186D20D4E9
	for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973506; cv=none; b=ug3pQ1fbygmIsbqz0zCNeGIdH6E8XVXemu/6saXadk5QXyhYQlHRs5w7ByrA3Al6IadUTtWbthQASqzQcIHGSNa5mqVJzL35xrVgF52FWYQKOkOo1PQKsmNXQ7G9H3zhYUhg4FTk0FsoeuSNGsADFKTjIReHGupvKyFyPFWVwFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973506; c=relaxed/simple;
	bh=vxeZU8BIk7yt5+gefMlL/GNoEVo0y7v8NbR4bXP2d6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BHvbH6YEyz6MzCezHCQrerCmuvgiENRLzof/iwq5q535/nZt0wfdpor2qYNxtfhEPcF0liciMnGspKNzlrCNcd5dpk603RPmvCRCTCuGlLp1lb68cVm0+OHpW5wu0XyIFaqdwqL25qY4eveYJH1+ujd5oaWj45nLcMOEiHvOmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KoDFrd9Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoDFrd9Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760973503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=376JEJXXuhTvk7uwIbwEp0J9xIBggDxY0JbNoKssPdI=;
	b=KoDFrd9QUP/1boARnYyV7LWBjD+sJIP0va6QqQ+rtR1Dq9ulCgOfX2RtUmRZ/em4jTPn4M
	hsX1eFF6IR6UWvBtiNBmpZLHpciLJgVF4ujA3dMcPOn1XrxnKeOK1RRomULKpm5CvUpjTL
	uJzC3AfzPvAu5IoJCY9kEzt6LEr6Mc4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-5wlMBGVeM6uEAj3BTdYLOQ-1; Mon, 20 Oct 2025 11:18:22 -0400
X-MC-Unique: 5wlMBGVeM6uEAj3BTdYLOQ-1
X-Mimecast-MFC-AGG-ID: 5wlMBGVeM6uEAj3BTdYLOQ_1760973501
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47106a388cfso20124395e9.0
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 08:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760973501; x=1761578301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=376JEJXXuhTvk7uwIbwEp0J9xIBggDxY0JbNoKssPdI=;
        b=fl0vGQoypLHv9RpugvHwDfmTVPhru5Kx1xsrn7WcCSqzIbNPEz3wlkQodwDiAomzBo
         Xqot2nUahiD5xbWBKWjCWi2sNVAnQh9xwqQggy+CuqzKPEFy2yGCHyXX+ts0TfiZKgfO
         H10iVAHlKonuK9aTAtjGxC2PrW9Qobm+2DjGnmmZRi02RiFGn5AKVKEHhIkk2htzlvc5
         EIIy82qttWjN0Aiukv6N49pLlvZEVu0hRK06SkDPEJ0VZ5TvpTCUh7bQJottRrZkzKZJ
         wp2lF6lawa7Gid4FwTjhJl5nf9Q68UORE7tIORmEi8lEDtzjwXe1HqHBZAEfgxxr2ABc
         nOMg==
X-Forwarded-Encrypted: i=1; AJvYcCVviPrs0EX/necN7BVNCzDW4+/405zzY2QF7S56O0X9lrheUL5eOsNEG1tQH8nH9E+80M/GhfBM53Mo47n+aw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywb+KZrpZry4LoAqCD6vJlvwe2SU9JmcdLbYTjzNZ1jPAfjWjpx
	1urQvgfU+/N4s7AtwbnE2JCX9FVVnAiaR3oXyCCwuKqHsCAjOwg5WA/29+j37S97psJNJTspmtk
	ubcn7NdwzJtX9UKTW+H8fIgBuNA+JrtYi0+ABjDqRgZgNlZkKDqWS9U7nWeG/xtPHXDBq
X-Gm-Gg: ASbGncuFHTtFgBtiPS9kX2Goy9HYxi8va5HvhToLmKf3cG/VtbBbFX8U/BSIkEROz1Z
	bCsKT8kwujKanIxRusondzKTKWYyxpvx54OAl6RdvZkhJOM7xvsd2c922LkeDC9wLfCuAFHD4o0
	hulgB3qsAzkHM7oazxZbtZrm+tG/zO9y7/72w955urr/ZdyMwtwuBA3ypaOrAS6evGEdCAHOdWD
	dlQhz8R5sTsftl8+ugYwTpkUnH7g/KCobU1Fio/CREsQ/JQVeGBWGQx0NHJB+GPiyEdal5rO0Cm
	unb+INSezySDhkJT/015oUvRq5aD88gIUY0lg4UUoBBe8Dzxws6wA8ej1HiQgof+VnHn
X-Received: by 2002:a05:600c:3f08:b0:470:ffd1:782d with SMTP id 5b1f17b1804b1-47117876a19mr111618945e9.6.1760973501154;
        Mon, 20 Oct 2025 08:18:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETLd9da+Ou77Y8StkQ2q014OfnaoUD42+rUXfxhJ8RF6vKnDc5lJ9/jBhXf+wCuZ6ndVoZBw==
X-Received: by 2002:a05:600c:3f08:b0:470:ffd1:782d with SMTP id 5b1f17b1804b1-47117876a19mr111618715e9.6.1760973500619;
        Mon, 20 Oct 2025 08:18:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471553f8a3asm174428685e9.16.2025.10.20.08.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:18:20 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:18:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 14/19] virtio_ring: determine descriptor flags at one
 time
Message-ID: <20251020110341-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-15-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251020071003.28834-15-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1vOPBQf8EQMpbUg20mCOEP87Tv6p_nnmAOqByMXsgGk_1760973501
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Oct 20, 2025 at 03:09:58PM +0800, Jason Wang wrote:
> Let's determine the last descriptor by counting the number of sg. This
> would be consistent with packed virtqueue implementation and ease the
> future in-order implementation.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 37b16ef906a4..20bc48b1241e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -575,7 +575,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	struct vring_desc_extra *extra;
>  	struct scatterlist *sg;
>  	struct vring_desc *desc;
> -	unsigned int i, n, avail, descs_used, prev, err_idx;
> +	unsigned int i, n, avail, descs_used, err_idx, c = 0;
>  	int head;
>  	bool indirect;
>  

c is not a great variable name. Maybe sg_count?

same in patch 19 actually.


> @@ -639,12 +639,11 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr, &len, premapped))
>  				goto unmap_release;
>  
> -			prev = i;
>  			/* Note that we trust indirect descriptor
>  			 * table since it use stream DMA mapping.
>  			 */
>  			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
> -						     VRING_DESC_F_NEXT,
> +						     ++c == total_sg ? 0 : VRING_DESC_F_NEXT,
>  						     premapped);
>  		}
>  	}
> @@ -656,21 +655,15 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
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

this continuation line should be indented more,
and maybe premapped on a line by itself.
Alternatively use a variable for flags.

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

