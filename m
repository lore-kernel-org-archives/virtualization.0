Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2534FF47
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710310; cv=none; b=njtETuUIgUr5cO45PwZKyIo8Bc7ubDQ7DaSTEL653XBDYQH+/58kc0c6Knfy4SVjFzc1T7oep//6CsI3dJ/kcQMZ5Gxog5OCvCg6j5Fxyak4KVY4H5V5qRlUtcj/JzFM6A5YvP0XqQ0rvVHwfWUY8V+tE6cgvXxu4DEBczG3AFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710310; c=relaxed/simple;
	bh=3kNfQon72BntdnPcyCmIVY1CnJOW18aHomAr9Tp38M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Zu/fMchDnGhulgxQycjSs31vYku9L3a35RjYVUWh7GMxZhqMziIrMiMgkvF+L2llTXEbRfAkPE/12Ky6KPV3tm7cE6mcE2F7U8N+oLkNdpMlET7GeMLkuO6qIT7ZMYv35zVidfQBYAkjcmdx7ijpNvEJIp5k38cMrJrc/qktHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrHpwfyG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrHpwfyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769710308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sR+lMNDRP3cmxx8RR95s6vZsFNJKZiISbaEJv5rMD4Q=;
	b=GrHpwfyGYXqe+SEEtc9Q3pE/JkhgkmhutRxbpRIvbmxopNwXPJgw2RdxVdRnpI5VC1E/g/
	vKlYeh9G6yLxvaoBIFPaiWcIqsn+vyyGE7beaDhVpl9iBUdcqurWyTVT8Ah3W19dSNu1VZ
	IdZQlar1fsX9eZW2KCamxaOkGN5/AUw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-xOL4J0JdNdyeJ3DrolfpFw-1; Thu, 29 Jan 2026 13:11:46 -0500
X-MC-Unique: xOL4J0JdNdyeJ3DrolfpFw-1
X-Mimecast-MFC-AGG-ID: xOL4J0JdNdyeJ3DrolfpFw_1769710306
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-480686b3b4cso11909265e9.0
        for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 10:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769710305; x=1770315105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sR+lMNDRP3cmxx8RR95s6vZsFNJKZiISbaEJv5rMD4Q=;
        b=o8XWMxrwy7DWD7/CWmbG8fiF5UkJY+TNybXCq9/hYDMTevKpyZdpxVBU3iDIn12KPO
         MvS29+mh+ua4M5VBhLx3Qihaw4TNI8hjuMmhZYNuUCFaWSbwPrdR9WohmRJAw3LzNNwk
         rJzpCVdIYR61xNW8tr/mel5GUOjDQfwITNKvIrcFeyoolovj4ePM6e0BzXdEGStPHkIR
         LcCFke7ehsmVwWwjJbOYT8whYwgRHBZZQ10UWpT3JvMPlPj08WOaLkiq1BsYEg2m7nEa
         ytOmbT80ClRrzhBt5txcR80JlpbZBMihojsONHHkRSFHnt56NZpf8eCXF3jFy+OOyc5H
         BAvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWBLyiFMU2BDoWgApUc2cpYN0YBzwXRYTFgHi8aMOTScvsJVUTW+ipErGy2vKo11z9fHatHB94XNV85Q5TWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkGFN5Q/knSNjkyPx99bZIQhUrV76+N94p76AAp1ClPLv3ke6S
	CHfwcDEwXxR1rt21HZNOypDkQgVhpKdzQWL6k9Yg08DpUvYj8Zw0niw75Ne3FyiDCQmr4yufVRY
	NXqbSLua/Z2h7bOmnTveSx11TvovUNfwETDRLkWevd8+g/AbbCj+8IXjmR/f56IgZ8UUC2JuKGk
	9g
X-Gm-Gg: AZuq6aKoGEDiwXBprREEDJpRQoPvkhPHk3O58K36/yVtJD0bg4dA5h9ThG/7R+bI9WA
	LwucGWFx0HClkdwqv32WuoZiEITxVIGtNywS049EUweNBXQ2ua3ijG3INAmoNeMICxbFWit1jep
	NwDuTr4nX96kStPzp1MjPhc5unStcdnUbeiGl5l4haKR/ATOiZODPex2WYReNJFbA1Mdra01fxr
	u5IF5qGxXy0aGHrhpM/EYckLspwsYkNWgosKnP59tNR/Ht/Z95N94scd/v+zSqYgmHlWtva76Rm
	Bnfy2x/X89ahoDB/O1yndedSHnX1oVojzYw7G1jCT6pH7B4zjZ+Wzm5kCjEPn+Y0QSMc52f/5ZE
	D5d8SBzYkkpA5czCeL0X/Bk551pQx/Rz/IA==
X-Received: by 2002:a05:600c:3f16:b0:477:54cd:200e with SMTP id 5b1f17b1804b1-482db4569c0mr779135e9.1.1769710305300;
        Thu, 29 Jan 2026 10:11:45 -0800 (PST)
X-Received: by 2002:a05:600c:3f16:b0:477:54cd:200e with SMTP id 5b1f17b1804b1-482db4569c0mr778815e9.1.1769710304801;
        Thu, 29 Jan 2026 10:11:44 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cddffe9sm196831645e9.4.2026.01.29.10.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 10:11:44 -0800 (PST)
Date: Thu, 29 Jan 2026 13:11:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Alexander Graf <graf@amazon.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"open list:VIRTIO CORE" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] virtio_ring: Add READ_ONCE annotations for
 device-writable fields
Message-ID: <20260129130818-mutt-send-email-mst@kernel.org>
References: <20260129121604.745681-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260129121604.745681-1-johannes.thumshirn@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: viuXtYCzyhUNhx_pTAIH_mPnk7u9x2a11a85EAr-Pf8_1769710306
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thanks for the patch! yet something to improve:

On Thu, Jan 29, 2026 at 01:15:58PM +0100, Johannes Thumshirn wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> KCSAN reports data races when accessing virtio ring fields that are
> concurrently written by the device (host). These are legitimate
> concurrent accesses where the CPU reads fields that the device updates
> via DMA-like mechanisms.
> 
> Add accessor functions that use READ_ONCE() to properly annotate these
> device-writable fields and prevent compiler optimizations that could in
> theory break the code. This also serves as documentation showing which
> fields are shared with the device.
> 
> The affected fields are:
> - Split ring: used->idx, used->ring[].id, used->ring[].len
> - Packed ring: desc[].flags, desc[].id, desc[].len
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> [jth: Add READ_ONCE in virtqueue_kick_prepare_split ]
> Co-developed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 

drop the empty line pls.

> ---



> Changes to v1:
> - Updated comments (mst, agraf)
> - Moved _read suffix to prefix in newly introduced functions (mst)
> - Update my minor contribution to Co-developed-by (agraf)
> - Add "in theory" to changelog
> ---
>  drivers/virtio/virtio_ring.c | 69 ++++++++++++++++++++++++++++--------
>  1 file changed, 54 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index ddab68959671..66802d11d30e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -222,6 +222,48 @@ struct vring_virtqueue {
>  #endif
>  };
>  
> +/*
> + * Accessors for device-writable fields in virtio rings.
> + * These fields are concurrently written by the device and read by the driver.
> + * Use READ_ONCE() to prevent compiler optimizations and document the
> + * intentional data race and prevent KCSAN warnings.

	Use READ_ONCE ... , document ... and prevent

> + */
> +static inline u16 vring_read_used_idx(const struct vring_virtqueue *vq)
> +{
> +	return virtio16_to_cpu(vq->vq.vdev,
> +			       READ_ONCE(vq->split.vring.used->idx));
> +}
> +
> +static inline u32 vring_read_used_id(const struct vring_virtqueue *vq, u16 idx)
> +{
> +	return virtio32_to_cpu(vq->vq.vdev,
> +			       READ_ONCE(vq->split.vring.used->ring[idx].id));
> +}
> +
> +static inline u32 vring_read_used_len(const struct vring_virtqueue *vq, u16 idx)
> +{
> +	return virtio32_to_cpu(vq->vq.vdev,
> +			       READ_ONCE(vq->split.vring.used->ring[idx].len));
> +}
> +

above are only for split I think? then pls note in the name: e.g.
vring_read_split_used_len


> +static inline u16 vring_read_packed_desc_flags(const struct vring_virtqueue *vq,
> +					       u16 idx)
> +{
> +	return le16_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].flags));
> +}
> +
> +static inline u16 vring_read_packed_desc_id(const struct vring_virtqueue *vq,
> +				            u16 idx)
> +{
> +	return le16_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].id));
> +}
> +
> +static inline u32 vring_read_packed_desc_len(const struct vring_virtqueue *vq,
> +				             u16 idx)
> +{
> +	return le32_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].len));
> +}
> +

hmm the names are very long now. maybe drop _read_ from there.

>  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
>  static void vring_free(struct virtqueue *_vq);
>  
> @@ -736,9 +778,10 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
>  	LAST_ADD_TIME_INVALID(vq);
>  
>  	if (vq->event) {
> -		needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev,
> -					vring_avail_event(&vq->split.vring)),
> -					      new, old);
> +		u16 event = virtio16_to_cpu(_vq->vdev,
> +				READ_ONCE(vring_avail_event(&vq->split.vring)));
> +

why not wrap this one then?

> +		needs_kick = vring_need_event(event, new, old);
>  	} else {
>  		needs_kick = !(vq->split.vring.used->flags &
>  					cpu_to_virtio16(_vq->vdev,
> @@ -808,8 +851,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  
>  static bool more_used_split(const struct vring_virtqueue *vq)
>  {
> -	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
> -			vq->split.vring.used->idx);
> +	return vq->last_used_idx != vring_read_used_idx(vq);
>  }
>  
>  static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> @@ -838,10 +880,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	virtio_rmb(vq->weak_barriers);
>  
>  	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
> -	i = virtio32_to_cpu(_vq->vdev,
> -			vq->split.vring.used->ring[last_used].id);
> -	*len = virtio32_to_cpu(_vq->vdev,
> -			vq->split.vring.used->ring[last_used].len);
> +	i = vring_read_used_id(vq, last_used);
> +	*len = vring_read_used_len(vq, last_used);
>  
>  	if (unlikely(i >= vq->split.vring.num)) {
>  		BAD_RING(vq, "id %u out of range\n", i);
> @@ -923,8 +963,7 @@ static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int last_used_i
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev,
> -			vq->split.vring.used->idx);
> +	return (u16)last_used_idx != vring_read_used_idx(vq);
>  }
>  
>  static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
> @@ -1701,10 +1740,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
>  				       u16 idx, bool used_wrap_counter)
>  {
> -	bool avail, used;
>  	u16 flags;
> +	bool avail, used;
>  
> -	flags = le16_to_cpu(vq->packed.vring.desc[idx].flags);
> +	flags = vring_read_packed_desc_flags(vq, idx);
>  	avail = !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
>  	used = !!(flags & (1 << VRING_PACKED_DESC_F_USED));
>  
> @@ -1751,8 +1790,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	last_used_idx = READ_ONCE(vq->last_used_idx);
>  	used_wrap_counter = packed_used_wrap_counter(last_used_idx);
>  	last_used = packed_last_used(last_used_idx);
> -	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
> -	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
> +	id = vring_read_packed_desc_id(vq, last_used);
> +	*len = vring_read_packed_desc_len(vq, last_used);
>  
>  	if (unlikely(id >= vq->packed.vring.num)) {
>  		BAD_RING(vq, "id %u out of range\n", id);
> -- 
> 2.52.0

