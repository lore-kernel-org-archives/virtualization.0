Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A6B3D412B
	for <virtualization@lists.linux.dev>; Mon,  9 Mar 2026 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069239; cv=none; b=OgW5fpp3U/dGtTJkzEPiww/XtSwKlphpZGXiLy4OEYGu8KNGx/lbvytLzp5b3V2CeyrrqmbDERyfq0+xNDMfDOhgR5cKQTOxvlRaCS6F3abiegS2gsCVgjKm7vnRV9KAO2Fw+0cSZFnkH+RdYZhSrkGkw4DtbtKs8Aw8KKt4GSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069239; c=relaxed/simple;
	bh=EmTN4lfqvNBf2NGWRvyoj3Pdz7Zrbn88TVlk/KgiBfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNqzg4+IeNWWj4ikMfZhkR17MQOnptmQ5wt3DTB4pZr4qW9xJ8ddpfpsSeZlEMfjUGNi331AaZsEbOn5g4jvn8yrzkp0YFRF1+gTNNIhqivTw4QCizltaFw646DMrdZZUtE0aJC/xeT4PbFTgzv01t8/kDM+YDh8yvoMj6A31DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Z1C/wI4H; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z1C/wI4H"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899e43ae2e1so76830406d6.2
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 08:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773069237; x=1773674037; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EmTN4lfqvNBf2NGWRvyoj3Pdz7Zrbn88TVlk/KgiBfY=;
        b=Z1C/wI4Hotcfwcf7X46ZNmNiOXdT7cqaq/6NC3R4V12s5S4HI887hHZr27MRHEBjAM
         a6qouQV+Ux7HA/U47CRfLVGmWv2uio6/Qx6HW4px+uEIKrmNDFAmuIemRKHnzkDNTxST
         6ICupqZVMyvR13c3cSrVBE0rqf8Hm66eT6Fz3HqINrxB15umd+i+WNgklSxkD3rtlDpc
         aCCk9RkNwtYHMjJaWgQOFiVoSI9Ri1tYS5yV6bi9+zcao0pNf/CcYFTFQo0TKmvQZraJ
         SvsMPp/q8sN9tFUPNnWG5oZkqJAjC5XGguxQVsyicnf4oGIigpFBVMCaMeGPT8/1e5DF
         vqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069237; x=1773674037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmTN4lfqvNBf2NGWRvyoj3Pdz7Zrbn88TVlk/KgiBfY=;
        b=a6hLTvvv8wMZERApcQ2fBHf0ENo6nPT0TCZCoFbXkCZrsWya7PrSZIp9REfUSdxPhb
         uJ06oGe49gSfMrs7e2JnkQ0fN3F1xebCa7XeEGJkRQ5jZ5hKAN6zgCjYQ1HOz5cpN46O
         ncCcw6v4DGiHZ4yED+uNSETGvRbSOb2HNJUNRJcB/2MT23huL1Zc6tBXpyEqFKl+Q4qy
         joPWESoRqVBSf2y6AkE2qEa2wq5akCP1ceIsgaPnwqw4N5+h+x0ed9jVS9Kw4p5fWUX2
         UjqpZuFt1Nb5pVVTZxFVi1lFOzje1H84IeGCOkM04TdisBUcaNmc07HBWpT/9gd0ak/4
         M5mA==
X-Forwarded-Encrypted: i=1; AJvYcCV6au8jg65k6ys7E9buNG9ttlUXXVlxINgQaSi1ovxJAvKYY9Rf+gxAAFP6AjLfmojOqBiVKjs7oWtYeNxD5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/RpPrEgr6Ge/4/sinm/LBeFdcaSHvSeGc5k39cZa0d1ee1dtQ
	gd/kVrl5IUNzPIB/mMWgBJFpJ5e/p+ZzgQcwWw5Juu2DUD89/62cnym7ncUHmrjotbs=
X-Gm-Gg: ATEYQzwjTugepLHFvVJbRe0udedU2J4eUo45F8kf4QXlLNEMW9MENhkXw66doPkDzoF
	7LDe/UvESsGdy0wqBs8SbdIZL1+EPhdAYjsDp3EZVsO3me8ThxrDV8mVS8UEqkDCEAvtbrbDnp1
	sFvFf5dFtTIP6HBFoqke2VxIaemhbriXUlgeXug1aZSpQ3AuV/vfJx65Srhr8Ud/MrW58e8UUin
	FC/4G9dd8Zn4Bya6eaLTt+8HbeeQqgmR6hlotJVe+MFP1pG0K8YlTsJioWzXzJDTMzzblzYxhUW
	P06I2YIDXnM3C2F3ZsAh+D8s9aNerK1F6pzqFqCMJrd3oqUso3u4tSQ2L3e/9RllvW4rbse9Gjh
	IpQEjz8WF0SCh+phLfqhzY6JexKrGUvOkVjEPi7ckuojEx8Fd6xq+WdQzBLCSnIr69hlq15FhG9
	kkFDTX+gN529mmGDNnwHiqrMSoggRNGVN1DDGGOzGa47MG6BuIXulJ5aRBBs5eZQ3/ocwLDb1u8
	W+HWml5
X-Received: by 2002:a05:6214:224d:b0:89a:909:260 with SMTP id 6a1803df08f44-89a30acc08amr165840456d6.48.1773069237301;
        Mon, 09 Mar 2026 08:13:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316d8936sm85242106d6.28.2026.03.09.08.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:13:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzcIu-0000000GhN4-0sDe;
	Mon, 09 Mar 2026 12:13:56 -0300
Date: Mon, 9 Mar 2026 12:13:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20260309151356.GN1687929@ziepe.ca>
References: <20260307-dma-debug-overlap-v1-0-c034c38872af@nvidia.com>
 <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
 <20260308181920.GH1687929@ziepe.ca>
 <20260308184902.GR12611@unreal>
 <20260308230916.GI1687929@ziepe.ca>
 <CGME20260309090352eucas1p283a75c78cac495b5ad87df74c79aab07@eucas1p2.samsung.com>
 <20260309090342.GS12611@unreal>
 <c1d058f3-f864-4ed7-9f7a-683d6f4bf1ce@samsung.com>
 <20260309150502.GX12611@unreal>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309150502.GX12611@unreal>

On Mon, Mar 09, 2026 at 05:05:02PM +0200, Leon Romanovsky wrote:

> Regarding failure on unsupported systems, I have tried more than once to
> make the RDMA fail when the device is known to take the SWIOTLB path
> in RDMA and cannot operate correctly, but each attempt was met with a
> cold reception:
> https://lore.kernel.org/all/d18c454636bf3cfdba9b66b7cc794d713eadc4a5.1719909395.git.leon@kernel.org/

I think alot of that is the APIs used there. It is hard to determine
if SWIOTLB is possible or coherent is possible, I've also hit these
things in VFIO and gave up.

However, DMA_ATTR_REQUIRE_COHERENCE can be done properly and not leak
alot of dangerous APIs to drivers (beyond itself).

It is also more important now with CC systems, I think.

Jason
