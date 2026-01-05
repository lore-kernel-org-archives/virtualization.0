Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC44314B84
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 04:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767589006; cv=none; b=rMR3B8gSmvO9v3F/Yur8uDwxSa4oaDok5iwF+GjarSsyXt2NaXAqQy6G1AbuAQ0GxHE32C2h3ApBNiz4CsUG17RB//I09zH22qiXq6c5u9dw9k0ubgloFZidApHhJhtY7CGrD41MnY0r7VU7GpO/dA13yCp1vUWmm5NF+GD2oac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767589006; c=relaxed/simple;
	bh=jBwvhnDfidsek4dpH3nFNU7R+wPfEwm8oFGbdpxTVpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuSD/tr10xTMpsVeRK6CM+I2b80vs4KXOs4TX0lvaPUt0LpTwSWr9lxU569IU749erXbKlrkE3J+Fk2cyJwOCWaDpZnOJKAKtPxQlF0uvzh8zmOuuAHJsku0NakZva+rCyT0sBet6yV8xA81TYki3je6rcCnSSP5do43EgqJ+dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oCgc1Ihs; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCgc1Ihs"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so13136146a91.3
        for <virtualization@lists.linux.dev>; Sun, 04 Jan 2026 20:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767589004; x=1768193804; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3hFH3lNfVrL079RvxBKm1qFjwG/jqKdNHXIh3f8h06U=;
        b=oCgc1IhsBhBJnrwceWTMe0LuQ9Szsd0CHnYUjE66NDnzHfAjbuxfJXMWjT707SD7XX
         3KAOZR45HNsfeFhESzMAb8s4e1EyHYslXF16vDnGaVTyEMSOx33QnU6XgMHtIpxLYlHJ
         /1qHz1iJd/2/QUiD4NL02lHZePu+Au5kmAn8MZi/To7nsu8rLaMvEE55bnHbZtpgYvIR
         XxyzgPnGoxlVFrBeJr5PYq6kal6rClrh8Z+3QkL+ouH4U1IWDSU19sY0vjH5C9iingod
         lD+jE6LeaAVFxqyVpabGYOV3upzI4flq2esow+1qpZG3pazlrSrImPYX+n6GG+jWHHpi
         TnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767589004; x=1768193804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hFH3lNfVrL079RvxBKm1qFjwG/jqKdNHXIh3f8h06U=;
        b=SSsuhocJTfevOwpeYmGsrS+f0rzKOHVRPGE9Iv+4wtV9d2rDFUrVMM2+p3ssI6RLkU
         4WAAwWE4JNrEEgrCwvfYCI0IcdKoAYZKbw/4E1HG2PWmGiT/rfVO+Afz8fpoREcmMNqR
         9pHJaxt/sPp59xmx4QPfJK13jJUyCIds4c9BdzcdqbpUwKk/I2lqOSuzA/DUd/Ihmcwo
         oAn2x89MQwMde4hBD3IUTpC75m4i6uj1d9C2d608T9SDzJ/22zQlT35iW4cCz2+MkKg2
         kOFgYbOL1ID+owJSqhxW/P7p/Zzxr6uiM9WBvuglTP0EsgGN1k9cCNPhksswAOw0zN+9
         HIow==
X-Forwarded-Encrypted: i=1; AJvYcCV4T7d//vIIB1OJShkVpBVTb6Z+lfrLrgE4dIiyx8yKIns0UXUVroVlj0DoEwuVrnwCvCVF/MchXgT7MuCDIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZm+ER/EApvDJdhZU6mJKUuuB09DupBoZAdZD4biH7s2qVtR5J
	ZOaR/ex1EsSYC/KJeOra4M1TVawN6r3I6FshoDYD+tLhWC82F/nbeuqEeWBa79rr/XM=
X-Gm-Gg: AY/fxX76HLv6UvZ8YXvCwfg24pUmtg8N31k4h76PoJcuAN1vyVBKT0DsI5/A+puR1AE
	OtkeOjI2JRrp4FLQR6JvBzHAcE/Aln+tw3XEqI6rc1rvaJ4wYXjlnA4RSsbyecqnttfWWuSoh21
	GvvVwLymnaAx6z5KCsfmIZOa8kYKMrWZIdn3Gv8ZPmtRZ23b8ymDSZG5djtFs73hagKJx5So/UX
	RrfRr0G+hqST/8EFvHv/H6fA2wGwDuW9/xFRku4SELOfaZRj6Sa6H4nTa42HYllOw4O9Hq8ZUqO
	sum8WsGjdMMDiMUgC/a/0n4lLomiYVebEbee+Wr59OBzrnvuz2sWgm44JpU1Z0p1b+ldExIRoYH
	5kfHBT72+jyjLVf83Knd64XWtEVxhfvtM2+0/gWSGgnIfIOa3ZHCW5URG4w7UAz2BuOdOvCijMG
	EBB4NI0H5C1e0=
X-Google-Smtp-Source: AGHT+IFZ00gScIfn7Z/S2C4S8PPgyPbUGX5mTMlgh0Rzf0TnKH5YXmLt4fA7cx6w6t8/JqVkxOTy2w==
X-Received: by 2002:a05:6a20:918e:b0:364:13aa:a526 with SMTP id adf61e73a8af0-376a9ce54bbmr44864432637.60.1767589003573;
        Sun, 04 Jan 2026 20:56:43 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bd61b4csm40590900a12.18.2026.01.04.20.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 20:56:42 -0800 (PST)
Date: Mon, 5 Jan 2026 10:26:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Petr Tesarik <ptesarik@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH RFC 14/13] gpio: virtio: fix DMA alignment
Message-ID: <nyz6mnesozpu5u6p2mxrg37fwuj3sy7hjo2xkyepd3aybm7m52@7weoocg2pbs5>
References: <cover.1767089672.git.mst@redhat.com>
 <6f2f2a7a74141fa3ad92e001ee276c01ffe9ae49.1767112757.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f2f2a7a74141fa3ad92e001ee276c01ffe9ae49.1767112757.git.mst@redhat.com>

On 30-12-25, 11:40, Michael S. Tsirkin wrote:
> The res and ires buffers in struct virtio_gpio_line and struct
> vgpio_irq_line respectively are used for DMA_FROM_DEVICE via virtqueue_add_sgs().
> However, within these structs, even though these elements are tagged
> as ____cacheline_aligned, adjacent struct elements
> can share DMA cachelines on platforms where ARCH_DMA_MINALIGN >
> L1_CACHE_BYTES (e.g., arm64 with 128-byte DMA alignment but 64-byte
> cache lines).
> 
> The existing ____cacheline_aligned annotation aligns to L1_CACHE_BYTES
> which is now always sufficient for DMA alignment. For example,
> with L1_CACHE_BYTES = 32 and ARCH_DMA_MINALIGN = 128
>   - irq_lines[0].ires at offset 128
>   - irq_lines[1].type at offset 192
> both in same 128-byte DMA cacheline [128-256)
> 
> When the device writes to irq_lines[0].ires and the CPU concurrently
> modifies one of irq_lines[1].type/disabled/masked/queued flags,
> corruption can occur on non-cache-coherent platform.
> 
> Fix by using __dma_from_device_aligned_begin/end annotations on the
> DMA buffers. Drop ____cacheline_aligned - it's not required to isolate
> request and response, and keeping them would increase the memory cost.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/gpio/gpio-virtio.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
