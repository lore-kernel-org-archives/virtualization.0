Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04599184
	for <virtualization@lists.linux.dev>; Thu, 30 Nov 2023 00:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C/nICsSF"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1fa4e47f6c0so697737fac.0
        for <virtualization@lists.linux.dev>; Wed, 29 Nov 2023 16:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701302581; x=1701907381; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iqaBGyfV5ntKwlfmxQAMawFx8i861c6WUBXKE0OU9B4=;
        b=C/nICsSF4lFjwshOSfbWzqrGk+h/4sCvAhcWsbpXXRmSm1AWeuRGHAlmVxymvvwH/L
         ns5/eL2Yw8chmfFv2gyUgHNJ0bpa1PzoH2Y6rr1YHrHw+VMqrRsSwwiMnMTavVu5IDo2
         zYw36NQWhljOlbso37etAzEbC4I+u2atseF2JRm3FeNYTgH0n1VwjKmOh5SJkBuhxj2J
         0PZdS8Cfj8GJyc9+dNcFCnQGEdvDYPHHl6/jaDO9WNZO2/iH7BejCrOwi2kDp8U/dzPM
         g47Ey7aqdhYFXf/mDPF6nvB0By1ZzyhX+42F8gU7RPQThBN58oukfJ4Y5Xfz0N/xcMln
         ij3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701302581; x=1701907381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqaBGyfV5ntKwlfmxQAMawFx8i861c6WUBXKE0OU9B4=;
        b=P/f9UlRdpRHl3OUbn5ep7LSPK9bwgdb8i6KT5vBvql5FuTqNjbo8HD+9A69sZdZU3a
         qCmqZpb2l7uu/hI0L+q/wAG8N2AH3D3709XU0aOrwV58pJH9fHS7De+iNwKXvF4R4+4m
         l2gaovZET7ibEgVVfclSxz5cIChrMpoAHG0b1I2s2TlsQCyenMvbty7re+eTdLutUG0K
         rcJwW70iDxQ30qCJ2ett4+KT2My6kFwEW8sP/OoBsfMkNDCvgUD6bsIos7k5y6eWYHkm
         fUPNGKXhHazwuZxrF8b9pSbUbuuNY+MFMA+kWdAL7VL6v+iyve4wjxhTN1816yMC4K/n
         eThg==
X-Gm-Message-State: AOJu0YwC2C0aXd5qv6KtdZp2fKuV81G9qJNCaJDfvwIIfHRFkbmMHplU
	Az7y6YauACLlmOqzc1tO2NqREQ==
X-Google-Smtp-Source: AGHT+IH9mJrgeBca3QDmdqlZSO64E6UWuuZZMjhMVoz9rZsKA5pWXiF1aXxzzo/4HFbYhkfRvbso7A==
X-Received: by 2002:a05:6870:1603:b0:1f9:eb7e:6621 with SMTP id b3-20020a056870160300b001f9eb7e6621mr10166623oae.18.1701302580971;
        Wed, 29 Nov 2023 16:03:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id ry4-20020a056871208400b001efa3446d4esm3609159oab.43.2023.11.29.16.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 16:03:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8UWB-005qQQ-Hz;
	Wed, 29 Nov 2023 20:02:59 -0400
Date: Wed, 29 Nov 2023 20:02:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com,
	alim.akhtar@samsung.com, alyssa@rosenzweig.io,
	asahi@lists.linux.dev, baolu.lu@linux.intel.com,
	bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
	david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
	heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
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
Subject: Re: [PATCH 09/16] iommu/iommufd: use page allocation function
 provided by iommu-pages.h
Message-ID: <20231130000259.GS1312390@ziepe.ca>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-10-pasha.tatashin@soleen.com>
 <20231128235254.GE1312390@ziepe.ca>
 <CA+CK2bC=vMU54wXz1GSzpOcLFCuX5vuE6tD49JF8cMbz4tis-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bC=vMU54wXz1GSzpOcLFCuX5vuE6tD49JF8cMbz4tis-g@mail.gmail.com>

On Wed, Nov 29, 2023 at 04:59:43PM -0500, Pasha Tatashin wrote:
> On Tue, Nov 28, 2023 at 6:52 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Nov 28, 2023 at 08:49:31PM +0000, Pasha Tatashin wrote:
> > > Convert iommu/iommufd/* files to use the new page allocation functions
> > > provided in iommu-pages.h.
> > >
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > ---
> > >  drivers/iommu/iommufd/iova_bitmap.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > This is a short term allocation, it should not be counted, that is why
> > it is already not using GFP_KERNEL_ACCOUNT.
> 
> I made this change for completeness. I changed all calls to
> get_free_page/alloc_page etc under driver/iommu to use the
> iommu_alloc_* variants, this also helps future developers in this area
> to use the right allocation functions.
> The accounting is implemented using cheap per-cpu counters, so should
> not affect the performance, I think it is OK to keep them here.

Except it is a mis use of an API that should only be used for page
table memory :(

Jason
