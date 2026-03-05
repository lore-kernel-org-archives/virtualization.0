Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E94372B5A
	for <virtualization@lists.linux.dev>; Thu,  5 Mar 2026 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704119; cv=none; b=CmaPGiseAYDHeCJavU6nyqCjw8h/FyD8rFMa+ppdu2vElrs9v9WAQuvFOF596fglj8FGVQi5E1J/n7hwLZmPP6TqCdWo0KtKgLMMG/B/li5PKUFwE6s5PyB4bYZSu4REAxa6TXKX1AMdIJdiDwfidHE75wItKz+Wo5ijTxAxMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704119; c=relaxed/simple;
	bh=EA+7aVptETFhnFAwlBk5/yUBhBHiPSQasRFMGcthMGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BGHDgU40JZg2qBai6dAUl0RPGd7+kb0GB6kORCPIwz7xZlyDUJqYBAlCTYM9pDKfUQmOlOfRX10lkrT/rEflTXrXehP6Ea3SgLs+hFyNe8qtngJB/v90lfMgNPuAHGjGqt8yqDVhN+JLg+FfXd5quVsagkx9gY3EFFO6k1RSdxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMJNZPNc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMJNZPNc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772704116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eue2HekBguBPTXZSod2oBl+1Jw/OD9QVtNrkTaB9yfA=;
	b=dMJNZPNc4MftaREYKyz0ebaLMqaYx1mYBXlJJDnITDXOT9IugDNd1dfB7fRIlTqie15XFD
	mPSY6vRCxFHpKgDluWWKU+9qQXJhWBviXrutyzwk3mDxp+aCUc8FiWF6Bv36xdddyIUIib
	SjzOxTBM0G/9YDg9vyGVj5woR1jX4Gw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-HmKhPzrMM8Wx10CN-Hh3Fw-1; Thu, 05 Mar 2026 04:48:34 -0500
X-MC-Unique: HmKhPzrMM8Wx10CN-Hh3Fw-1
X-Mimecast-MFC-AGG-ID: HmKhPzrMM8Wx10CN-Hh3Fw_1772704113
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439b50dfca1so3148200f8f.0
        for <virtualization@lists.linux.dev>; Thu, 05 Mar 2026 01:48:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704113; x=1773308913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eue2HekBguBPTXZSod2oBl+1Jw/OD9QVtNrkTaB9yfA=;
        b=w2siWcwBnr4vjzRq0B8jESHf/PEtdoDPy0ThdES9FNJS+HtQaQPDBdC0EfdLeGMw8G
         hi9c8pVVnOwt7/N4E0Xsv4/GrIAbYEG6lA6aYjvbwrHrsL7MokWWIQ40CTqVQ0jeA5Gc
         PLLhFRzyDqIRn6wBXvj/Oq/ExeP7Hbm1xB7hwPxgr0emI/aKSfM/lmuwA1ywR9JyIllM
         Oko+bCre3BByqP6nUbqCsJBVWodhc6X1alwE/XUvBaE8B63XvelHu+RVYskdNwDdfPBh
         jN56WUdxY2MTwwYMNUT3sTL7Yx17uAvDffrCAX/dNsBuTy0GFYi31m/xikt7R0C44T25
         AGaw==
X-Forwarded-Encrypted: i=1; AJvYcCW6e+Q1ROKI3lnCtrj0uGIcCRADyFb/UI4JmV+9XxJxOPqqpy9pJR5Q+jQy93WLc2wYNiccWgBNeiRaiTUaZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIPkTGbMZaCwf0lAyVBNq0swKsea/F3Nz2REamwmYDme4c8Tuo
	oIXbBmIuggxmRTucVbFpYmxZW4DY1vEyZYMqYAkUgKpj8TibKePmNaJLj8LrwocsK7L4OgqPBlr
	1JNmqZVAdFxLWRV4u50XmQqpEaaXqUci3IJbo7pk20H5LEJXyQwktJoMg8pn7dVZImwsd
X-Gm-Gg: ATEYQzxSxUoEZ42vhAUGY3ucsBgemCZ0Lfn9E05FPPzOjiby7rFVGk+0hE+7LCZ+ayZ
	TRWlRdAznttpr2V/HEZJwHIomL1EW/vlxSnWaxqBRVVBGKjNBSFkE/cOLvHJJ9f2ZLSN8VPrH15
	/h+3jBqP9Fa6xNEhlYFGduWydUvrMcK+qgGxCvZi3i/YisSIcVxZyEKZMlMBBFsZJ/OyAgFHxbw
	Uka/n44LvG87SqYnpf3a2KdtPrr91yuIYXdShJao5J7qbTIMKdjBvmDwrvHVRbRFVi3zdS/T5rL
	9fNTZG4OuI4445No2tkqVZJoANAWrngtoYxsSZOn9cHCTyy3MUa2iekag8Spm6YA4K1cXdNySu8
	oZUUcF+WFdNf20UIY7UxaTPfnf26iE691CBYKTUfGtChedw==
X-Received: by 2002:a05:6000:1152:b0:439:c9d6:4313 with SMTP id ffacd0b85a97d-439c9d64396mr7045109f8f.44.1772704112891;
        Thu, 05 Mar 2026 01:48:32 -0800 (PST)
X-Received: by 2002:a05:6000:1152:b0:439:c9d6:4313 with SMTP id ffacd0b85a97d-439c9d64396mr7045067f8f.44.1772704112315;
        Thu, 05 Mar 2026 01:48:32 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ae3f31dbsm36420690f8f.1.2026.03.05.01.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:48:31 -0800 (PST)
Date: Thu, 5 Mar 2026 04:48:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chaohai Chen <wdhh6@aliyun.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: Fix data races in split virtqueue used ring
 accesses
Message-ID: <20260305044559-mutt-send-email-mst@kernel.org>
References: <20260305092927.3866089-1-wdhh6@aliyun.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260305092927.3866089-1-wdhh6@aliyun.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WorxEPy5s4SrwNH6qURuWZ9tc0jEl26Kt6mn1uaKmMI_1772704113
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 05, 2026 at 05:29:27PM +0800, Chaohai Chen wrote:
> KCSAN detected multiple data races when accessing the split virtqueue's
> used ring, which is shared memory concurrently accessed by both the CPU
> and the virtio device (hypervisor).
> 
> The races occur when reading the following fields without proper atomic
> operations:
> - vring.used->idx
> - vring.used->flags
> - vring.used->ring[].id
> - vring.used->ring[].len
> 
> These fields reside in DMA-shared memory and can be modified by the
> virtio device at any time. Without READ_ONCE(), the compiler may perform
> unsafe optimizations such as value caching or load tearing.

.... but does not.


> Example KCSAN report:
> 
> [  109.277250] ==================================================================
> [  109.283600] BUG: KCSAN: data-race in virtqueue_enable_cb_delayed_split+0x10f/0x170
> 
> [  109.295263] race at unknown origin, with read to 0xffff8b2a92ef2042 of 2 bytes by interrupt on cpu 1:
> [  109.306934]  virtqueue_enable_cb_delayed_split+0x10f/0x170
> [  109.312880]  virtqueue_enable_cb_delayed+0x3b/0x70
> [  109.318852]  start_xmit+0x315/0x860 [virtio_net]
> [  109.324532]  dev_hard_start_xmit+0x85/0x380
> [  109.329993]  sch_direct_xmit+0xd3/0x680
> [  109.335360]  __dev_xmit_skb+0x4ee/0xcc0
> [  109.340568]  __dev_queue_xmit+0x560/0xe00
> [  109.345701]  ip_finish_output2+0x49a/0x9b0
> [  109.350743]  __ip_finish_output+0x131/0x250
> [  109.355789]  ip_finish_output+0x28/0x180
> [  109.360712]  ip_output+0xa0/0x1c0
> [  109.365479]  __ip_queue_xmit+0x68d/0x9e0
> [  109.370156]  ip_queue_xmit+0x33/0x40
> [  109.374783]  __tcp_transmit_skb+0x1703/0x1970
> [  109.379467]  __tcp_send_ack.part.0+0x1bb/0x320
> ...
> [  109.499585]  do_idle+0x7a/0xe0
> [  109.502979]  cpu_startup_entry+0x25/0x30
> [  109.506481]  start_secondary+0x116/0x150
> [  109.509930]  common_startup_64+0x13e/0x141
> 
> [  109.516626] value changed: 0x0029 -> 0x002a
> 
> Fix these races by wrapping all reads from the used ring with READ_ONCE()
> to ensure:
> 1. The compiler always loads values from memory (no caching)
> 2. Loads are atomic (no load tearing)
> 3. The concurrent access intent is documented for KCSAN and developers
> 
> The changes affect the following functions:
> - virtqueue_kick_prepare_split(): used->flags and avail event
> - virtqueue_get_buf_ctx_split(): used->ring[].id and used->ring[].len
> - virtqueue_get_buf_ctx_split_in_order(): used->ring[].id and
> used->ring[].len
> - virtqueue_enable_cb_delayed_split(): used->idx
> 

These are no races, these are KCSAN false positives.
I am not against  documenting things using these macros
but i am against confusing commit log messages.



> Signed-off-by: Chaohai Chen <wdhh6@aliyun.com>
> ---
>  drivers/virtio/virtio_ring.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 335692d41617..a792a3f05837 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -810,10 +810,10 @@ static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
>  
>  	if (vq->event) {
>  		needs_kick = vring_need_event(virtio16_to_cpu(vq->vq.vdev,
> -					vring_avail_event(&vq->split.vring)),
> +					READ_ONCE(vring_avail_event(&vq->split.vring))),
>  					      new, old);
>  	} else {
> -		needs_kick = !(vq->split.vring.used->flags &
> +		needs_kick = !(READ_ONCE(vq->split.vring.used->flags) &
>  					cpu_to_virtio16(vq->vq.vdev,
>  						VRING_USED_F_NO_NOTIFY));
>  	}
> @@ -940,9 +940,9 @@ static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>  
>  	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
>  	i = virtio32_to_cpu(vq->vq.vdev,
> -			vq->split.vring.used->ring[last_used].id);
> +			READ_ONCE(vq->split.vring.used->ring[last_used].id));
>  	*len = virtio32_to_cpu(vq->vq.vdev,
> -			vq->split.vring.used->ring[last_used].len);
> +			READ_ONCE(vq->split.vring.used->ring[last_used].len));
>  
>  	if (unlikely(i >= vq->split.vring.num)) {
>  		BAD_RING(vq, "id %u out of range\n", i);
> @@ -1004,9 +1004,9 @@ static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtqueue *vq,
>  		virtio_rmb(vq->weak_barriers);
>  
>  		vq->batch_last.id = virtio32_to_cpu(vq->vq.vdev,
> -				    vq->split.vring.used->ring[last_used_idx].id);
> +				    READ_ONCE(vq->split.vring.used->ring[last_used_idx].id));
>  		vq->batch_last.len = virtio32_to_cpu(vq->vq.vdev,
> -				     vq->split.vring.used->ring[last_used_idx].len);
> +				     READ_ONCE(vq->split.vring.used->ring[last_used_idx].len));
>  	}
>  
>  	if (vq->batch_last.id == last_used) {
> @@ -1112,8 +1112,9 @@ static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq)
>  			&vring_used_event(&vq->split.vring),
>  			cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx + bufs));
>  
> -	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.used->idx)
> -					- vq->last_used_idx) > bufs)) {
> +	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev,
> +				READ_ONCE(vq->split.vring.used->idx))
> +				- vq->last_used_idx) > bufs)) {
>  		END_USE(vq);
>  		return false;



I also want to know what this does to performance, or at least
code size.

>  	}
> -- 
> 2.43.7

