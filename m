Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDC11DF26B
	for <virtualization@lists.linux.dev>; Wed, 31 Dec 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767189727; cv=none; b=IwHLTEOGJPqN16iG46A8lcJmuJ+2vi3QIqB6T+guB0iR2ARo5O5BSDvGrOS7eGjvzgaM7JxA0F3yYcQz1Zn3Hhbl9Zjm8DyyGYSwgI1t46NU7NmZFtBUQrJFqi92G77vkXl+mIy57LNjHSU0+dg37xEovQ6tsJMFIuyNqfBf8W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767189727; c=relaxed/simple;
	bh=4Hf8qGAfIDnMbElA9BV7uSYKEWjXXxN6zt+BgVtPhAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YyJfOzm2hk0c29ov0u/daBWqSrU6mUZgX19PrHCjbj00SDCVaM9/ORh+E9CiYzBe9HMmmCNjAkMUNa6VEkSAPUs/1BfxqJI487eTdmuTgxmebbBiTJvS7AmIVX1fdfcxg2ZBwvSrCgCkhYL5lxaP1zgZBsrwFfKQfq0yzOXXaV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JO2JH8s2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JO2JH8s2"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47d211aee52so7052615e9.2
        for <virtualization@lists.linux.dev>; Wed, 31 Dec 2025 06:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767189722; x=1767794522; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF3B5IdjLDGAw+kMK0g4LlwArvDLn5Kmbe4r9Q45hmQ=;
        b=JO2JH8s2dWeb0R9yZAs+pPTaPxr6Yu6vclfDURqjgaZlziF5urfbA1td0Wv7FufnMN
         zsmj4HSfLj96+S9XL7Dr/h/SyklPAiXjuAxIvh3XjLfmea3I/ZgUrM+ljUcc4uxDyN2n
         XHXeMxIWYZPuwGrqnnODgz+WFMLQV0U/4tWA9MKDOfO/5DtbQCpXhV8fuDkm3L+B+KQl
         UBdNeJGyrn5aF8Mp01czxITNby1oNcfUxG9C7Nl0P6wIVa5v9hi0FZUiGJB7iENqFBkA
         CL/prMWgkFX0U5mWOzHnolbzsIappWie6Wq4S4x1KG0XLq+Dx+EvEQlOL5/iJRGJs/yA
         aBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767189722; x=1767794522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kF3B5IdjLDGAw+kMK0g4LlwArvDLn5Kmbe4r9Q45hmQ=;
        b=ql5WIGP7c6Uqp/BUkXzGbpyLGCc7G+JfypiqQswp2MqUHVArE5+J3sApYYBLiYSOuc
         iQ/E54RpmUtbt4LS9PbZ7/gyFQuK1DPc74jIKLKwuBbApHq67t29k4zvk+p6BDBCOv+8
         URvwHuPumBTwKLA1xPMsRTZED9AbN8Hr4ZIl9yDmr1LXe8bltYLKaKGwhWO1XEwUI9Ew
         /b96zbQ3Pk7jwkebEM1piOh4rmRV76TtQCycuDd/PIVh0erA2CVhu7PrMnknet4QYqaw
         K1AAskRr6/G4NonpyIXBEBjUoPNVxbebIXtHeDELSHUmhqLEbTFpmQs7WYoFY1wuNW7o
         iiAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8atIxc9fF05fQdXJwuxnr+g+qYTeRqAcJat6iJnbhCBkQwgwCJ06kcZhQPqy4wFPn/kfxARViDU7CIqJxbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHCHyUFDGHtoQYwqBbwN1VDwae2o3N2yuF2kYtyxX7J2bEAJh4
	a0mj/8cIVGvmuGwyiGMIJU+m1tiff3oO+c2mxk4flFKVvAF1f4N4IdgNhVpryvfaaKo=
X-Gm-Gg: AY/fxX4iOcgzZMNdgBYDdvGl/WQwREw8nhRRRW8P1ell9fJ2ZlmR5XNv/p0j8rB6/IR
	jnRkYlcXXuAdQrmXdy7Y6NnNvs9B4nLC5fLhNvVQ4IKOI2FZhH7Dt4Yl4y41vgDHNLRqjZNE2Li
	NlXLrKH5HQa3ujKA/QRht+oFVRUSKIymmFfxR2bFkvz9y0dasVNnwvn0I+KTdR+xUgaFSsyGOO3
	0l0lrJTkrwYloXI5npjSTOQvdFfXosx5nwZA08elM6ERROhjeb8hItWUS+b0LK5NNR+L0EycXnT
	UxPsmstHv4qCCtNrAfHdinP0D16QfyWoJgnso43w5qoawOzsIj6RknEVi50m/E2ajGag33vZrm7
	mMlaHmVt4g0sXDD9qzow6IJwi0dIUD6oMdG2DL6tcRKD5WXqEoBZVeDfhbCaWlwi5TDppYWNH7v
	A4DY2cb7cKV3jAuRVeIST4awT2BajFeKI+v5NmUHJzATj7MByNqC0gXgmKIIW2tiYRGSOz52+l5
	oCJ
X-Google-Smtp-Source: AGHT+IE0s0lyU5FbbMJZMjZzb/JdJphgG95YZRZrXFcSa/kp+KRPaXRAnUQjMNNmxS+JnzgO7HwnTw==
X-Received: by 2002:a05:600c:4fc6:b0:47a:94fc:d063 with SMTP id 5b1f17b1804b1-47d19538e2cmr221697055e9.1.1767189721959;
        Wed, 31 Dec 2025 06:02:01 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2ebfsm73767887f8f.40.2025.12.31.06.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 06:02:01 -0800 (PST)
Date: Wed, 31 Dec 2025 15:01:59 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Leon Romanovsky
 <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 01/13] dma-mapping: add
 __dma_from_device_align_begin/end
Message-ID: <20251231150159.1779b585@mordecai>
In-Reply-To: <ca12c790f6dee2ca0e24f16c0ebf3591867ddc4a.1767089672.git.mst@redhat.com>
References: <cover.1767089672.git.mst@redhat.com>
	<ca12c790f6dee2ca0e24f16c0ebf3591867ddc4a.1767089672.git.mst@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Dec 2025 05:15:46 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> When a structure contains a buffer that DMA writes to alongside fields
> that the CPU writes to, cache line sharing between the DMA buffer and
> CPU-written fields can cause data corruption on non-cache-coherent
> platforms.
> 
> Add __dma_from_device_aligned_begin/__dma_from_device_aligned_end
> annotations to ensure proper alignment to prevent this:
> 
> struct my_device {
> 	spinlock_t lock1;
> 	__dma_from_device_aligned_begin char dma_buffer1[16];
> 	char dma_buffer2[16];
> 	__dma_from_device_aligned_end spinlock_t lock2;
> };
> 
> When the DMA buffer is the last field in the structure, just
> __dma_from_device_aligned_begin is enough - the compiler's struct
> padding protects the tail:
> 
> struct my_device {
> 	spinlock_t lock;
> 	struct mutex mlock;
> 	__dma_from_device_aligned_begin char dma_buffer1[16];
> 	char dma_buffer2[16];
> };

This works, but it's a bit hard to read. Can we reuse the
__cacheline_group_{begin, end}() macros from <linux/cache.h>?
Something like this:

#define __dma_from_device_group_begin(GROUP)			\
	__cacheline_group_begin(GROUP)				\
	____dma_from_device_aligned
#define __dma_from_device_group_end(GROUP)			\
	__cacheline_group_end(GROUP)				\
	____dma_from_device_aligned

And used like this (the "rxbuf" group id was chosen arbitrarily):

struct my_device {
	spinlock_t lock1;
	__dma_from_device_group_begin(rxbuf);
	char dma_buffer1[16];
	char dma_buffer2[16];
	__dma_from_device_group_end(rxbuf);
	spinlock_t lock2;
};

Petr T

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/dma-mapping.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index aa36a0d1d9df..47b7de3786a1 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -703,6 +703,16 @@ static inline int dma_get_cache_alignment(void)
>  }
>  #endif
>  
> +#ifdef ARCH_HAS_DMA_MINALIGN
> +#define ____dma_from_device_aligned __aligned(ARCH_DMA_MINALIGN)
> +#else
> +#define ____dma_from_device_aligned
> +#endif
> +/* Apply to the 1st field of the DMA buffer */
> +#define __dma_from_device_aligned_begin ____dma_from_device_aligned
> +/* Apply to the 1st field beyond the DMA buffer */
> +#define __dma_from_device_aligned_end ____dma_from_device_aligned
> +
>  static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp)
>  {

