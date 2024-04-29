Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70213AD22
	for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416507; cv=none; b=et01ojW9zdq3uySHbKqqm+ALVEh7Xt+vC3KBYvUvQ2STY8ycsxlvd142WtGrpUTalhxvxiVRroZUcgJeaxpDvGfLVjNHeww1Gomed8G10TGIiDBrHlK3/49HXJbeIQ0yP8iv+vpkxkNjseUL/fO7dyepI9LUcy4pqc4eatda5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416507; c=relaxed/simple;
	bh=eZxtrf9lFLbRYS6FHtj2I3gWxhGJwU4It4fKZYp2ywk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MbfnlFgk6RwAhdFC4KXT2VYEHT16iyHUpDO6o6BiQRqQi9yCZz9KNIR/BJSpqbuBTB09oH5OvHEODP/Bbl7/jO8wkRDOqk7gQ82QCIWVEVZTm9VQX2KK8L+j8LhHMqDKEFbHQN/ZvWFtibMmEoH5rzbbXePGYo/GJ5Ef87985FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d4Ugv8L6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4Ugv8L6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714416503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RdG84ex/nMZG5ZQdy1/L27yMdIPK+dfGYmnkbYr0h48=;
	b=d4Ugv8L66TYR+YtfvKvtEztPLi+qOAxwbMS91+w0/xreUYCvhlvxoWveEdi0k2+AECUT6F
	bvJKS6X8Do489mypxyorIk3SPRJ0tst5wlHsTx21283ykPs2Z1hxaND8Hq8CLEAuqBn7A1
	17tezJoEtOTbyL77WLlak4lAmHvVyuQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-wwZdoorNPFCMyip5ULdCPw-1; Mon, 29 Apr 2024 14:48:21 -0400
X-MC-Unique: wwZdoorNPFCMyip5ULdCPw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41c095d5b07so8435485e9.2
        for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 11:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416500; x=1715021300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdG84ex/nMZG5ZQdy1/L27yMdIPK+dfGYmnkbYr0h48=;
        b=X/fc1iTGaFwqgfrSjyCHlVI5hBuuf2GyYlZ5zZ1rTu2xr9Y3pJh54E+DaUDNn9bpbQ
         mOsaYAwqR5OMN9DbNrOn/c+QO/R2WDn9Kd+Cms3GGMnPplPJ/dedjdu8Qqi6qHoplN5V
         AGRKEs+2l/X2pBOGQ4AT2fN5UTZK4n3SxaAr7XaaKgQxu17qZZ6hoV1edhUkonMDB18F
         57XrwFGHG222fxqCspKIu/mD8Nb522PRLEpyvV876wL9dYVFqHhh/jzLl9ZbQMf9detI
         GvkVx9g37RiGApTkbqhnjXgsbsHQwVfRiroR75ZpKLE/ZxNK+Ic+RRx8ixkCuyjxWQnj
         MGFA==
X-Gm-Message-State: AOJu0Yz0zc4TZhW7IROjXM6d+ooX4sc53akUqwpvdYmLRgj5fplHyodQ
	/9jljNZ9PcuG4dRUMshVoZe/zu4NRUe2P+d0kD7bXAQzJcjFtF6dzHumirBUPvjD9vCWyHxbinz
	DTjwsRN62Vlglb0wL0UtY3hRKytrgpusNxPpESCcc21Hpt71gC0LEHcplwWwhEz9W
X-Received: by 2002:a05:600c:510f:b0:41b:f979:e359 with SMTP id o15-20020a05600c510f00b0041bf979e359mr464444wms.38.1714416499965;
        Mon, 29 Apr 2024 11:48:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjtAIlxMm2tBl4L3iWAcVWLXlMihfauuOETtUwmHtI4xqPiyJid/dfBh3OESk5FQcVaWHJNg==
X-Received: by 2002:a05:600c:510f:b0:41b:f979:e359 with SMTP id o15-20020a05600c510f00b0041bf979e359mr464429wms.38.1714416499419;
        Mon, 29 Apr 2024 11:48:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:67cc:7d0:12ee:4f8f:484f])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0041563096e15sm46664716wmo.5.2024.04.29.11.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:48:19 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:48:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v2 3/4] vhost: Improve vhost_get_avail_head()
Message-ID: <20240429144751-mutt-send-email-mst@kernel.org>
References: <20240429101400.617007-1-gshan@redhat.com>
 <20240429101400.617007-4-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240429101400.617007-4-gshan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2024 at 08:13:59PM +1000, Gavin Shan wrote:
> Improve vhost_get_avail_head() so that the head or errno is returned.
> With it, the relevant sanity checks are squeezed to vhost_get_avail_head()
> and vhost_get_vq_desc() is further simplified.
> 
> No functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

I don't see what does this moving code around achieve.

> ---
>  drivers/vhost/vhost.c | 50 ++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index b278c0333a66..4ddb9ec2fe46 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1322,11 +1322,27 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
>  	return 1;
>  }
>  
> -static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
> -				       __virtio16 *head, int idx)
> +static inline int vhost_get_avail_head(struct vhost_virtqueue *vq)
>  {
> -	return vhost_get_avail(vq, *head,
> -			       &vq->avail->ring[idx & (vq->num - 1)]);
> +	__virtio16 head;
> +	int r;
> +
> +	r = vhost_get_avail(vq, head,
> +			    &vq->avail->ring[vq->last_avail_idx & (vq->num - 1)]);
> +	if (unlikely(r)) {
> +		vq_err(vq, "Failed to read head: index %u address %p\n",
> +		       vq->last_avail_idx,
> +		       &vq->avail->ring[vq->last_avail_idx & (vq->num - 1)]);
> +		return r;
> +	}
> +
> +	r = vhost16_to_cpu(vq, head);
> +	if (unlikely(r >= vq->num)) {
> +		vq_err(vq, "Invalid head %d (%u)\n", r, vq->num);
> +		return -EINVAL;
> +	}
> +
> +	return r;
>  }
>  
>  static inline int vhost_get_avail_flags(struct vhost_virtqueue *vq,
> @@ -2523,9 +2539,8 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  		      struct vhost_log *log, unsigned int *log_num)
>  {
>  	struct vring_desc desc;
> -	unsigned int i, head, found = 0;
> -	__virtio16 ring_head;
> -	int ret, access;
> +	unsigned int i, found = 0;
> +	int head, ret, access;
>  
>  	if (vq->avail_idx == vq->last_avail_idx) {
>  		ret = vhost_get_avail_idx(vq);
> @@ -2536,23 +2551,10 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  			return vq->num;
>  	}
>  
> -	/* Grab the next descriptor number they're advertising, and increment
> -	 * the index we've seen. */
> -	if (unlikely(vhost_get_avail_head(vq, &ring_head, vq->last_avail_idx))) {
> -		vq_err(vq, "Failed to read head: idx %d address %p\n",
> -		       vq->last_avail_idx,
> -		       &vq->avail->ring[vq->last_avail_idx % vq->num]);
> -		return -EFAULT;
> -	}
> -
> -	head = vhost16_to_cpu(vq, ring_head);
> -
> -	/* If their number is silly, that's an error. */
> -	if (unlikely(head >= vq->num)) {
> -		vq_err(vq, "Guest says index %u > %u is available",
> -		       head, vq->num);
> -		return -EINVAL;
> -	}
> +	/* Grab the next descriptor number they're advertising */
> +	head = vhost_get_avail_head(vq);
> +	if (unlikely(head < 0))
> +		return head;
>  
>  	/* When we start there are none of either input nor output. */
>  	*out_num = *in_num = 0;
> -- 
> 2.44.0

