Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D946234966
	for <virtualization@lists.linux.dev>; Sat, 27 Sep 2025 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759005428; cv=none; b=hvtpOWH1EQFtcPO7dlN4N7z6z6J4mAwJ6+QjSnEKgC/cGEgTVQnBoA4L4btW85ZPd0km4u9jQnKgdDFHq+wU0Dom1zjNma0snTsadb5jKaVLziT3PNgRXq1FMcY/85c1gIpQWS+sf8VduFn5YMqmyhwr3m3BMLjdWIdFbsNMsUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759005428; c=relaxed/simple;
	bh=sfYVx76JGrxHqHCOgMqEADM4JLCw9ZLaEQjj51LNMr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oVECddxyiEpMwkA8wQfhRrDq1ghNtj7a0tsb6lAV0nyAljU91aLHoJXSBUh7GMxukfhET1dG8SEhEAIMp3u9efweolB8awxkDfAk1MnlzFv+VUbGmkrYsdX/GiMvr9w4FiKLRput1CPLqeotv8aaBGx10dQeEKIQyEzovNHTkfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+Y+Yxzq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+Y+Yxzq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759005425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NSL50vU3vn5zRDcV8odSyRV3zrATLUSrY+rAICw6mik=;
	b=g+Y+Yxzq0GSciQioi7KvDWz9Wok/VYlpXFO3UViW4BE/Z9C/tDcIAHh8eM5Npg6UlZY7KF
	Zoi0/7f+xYUDawzJmA/IWssRy385zrzOxSbU/YHRF/XQxdhOHy+Zk07Z3h2x5O72HJ6sia
	TOq7rPXWMZuKT1KEIq1pJUXaCkGTSrk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-GGTv-vg7P_WWBd80SOquZA-1; Sat, 27 Sep 2025 16:37:01 -0400
X-MC-Unique: GGTv-vg7P_WWBd80SOquZA-1
X-Mimecast-MFC-AGG-ID: GGTv-vg7P_WWBd80SOquZA_1759005421
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee130237e1so1442691f8f.0
        for <virtualization@lists.linux.dev>; Sat, 27 Sep 2025 13:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759005420; x=1759610220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSL50vU3vn5zRDcV8odSyRV3zrATLUSrY+rAICw6mik=;
        b=eZm8XWSxBLt8LJAhbe2uo4mtLlQbY4dPYU1VvLoZliBfQi6PJvH1yz/QDgbVKvC5St
         75QmZYom16lA0drmWWWG9EWpAj98JgqS5FHzkuYZg+X8K7gVhWDNY3iCFwriydJE8Ayi
         tfBh4jnzZ9MWXlAwR/1YWRnRY0Pgi21x+EEQzEqkqeobwJ9AmABQ3OuMBDzmFzbRkS7J
         ByPJpeWV6Df2otcXScGbHloV+5uCqkOt+B/tPQhtGETL5UnzwhOoeaS/LaXxweW45M4z
         zOnC3preuuLTyahMh5DvwZU4PH1Rh4sKN7XEE4Pglclr8ivXbgtxS5cps6Yaq/kc0tqY
         ikIg==
X-Forwarded-Encrypted: i=1; AJvYcCVtzPhYtI5NvKXa2A/PFEB3X2qLWnPq/pyTpsDXysBmSC8Lzp+nwXcxbUcHkwOtCBpfaA4WH4UACVvpRIRnbw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywj85WH4yiogDgswYqlrtOyIBEPYaQeQB1f7muTRSavKNol5kr2
	t4Sf1fpdRC93q+N24FpRe+hZZxuw5I+CPZxn6Tbtb+tGw3I9K+xIdDKKB2cmR9nXuBc126L2SVV
	kWYqxQLE81+lG13CDpZHj2Bss6CfBlCiUMepnuOOgOq7b26/p4fmkj38XJ0ab9S/OdXVmyQXNhl
	gr
X-Gm-Gg: ASbGncvEYq5KG5tjdGXPsRQmz6UX9sA/2EQ71oFaI9fAm+mV3NYlzN9jCHkUQk1FsTj
	k6op3QA2bOKlFdiCQZZCcg/zhSR2XWJFBA6O3hMPCkpRhTOWBI3cjVxGqH1T+cEotwB4dqTxm29
	xBbubTx1BpqhZwVeqtSGLg0fhkKOOzcyGVeZcZeqot+93K8q2xpaPHa4TEF4Avm5cBoNcckO5tg
	mTzYYnfxgunpKvqxjJ751IZib0zXhibNQmnOXG2jB2pGH9i1nfYxh3A5I8B43K1pJZKszdYZt0r
	rvtcqmkIjnqMOMav2wNRMMf4xXKSWULX6Q==
X-Received: by 2002:a05:6000:22c7:b0:3ec:e276:f3d5 with SMTP id ffacd0b85a97d-40e48a56cddmr11399271f8f.42.1759005420276;
        Sat, 27 Sep 2025 13:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf/X8n0rnPQnTiFh6PR8PNOgfG0IN2tIXN0qUNFfjcbHhagOSXpXgOJkcWSW/etGX5pqojgA==
X-Received: by 2002:a05:6000:22c7:b0:3ec:e276:f3d5 with SMTP id ffacd0b85a97d-40e48a56cddmr11399254f8f.42.1759005419753;
        Sat, 27 Sep 2025 13:36:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9e3bdsm131200905e9.2.2025.09.27.13.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 13:36:59 -0700 (PDT)
Date: Sat, 27 Sep 2025 16:36:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] vhost: vringh: Modify the return value check
Message-ID: <20250927163552-mutt-send-email-mst@kernel.org>
References: <20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J9Nxku9BiAAHJY9WbOHumLGTU3d2seM9uYEK2Lph0IA_1759005421
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 10, 2025 at 05:17:38PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> The return value of copy_from_iter and copy_to_iter can't be negative,
> check whether the copied lengths are equal.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Given copy_to_iter was fixed on net, how about applying
this one on net, too?


> ---
>  drivers/vhost/vringh.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9f27c3f6091b..0c8a17cbb22e 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1115,6 +1115,7 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
>  		struct iov_iter iter;
>  		u64 translated;
>  		int ret;
> +		size_t size;
>  
>  		ret = iotlb_translate(vrh, (u64)(uintptr_t)src,
>  				      len - total_translated, &translated,
> @@ -1132,9 +1133,9 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
>  				      translated);
>  		}
>  
> -		ret = copy_from_iter(dst, translated, &iter);
> -		if (ret < 0)
> -			return ret;
> +		size = copy_from_iter(dst, translated, &iter);
> +		if (size != translated)
> +			return -EFAULT;
>  
>  		src += translated;
>  		dst += translated;
> -- 
> 2.33.0
> 
> 

