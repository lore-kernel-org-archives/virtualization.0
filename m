Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E8F10E7
	for <virtualization@lists.linux.dev>; Wed, 29 Nov 2023 00:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VDDA0Je+"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1fa0885e1c2so2747742fac.0
        for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 16:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701219292; x=1701824092; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KD7A1Mi78WcdpTbacYeqydWRhhJC6MIZ9wADFHK3ceE=;
        b=VDDA0Je+yyAKTlvuJtQ/gPL6S++HMcAHethP3+CelioZeIqGwCUGtxzuDUuWMaJDdo
         yTbQCyeunwCgY0g0atIiRlw6At7NmS7UX1puHaJtkvv314lyCfHcbSmxYmfkq6ewvqHu
         EkoDnjaCXqpW/5QnnrY5LyZuq3zSvv0N5axTor0ItBl7jy85dCDAskajvBzpgNgOPDwu
         xM1PbipnzgU4VTi+YJUMRoV2qF1dZqKAWfESf6lCDWlNDDnNu9s1cCi6tn9g2NFkNige
         TqU6emzUPD+jWqhQRtNz96IZwHx3AYh1xWgP9RNyd8KkfxJ0QLFjP35d5RA05AKtrsXT
         ITvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701219292; x=1701824092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KD7A1Mi78WcdpTbacYeqydWRhhJC6MIZ9wADFHK3ceE=;
        b=IIbWrQE0oORnoou0bfHbiNZ+Sfk29lKvMx9F/8dg5CYgEPWL3BP58MV2EUqf5UZEIA
         YM9chvufdl+vT4tUIVFCzcrTZq7JJBGuKQvpIwzo6kx1e0mNceQ6p4cRmjke+R1ZuWW1
         OJI8IFzOWMfQumtb81Dln6o5nHbZ5zkAtmSUOA9KiRM2KC/sxQRf0ielcuTE9RyimNl3
         YabcH6Nncy5e/Rw57sAp2IOWzcFZNYB6xncfjvwi8B+o92NlHycqo1jYncXOD6MJRmDJ
         Vp/FFVg0BhXQtivb8Uo46U/09sGAd8H2/CZ7QIb4qpF6rwTDImAaVISuWZV0yxlwP9PB
         JwYA==
X-Gm-Message-State: AOJu0YzW4K8nPg+fvjKQynKGkY8vFaxMbDtt9nJj1NuDjM9JYK60MpyI
	35fir4mE6gTBDcyXPZh9JaxwUw==
X-Google-Smtp-Source: AGHT+IGKiwEuykqxh29J1y1VqvKSA4pC1uEUHtE7SoQBvdHo0iXpRqPiFg8DX/ZmKtSwphh/2Jx77g==
X-Received: by 2002:a05:6870:c690:b0:1fa:2f8:c734 with SMTP id cv16-20020a056870c69000b001fa02f8c734mr16951479oab.5.1701219291679;
        Tue, 28 Nov 2023 16:54:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id b1-20020a056830344100b006d81e704023sm945291otu.2.2023.11.28.16.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 16:54:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r88qo-005kIY-2m;
	Tue, 28 Nov 2023 20:54:50 -0400
Date: Tue, 28 Nov 2023 20:54:50 -0400
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
Message-ID: <20231129005450.GH1312390@ziepe.ca>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <CAJD7tkb1FqTqwONrp2nphBDkEamQtPCOFm0208H3tp0Gq2OLMQ@mail.gmail.com>
 <CA+CK2bB3nHfu1Z6_6fqN3YTAzKXMiJ12MOWpbs8JY7rQo4Fq0g@mail.gmail.com>
 <CAJD7tkZZNhf4KGV+7N+z8NFpJrvyeNudXU-WdVeE8Rm9pobfgQ@mail.gmail.com>
 <20231128235214.GD1312390@ziepe.ca>
 <CAJD7tkbbq6bHtPn7yE3wSS693OSthh1eBDvF-_MWZfDMXDYPKw@mail.gmail.com>
 <20231129002826.GG1312390@ziepe.ca>
 <CAJD7tkbxhK7XFcf7h+XE2poNuOsFBQFrxZyeFr=9DoEG_acssA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbxhK7XFcf7h+XE2poNuOsFBQFrxZyeFr=9DoEG_acssA@mail.gmail.com>

On Tue, Nov 28, 2023 at 04:30:27PM -0800, Yosry Ahmed wrote:
> On Tue, Nov 28, 2023 at 4:28 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Nov 28, 2023 at 04:25:03PM -0800, Yosry Ahmed wrote:
> >
> > > > > Right, but as I mention above, if userspace starts depending on this
> > > > > equation, we won't be able to add any more classes of "secondary" page
> > > > > tables to SecPageTables. I'd like to avoid that if possible. We can do
> > > > > the subtraction in the kernel.
> > > >
> > > > What Sean had suggested was that SecPageTables was always intended to
> > > > account all the non-primary mmu memory used by page tables. If this is
> > > > the case we shouldn't be trying to break it apart into finer
> > > > counters. These are big picture counters, not detailed allocation by
> > > > owner counters.
> > >
> > > Right, I agree with that, but if SecPageTables includes page tables
> > > from multiple sources, and it is observed to be suspiciously high, the
> > > logical next step is to try to find the culprit, right?
> >
> > You can make that case already, if it is high wouldn't you want to
> > find the exact VMM process that was making it high?
> >
> > It is a sign of fire, not a detailed debug tool.
> 
> Fair enough. We can always add separate counters later if needed,
> potentially under KVM stats to get more fine-grained details as you
> mentioned.
> 
> I am only worried about users subtracting the iommu-only counter to
> get a KVM counter. We should at least document that  SecPageTables may
> be expanded to include other sources later to avoid that.

Well, we just broke it already, anyone thinking it was only kvm
counters is going to be sad now :) As I understand it was already
described to be more general that kvm so probably nothing to do really

Jason
