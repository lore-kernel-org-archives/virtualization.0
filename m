Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ABF8612C
	for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416598; cv=none; b=R2yovuox9a/bzQre9y0MRdUU40q1QJxJFDlJflgRt/1A52g8lNWcLUvFOS/A5shJl3eTyiw+F92/2yslRVRBV8sTmRXfXxU5+e44DGRGlIwRfDOoHbMxErq6zKOTpLO6+ATakb7mtbpT4hdemA/9U1Ti2eEF9vP1atiV6De3wf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416598; c=relaxed/simple;
	bh=ibS47OzWKnXsrz/clEM8WXST7kYkQMIbx8DG7ht8SUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mW30iadtuEOjdazQIqeDyebFke0xdMwlGXtUypDUC8YnRy/4BOEmJXGFaCEQRoEcxTyb87zmk0w97JJsxuKaUaupflyDxhmacS5ZMDLqbqeVocMWG/aNXHCuX/zqU9tU8oor0BQFRwy3JspKYZhQcuY8g4Y1an65gt5qR8yCYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqadV/dl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqadV/dl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714416595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cri9wJQIMuiWfyMRh8o3fAPmxNnbcSXNHzgldLoV4IA=;
	b=MqadV/dlW3kQsqkTbA0W1rkhQQl4zk3cN85JPNvMC5Bnz7GU20pImE96uF/69WKv3duz14
	Nk/QktB3Zg+wGt0Rq+h2jowhxbvuS4MlLBI1+RM/3ue29naccB+zyDE0teNBE8lMRSDRoZ
	pLPRc7Yvj27u8Iwcp4q7AkPV+ztf1Ng=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-bvJviUDnP56b__lmo4NZVw-1; Mon, 29 Apr 2024 14:49:54 -0400
X-MC-Unique: bvJviUDnP56b__lmo4NZVw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41a38f6e371so21491965e9.2
        for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 11:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416593; x=1715021393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cri9wJQIMuiWfyMRh8o3fAPmxNnbcSXNHzgldLoV4IA=;
        b=qm6klLg2NGLP03wsaX8N1YwVdQlMfCy2LfbZl+F9GLuFb8SFjvrrQPIxUlld5HHWFT
         CneAlDR8FmMHblNVyvee3OZPzt9vkXFSj65MtZZjELqE77fPGiC7LCP+WImPfrWM1OE2
         b1krVFgk6UOzVhszRDvqPlt9ZhD7qU+wDvLrRmTBcG5fqDIENJF03XZI3AZ103vvOTPz
         CEzrfihO8H+0fyKiSVKKOqGvzkLlEhDofg98YKWgtUsf/G54SEXy3qnw475UiuLRkGt6
         iI1jSvR5nTf/JWMTe4Yf5UsI7zOQYIBaNRpY0m0nMhkfoLuc1IgK10UFuCXvVMyhEzAJ
         MYZw==
X-Gm-Message-State: AOJu0YwByfUK4GP9Y9/9s8bcJCiZgUrANAinayIIWRK4PtRImCp8NILq
	gizNnNVCrLOp3VYsLau4KYXmjXSTz6jaQejEP9UXmvbLjBKlGP0KdeGzQEUukWISiY2XPhZNioP
	IW4duIF4NOSiiO8EBBQOrPVaCOz4VFwYyDUF19U3lf56n1sQH603yBNetF8wSHmwF
X-Received: by 2002:a05:600c:46ce:b0:41c:2313:da92 with SMTP id q14-20020a05600c46ce00b0041c2313da92mr3567507wmo.4.1714416593039;
        Mon, 29 Apr 2024 11:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkkesKdP7YY8chM377hZx4GvhLIFpBn1K2lrDyPtS5lNinYq8rzhwIkb7IwxxwcLnNiSC0Rg==
X-Received: by 2002:a05:600c:46ce:b0:41c:2313:da92 with SMTP id q14-20020a05600c46ce00b0041c2313da92mr3567486wmo.4.1714416592241;
        Mon, 29 Apr 2024 11:49:52 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:67cc:7d0:12ee:4f8f:484f])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d6207000000b00346f9071405sm30250181wru.21.2024.04.29.11.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:49:51 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:49:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v2 4/4] vhost: Reformat vhost_{get, put}_user()
Message-ID: <20240429144908-mutt-send-email-mst@kernel.org>
References: <20240429101400.617007-1-gshan@redhat.com>
 <20240429101400.617007-5-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240429101400.617007-5-gshan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2024 at 08:14:00PM +1000, Gavin Shan wrote:
> Reformat the macros to use tab as the terminator for each line so
> that it looks clean.
> 
> No functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Just messes up history for no real gain.

> ---
>  drivers/vhost/vhost.c | 60 +++++++++++++++++++++----------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 4ddb9ec2fe46..c1ed5e750521 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1207,21 +1207,22 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
>  	return __vhost_get_user_slow(vq, addr, size, type);
>  }
>  
> -#define vhost_put_user(vq, x, ptr)		\
> -({ \
> -	int ret; \
> -	if (!vq->iotlb) { \
> -		ret = __put_user(x, ptr); \
> -	} else { \
> -		__typeof__(ptr) to = \
> +#define vhost_put_user(vq, x, ptr)					\
> +({									\
> +	int ret;							\
> +	if (!vq->iotlb) {						\
> +		ret = __put_user(x, ptr);				\
> +	} else {							\
> +		__typeof__(ptr) to =					\
>  			(__typeof__(ptr)) __vhost_get_user(vq, ptr,	\
> -					  sizeof(*ptr), VHOST_ADDR_USED); \
> -		if (to != NULL) \
> -			ret = __put_user(x, to); \
> -		else \
> -			ret = -EFAULT;	\
> -	} \
> -	ret; \
> +						sizeof(*ptr),		\
> +						VHOST_ADDR_USED);	\
> +		if (to != NULL)						\
> +			ret = __put_user(x, to);			\
> +		else							\
> +			ret = -EFAULT;					\
> +	}								\
> +	ret;								\
>  })
>  
>  static inline int vhost_put_avail_event(struct vhost_virtqueue *vq)
> @@ -1252,22 +1253,21 @@ static inline int vhost_put_used_idx(struct vhost_virtqueue *vq)
>  			      &vq->used->idx);
>  }
>  
> -#define vhost_get_user(vq, x, ptr, type)		\
> -({ \
> -	int ret; \
> -	if (!vq->iotlb) { \
> -		ret = __get_user(x, ptr); \
> -	} else { \
> -		__typeof__(ptr) from = \
> -			(__typeof__(ptr)) __vhost_get_user(vq, ptr, \
> -							   sizeof(*ptr), \
> -							   type); \
> -		if (from != NULL) \
> -			ret = __get_user(x, from); \
> -		else \
> -			ret = -EFAULT; \
> -	} \
> -	ret; \
> +#define vhost_get_user(vq, x, ptr, type)				\
> +({									\
> +	int ret;							\
> +	if (!vq->iotlb) {						\
> +		ret = __get_user(x, ptr);				\
> +	} else {							\
> +		__typeof__(ptr) from =					\
> +			(__typeof__(ptr)) __vhost_get_user(vq, ptr,	\
> +						sizeof(*ptr), type);	\
> +		if (from != NULL)					\
> +			ret = __get_user(x, from);			\
> +		else							\
> +			ret = -EFAULT;					\
> +	}								\
> +	ret;								\
>  })
>  
>  #define vhost_get_avail(vq, x, ptr) \
> -- 
> 2.44.0

