Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E30F57300
	for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YzhhdgCG"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-77dc2981a58so56019785a.3
        for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 15:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701212831; x=1701817631; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKGceIQmjzcsQC3Q07PKAqpPD6bs9odge0wDr5u7PKU=;
        b=YzhhdgCGr0+nEdXgp6xVikLJUkjYfzw4VO4yop4HEzE4AlB/QdJFOMuVoSg5WcmTGG
         TqomdldpYArloRIMOHmnh9KU1w4YDxm+++DqzLwMxGGl/Oo30tjw7RNxmyTlscOXQZpD
         BYoiOfI4JxzmbnyS2CkFKjxKCwt+HRNT1j1LLPvA6WaKQ/t2N0fgD3OmWq/Htk8REo6n
         VgcuvnJrlG/IzFFS0V754xpibVU52ex+Fglh4eArBoaks1142wjSgnGJVB0VwB7uvO+K
         NAIpyyxup8q8cnm466GkC7pylST9YHXHwNicyNlkUbYkOmhhsiTnDeijPz3BdmfzTARS
         gZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701212831; x=1701817631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKGceIQmjzcsQC3Q07PKAqpPD6bs9odge0wDr5u7PKU=;
        b=rqrUn+0TwRP5gy//CjL7woP8taTPf5Y4yHc9bVHQMfRfe7yOdQGoLcU3geqlg2qhZq
         uQi9OWawtJm2M/guZjIjTRH3r/a4r0eCXqJcLPwGRbpOOugby3U2ppilzQS8JYZS/bgo
         QxtkroEzQ97+J+EXxaZk1z0Q5uOf7o8Lijx7217Ir/LkEEqNblLyS1lyOEri4bKMIkE1
         RRtmV4HWZy9ioNXoMSx4Xp62hA+gSC1i8dgf/Gc9cek1Of+ZnBhuygbV4V49rRxPK3Qq
         xJ/M7Ao8i1/JMXbYuGZoyqnQny0Qajb/0PFFOGQ2Zx7aaKwABLjKeVwZ/SD5ERWYxGTc
         YPnw==
X-Gm-Message-State: AOJu0YyYXOotQO8gBy7A4i/KD51EXpBr8CoJkA0g4zGDJWnZ+8SKDrOc
	6Dh2iiYSUj+9mHHoGuiROKeRClbQnVAwL3CIcy71vw==
X-Google-Smtp-Source: AGHT+IHAHLSOITMZygZZbwHqs8Pcv2cxmXIEpgUbJ5bxgMm59HnXI3xdTgQIpiDfVoUOALVinCHvTAH42dtkODtq5L8=
X-Received: by 2002:a05:622a:241:b0:423:8287:dc68 with SMTP id
 c1-20020a05622a024100b004238287dc68mr17998278qtx.52.1701212830897; Tue, 28
 Nov 2023 15:07:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-7-pasha.tatashin@soleen.com> <d99e0d4a-94a9-482b-b5b5-833cba518b86@arm.com>
 <CA+CK2bDswtrqiOMt3+0LBb0+7nJY9aBpzZdsmrWRzy9WxBqKEg@mail.gmail.com> <79c397ee-b71b-470e-9184-401b4b96a0d2@arm.com>
In-Reply-To: <79c397ee-b71b-470e-9184-401b4b96a0d2@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 28 Nov 2023 18:06:34 -0500
Message-ID: <CA+CK2bDyKP6RT1ZWLKXBcRrfSuONo9LPicskc9+ek=FX_KhwYg@mail.gmail.com>
Subject: Re: [PATCH 06/16] iommu/dma: use page allocation function provided by iommu-pages.h
To: Robin Murphy <robin.murphy@arm.com>
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com, 
	alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev, 
	baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org, 
	corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, 
	heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com, 
	jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com, joro@8bytes.org, 
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
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 5:59=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-11-28 10:50 pm, Pasha Tatashin wrote:
> > On Tue, Nov 28, 2023 at 5:34=E2=80=AFPM Robin Murphy <robin.murphy@arm.=
com> wrote:
> >>
> >> On 2023-11-28 8:49 pm, Pasha Tatashin wrote:
> >>> Convert iommu/dma-iommu.c to use the new page allocation functions
> >>> provided in iommu-pages.h.
> >>
> >> These have nothing to do with IOMMU pagetables, they are DMA buffers a=
nd
> >> they belong to whoever called the corresponding dma_alloc_* function.
> >
> > Hi Robin,
> >
> > This is true, however, we want to account and observe the pages
> > allocated by IOMMU subsystem for DMA buffers, as they are essentially
> > unmovable locked pages. Should we separate IOMMU memory from KVM
> > memory all together and add another field to /proc/meminfo, something
> > like "iommu -> iommu pagetable and dma memory", or do we want to
> > export DMA memory separately from IOMMU page tables?
>
> These are not allocated by "the IOMMU subsystem", they are allocated by
> the DMA API. Even if you want to claim that a driver pinning memory via
> iommu_dma_ops is somehow different from the same driver pinning the same
> amount of memory via dma-direct when iommu.passthrough=3D1, it's still
> nonsense because you're failing to account the pages which iommu_dma_ops
> gets from CMA, dma_common_alloc_pages(), dynamic SWIOTLB, the various
> pools, and so on.
>
> Thanks,
> Robin.
>
> > Since, I included DMA memory, I specifically removed mentioning of
> > IOMMU page tables in the most of places, and only report it as IOMMU
> > memory. However, since it is still bundled together with SecPageTables
> > it can be confusing.
> >
> > Pasha
