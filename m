Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6BD2F6920
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318880; cv=none; b=eSNv8isXBJGJuUoTLEnjSRxhSadYxIguQ7EHpapLok6Wk5pkMJ/tyFw0sJx6pAb+1l/h2117EYMFQdPCxfHJkWQZsrogRm3oHpJpPzUIEaeQhUvMKG6RiRx/K9Sl7AXZG0wGT7JKH7nivv/TxfSZm7Sh6bTFZ454STRC8jXnr0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318880; c=relaxed/simple;
	bh=APBW+HdbDJGC0qi66ebGpgzi6a/5pJAPmLFyIpoPoUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4dZQFz3XRnrwxZwbTuF6HbMOeIwqyvyARh1DaYk7J4g23j7KqL90iziVea51af7XKb2xeJoLCD9OEJs3PVycwG2Hn8hYkUTrzzDzEnCZcV/SstIZ33AHhPkWBztFSz0nlEs5TQqTA+STMbKGUNj0+YCq4Vu0gILSbeptwRxvKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nczf3MON; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nczf3MON"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cd75abd09dso113316985a.0
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 05:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773318878; x=1773923678; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULg7grqreMOX2MMOX7z3yI5zs+73GrCTo1UP0N+hYkE=;
        b=nczf3MONJUWYbuFuVaB7tcr9RLMJRoTGRIJkYGUyXK0ybNQHWNhRg0+/s0iG6pnFoc
         ttAeS329vXEIK5as1pnyZW2y2RVtyG4/dgaAt2bD3FyqMnns4ZUmjXEHuJ0LEduoEO9f
         uG8Vfzbdt3T1Uhg7H5+nPaIOgVy0HRwP7S92A2/O+x+DnBx66pH8fzqdjS845WlTHcZ3
         ghfsalJA0n3/TOZP3+k9Z5sKEc75t6W1zeQfhKa+zrwh4cmUUxHyFEho5+FgOrUvf6Tw
         zHlobmFUy2xZqeKWImlj2bs/CUl511geCguJd/ZRWa67D33I5E0SUp/s5F0KAjJKMS6M
         zowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318878; x=1773923678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULg7grqreMOX2MMOX7z3yI5zs+73GrCTo1UP0N+hYkE=;
        b=c+ox3xh8ZwQgeZxRbO2/Ul6oSQrhZ8NU8uojGiJHLIupaJEaz+Cka9iGqSPFBIyvRN
         +aLkJzfYW0zyBxMH5TuQWjhmYnNu0Z+1rVBIR0Go6mbb0TihVxaNYK1t6pYe8khxYIfE
         2x3WuHRKEcaqs/lx8/VUgwFaXZaTNoR4sS7V/bJskT5sjN3rOwSSENHreaK8pgPu4se1
         WpzX7Th6vzEnbsRRJERzw8cPExvkwtV1H3ZKs9PLcbU+iy5gJ9LG5B5sSUDden3rZXEl
         i9Wd7r+DgUkVm6LTQxttCpDz3l5PZkPN4GwhAdy7OdAmHOt1xCPHkEB0FJSnzB71X5AG
         A+Zg==
X-Forwarded-Encrypted: i=1; AJvYcCU3tAJJVmf5hq67Lm5I09hq0lxialCIvz1SkAsI94iFuWv+aGe2YO4xK8in7kYf2FgTqkh6d0kAyPIS5AZPuA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjPrLo/7OxpLpH/d1PvHw36mPV/ByzTSBF7vgNLCQZE7YiqCjg
	T+xOMuSIZ2ThMqU2lvYmJIIvZPw61/4oaw34V/0okMFwc/igeLq1PqNkEZn7i1WJmYQ=
X-Gm-Gg: ATEYQzxpu28Gku0vJ/6GEhmFNwi60bD/O1w13cu7Rh2L76Kp9LwWy/CEbUDvmlsGuX6
	T4WvoiBoS0uyRsdLWEGtPF/3P4T69bR7h3PxzEqzeSjVBYLvs/Ze7yk1vMqQXBMWAMFj17hTatA
	bqQj/2jC6CdldvNG1Uq14aZmXDszb1Mgwpy1s7Mh+J+TUcLFX/jE7xhwTZt34DiIJPYtxkN16Wz
	r9G/9LcbHlsYvgIivLHI/yOoJINBooyMGWbcLaJS+wbuagoJh1VfIjGafL0Kt1cfsSdRKPLWdAJ
	NYgKDag4p/gOj/k/GA/5GBZ+k0iDb3nYxAWjDEnWDwPRqAXs5l+dvs8SJwKY49QEYx215XfPqWE
	zbu4QxDEgQFfTmaNUu3ck8bU7R08GcEluK1GzmLO34TsdjX6+sKi/pUSchAE3YI/IugpLsfoLCc
	CwQ3GkBBvdMS2DyaOyt57zoY1RuUWre1pAfTtUAFXvHijPBC66/F5tJ7JyGa7pBR8HhmYDkuJjL
	2HW7stz
X-Received: by 2002:a05:620a:46a8:b0:8cd:8938:eff9 with SMTP id af79cd13be357-8cda1936a90mr737651285a.1.1773318877767;
        Thu, 12 Mar 2026 05:34:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21346a0sm323887785a.34.2026.03.12.05.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:34:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0fFL-00000006ezF-1zix;
	Thu, 12 Mar 2026 09:34:35 -0300
Date: Thu, 12 Mar 2026 09:34:35 -0300
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
Subject: Re: [PATCH v2 7/8] RDMA/umem: Tell DMA mapping that UMEM requires
 coherency
Message-ID: <20260312123435.GH1469476@ziepe.ca>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-7-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dma-debug-overlap-v2-7-e00bc2ca346d@nvidia.com>

On Wed, Mar 11, 2026 at 09:08:50PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The RDMA subsystem exposes DMA regions through the verbs interface, which
> assumes a coherent system. Use the DMA_ATTR_REQUIRE_COHERENCE attribute to
> ensure coherency and avoid taking the SWIOTLB path.

Lets elaborate a bit more so people understand why verbs is like
this:

The RDMA verbs programming model is like HMM and assumes concurrent DMA and
CPU access to userspace memory in a process. The HW device and
programming model has so-called "one-sided" operations which are
initiated over the network by a remote CPU without notification or
involvement of the local CPU. These include things like ATOMIC
compare/swap, READ, and WRITE. Using these operations a remote CPU can
traverse data structures, form locks, and so on without awareness of
the host CPU. Having SWIOTLB substitute the memory or the DMA be cache
incoherent completely breaks these use cases.

RDMA in-kernel is OK with incoherence because none of the kernel use
cases make use of one-sided operations that would cause problems.

Jason
