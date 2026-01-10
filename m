Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087851DED40
	for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768089252; cv=none; b=mYcj6hnHwifv+XSMm8/PvYPUEBYdUhQvg7fY9xgr1O7mHnvvcOFH7Y09NaI+S7PWMpCF9OGU3072SirNKfqYS6IWq7LN6oTi9S9Ds2CRi1xecfPXj1MM3rfoGlojUXpjynsd8UO5xW/kgkRpcHKYTAwYjE2bjEkgChuqXR38eeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768089252; c=relaxed/simple;
	bh=Va3PZ+XyHWYa7wvBVca2BSI3zTZzZLZMzJcYIoJwDzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RoeUEQmphn4SVKkCthsBdQ9qVEaprzUFOJMXknibIOqBw0kqv6LRynUj1jdnCPTmbwS9xPlsiJFoy2FUaKXthXatTIP5wQhgRqmZMi6LYkRSxf80yn4md5SSRSc2UwIVYGQuvkB4YS+0Pqctg4tcdM8/HVz5e0EnY7I3COcJloA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAKptrDX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAKptrDX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768089249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMIqYyYEkztN33AcbA8wyUqktgEZTsE9ZUOY1WJxaMg=;
	b=AAKptrDXT49NWSjHG8bfpeKtGkoR2G5aA0gxVT9YSfLuC/YmgeT+ByVFKkCB2I8NR+2xnf
	oKe7FonE3ZOpmip0Y/6+AnvxqLKoGWDyBICLLVKyICRqVXpgWC8R+/B5GWeU9a7knj5nDJ
	WHdSpHt3xKsKAAaJYcuVPsqlHfErod4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-hCxG3Mm8P46q8kVaznV_sg-1; Sat, 10 Jan 2026 18:54:08 -0500
X-MC-Unique: hCxG3Mm8P46q8kVaznV_sg-1
X-Mimecast-MFC-AGG-ID: hCxG3Mm8P46q8kVaznV_sg_1768089247
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d62cc05daso35249445e9.3
        for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 15:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768089247; x=1768694047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMIqYyYEkztN33AcbA8wyUqktgEZTsE9ZUOY1WJxaMg=;
        b=oorLHuXk13IynTSNeTYm/cFsaKGq0RNyV6OTJ2O6PUSG/V22m0hXxWkJ48y23ZaV+3
         aKwAkfrqzIyo4G06KUElW/7KRAWXRny0h6W1AXwKXMOhmvZnem+MczxV3ZwGSJVKr4qG
         uYsbN/YAJgV/UH14mY8MjoWy8s7Eq1gW1AvncUDpbI2dhVvcQM8f2lhu56SgoXDzPiic
         dtr5d/PLxFXJbJox99NmQRirumU7suE43cFMoMsarOBP2pVVImxnSrvGCSSZbJPYOyIO
         Pd9s/ppsVjjvJ+QMTgfmE3b9b2u2fOrcu+xMWsQ45RTO8VIBhO5NZFQ5C6S6Uzgbo7x5
         Ssrw==
X-Forwarded-Encrypted: i=1; AJvYcCVDa9h1NjhAE3GVDMkYKJywZe24CdNP4mgJVz/m9EdEkwQS1B/6xnZWMvHt1EqL6k5dsPCefj8e6VfZyu/Ngw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDHJCeN1bIIW/KPHcr9NX7K8tBbHZUVQ6Ibeh6G14rHsgpzNM6
	HeVtowDvlx84iyWCCMs+5LPcucrUZ7XN+rBr6Nl74QebZHLJP9Mi9kHptl854Ska7mdlkn+p6wr
	XtoNIXcAC6DSGsOPb1l0HTpZ05l4jZ930Cx9HdW68bpycfS+eyezqSBdwyalXdOdxwOB0
X-Gm-Gg: AY/fxX5GhFX2OBdCJoxI4IE4t2KgPPPQfUMCSCB1fBBKm7hkbFLJaeRmy1Po/yxBMRi
	o5pg5fwfl90RsqSlpZgWONKZtm4CB9VJRapVxjUkjaoYK7Y/CNeXjUgVfAxF70X6ksuEI1hmyGr
	/dz+IBokiyrwou50ofwIJBbHv83GGUvl86nMK7FcFnwy0QV9AbBKcB3TkbH/d3cbp7U4q6oN7Sy
	TmGoc5bKJpmjsruqEkMWaemAEOb5aL16sShv/uAd6mvhf7zyC8+kXkqslTsaxun7AIiPUSORNZm
	E6DJdQ+27lINSwY0rzpyPGXJXu2lksJiaZh5wYk93C0SCcDXDkUAv4ozHe2RAv3/SJgOF3bpG9B
	DDfLwAzJHbUrKoAE5bjLDWje57QyReBM=
X-Received: by 2002:a05:600c:1988:b0:477:73e9:dc17 with SMTP id 5b1f17b1804b1-47d84b52c14mr169376045e9.35.1768089247034;
        Sat, 10 Jan 2026 15:54:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2lFv6S2UpYScZqXvGjsvTnj/bNNQPc/FV+uevdBAkv0ovWOp0NMfbAA2MPXsWK69PV+zdKw==
X-Received: by 2002:a05:600c:1988:b0:477:73e9:dc17 with SMTP id 5b1f17b1804b1-47d84b52c14mr169375965e9.35.1768089246654;
        Sat, 10 Jan 2026 15:54:06 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8719d057sm93697125e9.16.2026.01.10.15.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 15:54:06 -0800 (PST)
Date: Sat, 10 Jan 2026 18:54:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v11 09/12] vduse: take out allocations from
 vduse_dev_alloc_coherent
Message-ID: <20260110185006-mutt-send-email-mst@kernel.org>
References: <20260109152430.512923-1-eperezma@redhat.com>
 <20260109152430.512923-10-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260109152430.512923-10-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z8O5FKKra3E2NrDcc_IpvB4vxYyagkYURUgiyuoZCCA_1768089247
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jan 09, 2026 at 04:24:27PM +0100, Eugenio Pérez wrote:
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 82ee476d45e0..675da1465e0e 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -923,16 +923,24 @@ static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
>  	if (!token.group)
>  		return NULL;
>  
> +	addr = alloc_pages_exact(size, flag);
> +	if (!addr)
> +		return NULL;
> +

So addr has allocated pages here ...


>  	vdev = token.group->dev;
>  	domain = vdev->domain;
>  	addr = vduse_domain_alloc_coherent(domain, size,
> -					   (dma_addr_t *)&iova, flag);
> +					   (dma_addr_t *)&iova, addr);

and then is overwritten here ...

>  	if (!addr)
> -		return NULL;
> +		goto err;

except on error where we go to err ...

>  
>  	*dma_addr = (dma_addr_t)iova;
>  
>  	return addr;
> +
> +err:
> +	free_pages_exact(addr, size);

only to try and free NULL. will leak the original pages, will it not.

> +	return NULL;
>  }
>  
>  static void vduse_dev_free_coherent(union virtio_map token, size_t size,

