Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E92824677A
	for <virtualization@lists.linux.dev>; Fri, 25 Jul 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753449125; cv=none; b=IA4kotXyCTtsgtfeqKe59M0sAlucnaFinbQcl19JjzT2zya1ITrRjDy+xCM5aMUkbYUbqeljuJ8zGkknauwjLIfQjFQyjz2IcFhQtyt0tuestUMdtneQLhPtFbIgBAXZCMoZILe6dTg0fYtfqyOh69drTbTQXjnEExGcnDFqLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753449125; c=relaxed/simple;
	bh=4eae3oNI/1QzpMOYJGbwbybwLjRh7YnkKjFeCkHKrGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZC+9yDYRAwzvXYgOfydSkbrQGAdZjseI/PmoLrNjadfByH1ChsesPZY8jInHGfXp7JHgywoUEN1R99zUNwX9ADpO4v6dcASIk2QjbMpjaySLaCoVyA/PTJnCuY4BjIkrtvDuppTgZdj3Bzlk8CH3e3UpOkjSIg7hKaCmPWjo8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/VOgu8S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/VOgu8S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753449122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QE5pNevTgSrBNAfqe5rNVIW9hc1HtsvMNrpjAUoQRU0=;
	b=g/VOgu8SKOvhS9FLBowRssNRWF3eQy9+hnXRndKKCqPqhhUgmX4r1+h1yqrMusw/t/s9uG
	o9b8O3tsiQbxqLH/Go/E9EjvKF1E68dhoY/If8c63yYM8rhGhUZXqTbZafEDCBHMP0zkLU
	tAnjTzn/8fS9817WuYiewVFN98X75No=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-WhwUsL5uPoy75KHqML2olA-1; Fri, 25 Jul 2025 09:12:01 -0400
X-MC-Unique: WhwUsL5uPoy75KHqML2olA-1
X-Mimecast-MFC-AGG-ID: WhwUsL5uPoy75KHqML2olA_1753449120
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so11033465e9.0
        for <virtualization@lists.linux.dev>; Fri, 25 Jul 2025 06:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753449120; x=1754053920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QE5pNevTgSrBNAfqe5rNVIW9hc1HtsvMNrpjAUoQRU0=;
        b=BJYJC9O06xNXXQIIKuvU3sXZysNXv93hF7JPMHRPGZkr65SIIjXPesxM1GKbq9vPxv
         04vbKTifW7OoJPsu4RfgnpJ1h3JUO6F1Oqrmz12bP85iaUQXKdaYf7UcjzoqlQL3WajH
         +GLQO6tS74TuxoMAsT7mB6lpGRRAzyisemh8lGyYFiV3V5/0vZ2B3MiZ9gYPBANgKFKB
         2+kJUPOWwv43P1CCMnFn1RHJUM97lPb3Ux1psBn8+8hvqwkmFEUHzxuVpK4gISMoWFP4
         N5TF2Rre9MJXoymKFqshTumUHpKMfeavsKlwG/FtZXEiwzCE9WiJzYvmn5G/ij5NcbOh
         UJOA==
X-Forwarded-Encrypted: i=1; AJvYcCVAHAjvck/5UIv3JkZe460xKacZ9lDypq5Mp+bsYaeuANTBStFW5DdHNjyi5kYNlRkTOUTfMxGqn4U9qXoCIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfXeKj3FfrM++9x7+GsyfEqwxlknj6QQFhmZmTuzyOw3LuFcpE
	CYkX1q+8wo7zK0RPdol1PUYwwlNbEz/NoEuluXZgb8tkIvn3weuEJ0FLFldaC1tLHJ6hzmK9xy+
	MiDDc/yHpeTDcF/rytGl6jT0XVLTDQjU0RyV7Bny9vfrp3HYzcMGBsTDvuiLBO6pe0WOS
X-Gm-Gg: ASbGnctAq8O6dExb3/Aiu7LJScMHnxsyCTDPyI+5tb1GX+FHJdHL+CgRIWWArbhj2Xu
	itq7Z05gna9SvCHRdlEXv/Ekh+CKG/xjzz6ck4s8O84ekUDOOsYfRlOcSlNDSpW7Scgji6Ws3qS
	2sZW5vE9tuideSKyUQFjRGeRYQSpb6YT9HUcBuewyrVqq2P/5MO4f808UnR40uE+JeOwnUr2UMh
	lTNOnOWjCVK1RPXs+jhXV4dQ76waxFYeGN7PVtZeqMuoLtkiiUiM4ApjegBvLpV9C0URl8Hrm/Z
	OfqIxhVvSMdNDPhKCF1CLJXZbSgMjTAzYA==
X-Received: by 2002:a05:600c:3acf:b0:456:f85:469b with SMTP id 5b1f17b1804b1-4587655600fmr18480875e9.25.1753449119516;
        Fri, 25 Jul 2025 06:11:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTr7oYcrZTiXGPdV3WbWEeF3Uca/G8/N4QJ8yjiu46Cu237Z8e7cthr/VFQgMfq45FcU7ajQ==
X-Received: by 2002:a05:600c:3acf:b0:456:f85:469b with SMTP id 5b1f17b1804b1-4587655600fmr18480595e9.25.1753449119098;
        Fri, 25 Jul 2025 06:11:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:153d:b500:b346:7481:16b2:6b23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705678c1sm53152895e9.25.2025.07.25.06.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 06:11:58 -0700 (PDT)
Date: Fri, 25 Jul 2025 09:11:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"kernelci . org bot" <bot@kernelci.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] virtio_ring: fix uninitialized used value
Message-ID: <20250725091129-mutt-send-email-mst@kernel.org>
References: <20250725083635.73355-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250725083635.73355-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dEh6z2uP_AS1mr_484JX9YBWJrIsOSj3xg44T-OiVBw_1753449120
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 25, 2025 at 04:36:35PM +0800, Jason Wang wrote:
> Buildbot reports uninitialized used:
> 
> drivers/virtio/virtio_ring.c:2113:40: error: variable 'id' is
> uninitialized when used here [-Werror,-Wuninitialized]
>  2113 |                 BAD_RING(vq, "id %u out of range\n", id);
>       |                                                      ^~
> drivers/virtio/virtio_ring.c:2077:19: note: initialize the variable
> 'id' to silence this warning
>  2077 |         u16 last_used, id, last_used_idx;
>       |                          ^
>       |                           = 0
> 1 error generated.
> 
> Fixing this by use last_used instead and drop the complete unused
> variable id.
> 
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

I squashed but I think you should respin.
also noticed a couple of minor issues.

> ---
>  drivers/virtio/virtio_ring.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 8f9413acd4e2..7b960ce9a034 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2074,7 +2074,7 @@ static void *virtqueue_get_buf_ctx_packed_in_order(struct vring_virtqueue *vq,
>  						   void **ctx)
>  {
>  	unsigned int num = vq->packed.vring.num;
> -	u16 last_used, id, last_used_idx;
> +	u16 last_used, last_used_idx;
>  	bool used_wrap_counter;
>  	void *ret;
>  
> @@ -2110,11 +2110,11 @@ static void *virtqueue_get_buf_ctx_packed_in_order(struct vring_virtqueue *vq,
>  		*len = vq->packed.desc_state[last_used].total_len;
>  
>  	if (unlikely(last_used >= num)) {
> -		BAD_RING(vq, "id %u out of range\n", id);
> +		BAD_RING(vq, "id %u out of range\n", last_used);
>  		return NULL;
>  	}
>  	if (unlikely(!vq->packed.desc_state[last_used].data)) {
> -		BAD_RING(vq, "id %u is not a head!\n", id);
> +		BAD_RING(vq, "id %u is not a head!\n", last_used);
>  		return NULL;
>  	}
>  
> -- 
> 2.39.5

