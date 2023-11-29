Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C55EE9A
	for <virtualization@lists.linux.dev>; Wed, 29 Nov 2023 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NPPR0xzB"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50bc811d12fso348271e87.1
        for <virtualization@lists.linux.dev>; Wed, 29 Nov 2023 12:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701290700; x=1701895500; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlZYiStM5KCC7J/v+177rjHqt9KWJCfJWFMkelab9t4=;
        b=NPPR0xzBqxD0dF0EH9EnzSNHkaAP72VJL7Fn3gcm7EnMVHmqOqhy063u/LfnG0VgIa
         09e4DOMHqSJHt+xoXaqc5J58Cm0uUvYIBaUVycjX8JyEo71QVrys8m6DhemybQt6Q/dd
         oJWYbygGTRG6YNSeykaUXAWtpx+ogAPbVH/9QJZyyaqfQIu+9gCsYgxZiTRBtJ2V4zur
         9DpB/eQdQVxQT7IBZYwwi/ZF3zuuCEGzA0omfx88xohiTZAuSRSmv4yXUTu06kC60L2+
         cbmxloW8VSdUWiI9Ou3Ch1o4R18sf5y3egBUqlqk9v3Z9TPIjOcRbOf3nZoryU49yWFf
         0qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701290700; x=1701895500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlZYiStM5KCC7J/v+177rjHqt9KWJCfJWFMkelab9t4=;
        b=XMHbJarhsG/OjmUgR09l0dmiSlootCeG0tCManBT+WvdIkJYdOMMs1CHPbfgvZkBTX
         JB0E2IWOUqFNtOLd7RXdcXCUvfMIKK5YGCjF/r47jOwjRm32KsfLsHWUG9M6KHBxuB1C
         nZqmn6bvb9wibZdZ7sKN1MDgRCtczj0O3N0u1hhhjsW0fvBYydsB06isdCgKbTVxer+E
         P4IjvTlZx3vQOd1EVNvNPNrgPTcugrdhkQ0d3JHULTaCZVneCya48VbiqM4s0eLeJcvn
         b+tjEKDjCCABzfUEfMFV9BdcdSWUMVHmNpW03LjTHH/FzCEBWSt75PZYbI+FbbJRNmPt
         2imA==
X-Gm-Message-State: AOJu0YwzbD5PO56C6VDA0a/vK5qdLmbjIy6t7ldhnuFrj6Ik9pQtGuj5
	VsJC6ToMApaz5t5kz1h0waVLvZHHhNXMOWNyiATkJA==
X-Google-Smtp-Source: AGHT+IGMB2fUN71OTthlqnqBV10GCXDIRhuYgMFmlKYXWcCU4XgzYTup+BcRc5IJEjmMB4Fgw8Ibq0j5FX6Di+vVaiM=
X-Received: by 2002:ac2:4a6f:0:b0:50b:cb50:401 with SMTP id
 q15-20020ac24a6f000000b0050bcb500401mr153882lfp.34.1701290700342; Wed, 29 Nov
 2023 12:45:00 -0800 (PST)
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
 <CA+CK2bCcfS1Fo8RvTeGXj_ejPRX9--sh5Jz8nzhkZnut4juDmg@mail.gmail.com> <20231129200305.GI1312390@ziepe.ca>
In-Reply-To: <20231129200305.GI1312390@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 29 Nov 2023 15:44:21 -0500
Message-ID: <CA+CK2bA05Bh+H4qsP7ZM6ZcnBXu64frEfpCDYZuLOQ4UxJC4EA@mail.gmail.com>
Subject: Re: [PATCH 08/16] iommu/fsl: use page allocation function provided by iommu-pages.h
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, akpm@linux-foundation.org, 
	alex.williamson@redhat.com, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jasowang@redhat.com, jernej.skrabec@gmail.com, 
	jonathanh@nvidia.com, joro@8bytes.org, kevin.tian@intel.com, 
	krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org, 
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

On Wed, Nov 29, 2023 at 3:03=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Wed, Nov 29, 2023 at 02:45:03PM -0500, Pasha Tatashin wrote:
>
> > > same kind of big systems where IOMMU pagetables would be of any conce=
rn.
> > > I believe some of the some of the "serious" NICs can easily run up
> > > hundreds of megabytes if not gigabytes worth of queues, SKB pools, et=
c.
> > > - would you propose accounting those too?
> >
> > Yes. Any kind of kernel memory that is proportional to the workload
> > should be accountable. Someone is using those resources compared to
> > the idling system, and that someone should be charged.
>
> There is a difference between charged and accounted
>
> You should be running around adding GFP_KERNEL_ACCOUNT, yes. I already
> did a bunch of that work. Split that out from this series and send it
> to the right maintainers.

I will do that.

>
> Adding a counter for allocations and showing in procfs is a very
> different question. IMHO that should not be done in micro, the
> threshold to add a new counter should be high.

I agree, /proc/meminfo, should not include everything, however overall
network consumption that includes memory allocated by network driver
would be useful to have, may be it should be exported by device
drivers and added to the protocol memory. We already have network
protocol memory consumption in procfs:

# awk '{printf "%-10s %s\n", $1, $4}' /proc/net/protocols | grep  -v '\-1'
protocol   memory
UDPv6      22673
TCPv6      16961

> There is definately room for a generic debugging feature to break down
> GFP_KERNEL_ACCOUNT by owernship somehow. Maybe it can already be done
> with BPF. IDK
