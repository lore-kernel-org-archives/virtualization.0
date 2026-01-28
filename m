Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3448228682
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621025; cv=none; b=YKhUaw+XuW6sdYZaJoYTMntYpX3POlp5jt1vSCz2fHyV7qWmpM/9ut7kFNU4o9xEVJeRItGkSSf5wkKNUruYrww566UtIamb17TgwaepDyAUlO2NldQTnKIdckN1iwn2fwSV/1mjAI5YibrO6qeXeIukAw3AtdX1kIT6wKW8ZaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621025; c=relaxed/simple;
	bh=qbbTNigXkPLBi/kTiMQHzZE3hHFs36knucV3j8O5E5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tcOWsbN00bQTsIjKLurlRVPIoN5cXa1crDdeBcvQFd7+a+Dt8Tia2WuN97r4vOIlAYsBQ6h3qZorsASQ5YnHoIXP+tfAhl6LZB0KI16YA1kTNLISkjWT/iTWApeG5oYdOYzpbDkLBtX+XwviPd+ZHAyyfalG6vuzfs+dO4cP3bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CfJ7TPnZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfJ7TPnZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769621023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gPnWFJelX/wlQBx2ivYdH45+n52GlMlmx8tnvEyIbww=;
	b=CfJ7TPnZHSaFx+SXAz2+CMx0Fs1f7FEh5I+7lEV9jPfGbVE/HiUsjl9QdErJNZ9sXjV6MJ
	J+/ib+ODf66DgjiKJmIBHF7UR3yke9fQ965lOQIbyjZAI7lJ87fkYXxL3IxnsaXQs1vVYt
	iJ7Omt+k2utU8F5caCQztGRnlmnr+OE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-kASwmKFXO22hGU5wATfLrQ-1; Wed, 28 Jan 2026 12:23:41 -0500
X-MC-Unique: kASwmKFXO22hGU5wATfLrQ-1
X-Mimecast-MFC-AGG-ID: kASwmKFXO22hGU5wATfLrQ_1769621020
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-59e0d5d1c81so29919e87.0
        for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 09:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769621020; x=1770225820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPnWFJelX/wlQBx2ivYdH45+n52GlMlmx8tnvEyIbww=;
        b=rjrdZewkRURiuBmhbbJZrI8ur9sedbko39ERYIXIx8UKhlkcV79C7ESh1gVeB/JAwp
         +pPqgWQwC3HLMl4IgTuYxvGc7MYxia1eIgGnropnAdJ/oaB4LewEIpeR/59nE1BOH8PL
         tzGUARgY4fgIEmzf8xPO1ux9m+eOkXnxYEcLqfYCMP0Cwbk6dtNHdqOtLOWMFGBHqOvv
         QaUE6u0VrvPdmCLgaXxlHgLXUwn9LKxLNzuYBMfOgC/+qTLRV0V1lUUMKjarBFJ472yK
         dCuYYeRJL8PLEvhHGEsO0VQSJfHWJUMa7/cOzzhtaTuyWRG0cFUo5I16IUH1ff2e1ke8
         qcPg==
X-Forwarded-Encrypted: i=1; AJvYcCWsn6JtbOjkkHgBeqsZiBCRUkMeMdRKFPV6RzLfBapsL86nkBMteRhTnFP3zvWpO7a5FrzR6ZV7SWnDAt9WUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzU0ERK3s8HckABzBbZTBG52kheEA9I+X5ZQ914Q8WB7j3+B5Wl
	9N7xWu86jR3esd7qkhqCCOwi9X0D8yX5dQsBnPUMicB/X59FcNuurvo5G9zuhx7Xr5N/wg6VG0n
	gwcVUrlt1C+SHe8Y3ons0KTR0W6VqdAlyIJxFLXMWhcQ46XRBbFcbn4uT16q/+NnLs8E5
X-Gm-Gg: AZuq6aJFwxq7wKm9teJH+KC5hkEoUNyH2kJpd+Yqohhg6V5LIMTc9V2slS0v5eYie01
	UzDi4kG//BDHAQfTb9+t9JkVcDEYn7+xDKsXLt6XI1E6SaLe7nXNG0kCwLob0SIN9cloRzAusLL
	MAvbn6IMYUSVv7RsF14iMs2n3KIucWPwMe0KuMsoDy7QwsKjfOy5VOOTehqqU2nVdcQI5mOwRfn
	YOyt11C0og61xCZiHz3ZxXqHKTMhMgzK8OpDS1TP6UoCY6/8GRawoLmDeTCK0G1lWlhG20uJJQv
	zD2DMtMpKhgtpY9fJsFRQHQNmAFDT7pWZ771vX9cIVhGgBlOwPIK/LDzEHJrRiBaFVPsKkPwNTh
	sF4sjda72WEhmXpe7HIp/wwaLKvuVtOesCQ==
X-Received: by 2002:a05:6512:3b99:b0:59d:4a12:5f7 with SMTP id 2adb3069b0e04-59e04025374mr2793097e87.31.1769621019838;
        Wed, 28 Jan 2026 09:23:39 -0800 (PST)
X-Received: by 2002:a05:6512:3b99:b0:59d:4a12:5f7 with SMTP id 2adb3069b0e04-59e04025374mr2793078e87.31.1769621019241;
        Wed, 28 Jan 2026 09:23:39 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b7a8csm643655e87.77.2026.01.28.09.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 09:23:38 -0800 (PST)
Date: Wed, 28 Jan 2026 12:23:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"open list:VIRTIO CORE" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH] virtio_ring: Add READ_ONCE annotations for
 device-writable fields
Message-ID: <20260128121309-mutt-send-email-mst@kernel.org>
References: <20260128135947.455686-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260128135947.455686-1-johannes.thumshirn@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aYYMLjJ9GogPuslVulNEwfXeNhtY4vo3NMfNB5_aizM_1769621020
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2026 at 02:59:46PM +0100, Johannes Thumshirn wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> KCSAN reports data races when accessing virtio ring fields that are
> concurrently written by the device (host). These are legitimate
> concurrent accesses where the CPU reads fields that the device updates
> via DMA-like mechanisms.
> 
> Add accessor functions that use READ_ONCE() to properly annotate these
> device-writable fields and prevent compiler optimizations that could

let's add "in theory" here

> break the code. This also serves as documentation showing which fields
> are shared with the device.
> 
> The affected fields are:
> - Split ring: used->idx, used->ring[].id, used->ring[].len
> - Packed ring: desc[].flags, desc[].id, desc[].len

I would add here: using WRITE_ONCE for driver writes into fields
isn't done here as it does not currently trigger warnings.


> 
> Reported-by: Kernel Concurrency Sanitizer (KCSAN)
> Signed-off-by: Alexander Graf <graf@amazon.com>
> [jth: Add READ_ONCE in virtqueue_kick_prepare_split ]
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good to me. Yet something to improve:

> ---
>  drivers/virtio/virtio_ring.c | 88 ++++++++++++++++++++++++++++++------
>  1 file changed, 73 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index ddab68959671..74957c83e138 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -222,6 +222,63 @@ struct vring_virtqueue {
>  #endif
>  };
>  
> +/*
> + * Accessors for device-writable fields in virtio rings.
> + * These fields are concurrently written by the device and read by the driver.
> + * Use READ_ONCE() to prevent compiler optimizations and document the
> + * intentional data race.

... and prevent KCSAN warnings

> + */
> +
> +/* Split ring: read device-written fields from used ring */
> +static inline u16 vring_used_idx_read(const struct vring_virtqueue *vq)

I'd prefer a consistent prefix. Maybe:

vring_read_used_idx

and so on.




> +{
> +	return virtio16_to_cpu(vq->vq.vdev,
> +			       READ_ONCE(vq->split.vring.used->idx));
> +}
> +
> +static inline u32 vring_used_id_read(const struct vring_virtqueue *vq,
> +				     u16 idx)
> +{
> +	return virtio32_to_cpu(vq->vq.vdev,
> +			       READ_ONCE(vq->split.vring.used->ring[idx].id));
> +}
> +
> +static inline u32 vring_used_len_read(const struct vring_virtqueue *vq,
> +				      u16 idx)
> +{
> +	return virtio32_to_cpu(vq->vq.vdev,
> +			       READ_ONCE(vq->split.vring.used->ring[idx].len));
> +}
> +
> +/* Packed ring: read device-written fields from descriptors */
> +static inline u16 vring_packed_desc_flags_read(const struct vring_virtqueue *vq,
> +					       u16 idx)
> +{
> +	return le16_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].flags));
> +}
> +
> +static inline u16 vring_packed_desc_id_read(const struct vring_virtqueue *vq,
> +					    u16 idx)
> +{
> +	return le16_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].id));
> +}
> +
> +static inline u32 vring_packed_desc_len_read(const struct vring_virtqueue *vq,
> +					     u16 idx)
> +{
> +	return le32_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].len));
> +}
> +
> +/*
> + * Note: We don't need READ_ONCE for driver->device fields like:
> + * - split.vring.avail->idx (driver writes, device reads)
> + * - packed.vring.desc[].addr (driver writes, device reads)
> + * These are written by the driver and only read by the device, so the
> + * driver can safely access them

read them, really.

> without READ_ONCE.

... and without triggering KCSAM warnings.

> The device must use
> + * appropriate barriers on its side.
> + */
> +
> +

extra empty line here.

>  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
>  static void vring_free(struct virtqueue *_vq);
>  
> @@ -736,9 +793,10 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
>  	LAST_ADD_TIME_INVALID(vq);
>  
>  	if (vq->event) {
> -		needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev,
> -					vring_avail_event(&vq->split.vring)),
> -					      new, old);
> +		u16 event = virtio16_to_cpu(_vq->vdev,
> +				READ_ONCE(vring_avail_event(&vq->split.vring)));

why not wrap this one, too?

> +
> +		needs_kick = vring_need_event(event, new, old);
>  	} else {
>  		needs_kick = !(vq->split.vring.used->flags &
>  					cpu_to_virtio16(_vq->vdev,
> @@ -808,8 +866,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  
>  static bool more_used_split(const struct vring_virtqueue *vq)
>  {
> -	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
> -			vq->split.vring.used->idx);
> +	return vq->last_used_idx != vring_used_idx_read(vq);
>  }
>  
>  static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> @@ -838,10 +895,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	virtio_rmb(vq->weak_barriers);
>  
>  	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
> -	i = virtio32_to_cpu(_vq->vdev,
> -			vq->split.vring.used->ring[last_used].id);
> -	*len = virtio32_to_cpu(_vq->vdev,
> -			vq->split.vring.used->ring[last_used].len);
> +	i = vring_used_id_read(vq, last_used);
> +	*len = vring_used_len_read(vq, last_used);
>  
>  	if (unlikely(i >= vq->split.vring.num)) {
>  		BAD_RING(vq, "id %u out of range\n", i);
> @@ -923,8 +978,7 @@ static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int last_used_i
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev,
> -			vq->split.vring.used->idx);
> +	return (u16)last_used_idx != vring_used_idx_read(vq);
>  }
>  
>  static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
> @@ -1701,10 +1755,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
>  				       u16 idx, bool used_wrap_counter)
>  {
> -	bool avail, used;
>  	u16 flags;
> +	bool avail, used;
>  
> -	flags = le16_to_cpu(vq->packed.vring.desc[idx].flags);
> +	flags = vring_packed_desc_flags_read(vq, idx);
>  	avail = !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
>  	used = !!(flags & (1 << VRING_PACKED_DESC_F_USED));
>  
> @@ -1751,8 +1805,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	last_used_idx = READ_ONCE(vq->last_used_idx);
>  	used_wrap_counter = packed_used_wrap_counter(last_used_idx);
>  	last_used = packed_last_used(last_used_idx);
> -	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
> -	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
> +	id = vring_packed_desc_id_read(vq, last_used);
> +	*len = vring_packed_desc_len_read(vq, last_used);
>  
>  	if (unlikely(id >= vq->packed.vring.num)) {
>  		BAD_RING(vq, "id %u out of range\n", id);
> @@ -1850,6 +1904,10 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
>  	bool wrap_counter;
>  	u16 used_idx;
>  
> +	/*
> +	 * Note: off_wrap is from virtqueue_enable_cb_prepare_packed() which
> +	 * already used READ_ONCE on vq->last_used_idx, so we don't need it again.

we don't need what again? off_wrap is a local variable.

> +	 */
>  	wrap_counter = off_wrap >> VRING_PACKED_EVENT_F_WRAP_CTR;
>  	used_idx = off_wrap & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);
>  
> -- 
> 2.52.0

