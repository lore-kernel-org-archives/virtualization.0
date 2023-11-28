Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050E944380
	for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N/xB1GIY"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6d81173a219so2632165a34.3
        for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 15:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701215536; x=1701820336; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGeDrNEnimmhtGEyy4xADkNVo65XsrpvCKCPlUM9+8M=;
        b=N/xB1GIYe9kW68z9NOYGmBPpBaa+CN1i1vQJAlY53lJmW2SdmOsFlQ1797+I5JrYXa
         Yv0FDwRtRCnoIZzRrx+fCUlUwjaouHVAUirwe4YQOlKYinOo6OZNln3nDa4Q9VgNVyEN
         nvxwIYjNclppXHZLgt76s0n5QSegCra4YgNJGxQhaP02WoNmKzojfomvTLGy2g4P39+m
         hpCGUKJGDO80Fi63MXjJXW7VIEsQn9OfZrhVYtgKYqJRJG5R/Jn2HOaAaTlzoo5d/zCA
         SUWyAe+My4VMMzO8ocSHb1SSI1UZOODCqiyRZzSE+9W+n5Rm8jgvua5I/77Gn+T9ffNV
         NQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701215536; x=1701820336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGeDrNEnimmhtGEyy4xADkNVo65XsrpvCKCPlUM9+8M=;
        b=KwFmgAgFk1U75JFe8Vgdluaqv/St0+axLFXnbrEIhLuLm0rJD172cb8wf3YqzNTcY/
         BQYqS5Fa6qViUDQpBJfkPIfJSo3hxpzujGbftnq0Sj6W2pGMpoDKbKP+eGntv5YyALcg
         aG4GZHLGaXqgBPY0IhkDlv9OPFxlFOBGto2a6AQOhKyaBWIIifRrOsEcx4Xy1ixKo6mw
         w3nvhk0GLZ/0IWOK8ckSBuUzqZHBkWfAIlu6iUkDzAjzZ9btzo3W2TdJ7YyYtTYFXcEP
         UrRlllV4tecXMqWqNUelGZkAS8PtU4522OnrYkC9p72abfEO2u1gM1sEBtBWYK7bZ2b8
         G8/g==
X-Gm-Message-State: AOJu0Yys4uWWkq5KonmHJF5si7YkW0TstikYr/1inAbncE8YrZg+97MJ
	HpCSxgyAgZwWgXYiOaXphcPGIQ==
X-Google-Smtp-Source: AGHT+IH9LmWzJO7y47O3QlJBfbaegvjW4JiiPSyZGlFsMKhzquzPk2K8a5k6oldvIY99Eeb+EHerAg==
X-Received: by 2002:a9d:6403:0:b0:6d6:4972:b7ae with SMTP id h3-20020a9d6403000000b006d64972b7aemr18597902otl.13.1701215536183;
        Tue, 28 Nov 2023 15:52:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id v10-20020a056830140a00b006d834fd3399sm504997otp.59.2023.11.28.15.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 15:52:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r87sE-005jI0-V5;
	Tue, 28 Nov 2023 19:52:14 -0400
Date: Tue, 28 Nov 2023 19:52:14 -0400
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
Message-ID: <20231128235214.GD1312390@ziepe.ca>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <CAJD7tkb1FqTqwONrp2nphBDkEamQtPCOFm0208H3tp0Gq2OLMQ@mail.gmail.com>
 <CA+CK2bB3nHfu1Z6_6fqN3YTAzKXMiJ12MOWpbs8JY7rQo4Fq0g@mail.gmail.com>
 <CAJD7tkZZNhf4KGV+7N+z8NFpJrvyeNudXU-WdVeE8Rm9pobfgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZZNhf4KGV+7N+z8NFpJrvyeNudXU-WdVeE8Rm9pobfgQ@mail.gmail.com>

On Tue, Nov 28, 2023 at 03:03:30PM -0800, Yosry Ahmed wrote:
> > Yes, another counter for KVM could be added. On the other hand KVM
> > only can be computed by subtracting one from another as there are only
> > two types of secondary page tables, KVM and IOMMU:
> >
> > /sys/devices/system/node/node0/meminfo
> > Node 0 SecPageTables:    422204 kB
> >
> >  /sys/devices/system/node/nodeN/vmstat
> > nr_iommu_pages 105555
> >
> > KVM only = SecPageTables - nr_iommu_pages * PAGE_SIZE / 1024
> >
> 
> Right, but as I mention above, if userspace starts depending on this
> equation, we won't be able to add any more classes of "secondary" page
> tables to SecPageTables. I'd like to avoid that if possible. We can do
> the subtraction in the kernel.

What Sean had suggested was that SecPageTables was always intended to
account all the non-primary mmu memory used by page tables. If this is
the case we shouldn't be trying to break it apart into finer
counters. These are big picture counters, not detailed allocation by
owner counters.

Jason
