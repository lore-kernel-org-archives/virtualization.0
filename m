Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02152DC76B
	for <virtualization@lists.linux.dev>; Mon, 26 Jan 2026 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769461273; cv=none; b=jkimce+oS9iE67j+3o/pVZxNtHv3agcn1oYgxAhYGVo4hYuImzjf8ceIf6k7DVqS6eWv1ixeCyT8MR63BGDsQMuCNlQ9eo8SwmBT7LxjiMZymwQm9V+HEnXkuHSpJnzk/KAsBADLx0VSPa2D/1qX99pk88t9DxDRGoSjIaMezWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769461273; c=relaxed/simple;
	bh=/uBBJ41PsJ+poHfkbr45RI19WGdtV1Pwu8dAjRjrE+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPn2q2yFXD2urHYCmKUOaQFrf1Wzuz8RGUhoSGA5hqXk7lOvFFaWnJlN2pxOV3L9rEDJqeoTYt4LZDvj2q1A3N41/tvKkrMFH1bd2zoneiGkbGHecnpSEqMCUMv7xGHfDccNow/TGHZNToA71B9f9vIk6C91v9r7Jfb4WZeHLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=koC1Q+iD; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="koC1Q+iD"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88a367a1dbbso87727176d6.0
        for <virtualization@lists.linux.dev>; Mon, 26 Jan 2026 13:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769461270; x=1770066070; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tu3uAyHuSXXXZq6VSWtVG72sHh/RWKg7/MHSYDvcONg=;
        b=koC1Q+iDSahvWalXWFQLqhD1axRaLPr54xKPCYIW6In+rWyfE+fmE4zDEmWU6SLpGB
         BTQgqfTAQqhqqsG3RP/V9Bky9yMXYew8pqyPUEGwVdGAj9r6BJr3v0t3J7j9UOc2+gP6
         hU88ZX+aWt4ixBDx283qV0ApdkCzihfQasRec2v1GuLcA7pb/aeCrmyIK4ax9NGgw3eG
         2wa1rB9NjS15udWFWQXwfGWfpr7q1a3vOHHUQdfoDZdJ/s1haOFXuejy3FL3NWr56x3r
         NOo4Yyg1TvgKwdrWN2YFU95Aw11BOR4DPkuMODJHsvAVhforRRtVgwEZvpXhtX69Whbf
         waOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769461270; x=1770066070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tu3uAyHuSXXXZq6VSWtVG72sHh/RWKg7/MHSYDvcONg=;
        b=DNguuFbjDxuDfyvuoO4mGorNZONrDUm1hSWer6pac23c+d+8+Y/wS/lYCoDqy4rPeq
         n+IB/LxxF1DG7HgAj83ABc5ENJFmU/ddFQaX42o95PsZHbiuem9f520sMAtvPTvS9UKT
         wHUl4cZ+lmWd/kWDOJweH4S4S+FFSr24+G8zsbU0AaIFnN7uxzC5flJ4jwHWQQJaigwi
         P5PavNDQbuq7t12lpwf6m4TUCf0s0BVR6L0AQsUzgI8tdvN5L9Y6ZMvJ4PZ3y6OnKeJK
         O7LUEM0BZN/ynwiiNzUNrXct9SoNKtuvNZJvZlcfgFKmzjYlBxBESmEuH91QGiUDIb0S
         GOwA==
X-Forwarded-Encrypted: i=1; AJvYcCX17eZK5Mp2OFmFmCi4nIjVksZ2ghY0C/O55lsvcCT/g1hP1w7wlErb/jJG8/iH+ZBJCTvTVQ+pc7jOcqwSvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOpaJG/q/AlsjMua0yQ3Z+zkFDdRwXo9dnXofUsMYSX01n/o/9
	TBQYh/OnghzgR6BtS2chlOJ7kU3B51tAAm+jyPYCxlWRJcppWrdqoqfpjnTbFZGYCOM=
X-Gm-Gg: AZuq6aKPr736qtcvbIMVMCFRWlaqfHHKXhaWkGwgbwuRs2p6IGBPLD+RnhTAqDOAO3u
	Q4DBco3rw8fems0FE4gD4wDnsmqHLyA/iuGYEJKPFPnVJTbOWYxinTWv7YVZtfyJmySJeT2pW7b
	pacES/MGpl1nkMWAaJBJp9h0FIlMKOSv6ums3EzC3jRBz081LrGbJU8Un727Gm73UOhD5So7tjn
	28Bhv7dsci+fb4pUhJcJHe79ZZJmtzKQINRJiCpGAX5+jLombKGiW/1QNFVN1enC0fbpCNl6N/U
	fw5hVaq30gsSFrpsr3vghe1/lPAmcn3AYSZCWDT75Ti4qUS3wCqetyWgRvcD0aXcoqW9LYz1LHe
	03DGYZ2KLPdv9YxLJCihefL7Fh0omJakch6KRHBvmnm2a5sYJP+rTTdTECgVihMM9VO+ybKkjGj
	T2OZEjE3T5sVJaDd2xPX7AbjQlq6kfPcEdILlatfIKvLKo14szj79nKqGh+yC4BMbTqac=
X-Received: by 2002:a05:6214:1cc9:b0:894:7b34:dacd with SMTP id 6a1803df08f44-894b06f336dmr73487126d6.31.1769461270245;
        Mon, 26 Jan 2026 13:01:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894918b1436sm104983856d6.35.2026.01.26.13.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 13:01:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vkThs-00000008z30-31vX;
	Mon, 26 Jan 2026 17:01:08 -0400
Date: Mon, 26 Jan 2026 17:01:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v5 6/8] dma-buf: Add dma_buf_attach_revocable()
Message-ID: <20260126210108.GD1641016@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-6-f98fca917e96@nvidia.com>
 <aXfQ1LFNDUrfeuHf@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXfQ1LFNDUrfeuHf@google.com>

On Mon, Jan 26, 2026 at 08:38:44PM +0000, Pranjal Shrivastava wrote:
> I noticed that Patch 5 removes the invalidate_mappings stub from 
> umem_dmabuf.c, effectively making the callback NULL for an RDMA 
> importer. Consequently, dma_buf_attach_revocable() (introduced here)
> will return false for these importers.

Yes, that is the intention.

> Since the cover letter mentions that VFIO will use
> dma_buf_attach_revocable() to prevent unbounded waits, this appears to
> effectively block paths like the VFIO-export -> RDMA-import path..

It remains usable with the ODP path and people are using that right
now.

> Given that RDMA is a significant consumer of dma-bufs, are there plans
> to implement proper revocation support in the IB/RDMA core (umem_dmabuf)? 

This depends on each HW, they need a way to implement the revoke
semantic. I can't guess what is possible, but I would hope that most
HW could at least do a revoke on a real MR.

Eg a MR rereg operation to a kernel owned empty PD is an effective
"revoke", and MR rereg is at least defined by standards so HW should
implement it.
 
> It would be good to know if there's a plan for bringing such importers
> into compliance with the new revocation semantics so they can interop
> with VFIO OR are we completely ruling out users like RDMA / IB importing
> any DMABUFs exported by VFIO?

It will be driver dependent, there is no one shot update here.

Jason
