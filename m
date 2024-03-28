Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487182AEFB
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618296; cv=none; b=Vh/aSPBtgdN0/8at9PbPuUDLgXjUae1lHa3ydvfSIiBArx1nJzbTGLHOp1DgWNu1MdyRG0TnqG3nDWJKDu5mYHraLLPv90LeiHunnbfjlWQpCS/qvCFdwbdDPidUq+aa7oycZEVRcPSUTu0Qr3IQWMKW6zEZJLxxW6a/u/YRAoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618296; c=relaxed/simple;
	bh=UJN7llSWloOuIDmPUo9y4ITRwT/t6aHkKo6Xb+1KdJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EQM6bNDct7h/A4ZRtnphEd2ukP1Ks4MpBdQfJcLQL5n/XZ7dy0THQeJZNA27agl0aNFjkrAYwE3g+Vx2SG2aG04PJ01DBIsJ8O8AaS+azUq2SKdfwjp+YWDAM0IfjQuXhCG9AYvpS3vXR4r0H1hDYwfgIK0rz2pcYtZMWx6x7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ge+l8fJB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ge+l8fJB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711618293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ua5EarvvCOybG1jxpRjFw0PAbL97hvnMCO8ki8fQsj4=;
	b=ge+l8fJBp/K4Hi6o4QEMUYAR6Ahc9RZ2IzeLhHUzJMwgLbIOrr4VKz9WQUKUry13lRH4Bh
	UFUHvEhZ2YTlaKmCO+xLf2pE1CyRQljx3qGv5weq36JRU7H4GMP9D9sqLXvu4hab68yZ/U
	bxJkKv2iGhKhSD75Mycqk2YK+z36fhY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-hpqSclTlPhaTvG2XYuykeA-1; Thu, 28 Mar 2024 05:31:31 -0400
X-MC-Unique: hpqSclTlPhaTvG2XYuykeA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-513e31aef6cso597674e87.1
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 02:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711618289; x=1712223089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ua5EarvvCOybG1jxpRjFw0PAbL97hvnMCO8ki8fQsj4=;
        b=YgxoCQJ2uoOLejve7IwLOcROIwujo8OKTNEsBEXIF2ehZcfLv/2eYIZgccsfMtbRKR
         UaP+lWlt9BmRpoWnOsNK2BJ4a7ThRJ3i0YS9dFi2vdJRMLYcsvMmlEA99CpsxlAUvQt6
         E9uSKl00LTYzCNPR7TrXtYaDI9/Bsw4ahhJ5o3irfme0CUjPri8le+c2Z+ThVBOVcUHO
         LWMYrbMjQbDWs7Ypb31c8KRS1dQBYXgv5/ncjbUHacDwoAHFp2ggoH7EOpvtr/QDp4ti
         AGp33CoMp8wTyWLezSCHPsqCqCiEr2qVDXY5cBy/14tpvpuayRK2ZdFX24keHx62iMrk
         3aeA==
X-Gm-Message-State: AOJu0YzvE/eFG3LLJTuTuyWyz+lKmYbDX40wc7R1nV9K/KWEMAgDf7w6
	5wLuRpGCYkzFjtlI5P0mjCfLzBq+ex9XLR4U21aRQjY8LJJf6X005kvBZ917mG+dcI980ryAmzJ
	1QV/Aysd8IXpcnbb8ldviD+OWxJ0xm71KQO1TmVTwTBTd90+h25ndMDZeBw7ZqfqE
X-Received: by 2002:a05:6512:3f05:b0:515:cb05:e749 with SMTP id y5-20020a0565123f0500b00515cb05e749mr654378lfa.12.1711618289498;
        Thu, 28 Mar 2024 02:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFisRfWJuhlbFUMvd/32hjjG15wfiARI/XrGWl3eBUrZwU/0XaBazhK4Ry6B5HvV7bfIwjJaQ==
X-Received: by 2002:a05:6512:3f05:b0:515:cb05:e749 with SMTP id y5-20020a0565123f0500b00515cb05e749mr654341lfa.12.1711618288700;
        Thu, 28 Mar 2024 02:31:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:5969:7af8:be53:dc56:3ccc])
        by smtp.gmail.com with ESMTPSA id gl17-20020a170906e0d100b00a4df6442e69sm524418ejb.152.2024.03.28.02.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:31:28 -0700 (PDT)
Date: Thu, 28 Mar 2024 05:31:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, will@kernel.org, davem@davemloft.net,
	stefanha@redhat.com, sgarzare@redhat.com, keirf@google.com,
	yihyu@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v3 3/3] vhost: Improve vhost_get_avail_idx() with
 smp_rmb()
Message-ID: <20240328052814-mutt-send-email-mst@kernel.org>
References: <20240328002149.1141302-1-gshan@redhat.com>
 <20240328002149.1141302-4-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240328002149.1141302-4-gshan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 28, 2024 at 10:21:49AM +1000, Gavin Shan wrote:
> All the callers of vhost_get_avail_idx() are concerned to the memory
> barrier, imposed by smp_rmb() to ensure the order of the available
> ring entry read and avail_idx read.
> 
> Improve vhost_get_avail_idx() so that smp_rmb() is executed when
> the avail_idx is advanced. With it, the callers needn't to worry
> about the memory barrier.
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Previous patches are ok. This one I feel needs more work -
first more code such as sanity checking should go into
this function, second there's actually a difference
between comparing to last_avail_idx and just comparing
to the previous value of avail_idx.
I will pick patches 1-2 and post a cleanup on top so you can
take a look, ok?


> ---
>  drivers/vhost/vhost.c | 75 +++++++++++++++----------------------------
>  1 file changed, 26 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 32686c79c41d..e6882f4f6ce2 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1290,10 +1290,28 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
>  		mutex_unlock(&d->vqs[i]->mutex);
>  }
>  
> -static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
> -				      __virtio16 *idx)
> +static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
>  {
> -	return vhost_get_avail(vq, *idx, &vq->avail->idx);
> +	__virtio16 avail_idx;
> +	int r;
> +
> +	r = vhost_get_avail(vq, avail_idx, &vq->avail->idx);
> +	if (unlikely(r)) {
> +		vq_err(vq, "Failed to access avail idx at %p\n",
> +		       &vq->avail->idx);
> +		return r;
> +	}
> +
> +	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
> +	if (vq->avail_idx != vq->last_avail_idx) {
> +		/* Ensure the available ring entry read happens
> +		 * before the avail_idx read when the avail_idx
> +		 * is advanced.
> +		 */
> +		smp_rmb();
> +	}
> +
> +	return 0;
>  }
>  
>  static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
> @@ -2499,7 +2517,6 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  	struct vring_desc desc;
>  	unsigned int i, head, found = 0;
>  	u16 last_avail_idx;
> -	__virtio16 avail_idx;
>  	__virtio16 ring_head;
>  	int ret, access;
>  
> @@ -2507,12 +2524,8 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  	last_avail_idx = vq->last_avail_idx;
>  
>  	if (vq->avail_idx == vq->last_avail_idx) {
> -		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
> -			vq_err(vq, "Failed to access avail idx at %p\n",
> -				&vq->avail->idx);
> +		if (unlikely(vhost_get_avail_idx(vq)))
>  			return -EFAULT;
> -		}
> -		vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>  
>  		if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
>  			vq_err(vq, "Guest moved used index from %u to %u",
> @@ -2525,11 +2538,6 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  		 */
>  		if (vq->avail_idx == last_avail_idx)
>  			return vq->num;
> -
> -		/* Only get avail ring entries after they have been
> -		 * exposed by guest.
> -		 */
> -		smp_rmb();
>  	}
>  
>  	/* Grab the next descriptor number they're advertising, and increment
> @@ -2790,35 +2798,19 @@ EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
>  /* return true if we're sure that avaiable ring is empty */
>  bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  {
> -	__virtio16 avail_idx;
> -	int r;
> -
>  	if (vq->avail_idx != vq->last_avail_idx)
>  		return false;
>  
> -	r = vhost_get_avail_idx(vq, &avail_idx);
> -	if (unlikely(r))
> -		return false;
> -
> -	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
> -	if (vq->avail_idx != vq->last_avail_idx) {
> -		/* Since we have updated avail_idx, the following
> -		 * call to vhost_get_vq_desc() will read available
> -		 * ring entries. Make sure that read happens after
> -		 * the avail_idx read.
> -		 */
> -		smp_rmb();
> +	if (unlikely(vhost_get_avail_idx(vq)))
>  		return false;
> -	}
>  
> -	return true;
> +	return vq->avail_idx == vq->last_avail_idx;
>  }
>  EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
>  
>  /* OK, now we need to know about added descriptors. */
>  bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  {
> -	__virtio16 avail_idx;
>  	int r;
>  
>  	if (!(vq->used_flags & VRING_USED_F_NO_NOTIFY))
> @@ -2842,25 +2834,10 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  	/* They could have slipped one in as we were doing that: make
>  	 * sure it's written, then check again. */
>  	smp_mb();
> -	r = vhost_get_avail_idx(vq, &avail_idx);
> -	if (r) {
> -		vq_err(vq, "Failed to check avail idx at %p: %d\n",
> -		       &vq->avail->idx, r);
> +	if (unlikely(vhost_get_avail_idx(vq)))
>  		return false;
> -	}
> -
> -	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
> -	if (vq->avail_idx != vq->last_avail_idx) {
> -		/* Since we have updated avail_idx, the following
> -		 * call to vhost_get_vq_desc() will read available
> -		 * ring entries. Make sure that read happens after
> -		 * the avail_idx read.
> -		 */
> -		smp_rmb();
> -		return true;
> -	}
>  
> -	return false;
> +	return vq->avail_idx != vq->last_avail_idx;
>  }
>  EXPORT_SYMBOL_GPL(vhost_enable_notify);
>  
> -- 
> 2.44.0

