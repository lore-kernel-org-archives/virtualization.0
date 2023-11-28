Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4A65C066
	for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V8HzhwGv"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-58d06bfadf8so3650178eaf.1
        for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 15:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701215438; x=1701820238; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XYTfkI+bm13XmNm4VDm7JNv4il6+T5S3nBbruRBN+40=;
        b=V8HzhwGvaxnXVUB4Ij72juxqDP3Gyww6qyfpKvd0qzazabxHQm/EeIZWagPDlt2vP9
         hDju+cairoks5tCO9CVLKouuA36ODmjjn3PM7n1/dsIRI12MltoTPfwWqX9bpR8bMfRw
         KmQ/83+AOufZLEiOayxyZugm/vTLam9TDWtOgM1LLEiMaI1MoYxxwXUwlfN1956glD5q
         fj60UQanKRaaDfkI9FktZAHIqlFts4djDRA3JjdSW7iBpOa59p5ovLnCpXjfXG5IAPaG
         gEZdwYS5sZTfH/SjAXjqwvtg3F3htY/BQwbCyQReK7r/4noLSUBPCVy1x3xTkMMjgQ3G
         /LsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701215438; x=1701820238;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYTfkI+bm13XmNm4VDm7JNv4il6+T5S3nBbruRBN+40=;
        b=oT86Tu+fDTuxWe3NdarUIYszWYFWapkLvbS6U7vYx2pp0/yhtBctsVLd8Tu7ghsOQ+
         ksRiC+TTcabG+xnOwTdDlRI+6qRdy9gjWuEP1wYVSzIXGYBQwF2dyaX16H0LPAbai7YC
         t2LSQEz75MZ2LtKfizYzfMpDYfsQOcTEiyR8wQit7F6nHLhl3HPkYFdxVnJPr1PSszZg
         F8BU+WNZO0WlnMAZdg4nG2dBBkrke7ESqiYiGvEKbHV/jUKGOjJ7pqP9G+ApwA95hgo4
         QUbNToZuBvB4NMXE5BZUyIQUw6RvN/YcoHKSjwQQQX0P6jYf0e2Mu3RY2iPxLdPPc11c
         ip1Q==
X-Gm-Message-State: AOJu0YxRI6kmTGLe/MkTAAnW8BJqfh16+26i0xvn8hF+w6CDhrak8JUT
	HZ8FAFNpZ1L+yP8rZazmga9sZA==
X-Google-Smtp-Source: AGHT+IGwgOr6qdtdfdMX4Rg2CnVVZBQ0aH/828IT9FkkN9y3SJG6wbzLt3OY2goWTqPUl1CtrUxcHA==
X-Received: by 2002:a05:6820:809:b0:58d:a6ed:5601 with SMTP id bg9-20020a056820080900b0058da6ed5601mr6252111oob.1.1701215438416;
        Tue, 28 Nov 2023 15:50:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id b35-20020a4a98e6000000b0058d2ea19475sm1934017ooj.11.2023.11.28.15.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 15:50:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r87qf-005jHH-5R;
	Tue, 28 Nov 2023 19:50:37 -0400
Date: Tue, 28 Nov 2023 19:50:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Robin Murphy <robin.murphy@arm.com>, akpm@linux-foundation.org,
	alex.williamson@redhat.com, alim.akhtar@samsung.com,
	alyssa@rosenzweig.io, asahi@lists.linux.dev,
	baolu.lu@linux.intel.com, bhelgaas@google.com,
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
	iommu@lists.linux.dev, jasowang@redhat.com,
	jernej.skrabec@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
	kevin.tian@intel.com, krzysztof.kozlowski@linaro.org,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
	marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
	m.szyprowski@samsung.com, netdev@vger.kernel.org,
	paulmck@kernel.org, rdunlap@infradead.org, samuel@sholland.org,
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
	thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org,
	will@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH 08/16] iommu/fsl: use page allocation function provided
 by iommu-pages.h
Message-ID: <20231128235037.GC1312390@ziepe.ca>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-9-pasha.tatashin@soleen.com>
 <1c6156de-c6c7-43a7-8c34-8239abee3978@arm.com>
 <CA+CK2bCOtwZxTUS60PHOQ3szXdCzau7OpopgFEbbC6a9Frxafg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCOtwZxTUS60PHOQ3szXdCzau7OpopgFEbbC6a9Frxafg@mail.gmail.com>

On Tue, Nov 28, 2023 at 06:00:13PM -0500, Pasha Tatashin wrote:
> On Tue, Nov 28, 2023 at 5:53 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2023-11-28 8:49 pm, Pasha Tatashin wrote:
> > > Convert iommu/fsl_pamu.c to use the new page allocation functions
> > > provided in iommu-pages.h.
> >
> > Again, this is not a pagetable. This thing doesn't even *have* pagetables.
> >
> > Similar to patches #1 and #2 where you're lumping in configuration
> > tables which belong to the IOMMU driver itself, as opposed to pagetables
> > which effectively belong to an IOMMU domain's user. But then there are
> > still drivers where you're *not* accounting similar configuration
> > structures, so I really struggle to see how this metric is useful when
> > it's so completely inconsistent in what it's counting :/
> 
> The whole IOMMU subsystem allocates a significant amount of kernel
> locked memory that we want to at least observe. The new field in
> vmstat does just that: it reports ALL buddy allocator memory that
> IOMMU allocates. However, for accounting purposes, I agree, we need to
> do better, and separate at least iommu pagetables from the rest.
> 
> We can separate the metric into two:
> iommu pagetable only
> iommu everything
> 
> or into three:
> iommu pagetable only
> iommu dma
> iommu everything
> 
> What do you think?

I think I said this at LPC - if you want to have fine grained
accounting of memory by owner you need to go talk to the cgroup people
and come up with something generic. Adding ever open coded finer
category breakdowns just for iommu doesn't make alot of sense.

You can make some argument that the pagetable memory should be counted
because kvm counts it's shadow memory, but I wouldn't go into further
detail than that with hand coded counters..

Jason
