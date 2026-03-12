Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF8E221DB1
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318062; cv=none; b=AJFF4FxXzVgyfQFN/ND+0xqrOQRTr36RNcLe68W/w0j4BIfSPWxkIAnRvieLU984acy2mk3VA9vawr+oCkJMeZaL3NfzY9YkL8RIqHfojMoUYpTMg4u+Yb94ZCs5BzDXxObWkYoc0RjvUX64NMKGB3rt4I/sWlvEQ2ifMiTpuOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318062; c=relaxed/simple;
	bh=ykZqC/Mt6PvknDhYlKuIL2nlRrianZMm9PtDxixDlPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLbBKj4V3OtzpfhxTqChaBnPq+45JeR/o11acDnAHqsif5B+y+U6/xzd3B8kWgiZazp2mztS+MYbU2LyYRcbcipFOfoFru3SlH1iaX27XcBMZKqMhoyFqW+dRgISd/AUHmJgnFFWWCuNjfXmnMkAvawIpLIaPH4INCCj/Yc/8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cNj5o50l; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cNj5o50l"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50905b779dfso10914251cf.3
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773318060; x=1773922860; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5rN+Dnt+nngZKc/HxpCY0GaFz9G0vHdC78c5bVshyI=;
        b=cNj5o50lxWfYFiiEIKkwRkJtSY3/U/FV2hjvrcptuiH4r798VGkgam+DmAZwcV6k/C
         xxtcnjn/ApSJ/pCpPYwEV3BDHLIxcYUA2c8PBTb73BrDFcCCN2EyOuxoUsLAhmP9HNM9
         5K1m6QFpWIQbqCJ+ZGGU5bXwMYEf57DO63+FScyi9c4ksTaZUNlNB4xRfhd/Zp6ZqW4K
         KUvfFOeBSbTkgobtxMOavDhKC00HG7LACcY4e2aj4SLynMqz6Gmk34VjunXGgIoerJvA
         DxtFeUsqQUWodNqv0yDQnxpoOoes3vhEF1ixtovDawXeoOgyX3Z533B0e16gL4JEbxKk
         DUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318060; x=1773922860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5rN+Dnt+nngZKc/HxpCY0GaFz9G0vHdC78c5bVshyI=;
        b=GAFpFptJ6wZEgSaCAMYzVTsKYpMl5Ov6IOpJvTkvOxcfykCOpatLA1aGisw/5bHncw
         je15TxzUqBzo/bSCLrhn/z4OVIbEIX+SFlHmGcUJf3DxoCkjJqynKOW6DutoAQ/UGp5w
         8MzcdiuUXCtu/jpQmQAL7moblOsmNDsz4QORVBObFXkCvYrmTxtI2vfEz+g+fo+uwKpH
         1r/s+IDD82H/Nt95I6M3tpB2T0D9wzmQdKgzfpwhYcc+lUMbjlu6V8NPk0TQx7tr7xH3
         T1h1+DUbxhUIfXRzE7236DC+eyybeeO0G8mV6SorMOcWnE07To1UUVof0kdUY4S6U3Xb
         ftRg==
X-Forwarded-Encrypted: i=1; AJvYcCWmorrnPrZZHnsgV/vBH5/yB3Wiot3oiMURnXffNM6dExxbQkp/nBWARncY284mPtdUjSKuGkst3mnVNOGsCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxamBNWY4frbt6D0lv+7q63h9R3h/Ykc6JND3PBcywUQh8PHSj
	lhnCdkY9cUKnQQCLR7O6yR2P2EZKIr0dWezMjOOgDJUCDNuxKkj2x03YtHbzvLCjjJU=
X-Gm-Gg: ATEYQzyG7keTmpyEgufXZcCQuPaqfOB+DaWRlD/OkCYOGj4P/wNuz4Zqb0K/4woF9sN
	Ar6wcS0TIyFRV1023aZZLxgTMotip/FyFWdgfA2/IsejEP/PAvcl/68dmq8rGdyGd/CfUbb8XeS
	R9780KRyuAqOiFNkzz9jSy6kdnzZLgd5eR45idl1YBkfUaaM0X5wZB1DfUryPxHozpkeepn7hCG
	fqEF9qTAAhi4GWgeoH3hsxTCR39DkEImgcBNL4ako8/98bLAIFoEfPXa0/JRyAblHvZ2Za6sxnL
	5eb6vb11KcPfxSsedB08bstdb1nNA2FOMj+t2r2+BYybc2YWJtYq7o3CidCO69fOwDL5JyJoFvq
	wdfrH/6Fdq/Zx3rrqQQLdD6ac5rEwvzgD1E8cOxXU92DISK1P+JWPZdYaIs4sizg67StPwK2aQ0
	gkHTsT+ee7BsvvEGHSsexQ7NAdp83RdbjR12ad6SaAJ9w+ewP5u2zd8x4wYIxg1btxX5eUxLbxa
	Eit1/MWt2bYEoMSmKI=
X-Received: by 2002:a05:622a:11c1:b0:509:4410:4492 with SMTP id d75a77b69052e-50944104900mr62025551cf.22.1773318060513;
        Thu, 12 Mar 2026 05:21:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939ec5017sm30688511cf.8.2026.03.12.05.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:20:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0f2A-00000006et5-427z;
	Thu, 12 Mar 2026 09:20:58 -0300
Date: Thu, 12 Mar 2026 09:20:58 -0300
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
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 5/8] dma-direct: prevent SWIOTLB path when
 DMA_ATTR_REQUIRE_COHERENT is set
Message-ID: <20260312122058.GE1469476@ziepe.ca>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-5-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dma-debug-overlap-v2-5-e00bc2ca346d@nvidia.com>

On Wed, Mar 11, 2026 at 09:08:48PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> DMA_ATTR_REQUIRE_COHERENT indicates that SWIOTLB must not be used.
> Ensure the SWIOTLB path is declined whenever the DMA direct path is
> selected.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  kernel/dma/direct.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index e89f175e9c2d0..6184ff303f080 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -84,7 +84,7 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>  	dma_addr_t dma_addr;
>  
>  	if (is_swiotlb_force_bounce(dev)) {
> -		if (attrs & DMA_ATTR_MMIO)
> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>  			return DMA_MAPPING_ERROR;
>  
>  		return swiotlb_map(dev, phys, size, dir, attrs);

Oh here it is, still maybe it is better to put it in swiotlb_map() ?

Jason
