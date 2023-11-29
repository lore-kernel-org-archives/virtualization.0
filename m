Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1195E0DB
	for <virtualization@lists.linux.dev>; Wed, 29 Nov 2023 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ndt3rzOT"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2c9c5d30b32so2312401fa.2
        for <virtualization@lists.linux.dev>; Wed, 29 Nov 2023 11:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701287143; x=1701891943; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fNNsoM3smwE3RnQXjosvlH5YCUc/qVQE7cVYHj28TpE=;
        b=ndt3rzOTQwSL5H+aAeZWmLVQhdqtyOAn/zTrZSoErN4lKy9H036vfPSi44fG4l0Mnw
         j4o+LCzshI+IM9bSfdOQqUuamwOwfnvOkq1Cj7fbY3z6lqmkin6PLprmEw1txDS3+Nb4
         iCvy10yVTIFGCIJPgwTFq5g/ilBOjSAU8wuOqdmuBeMGY/hHv0sxXHoqOUThLEwTdv50
         JYVMhS43/WArx6MprF39pEC5Zy0jV6Vf0dN39Lcn45cZx3JVOoGAkb7/FcRNFTVJGl5E
         URZFtdpqV7VMyb0gfO2r/iroag1+59mpbvh9p9Y+6OLU71qt1mFfa7xzqZyM4iFqWs4m
         mMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701287143; x=1701891943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNNsoM3smwE3RnQXjosvlH5YCUc/qVQE7cVYHj28TpE=;
        b=Bqebm9v2JOnu4KDIo8aVcJ2RBHWrFS8axMpXszQlmN2u07bepp2tTQ6BBtVxidMwz9
         WWx1ue39ChQNAbSGyuY1ffZjbz9A/XZ3LxBi7tMGinjNuCIc649yGSDNHlq585E+TdSw
         vNRs/RD/EY5P6Q8bZr7ypPcbFasYPTU6jbb8LSzuf3fkS4yRhagEPeXC9LAArnAW3gZT
         3wskT2zJn7K9MmqTeytdDrxX6+ov/Hoh0g7b/MeKj23uoMmgmixwCf0ZPNLKxyQK4a3P
         PDRmqog/4flfCjqqOPZw45eRcdcm5Th52SrHDVO2SbB4uGXtM5GTmiPvb/7ybQqTtGz7
         M/sw==
X-Gm-Message-State: AOJu0Yytjxxa1s/zWzIX0awZVqGyYPw+Qqetf/Qk3IXCQFvfxw3cYrOo
	S3sZcffscfgShp/AdZI8XagefJHa+BRs+bQlzub4DA==
X-Google-Smtp-Source: AGHT+IHo1CBmTuUhAhmoXR/KJsiUOGXe0H72uTjo3bJ8/f4ydzGN+L/1B0mI7eNNH55dLwJ3p7aHezZlyWQqax7aj9w=
X-Received: by 2002:a2e:9b59:0:b0:2c6:ece6:5b65 with SMTP id
 o25-20020a2e9b59000000b002c6ece65b65mr12569535ljj.10.1701287142874; Wed, 29
 Nov 2023 11:45:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-9-pasha.tatashin@soleen.com> <1c6156de-c6c7-43a7-8c34-8239abee3978@arm.com>
 <CA+CK2bCOtwZxTUS60PHOQ3szXdCzau7OpopgFEbbC6a9Frxafg@mail.gmail.com>
 <20231128235037.GC1312390@ziepe.ca> <52de3aca-41b1-471e-8f87-1a77de547510@arm.com>
In-Reply-To: <52de3aca-41b1-471e-8f87-1a77de547510@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 29 Nov 2023 14:45:03 -0500
Message-ID: <CA+CK2bCcfS1Fo8RvTeGXj_ejPRX9--sh5Jz8nzhkZnut4juDmg@mail.gmail.com>
Subject: Re: [PATCH 08/16] iommu/fsl: use page allocation function provided by iommu-pages.h
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, akpm@linux-foundation.org, alex.williamson@redhat.com, 
	alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev, 
	baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org, 
	corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, 
	heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com, 
	jernej.skrabec@gmail.com, jonathanh@nvidia.com, joro@8bytes.org, 
	kevin.tian@intel.com, krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, mst@redhat.com, m.szyprowski@samsung.com, 
	netdev@vger.kernel.org, paulmck@kernel.org, rdunlap@infradead.org, 
	samuel@sholland.org, suravee.suthikulpanit@amd.com, sven@svenpeter.dev, 
	thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com, 
	vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org, 
	will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"

> >> We can separate the metric into two:
> >> iommu pagetable only
> >> iommu everything
> >>
> >> or into three:
> >> iommu pagetable only
> >> iommu dma
> >> iommu everything
> >>
> >> What do you think?
> >
> > I think I said this at LPC - if you want to have fine grained
> > accounting of memory by owner you need to go talk to the cgroup people
> > and come up with something generic. Adding ever open coded finer
> > category breakdowns just for iommu doesn't make alot of sense.
> >
> > You can make some argument that the pagetable memory should be counted
> > because kvm counts it's shadow memory, but I wouldn't go into further
> > detail than that with hand coded counters..
>
> Right, pagetable memory is interesting since it's something that any
> random kernel user can indirectly allocate via iommu_domain_alloc() and
> iommu_map(), and some of those users may even be doing so on behalf of
> userspace. I have no objection to accounting and potentially applying
> limits to *that*.

Yes, in the next version, I will separate pagetable only from the
rest, for the limits.

> Beyond that, though, there is nothing special about "the IOMMU
> subsystem". The amount of memory an IOMMU driver needs to allocate for
> itself in order to function is not of interest beyond curiosity, it just
> is what it is; limiting it would only break the IOMMU, and if a user

Agree about the amount of memory IOMMU allocates for itself, but that
should be small, if it is not, we have to at least show where the
memory is used.

> thinks it's "too much", the only actionable thing that might help is to
> physically remove devices from the system. Similar for DMA buffers; it
> might be intriguing to account those, but it's not really an actionable
> metric - in the overwhelming majority of cases you can't simply tell a
> driver to allocate less than what it needs. And that is of course
> assuming if we were to account *all* DMA buffers, since whether they
> happen to have an IOMMU translation or not is irrelevant (we'd have
> already accounted the pagetables as pagetables if so).

DMA mappings should be observable (do not have to be limited). At the
very least, it can help with explaining the kernel memory overhead
anomalies on production systems.

> I bet "the networking subsystem" also consumes significant memory on the

It does, and GPU drivers also may consume a significant amount of memory.

> same kind of big systems where IOMMU pagetables would be of any concern.
> I believe some of the some of the "serious" NICs can easily run up
> hundreds of megabytes if not gigabytes worth of queues, SKB pools, etc.
> - would you propose accounting those too?

Yes. Any kind of kernel memory that is proportional to the workload
should be accountable. Someone is using those resources compared to
the idling system, and that someone should be charged.

Pasha
