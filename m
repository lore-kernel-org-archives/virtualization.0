Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCCE270EA5
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758476577; cv=none; b=expLZXBAIX9xuAer6a/e9PcwNMjgC1gCcXR9PzwUPDoHQnu24D+cQWlIgqBiZW+n4Szazi1FEJQxfFpMo1zW6GcQIzGrZTToRlQ0BdosJrOmwk6DSrx63ADUZZceMESHoCfTjkSL+uFIFV1yAvyMJmMxXmNbY0Y2Kqa0F+oRjBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758476577; c=relaxed/simple;
	bh=NyKEKr1b2BIcyNy09zsOZ61YBaYjsa5gw1rrHkIXNFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Q/1iARDL+4TrdkNuVon/UygmJZYggVYM+sBF6lmG3+qynqs5Qct0F6RGBasl3OUsKOaJFeVlUbdRxH39pRIaUdP9ELuiQvhfPZ2RwXHHDvpVdW/1HP8JMp58aiiSQdU/KLAvcVALjEl1AxB0gx83mQ9Mq4uNHoHEWbW0ZNF/l2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sgra2/cR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sgra2/cR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758476575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ki5SNULUk4ovbhFY3JwbvaZTB4gpWhdkwmyhVBSCsGw=;
	b=Sgra2/cRZPgsiXXBrJZQpWUfpHSm+mmWbs7JkxymzP1CZAJrtmfvrzelC9ZWF8wxs/OGtn
	T/54dejT2mDBSXV7659iOcE1glDgvtJViPaAvJEnoShWzjiuFC0Ka/5zJ5l4FW53dEx5Iy
	+Ymam71deik3umutz2PXjToX3M3yKdE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-uswMF-J1OM-F86eqW2nSDg-1; Sun, 21 Sep 2025 13:42:52 -0400
X-MC-Unique: uswMF-J1OM-F86eqW2nSDg-1
X-Mimecast-MFC-AGG-ID: uswMF-J1OM-F86eqW2nSDg_1758476571
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45f29eb22f8so18660315e9.0
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 10:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758476571; x=1759081371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ki5SNULUk4ovbhFY3JwbvaZTB4gpWhdkwmyhVBSCsGw=;
        b=To7qQoUXCyU/Bs6h4+w29TqXVX488WwqD2CzrL6Kg3eiqAqSDjbvYKQLWczOTY5GZO
         iYBu1M1uVr1f+qOF4bPTA0jiEE17L/eO6oOQUPvxgAkQRsCSpRmShh+ic1I2k9Ar6h5C
         6XcqLsX6q4LnEdFh/9AwOW3AKWIpRJO2vYE4b/XjwZKp0W78Ed0ZxO86N/3x6BrEQ4nm
         ig2ql8JZuBdDP8beELVZJJtETphkglf1p6coaAFDG20SGriWK5BWaiPK1CAyQwokTlNb
         NZve6fQ7ZjoBtD9cxcuWpe+O/YghtoSIjAwZVQFznwMWai/I60+NXmSawry9WsWhLXhk
         UHlw==
X-Forwarded-Encrypted: i=1; AJvYcCWgGneYjyE3IN+Yv81YJH5ESexSBkuXTkTezg+/isYUnM6fyXWvkRSYGmGX5M/RV8x76e4RqZiCOhQnFU43xQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWeMmvY0ykFm5X6ltxeT0CdGw5F80xea67qtAsqufZAa0h2poM
	nOR9LpMpK5CgAPfS6uXW1P6I6MwtT9l98AE56PrfKwg+nTy67dSYyZJVLf9GyVDqMRKFe6Aaz4O
	WnHhEEW5q4RfQeEI1eZBEEvYm2LXGMi/F2WgbP4PWFhrp7xkKDmeeJ1ZP1oJXzQeD5532
X-Gm-Gg: ASbGncsPMHjXwSVUiozkEGNb3la0IISQtGUdDRSU5pJcaZqE9qyvdLX9n2WKB73O/xF
	gRg5DihQ8yWQ4b1y4Uu+nayskl+DBodkNEI/GTkmJyCwVrNLflF+Fowiqb/mQ9KBAu5UUMpRJGf
	X9QkISXtAViGGcKOySYI14HaFHTKG5jP6J8R+RVCwmeqk928I5Qjm7e5tP1XUEozkul3Iohht/t
	0numqzCQgO00PRpdEcU7r392PxgtymSNHdHsKnwOhs8YK4FRDKJ5qL0gBPkdatO65wuxaC9OUsG
	y/LySnGRObfiWHZ3B3lY0pztPIq3hg7q/k4=
X-Received: by 2002:a05:600c:4fc2:b0:45d:ec9d:5fde with SMTP id 5b1f17b1804b1-467ec46079dmr95217405e9.37.1758476570636;
        Sun, 21 Sep 2025 10:42:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiD/X8G7MP1jcVbjEIkInBgciEQnAeB2QSMG8GJCmlocmhldDBxHzW7xwz0JStIEtLdCYMSA==
X-Received: by 2002:a05:600c:4fc2:b0:45d:ec9d:5fde with SMTP id 5b1f17b1804b1-467ec46079dmr95217255e9.37.1758476570232;
        Sun, 21 Sep 2025 10:42:50 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407aebsm17000435f8f.14.2025.09.21.10.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 10:42:49 -0700 (PDT)
Date: Sun, 21 Sep 2025 13:42:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 15/19] virtio_ring: factor out core logic of buffer
 detaching
Message-ID: <20250921134159-mutt-send-email-mst@kernel.org>
References: <20250919073154.49278-1-jasowang@redhat.com>
 <20250919073154.49278-16-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250919073154.49278-16-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uHYe-3xOgJ_9mKV1LFmkz4rxce-gbMmw2wBR_UMsA-k_1758476571
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 19, 2025 at 03:31:50PM +0800, Jason Wang wrote:
> Factor out core logic of buffer detaching and leave the id population
> to the caller so in order can just call the core logic.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 0949675a3d12..a83d08070e8a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1662,8 +1662,8 @@ static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
>  	return needs_kick;
>  }
>  
> -static void detach_buf_packed(struct vring_virtqueue *vq,
> -			      unsigned int id, void **ctx)
> +static void detach_buf_packed_in_order(struct vring_virtqueue *vq,
> +				       unsigned int id, void **ctx)
>  {
>  	struct vring_desc_state_packed *state = NULL;
>  	struct vring_packed_desc *desc;
> @@ -1674,8 +1674,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  	/* Clear data ptr. */
>  	state->data = NULL;
>  
> -	vq->packed.desc_extra[state->last].next = vq->free_head;
> -	vq->free_head = id;
>  	vq->vq.num_free += state->num;
>  
>  	if (unlikely(vq->use_map_api)) {
> @@ -1712,6 +1710,17 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  	}
>  }
>  
> +static void detach_buf_packed(struct vring_virtqueue *vq,
> +			      unsigned int id, void **ctx)
> +{
> +	struct vring_desc_state_packed *state = &vq->packed.desc_state[id];
> +
> +	vq->packed.desc_extra[state->last].next = vq->free_head;
> +	vq->free_head = id;
> +
> +	return detach_buf_packed_in_order(vq, id, ctx);
> +}
> +

Wait what? return in a void function?
How does this compile? I'm guessing it's tweaked by a follow
up patch?


>  static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
>  				       u16 idx, bool used_wrap_counter)
>  {
> -- 
> 2.31.1

