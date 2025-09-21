Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAC9137C52
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758480007; cv=none; b=USLOAE5juYVi1EUCOmzdSxrlcZXDIFGK2qGivc3Jpf2LswMg7IXX5rq+fHEo5O2z9/wpj8k0ORMOAg2DDX3hV/iwXuYm8A4malG7bZQER9VnULQVM/1uP1DlzN7qndqAL8c6P7h5b+o63+4+uXx5Nh8ApAdCmaFw0v1UZLbujhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758480007; c=relaxed/simple;
	bh=N2URmMcqqSL9E+49wAyf/0otiSSQtKZ5dw8twXpZWps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mrQLKhyQhrCxMC2Yvqep+nSOsnN5pXVq9A4KKibiu4DVV9apapVfv1tLTXlixiTVudDQKFjXGdn/M/kcPex1vmGj/+TslWHuRS66GXj4lEV/WSRwNe2BUpfIJaKN02su02v2iyvVOR0fT3GrffTaUQo22pOdXW0ooKGA0LPrejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hI5Nmh/B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hI5Nmh/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758480004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJXH+iEnGEt26c26vQRT9hIQ+xfb73XIUiLB79dbIag=;
	b=hI5Nmh/BYok5oiaARdlijDhluvohHsxinZwvTMft3zf2i/k+piTvyDozg/zDPhUKJIVrNO
	yOOQ0i1FTR8yF/fycJO8u5B31ymJ5r5e/8csQzuzwsHJhgtGzp/Dyx7iQTruK0v+WL3LzZ
	QoGsJLtGjI1EJUYkAA8j3ZQdoTGEeKA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-HNrAqKuLME-Vl7Y3ehqHTQ-1; Sun, 21 Sep 2025 14:39:57 -0400
X-MC-Unique: HNrAqKuLME-Vl7Y3ehqHTQ-1
X-Mimecast-MFC-AGG-ID: HNrAqKuLME-Vl7Y3ehqHTQ_1758479996
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45f28552927so28716825e9.2
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 11:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758479996; x=1759084796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJXH+iEnGEt26c26vQRT9hIQ+xfb73XIUiLB79dbIag=;
        b=D7RONuQIlCm520hEnS4RjVTiWzzpyR0Irlz/7gotQSRiQ0RBSzwEO4a/5BS4oFz9k+
         LI9WkuCwpRnKW5brX/0gyDBAf+NTmNgjyXzRdRDeWts6ib++eIDfgxZIGoAo+tJ+k0HD
         2Z41HAmC/N5shzUbmdtycnurbAL5Cx/bjGyirZHaTqXTVFdFJruUgyn8frUUuVkWIXxy
         oKlcbt3YL2uy5V2E1HgkvgX7QI5LmDrJBTESNqAz6RESZA+2EwCcbhrZZkwqMvEfwCo+
         ZBw5AN8wh6vDXt9pl2HrMcy8ra7OrH8QP+EUdJ8Ov+nZycLMK6z1EY0K/lY6vJMw0l/l
         kYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5KaQzFotVmXl+dXGNox3JeBhLJsmMMKLlVhksoNIjdEc81Ka+j6LwsPSrPhTL5d2plr//xQh7pbg73LiUIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVttf8Wxs1GDyv8+jSWqlefAutbbbd91fU9BOBk5fi2UYp4hW6
	yhMl+DCLV2kJU1GdmbeISxU/MwWNd7c+mVm8lyr8uH7NytokOtc2WqmQOB9lzuhID1Fd4DiH8yM
	XyrxHDlZqtPxce/l0+dFm5x9YA18DGKFw5nWINEV3YKMQMnFt6YdMlPIHMoo6X3XpsAD2
X-Gm-Gg: ASbGnctU9BlCeoL8UztnTpmCttl2HhJjX0v+6zAWl122k+oqRHCPueMb0OcR4mR9Xff
	GoRnU2XAkN2w8IVjXRWOjBvtJQx57ZYILoMhLgNLOf7RFyUIMnw1h+j08GnVXfucY+3iTH0/bzb
	ZibbBXkTksRBeXunFaunb0Hd95QzndSZiDX/Y1xC59akBvkb1WleNJhTB2KSJpwkvFDejQmzgAg
	6Q43doF216UYNygIrqO3nUnbcryvJAQEJ0Z+b/p3pZzq4Dnjtb2xZT9Q3qxhugCCaZaXtBNyM0U
	yptWjSXCltZXKVQs92YXbhF2CFftgxPXMlo=
X-Received: by 2002:a05:600c:4f42:b0:468:7a5a:725 with SMTP id 5b1f17b1804b1-4687a5a0801mr95488185e9.1.1758479995821;
        Sun, 21 Sep 2025 11:39:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1CBCIW++Ueg7vKc5VsvYUAu+SHw7b8hKtcbIM6zE006kbvlAaeQ1o+vByx1lH4SuXnMbMJQ==
X-Received: by 2002:a05:600c:4f42:b0:468:7a5a:725 with SMTP id 5b1f17b1804b1-4687a5a0801mr95488085e9.1.1758479995417;
        Sun, 21 Sep 2025 11:39:55 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32640f49sm117008595e9.9.2025.09.21.11.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 11:39:54 -0700 (PDT)
Date: Sun, 21 Sep 2025 14:39:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 14/19] virtio_ring: determine descriptor flags at one
 time
Message-ID: <20250921143758-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: FHHSu6v2PCGovrXufWXHcC-LeMpFhdQmuGkRIGzKuWw_1758479996
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

I would indent this line a bit more to the right - it is a continuation,
after all.

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

