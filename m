Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782F7352C22
	for <virtualization@lists.linux.dev>; Sun,  8 Mar 2026 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773011361; cv=none; b=f2T8MjPEwzEgdffkxyZunw0TO+LAsNtLVsyhRd90RN2nwh40hW3lYNFG3ni4o5iqf9v8fE7snaCLEKWFSeNXvqPJDAwQ32c/YZypNbgz0lNHajytWmZoTLKvu4TwHA8OzzFwbdn4Y7JF8kkQfDVgL+Pk1z9VUQ94znuqCwBCtXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773011361; c=relaxed/simple;
	bh=rBbx3d93p2y2jIh4G2U5Gu80cWTEuOIfSXCGSgCzVU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbQayRvYvRQILp1NPoO2rwlTV4xaHgPe+IC+b+Pl7cUigYrpExYT258Hpy7mFIEyMh6Q1qByzdomJVhdkHGNCn19iDrI364sfFhfHoopuxlZMRh3WAQL4zQR8tfuyvC+zpwiAniqSqALb8kxe/JWxNIhziUxss8LH/Aosrrm7uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C884pMYs; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C884pMYs"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506251815a3so99866321cf.0
        for <virtualization@lists.linux.dev>; Sun, 08 Mar 2026 16:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773011359; x=1773616159; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aJUOBkP/5JQJnNKHejLcwjpKdPk3k1pSv7xveepfvi0=;
        b=C884pMYs9CP6HvjhKtgcY8jeT/V/9zfVPxIUL1XnLjhk1fiwNh6K1B5736kjgC+X0z
         s78DNnGXMGq8sLoGyU2FGmLwcr2Avh++XdqyGAVrlEXoUfLrQCl5itFjpr2xjM07iT9e
         QTgXziHsG8lh0AZOM2N/LWDjKuF2y+UyBZOIaSMvHRapNL+bI9xxFBBUF1QHHvYFbW1Y
         l2uAQaT4B3EUILfoiyWi7Cwj2MEchgCCvQg8BdPGY40ExZ3EX0lcQpK2xOJp9bwKBQaH
         XirnObUwqb/+pny5B556oRQ/sD/oQSzHpalMzWwRmSSwivS/PanxgyoQetF2fhOlXp9O
         O1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773011359; x=1773616159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJUOBkP/5JQJnNKHejLcwjpKdPk3k1pSv7xveepfvi0=;
        b=jAOL35Wdj6KIcivi/GZHFfW9yNfad18kDmlnVfceJNwRJWubcyGcq3s6rDb5mljJA1
         w8YD+CGCwRTl17jxIc27r+cjy4d9YQAS+4DHpSoozU6JTE5AstYmyTbyWZXcaQb9Ch26
         3G/SXUJpCFr+WPMZqT/nDoEJ5+/0GbM0XxTQ3Hf3XHVrY3ouU9qI61jL+FaVP7LNsiHo
         VyP2cYnPBB1ZPeBIMwX1TUla2s0GWtOArbmHGo6Vn7ruD/V8sqRN/B3WS5RhtLGilb3x
         rBXvIHG1YnzY5l9hhnd4LbMIxVvH0aoLvmVesIHHm71lBMjlg76P9En+Zr3IcpFi+Tly
         /TlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR83daqAsuslNP45fB8YykeXJi4fagpx9jbQqgeb8GJk7p3qKiURxFKTGxcuXw5RvyrmMczNNUmU6ICzYPeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7912UVVbPPENCpp6d778DP+0CXkkhVBHb+Whn125M7hzK2P/m
	6eJKcjHnhO9IX+1+AKC+J3MRiXHwSoHNgt/WVMl9J0l6ak9zHN0Cz7xHs/4uHErd/jY=
X-Gm-Gg: ATEYQzzwiWtotZBua+h9ilCgDFFIrjrI4y8PAfxvgIrDrg0qa4Mo2+BIG+RS3eXbKpf
	Szlezgq0PbqyfBdxx7hBHEx2hraLAs8jEV17ZsMdQ7LMJv2lqrrdoJUSn3b2SC5d8eMcCzNRK7R
	2ZOsWhfL8AFrSL609LMR820CGbs9QAwzGNPDrp9UUqnVZFd8xSxh+f4hd8T7tIEtL96kCUFMv0n
	efjMz53ginNon57mJRD1A0k2n+jhdxvEeENkyl1kYQxoOTnxH5QncBwvOqlqh7YSm0h7lHi8ASA
	YMw1XW8l3lyVPl98ggJy1Kw/TZXYRApXqp8ICGfd2Ik+VTxsVrSzWm/YB40ItiW/bMqdcnaLjGO
	jitmpLGkM9l+df6OrhrQecoOEkKoV/063yfcvbxvowboQNKtjcbx4q3Nsx0M1kWfpTpqO2TcR4V
	u9+bKW00WyVG3onFsfaQFIz0uAszG2Rhgzh7EkB2YdO6/oQHHqyzn4zbCvcEJRNDtQ1WlCcBMe6
	V1lUoGf
X-Received: by 2002:a05:622a:1995:b0:509:127d:ee06 with SMTP id d75a77b69052e-509127df85cmr39687201cf.58.1773011359286;
        Sun, 08 Mar 2026 16:09:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f66da77csm51473791cf.30.2026.03.08.16.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 16:09:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzNFM-0000000Bzue-3rG7;
	Sun, 08 Mar 2026 20:09:16 -0300
Date: Sun, 8 Mar 2026 20:09:16 -0300
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
Message-ID: <20260308230916.GI1687929@ziepe.ca>
References: <20260307-dma-debug-overlap-v1-0-c034c38872af@nvidia.com>
 <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
 <20260308181920.GH1687929@ziepe.ca>
 <20260308184902.GR12611@unreal>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308184902.GR12611@unreal>

On Sun, Mar 08, 2026 at 08:49:02PM +0200, Leon Romanovsky wrote:
> On Sun, Mar 08, 2026 at 03:19:20PM -0300, Jason Gunthorpe wrote:
> > On Sat, Mar 07, 2026 at 06:49:56PM +0200, Leon Romanovsky wrote:
> > 
> > > -This attribute indicates the CPU will not dirty any cacheline overlapping this
> > > -DMA_FROM_DEVICE/DMA_BIDIRECTIONAL buffer while it is mapped. This allows
> > > -multiple small buffers to safely share a cacheline without risk of data
> > > -corruption, suppressing DMA debug warnings about overlapping mappings.
> > > -All mappings sharing a cacheline should have this attribute.
> > > +DMA_ATTR_CPU_CACHE_OVERLAP
> > 
> > This is a very specific and well defined use case that allows some cache
> > flushing behaviors to work only under the promise that the CPU doesn't
> > touch the memory to cause cache inconsistencies.
> > 
> > > +Another valid use case is on systems that are CPU-coherent and do not use
> > > +SWIOTLB, where the caller can guarantee that no cache maintenance operations
> > > +(such as flushes) will be performed that could overwrite shared cache lines.
> > 
> > This is something completely unrelated. 
> 
> I disagree. The situation is equivalent in that callers guarantee the
> CPU cache will not be overwritten.

The RDMA callers do no such thing, they just don't work at all if
there is non-coherence in the mapping which is why it is not a bug.

virtio looks like it does actually keep the caches clean for different
mappings (and probably also in practice forced coherent as well given
qemu is coherent with the VM and VFIO doesn't allow non-coherent DMA
devices)

> > What I would really like is a new DMA_ATTR_REQUIRE_COHERENT which
> > fails any mappings requests that would use any SWIOTLB or cache
> > flushing.
> 
> You are proposing something orthogonal that operates at a different layer
> (DMA mapping). However, for DMA debugging, your new attribute will be
> equivalent to DMA_ATTR_CPU_CACHE_OVERLAP.

DMA_ATTR is a dma mapping flag, if you want some weird dma debugging
flag it should be called DMA_ATTR_DEBUGGING_IGNORE_CACHELINES with
some kind of statement at the user why it is OK.

Jason
