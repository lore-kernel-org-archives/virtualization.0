Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B72373
	for <virtualization@lists.linux.dev>; Wed, 29 Nov 2023 00:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MidCvI3z"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-58d9a4e9464so1235905eaf.0
        for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 16:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701217708; x=1701822508; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMYRcf/Kii/rrCclUYaD6+8KP9DIOITQj8zQjAaRv7g=;
        b=MidCvI3zMROGFOp4WhNu60QvETpmXJCXW0dLG8OZLIcARk3Q8qppb1ekXbmu1LRLYc
         t2bpIAaKvTgoOr0UQ/VYlDP0UUehiAEWoK1h+yRN87eqSCDM8LpzF3yZ9UEMZoJ6V6Hk
         GIFiIT66lD1JikwOh2akfkODngGrLUKo9Q2jdKpGw8L1xXvxp/NNQ+BVTVpgcGaU0vv8
         8820GZoM26iDRskwXBuyEJDGQ4IgaJYBC4G1I8PK7U9d6/hTE6pWyi4UfJR9wtCNvLNc
         Cmenea9qQbH+qYQB9HafmUEM6dOLehQ7eHzXDmRqQGm4QtiinZob4n9aiIOF5O87+3CO
         MBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701217708; x=1701822508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMYRcf/Kii/rrCclUYaD6+8KP9DIOITQj8zQjAaRv7g=;
        b=LzQbs8/E/AedLOdgGYASB91ZqEDhW606fmsF+lUYTCGQV3Wf2nPze/24iGcXfSEQqB
         ZmA0OuLLWvVLDmsTwEt+DKyZIRIW+7hy1vcDi+nHG2XmkjrdrfWpOcC4tMDHwbCFZemD
         jzcITkaOpilw9Qdlf6xCUsRtjPG267RZKkrDCWiTpajy3iN92I7nlC3ZI7qg4yHusmYn
         67E1U2FD5XsJu1zOrTFWl0N146x6UARUqP6P1jc/WWKmo8MvgLHf7/CgDwtjKDxzR55/
         LTWaFlQ28FnFKwCOb39qfXvRchkBxV9NePItC7zrzZGMPx9EcQHr26HNgCHlqoFDFQj2
         WgDQ==
X-Gm-Message-State: AOJu0YxDoigd1n7TecEPc8dAXncM3bps0Ic+qMcHsovNtOqy+NyWHDwh
	ctrnX1JlI22C4KrQH3tZL9Ci4g==
X-Google-Smtp-Source: AGHT+IHxOFYr1Wu9Fd6OY7DYtdTti5/c4rkTAyn2SfjWCS9pDJNiXdB/2NGtfvjIa+mQCcwPiiU58Q==
X-Received: by 2002:a05:6820:1504:b0:58d:97fb:cce9 with SMTP id ay4-20020a056820150400b0058d97fbcce9mr7193926oob.0.1701217707699;
        Tue, 28 Nov 2023 16:28:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id l5-20020a4ac605000000b00581e090fd1fsm682626ooq.8.2023.11.28.16.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 16:28:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r88RG-005k2k-DG;
	Tue, 28 Nov 2023 20:28:26 -0400
Date: Tue, 28 Nov 2023 20:28:26 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
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
	paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
	samuel@sholland.org, suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com,
	virtualization@lists.linux.dev, wens@csie.org, will@kernel.org,
	yu-cheng.yu@intel.com
Subject: Re: [PATCH 00/16] IOMMU memory observability
Message-ID: <20231129002826.GG1312390@ziepe.ca>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <CAJD7tkb1FqTqwONrp2nphBDkEamQtPCOFm0208H3tp0Gq2OLMQ@mail.gmail.com>
 <CA+CK2bB3nHfu1Z6_6fqN3YTAzKXMiJ12MOWpbs8JY7rQo4Fq0g@mail.gmail.com>
 <CAJD7tkZZNhf4KGV+7N+z8NFpJrvyeNudXU-WdVeE8Rm9pobfgQ@mail.gmail.com>
 <20231128235214.GD1312390@ziepe.ca>
 <CAJD7tkbbq6bHtPn7yE3wSS693OSthh1eBDvF-_MWZfDMXDYPKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbbq6bHtPn7yE3wSS693OSthh1eBDvF-_MWZfDMXDYPKw@mail.gmail.com>

On Tue, Nov 28, 2023 at 04:25:03PM -0800, Yosry Ahmed wrote:

> > > Right, but as I mention above, if userspace starts depending on this
> > > equation, we won't be able to add any more classes of "secondary" page
> > > tables to SecPageTables. I'd like to avoid that if possible. We can do
> > > the subtraction in the kernel.
> >
> > What Sean had suggested was that SecPageTables was always intended to
> > account all the non-primary mmu memory used by page tables. If this is
> > the case we shouldn't be trying to break it apart into finer
> > counters. These are big picture counters, not detailed allocation by
> > owner counters.
> 
> Right, I agree with that, but if SecPageTables includes page tables
> from multiple sources, and it is observed to be suspiciously high, the
> logical next step is to try to find the culprit, right?

You can make that case already, if it is high wouldn't you want to
find the exact VMM process that was making it high?

It is a sign of fire, not a detailed debug tool.

Jason
