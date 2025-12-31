Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CCE30E842
	for <virtualization@lists.linux.dev>; Wed, 31 Dec 2025 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767214118; cv=none; b=Re7wTWld0bAVRWSjoPAwXPgPYvoQTo3jOhh13RQhZ1Tw/stV4vrWX0xVmkziCPBBXQkhktCkEXDCbdo5v8tKozUJU8O2zSC7jKMQPv8s3O9atpV6j5QgtaznPDWwEd3mM7w+0upepuaPD8F9MKNBoqHNVeEnMEI3vpKnt5qprB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767214118; c=relaxed/simple;
	bh=BpH6W25VRu697Yn7DFwf7krulZ0ceVuuDV1JpnQSClg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Q/w/NaqR8/weQEO0rSJRG99bqH+Bf+nhsNPd/z5ycmwt5njhWQVaSmgj9/4bZrqlLdMATnxr4c9/+WWKJQrShzEUTWzDx5ok6ELOx7PQQf4BKAQyvf7V8YSZ91IefOdTgG0DVz1R7xHs0PrsPurX9OvpwkVEc0k7YN28EBTlnGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhdCmos3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhdCmos3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767214115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t2sN+P6W4rMfz5k+VlkZX24a7rMpvbJroFZ4fnRS1gs=;
	b=RhdCmos3H+0DCCh5q5Xk4htwtWcJvQKikAfN0wIKQxxo1lqWjpOM0jG5UajfGJKLPt6opS
	knRspuTgiRQKzjg9vhNo/thcZ6JbVds6dlAwsZ4HyrnJZX695UPd0/XPb3KvraX/WKU2jI
	DaDq9x4czs3y0ANHQOeivAF1CpVlIXY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-rGd-L_JwOnKvsGqcg3eu1A-1; Wed, 31 Dec 2025 15:48:33 -0500
X-MC-Unique: rGd-L_JwOnKvsGqcg3eu1A-1
X-Mimecast-MFC-AGG-ID: rGd-L_JwOnKvsGqcg3eu1A_1767214112
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775d110fabso94908725e9.1
        for <virtualization@lists.linux.dev>; Wed, 31 Dec 2025 12:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767214112; x=1767818912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2sN+P6W4rMfz5k+VlkZX24a7rMpvbJroFZ4fnRS1gs=;
        b=hJeXuah10j/aHKCBE9bAmOC5JurSeEQimMczEv3+diIRKJlBxWcyJs/f/T37iNhhnW
         f+fBmm1cBrjv894Ibj9OhnNtccQp1yuhEnR6N4ZH4cmy+nY0nm8Flwagui/v5qX2LS4R
         frYo5EhlQGEKhHdw7kc9Hxkz9vpxhwfRtPPmwdUIOEfGxpV6dToeNLjKXe51m8Th0AiM
         QPWB/qcdVCekVM9O4usZnddl/hs8kXoDNLsE/ZUnwgV57LHOQmS8IbbGDsKC/nfHjh+t
         7B3EymvjGj46f+gUCmzpjJylZEDw/qs8nD/ObMaeG3kW/OaE5gLjQvgakjzPxtTfd2yR
         sT6A==
X-Forwarded-Encrypted: i=1; AJvYcCWwmyrRquu+pNmQrxpmdo95YKQvaojZxHl24/9lDIOWqSfNvwgehTaOusEf2OFr60AHVK3eIjuWdN/rdfOh3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxS9MlD8Em6kqEUmgb96ESbKGQfixiaQ6YnbqPdu8zUu2sjGyL4
	5Ti0cCw9fwYSQ62v1hv4wIS1MktrsbjWAiM2VFIenKsOn/zRBUx6a8PkJJtIaKj9wFzGrr3gwVM
	E9291mCFHj4RpVr8CRHHookz15gVEUoaOgDf6vUrG2lOJbA0weSX9cPwA8aFGbsDNbP9P
X-Gm-Gg: AY/fxX4CCprLn06Jwc9eY54Ax9MCB5hWlgpA6+CRFyC5Tzvyl7CtwH22Ij+Eq97c/Bi
	u64je/GLIOf+5kFnNVUPsVp4uhLF9vnchuhSq6xvNWPd8eEvx7wLACngPb13V+RUoaNOM+PIHFX
	8upraMljUXybxamzreL+BlD3oMmiJZOevb9TyenMnqm6H7ktxJ9Fi3MiPM2fe8FmU4o+Z5CgoGx
	kHc6VcObqbcMBt3dMbTMLjuxpdZ4O/iMtcIeYLILmygHldwpsS/NbBPQHVMVTpqHQdS/EDR938w
	OaOdLT5NiCUhjUjVvu1u80Fx3eajZU9max8+NpLDkaFg0GMDw6iqhnfH4RSU3bkX+ZGzqHvzawk
	dvoNyiWebgRHy2JFo00FjAFq4F9bhJHxjMQ==
X-Received: by 2002:a05:600c:444b:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47d1953b77fmr390890865e9.5.1767214111817;
        Wed, 31 Dec 2025 12:48:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUX2S3Ts6MrXbJAEZ1+1hODDbGMnh81w30kfQclg714E6BWRq3zDXGinSJodthec3i9GHMDw==
X-Received: by 2002:a05:600c:444b:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47d1953b77fmr390890515e9.5.1767214111286;
        Wed, 31 Dec 2025 12:48:31 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19362345sm662070775e9.6.2025.12.31.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 12:48:30 -0800 (PST)
Date: Wed, 31 Dec 2025 15:48:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 01/13] dma-mapping: add
 __dma_from_device_align_begin/end
Message-ID: <20251231154722-mutt-send-email-mst@kernel.org>
References: <cover.1767089672.git.mst@redhat.com>
 <ca12c790f6dee2ca0e24f16c0ebf3591867ddc4a.1767089672.git.mst@redhat.com>
 <20251231150159.1779b585@mordecai>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251231150159.1779b585@mordecai>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HBfngjdvUl86znmcCTneH67wNHeHAeEER-7S2IOZsxs_1767214112
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 31, 2025 at 03:01:59PM +0100, Petr Tesarik wrote:
> On Tue, 30 Dec 2025 05:15:46 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > When a structure contains a buffer that DMA writes to alongside fields
> > that the CPU writes to, cache line sharing between the DMA buffer and
> > CPU-written fields can cause data corruption on non-cache-coherent
> > platforms.
> > 
> > Add __dma_from_device_aligned_begin/__dma_from_device_aligned_end
> > annotations to ensure proper alignment to prevent this:
> > 
> > struct my_device {
> > 	spinlock_t lock1;
> > 	__dma_from_device_aligned_begin char dma_buffer1[16];
> > 	char dma_buffer2[16];
> > 	__dma_from_device_aligned_end spinlock_t lock2;
> > };
> > 
> > When the DMA buffer is the last field in the structure, just
> > __dma_from_device_aligned_begin is enough - the compiler's struct
> > padding protects the tail:
> > 
> > struct my_device {
> > 	spinlock_t lock;
> > 	struct mutex mlock;
> > 	__dma_from_device_aligned_begin char dma_buffer1[16];
> > 	char dma_buffer2[16];
> > };
> 
> This works, but it's a bit hard to read. Can we reuse the
> __cacheline_group_{begin, end}() macros from <linux/cache.h>?
> Something like this:
> 
> #define __dma_from_device_group_begin(GROUP)			\
> 	__cacheline_group_begin(GROUP)				\
> 	____dma_from_device_aligned
> #define __dma_from_device_group_end(GROUP)			\
> 	__cacheline_group_end(GROUP)				\
> 	____dma_from_device_aligned
> 
> And used like this (the "rxbuf" group id was chosen arbitrarily):
> 
> struct my_device {
> 	spinlock_t lock1;
> 	__dma_from_device_group_begin(rxbuf);
> 	char dma_buffer1[16];
> 	char dma_buffer2[16];
> 	__dma_from_device_group_end(rxbuf);
> 	spinlock_t lock2;
> };
> 
> Petr T

Made this change, and pushed out to my tree.

I'll post the new version in a couple of days, if no other issues
surface.




> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/dma-mapping.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index aa36a0d1d9df..47b7de3786a1 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -703,6 +703,16 @@ static inline int dma_get_cache_alignment(void)
> >  }
> >  #endif
> >  
> > +#ifdef ARCH_HAS_DMA_MINALIGN
> > +#define ____dma_from_device_aligned __aligned(ARCH_DMA_MINALIGN)
> > +#else
> > +#define ____dma_from_device_aligned
> > +#endif
> > +/* Apply to the 1st field of the DMA buffer */
> > +#define __dma_from_device_aligned_begin ____dma_from_device_aligned
> > +/* Apply to the 1st field beyond the DMA buffer */
> > +#define __dma_from_device_aligned_end ____dma_from_device_aligned
> > +
> >  static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
> >  		dma_addr_t *dma_handle, gfp_t gfp)
> >  {

