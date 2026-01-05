Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE69C324B16
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767589036; cv=none; b=TX6D2d0CSCq/o7ZQAyycg+2asWefGdaDAxE/t6L6wDFIJBBX4mK5089BSzhI0lzWb3swRaWNoLHxXm//FLhpb+GdyWNo6T1kL641NgZSDvLWSsvQ2rL9CROXmXkU4gGOI5QmXKNx+t15xXFMSmq+g+OvT3TEKdRLj+VUW4kMkSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767589036; c=relaxed/simple;
	bh=wdM/b8hJbUaslNLfaUyaSG8t8yHTFzri8J0kMFatf2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVsJ/vNnbigmT2d03o67E8nIIT2jYh/TP0UaCI1FslmKGrpHLabVt+PA1qQpqjv9UmK9eez8uUPjuew/MYb0P2Y2UbSsDrLOSJ0GAlZfBzwUb2KBzq7N47a/akdEozEWzEnwWHjNJcjV9t6TtA63EUmOqJ6KlcChHuc7pRrNzxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QNeRHaKq; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNeRHaKq"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34b75fba315so14729021a91.3
        for <virtualization@lists.linux.dev>; Sun, 04 Jan 2026 20:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767589034; x=1768193834; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EOEgCzmZP0GTJHcnce/bEe96Bif2a5t1CJ7MWxViYzU=;
        b=QNeRHaKqeWuGTF7FVCNp0douRxrlUPraONKNzZqjXV2dkZzJEXixtJxHr6OQFRUgmh
         bx/2HcDjvKACwVkj9FBUpRIncffw+LTniW3FZSMe33PWbHSfZm7XjC25lphRBNlYbWxD
         SKll6lT8a56y59SB9kSgISbir3WPv6ErM66NvU2Z5hZWG+oYMoK+sQ4yvmhHh5UxVnpk
         Hg+m1kft6oMJsEdLUV0awENUDuMbnSM4rz6qDULqBYA0nahwqyEMZG1mReyxD8j725ep
         k2qcrj4QumcO7uNa5ynHkpKLzY+K6lOZ+EbStyP7oqA/O6W+jRjaxsiW3GuIiJkkLMXw
         Ueyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767589034; x=1768193834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOEgCzmZP0GTJHcnce/bEe96Bif2a5t1CJ7MWxViYzU=;
        b=QVzPWRksR1zXbDI5HwVKjUTTGOK4M1DaYydddcpV8PBouSm4U6oaLL6mjN2z2j9nVa
         lKB/H7uDknIApQ7tzkIyXyAHCWSiYC/nHG7ccHz1d94m0NvGoi7QJzk+FbU3Ji5pn8tr
         rPCTakq4IFNOckxiQ0BooalXRCWVx3pzl9SsE2rSq3F4inSqsYn5flJJDNsLYJgFqN8z
         JkD97WDCT/6CRIeP5snj5iJ5i5Oerp9AEdBdBe72MD6vWI3CSPzkYIelJB2PlVGhSOhK
         nMVcffQOxWbWXVtB8F0Sqt+lHjAAsDPVy8w7xaiiLD56RWLz8dd1rUCIiGSk1gH1rSFG
         xupQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF/fAZPa32XW+dn94XNkyNTsIP9swjLopsMXZ6zLu3r0zoKfTgBHecYb782o3k0Zx+e9MKRk2A1D21gztjqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUSmWiB4EcB6OzoQu8gASWGxVqZKROYYyfN82tcs2HXS0e8aw4
	xl1iSE3hV7GweQ2eZ6gu4/10/S7RNQvwJl0aCXUB4j7YNKtbITmRuY87SwDpRe5Tdls=
X-Gm-Gg: AY/fxX4lFTUMcsv7cqto5HzdYFG2DhKD+U80SSZJZ+HNNAquFT0zxQkOFlkFiI231dG
	HCn+gpsyv5A35e2RRXA8iWKZQ2hBC92G/5by2/4rerJWKGNgFI2MJmwqpsstgIT75ujRs2/lEOr
	fEF7SV6QszUicRVEE2yFS9EO0DMHuiykqsaj6gbxlXLQwyUJ6DGcAaosCRfc/oA4cb2VO11UHvU
	u9fI38jMc7aayGMrSHbmbEYT6NNBLbV95gQ5AWWEuv/+KqLVqnbl38tNrnjCnlkhRXibyoUNMFU
	8sVDcw/WZ9yhXFos0Y9Hz7AQtjZWdkLoc9cRWEw4DwIfHQhrcnWYQ4iB20jrp3mJXpEaaG5eJRm
	V/oGgtpdP7KkL1TpM0HOIT8TJB/XcSDg4um7wSlJKJ4PXJEiCgWXy2rTlRZ2IpYCbzOOHsV2uIL
	LgPa4QxtUIcfGp/U5x93KVsg==
X-Google-Smtp-Source: AGHT+IECK/LcBFPZYYyRh4cCx6nIWU2Vivu4V4Wo0++VXRb6DotO+ATVsJPLekWH+2yfoIoKe3qHow==
X-Received: by 2002:a17:90b:278d:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-34e921f0439mr39742351a91.35.1767589033897;
        Sun, 04 Jan 2026 20:57:13 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f476ec31dsm4899585a91.3.2026.01.04.20.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 20:57:13 -0800 (PST)
Date: Mon, 5 Jan 2026 10:27:11 +0530
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
Subject: Re: [PATCH RFC 15/13] gpio: virtio: reorder fields to reduce struct
 padding
Message-ID: <w6to6itartzrxgapaj6dys2q3yqqoz3zetpb5bejnjb4heof2c@jkhmal3chyn2>
References: <cover.1767089672.git.mst@redhat.com>
 <55e9351282f530e2302e11497c6339c4a2e74471.1767112757.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55e9351282f530e2302e11497c6339c4a2e74471.1767112757.git.mst@redhat.com>

On 30-12-25, 11:40, Michael S. Tsirkin wrote:
> Reorder struct virtio_gpio_line fields to place the DMA buffers (req/res)
> last. This eliminates the need for __dma_from_device_aligned_end padding
> after the DMA buffer, since struct tail padding naturally protects it,
> making the struct a bit smaller.
> 
> Size reduction estimation when ARCH_DMA_MINALIGN=128:
> - request is 8 bytes
> - response is 2 bytes
> - removing _end saves up to 128-6=122 bytes padding to align rxlen field
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/gpio/gpio-virtio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
