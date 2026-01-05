Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F96313E37
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606050; cv=none; b=ZxofGm6jytHfR05NiObs8qT4zg7PEEkCDdtB0PjEoOu6Jd/ezTiEJ7Gryp9EazLhbKxdab8Eiiz/mY9h6nUAo3bxSQ7t9kHUL3aHxNGAZ7OXFZJn8mdGFUCF3Yle0ch34UUclj3UY2xEtrtkKEQbaNU50J+9WeHpQkjFILeGYO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606050; c=relaxed/simple;
	bh=kfKJrQ5a7Po2zi22PzxrbpGrQhRcJMv+xYYFiP1AGz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uizENka6VUeCM5k1WZg9acYZi0LjRyUC/p7eaqWAHA2zpIf0GEfwFxfU8wSowut7u6MU2kbMduYRqjHzhRfhfzyYsIPLPcEl5YotVJTFgOVym7HpZEDKarNd/Z/OfH6bkXk0w8AHlAOE3Ds+M3w3m3ELp7KIoVPD/wj/UJvoR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JAp4d4mS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JAp4d4mS"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779b49d724so16817325e9.0
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 01:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767606040; x=1768210840; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoPF4qbo+ysXILWF9RMN1mDoAoivYGl4rzNQocqtbj4=;
        b=JAp4d4mSrRR+yqI8E08iWf3zgqlrPuFuZWwl/TWwNA/DoVz+K2/91flgeSbgPi65TY
         1op7FqKJJ+R+JoR54tttZOtMNXtaOJArtX5d+0SV3n7ZtC3GnmCXfad6TJPRMsbUP31n
         GSCti5NYT1QiEZ5+/MR6FY4YK0t2uMxj1LYqdQ+SUVwSWecdHxjOZQaDozYsvBSHjZzg
         pbodljD6+kPryVZtqcN0Q3E2D3OK4ghA5oMid+UHLjKI/3o+M8LyAuV+V+lmHH5m+DA/
         H4LxR2LwURZtEh/wWBOQSw907WFOsljSWg++MJvZAv/RoI8O0ezKZgdA7EUSSg4i8Q+k
         gE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767606040; x=1768210840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uoPF4qbo+ysXILWF9RMN1mDoAoivYGl4rzNQocqtbj4=;
        b=Vgi9BY0gu5RHZu0vsIrPrcB9yzGsi1Fd37z8qWJSyi1+L35Ll6XSaT0+6MgUxsg4/q
         CXbncV5W7UwL7dIAx85shaIzcWJg67aOeHpWYzqCUKn89xV+y5qbCYjbgl49ekPSAXat
         FBIIWSZWwJQnAd72c+hzsit6YWjJWaDbeTURBoRc4WH4pDmFaKP0Qp+u4Ipi9QkLR7aT
         zJiVucvJb0K6bU3JAUi3yWuPXjwiuPaoLlk06+RsT74njM49aQVkGRbTKXIKro8+wLPD
         tDjM7QS2EYAVe3Bu00iFbAYPZldzHO6nMovtxEEQUSXqnu8YmM+kdSq0RykpNsqj+mWi
         /7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+bEJ0OC+y7x65CTw7z+b2+OJz7WdHmY4GB4OK/o8R5Z2cvFQMyJ8yQTiP/mh7XJocea0BCCpeP3YH0l/GTg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yze/AnxjNF0oEbCD3qzX2X5KMGicCkugpeZIWhzCfbAU723rsLl
	SWxt9kdMopthiXNz/0sRWxKsRL74SZgMUqM7Aq+VnCWnnzwcVa/LOyCUk+gIey15Mms=
X-Gm-Gg: AY/fxX4Xzw4uq/Y8txvyoDejsOjy4i/MekuHcFzdIlqDiyYpquNiKI46Pz7eZ3yyfb9
	i7FW4aFJmKb/Y2BHd97PqsTjsyS5+ll5edTB1EjnfWnnv4NI41xpurUZ9I743optByCsgusSv74
	2GOM4yAG53VioiT9ezUzux19/Kq1E/tXzgChXiGkjrwUuy8kFBF34ltv3F03i7iKNG5aejv2D20
	V1uaGiMpPwpZDsMymGc512mU5tQAo+BekQJ9zFu8DJKPfXd10c3NHWLSqRN9fRT0TzsoGp0zWmd
	hMuiJOf4HIp2bTfpzdeByMQYDJTpONnO03BD+4Mbl4UsvowJfqABWqljYPUGzGM6YAPL7U5zbh/
	VdTBl6oE9YDl0EcS8/0EzOxopCSVGxeUpw5IBdUoyFDGzhvUfhL2diizJTcFCWaoxVuKgTq6orN
	UoaRf7T3Allvdt5ee4VsvtAJDPb9wuwevLj1dBaHpeW78ybxEWoV0WGUH4K8mdaexnoQqkmhhsp
	TuLDwPiOyfCLPU=
X-Google-Smtp-Source: AGHT+IH9uJ6jLlQ3sMbfjfqB2tBZwtUo3Z4YZNjyI98ICTrDJSXZI/68FFDolBTS/hTy3IR7RjNHZw==
X-Received: by 2002:a05:6000:1841:b0:432:84fc:46bb with SMTP id ffacd0b85a97d-43284fc4782mr21485079f8f.6.1767606040029;
        Mon, 05 Jan 2026 01:40:40 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324e9ba877sm100563291f8f.0.2026.01.05.01.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 01:40:39 -0800 (PST)
Date: Mon, 5 Jan 2026 10:40:36 +0100
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
 <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Bartosz Golaszewski
 <brgl@kernel.org>, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 01/15] dma-mapping: add
 __dma_from_device_group_begin()/end()
Message-ID: <20260105104036.09a77f13@mordecai>
In-Reply-To: <19163086d5e4704c316f18f6da06bc1c72968904.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
	<19163086d5e4704c316f18f6da06bc1c72968904.1767601130.git.mst@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 03:22:54 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> When a structure contains a buffer that DMA writes to alongside fields
> that the CPU writes to, cache line sharing between the DMA buffer and
> CPU-written fields can cause data corruption on non-cache-coherent
> platforms.
> 
> Add __dma_from_device_group_begin()/end() annotations to ensure proper
> alignment to prevent this:
> 
> struct my_device {
> 	spinlock_t lock1;
> 	__dma_from_device_group_begin();
> 	char dma_buffer1[16];
> 	char dma_buffer2[16];
> 	__dma_from_device_group_end();
> 	spinlock_t lock2;
> };
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

LGTM. I'm not formally a reviewer, but FWIW:

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

> ---
>  include/linux/dma-mapping.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index aa36a0d1d9df..29ad2ce700f0 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -7,6 +7,7 @@
>  #include <linux/dma-direction.h>
>  #include <linux/scatterlist.h>
>  #include <linux/bug.h>
> +#include <linux/cache.h>
>  
>  /**
>   * List of possible attributes associated with a DMA mapping. The semantics
> @@ -703,6 +704,18 @@ static inline int dma_get_cache_alignment(void)
>  }
>  #endif
>  
> +#ifdef ARCH_HAS_DMA_MINALIGN
> +#define ____dma_from_device_aligned __aligned(ARCH_DMA_MINALIGN)
> +#else
> +#define ____dma_from_device_aligned
> +#endif
> +/* Mark start of DMA buffer */
> +#define __dma_from_device_group_begin(GROUP)			\
> +	__cacheline_group_begin(GROUP) ____dma_from_device_aligned
> +/* Mark end of DMA buffer */
> +#define __dma_from_device_group_end(GROUP)			\
> +	__cacheline_group_end(GROUP) ____dma_from_device_aligned
> +
>  static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp)
>  {

