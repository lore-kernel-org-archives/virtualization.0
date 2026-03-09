Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BE33ACF02
	for <virtualization@lists.linux.dev>; Mon,  9 Mar 2026 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062441; cv=none; b=lBVVD2nvg8Atp4jhz29MF4WbtDlXazOzS39iEPj2mly43/f9u+oHI4y22xJP09u7d9OYu5x6L9Gw730dU9no2lqt3ladUeTbm2l0+NRg0k5vuEm8+EbPk+itWg5dKtbN6bnTXtYhlTsFAzxj5o1hKsGjNPuWqLi8DySi3AK9L/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062441; c=relaxed/simple;
	bh=j2vrFZdiKMAYuLt1g2IsWM44uA/l0EgALyShPIZleAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMXjdIIlBTuBm2CDGDYEc+9gvYleKLGjvg5T8k+oXQAE/+YSn9JNH3R7EuKnwQjGS4uwefuV82oJJy6hmHQPgpqB6UqCgOT6TcXDsUh9xsumc7UruCtZ8wctqIufMjvHYAPDTavUVwtSJPIJsELiEjGrYABGo2enIq4LSJnrvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B47Bb1zO; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B47Bb1zO"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899a9f445cbso142506676d6.0
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773062439; x=1773667239; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yNhIcDXSP15bQbG0gfsf887zPsyic2zzORmBXzBTWec=;
        b=B47Bb1zOH+3gI8wFg3egKC69JIF4Ef+HC6J/jDOzvgtj4LT0dXWnzjdqJUv0FR++H4
         A1Q2XpVUH1SSnNSmRQP5+C0r1dlfH2fEfsdGgbDEt1tLyfJ+6o6LaaWNROtuptuhWaCa
         1QVAXrQqYVdyCatOlLrYT/mu/ZUr+L6oVu+B5xj7x7u60uFwN9kVdhkeXvdMDX9IiM1t
         wT2FwxG1IuOivH9AHb2eQwFqorvtXjwE3YIuqKjldAQcLodY5esF17KItxuGkGwLrpEV
         GUCX3dqojWrPmAJ+dqagQCcMEin2vp5DJURTXCAvJ856eN4f/dbZTw9ujlbBmLS8SZyU
         2YGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773062439; x=1773667239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNhIcDXSP15bQbG0gfsf887zPsyic2zzORmBXzBTWec=;
        b=gJst/Bvgei2/Knj15b5hmnd8IluK99fLQ8uDi3WqO93cTpSrreWRVx6HJrb82HrL1L
         1S1dVTUMJa6jiCODp7yMW02W0JtWz0adaeJgPU7RA5vX+mpgH71ZAj/IMPEl1temXPKW
         xZFs+26/z9c4+RlXvp+RPBHzNPquwk5YK4SPIwH4+CgLCoNMbCH96olXin4iWSjhMymF
         aAavPxSCzSCYGJ0g/LVxdqsgiJoMbF6g31M78D9V9660V25bL7vpuIHg+g1UaxqfCHkA
         wetJ7f2Jp9USqaCAy1leNCGriCV1ifRWcCMttWlTXQhmVXEUytLBV9BzDQrpg7runcvE
         i/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUar9QCmROuoygnzFE6bTJZxVbCNhrSJolppuNGI5MYmE+YILWTftmENlKAy9+7OuUjTWcTV8dpBWF0EjrR9A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyrmv+nKL5SDlOeC28k3IIhIQFfvbjfZFH9SaR/gotT8CQaeWs5
	/gtDjHGrzrr84FhUSF/wkM4BkFmoMYg5pScHXX2gxsysnO1+ghs/qT6jM0zriTx5TiA=
X-Gm-Gg: ATEYQzwk9rDRGdjfXtr+wzPlDBXwuqJ6eiN8eA0vqlIU7icNNAJWGrS0mCPnqUwzO9H
	2dXLu86NdgNHtSv6DIxLQyLo5v+W5zbTaKeiaFBfo3vzOJ2SYA5UfmIYwCQ+oqaUSSrh8Ysvd9O
	8b6D+r2iA0XIlHQfK+EPPmYlnPrRWjY+/2hQfV7ySsvF+/U4o+aCtrwF2FiSPKmbZyLDr8gOmXI
	1oeGWJOjXMNZ3pEpNR4WSj796cRX7jV/tVcp/nXU8HlQvsExHhG5IEvvnN/F6vcHihFRdVfPPC+
	pugOjoImdAqt6mq/36ysHxfo9ClVQK92KR2gBT1AEhrx1YroGkBTMkd5X90kGiGdoJhwOXpuUIQ
	gB5b8WvJwVlWuMYKnS/lukt/slkA7iqZv3rcJZcUtPuwvTPoC8HtiKqBeMqij0jynQe/PLRS+E+
	tqa6mTI67Ht1yXNdQgum/XVPb7gjkoNqA8tYidbKnW6HuNcefTJEJ8M0dOIkOeR4FcN7hsET+WQ
	lSi3KXD
X-Received: by 2002:ad4:5f05:0:b0:89a:77:42d1 with SMTP id 6a1803df08f44-89a30c2c07dmr163990476d6.66.1773062439445;
        Mon, 09 Mar 2026 06:20:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a3140f7ebsm74752146d6.6.2026.03.09.06.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 06:20:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzaXG-0000000G7pH-11Zd;
	Mon, 09 Mar 2026 10:20:38 -0300
Date: Mon, 9 Mar 2026 10:20:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] dma-mapping: Clarify valid conditions for CPU cache
 line overlap
Message-ID: <20260309132038.GL1687929@ziepe.ca>
References: <20260307-dma-debug-overlap-v1-0-c034c38872af@nvidia.com>
 <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
 <20260308181920.GH1687929@ziepe.ca>
 <20260308184902.GR12611@unreal>
 <20260308230916.GI1687929@ziepe.ca>
 <CGME20260309090352eucas1p283a75c78cac495b5ad87df74c79aab07@eucas1p2.samsung.com>
 <20260309090342.GS12611@unreal>
 <c1d058f3-f864-4ed7-9f7a-683d6f4bf1ce@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1d058f3-f864-4ed7-9f7a-683d6f4bf1ce@samsung.com>

On Mon, Mar 09, 2026 at 01:30:24PM +0100, Marek Szyprowski wrote:

> My question here is if RDMA works on any non-coherent DMA systems? 

The in kernel components do work, like storage, nvme over fabrics, netdev.

The user API (uverbs) does not work at all, and has never worked.

I think DRM has similar issues too where most of their DMA API usage
is OK but some places where they interact win pin_user_pages() have
the same issues as RDMA.

This is why I'd like a new attribute DMA_ATTR_REQUIRE_COHERENCE that
these special cases can use to fail instead of data corrupt.

Jason
