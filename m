Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C8E13AA20
	for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416302; cv=none; b=MHr/KOmPe5Vhg9BovL2zxZQmJ/AJeTDuBjwzqUfNBsf12P2CkZa8nEY9VR8XDKSrMVCpp+4d+IQ8i1NW4Nzw1dREnIc9z6eo03K4SxV4bJviWObkv0lNSVpG1Y/tJh9gSdZgX/iJUAee66ezdpzAC7NXWVZ9w3cuKePAu+mPt0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416302; c=relaxed/simple;
	bh=ThzOjjFdSWcf4ZwGD6I9o/10uRl3uJNw5agA1J54e0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HZ54RkmTtXWDeg8ARw1CU1XerBjuIEJaZHWBnR+wSXUYXR1+/41oRYKumBYBxk5PsxNoa7Dbc8h5Jji2vK+5UnhooLYuzboVkSKNnyKqaBHuCQFyDwrEZg02aKWLCGBoSJbwoLYXfT+EfbS+DJYh/Ztw4Niv/tgfpvg/WUvGexc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GGLK6wSu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGLK6wSu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714416299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mVBzmRd7oU5uOx/EylUSgaYUJMx4L8f+1pEBOrD7+jM=;
	b=GGLK6wSuW+H6DBbiqyKb2KpH7cs72pQXGSw25MmSI+yQ9KMmdRcEzQpFuy10OHV4DP+r57
	ulYDP+nQmraJyVFBJd1P9eO5RA9DQUbL2dGkzsozHHssrvrmLCgRCMslLIQoCtswZIUeTv
	XiVWbO5cyyZALZ47Lh5WFwzie1q8bUs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-iotcKRR6NZa5qDjBbMMf_A-1; Mon, 29 Apr 2024 14:44:58 -0400
X-MC-Unique: iotcKRR6NZa5qDjBbMMf_A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41c025915a9so9444015e9.3
        for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 11:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416297; x=1715021097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVBzmRd7oU5uOx/EylUSgaYUJMx4L8f+1pEBOrD7+jM=;
        b=PbjwkqtOgm6L53WfWJkBPGf2AsYG2B5BJm5fs+/DQ4IDG+rg+hkWTX2HPt6FhekxPq
         MhI/RCXOPjNn+pK7MQC3KpFe184oJyQjCXqV1VWbTb2JbZuCeqkjy3KUb1yzWozIXlmw
         sRUwr9w7ZOmd4CwpHgcaycuudMpip2qYCzGSdfPvF0F6zj4opl/bT3MIjfTrFyYTQWg0
         EWD5lt0fhr9zdVaO1ORhvRRYe+FdfCVf+K7HWU2S6ZLchKLROgO6tH/olA1WI2Rs6gKZ
         Gji6Rc/t3H2OYUAF3hYQNPTQtiR8cyczvu5gVeXUI3/+Te8M5wwR0VnwRbtov2fMFDhV
         lErg==
X-Gm-Message-State: AOJu0Yy76WierSDygl3n1EFZjEF1fxQVO8Y4mipW83gAHFU9d+JBwvoi
	O3KJfgFywENYkSVJPuI1xpbQEEYHYJxKTRtA2kLXlee/D1awF5INX8dm2WRz4zXzeX3nXEPIN1D
	mz56w0wt4+/yCaO7CCxHXC3FPDNlYmhLJs7macOxdmZjf1zB9IY4BDs9JZE9JtoKc
X-Received: by 2002:a05:600c:3507:b0:41c:13f6:206d with SMTP id h7-20020a05600c350700b0041c13f6206dmr4572567wmq.25.1714416296610;
        Mon, 29 Apr 2024 11:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuGloXgCYkzrg42at2UQkIWtzVS7rvi7tmkU09K8jMeIEPBTFnAQ1lWfTryCfyH+bMKhVPDw==
X-Received: by 2002:a05:600c:3507:b0:41c:13f6:206d with SMTP id h7-20020a05600c350700b0041c13f6206dmr4572541wmq.25.1714416295949;
        Mon, 29 Apr 2024 11:44:55 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:67cc:7d0:12ee:4f8f:484f])
        by smtp.gmail.com with ESMTPSA id iv20-20020a05600c549400b00418e4cc9de7sm42184282wmb.7.2024.04.29.11.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:44:55 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:44:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/4] vhost: Improve vhost_get_avail_idx() with
 smp_rmb()
Message-ID: <20240429143732-mutt-send-email-mst@kernel.org>
References: <20240429101400.617007-1-gshan@redhat.com>
 <20240429101400.617007-2-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240429101400.617007-2-gshan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2024 at 08:13:57PM +1000, Gavin Shan wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> 
> All the callers of vhost_get_avail_idx() are concerned to the memory

*with* the memory barrier

> barrier, imposed by smp_rmb() to ensure the order of the available
> ring entry read and avail_idx read.
> 
> Improve vhost_get_avail_idx() so that smp_rmb() is executed when
> the avail_idx is advanced.

accessed, not advanced. guest advances it.

> With it, the callers needn't to worry
> about the memory barrier.
> 
> No functional change intended.

I'd add:

As a side benefit, we also validate the index on all paths now, which
will hopefully help catch future errors earlier.

Note: current code is inconsistent in how it handles errors:
some places treat it as an empty ring, others - non empty.
This patch does not attempt to change the existing behaviour.



> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> [gshan: repainted vhost_get_avail_idx()]

?repainted?

> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Acked-by: Will Deacon <will@kernel.org>
> ---
>  drivers/vhost/vhost.c | 106 +++++++++++++++++-------------------------
>  1 file changed, 42 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 8995730ce0bf..7aa623117aab 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1290,10 +1290,36 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
>  		mutex_unlock(&d->vqs[i]->mutex);
>  }
>  
> -static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
> -				      __virtio16 *idx)
> +static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
>  {
> -	return vhost_get_avail(vq, *idx, &vq->avail->idx);
> +	__virtio16 idx;
> +	int r;
> +
> +	r = vhost_get_avail(vq, idx, &vq->avail->idx);
> +	if (unlikely(r < 0)) {
> +		vq_err(vq, "Failed to access available index at %p (%d)\n",
> +		       &vq->avail->idx, r);
> +		return r;
> +	}
> +
> +	/* Check it isn't doing very strange thing with available indexes */
> +	vq->avail_idx = vhost16_to_cpu(vq, idx);
> +	if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
> +		vq_err(vq, "Invalid available index change from %u to %u",
> +		       vq->last_avail_idx, vq->avail_idx);
> +		return -EINVAL;
> +	}
> +
> +	/* We're done if there is nothing new */
> +	if (vq->avail_idx == vq->last_avail_idx)
> +		return 0;
> +
> +	/*
> +	 * We updated vq->avail_idx so we need a memory barrier between
> +	 * the index read above and the caller reading avail ring entries.
> +	 */
> +	smp_rmb();
> +	return 1;
>  }
>  
>  static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
> @@ -2498,38 +2524,17 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  {
>  	struct vring_desc desc;
>  	unsigned int i, head, found = 0;
> -	u16 last_avail_idx;
> -	__virtio16 avail_idx;
> +	u16 last_avail_idx = vq->last_avail_idx;
>  	__virtio16 ring_head;
>  	int ret, access;
>  
> -	/* Check it isn't doing very strange things with descriptor numbers. */
> -	last_avail_idx = vq->last_avail_idx;
> -
>  	if (vq->avail_idx == vq->last_avail_idx) {
> -		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
> -			vq_err(vq, "Failed to access avail idx at %p\n",
> -				&vq->avail->idx);
> -			return -EFAULT;
> -		}
> -		vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
> -
> -		if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
> -			vq_err(vq, "Guest moved avail index from %u to %u",
> -				last_avail_idx, vq->avail_idx);
> -			return -EFAULT;
> -		}
> +		ret = vhost_get_avail_idx(vq);
> +		if (unlikely(ret < 0))
> +			return ret;
>  
> -		/* If there's nothing new since last we looked, return
> -		 * invalid.
> -		 */
> -		if (vq->avail_idx == last_avail_idx)
> +		if (!ret)
>  			return vq->num;
> -
> -		/* Only get avail ring entries after they have been
> -		 * exposed by guest.
> -		 */
> -		smp_rmb();
>  	}
>  
>  	/* Grab the next descriptor number they're advertising, and increment
> @@ -2790,35 +2795,20 @@ EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
>  /* return true if we're sure that avaiable ring is empty */
>  bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  {
> -	__virtio16 avail_idx;
>  	int r;
>  
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
> -		return false;
> -	}
> -
> -	return true;
> +	/* Treat error as non-empty here */

If you write the comment like that then put it before "return":
that is where you treat an error like this.
And I feel Note: is better in that the comment does not
explain all of what is going on, just an aspect of it.

> +	r = vhost_get_avail_idx(vq);
> +	return r == 0;
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
> @@ -2842,25 +2832,13 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  	/* They could have slipped one in as we were doing that: make
>  	 * sure it's written, then check again. */
>  	smp_mb();
> -	r = vhost_get_avail_idx(vq, &avail_idx);
> -	if (r) {
> -		vq_err(vq, "Failed to check avail idx at %p: %d\n",
> -		       &vq->avail->idx, r);
> -		return false;
> -	}
>  
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
> +	/* Treat error as empty here */
> +	r = vhost_get_avail_idx(vq);

If you write the comment like that then put it before "return":
that is where you treat an error like this.
And I feel Note: is better in that the comment does not
explain all of what is going on, just an aspect of it.

> +	if (unlikely(r < 0))
> +		return false;
>  
> -	return false;
> +	return r;
>  }
>  EXPORT_SYMBOL_GPL(vhost_enable_notify);
>  
> -- 
> 2.44.0

