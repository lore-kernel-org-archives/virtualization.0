Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C6B4CB2F
	for <virtualization@lists.linux.dev>; Wed, 29 Nov 2023 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="if/y/fFG"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-423dcd5d060so2417141cf.0
        for <virtualization@lists.linux.dev>; Wed, 29 Nov 2023 14:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701295220; x=1701900020; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiOfm5uGDMrP0UYnHwC5BRUcA0oU3b2DbcdcIFPiI/Q=;
        b=if/y/fFGh+maTAsAyHGQijIB5fH2tqMDIQW93wh3rI1RcQ8Qkr0rwyioeCLwqY3kyC
         /xTB3kKaHibPnw/aLf42p0Yd+J8bSoCd5bvv7G0xTcqhmKlU3XRYLp72cw8mZIP6stUC
         JQqHKdVtWq6TFYIxfgg9ASBqyXeVvrZ7x4e28c16PzO1UT1H0uJAYu+Xq6xa4V5PKlTD
         tBLSsPMfvE4ze7H+q6YYI+oinmpkILsgAq3rkUc6vK9wfpQzT0J8Oog52jYUsQ8GnD3e
         t3izOtOjkuV85yFaeaKtXCYMlzZPNPNQBIPGDbk5tRb7sOqLLM7hgkr7FgwKuslrqHxG
         UbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701295220; x=1701900020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiOfm5uGDMrP0UYnHwC5BRUcA0oU3b2DbcdcIFPiI/Q=;
        b=sl7+scsRTSJonFfBOG5QTbBEBpLASA7VnZZUTtyrZm+/xHBZ6Mn8tx7XpxTlXl1gkF
         t8w2D8CcQgWmoveKvRFujMnjtbSJwKVRboTEZGQ9iQcts9h8kbqp21gk75b2HyFawbD9
         dphRhPGEFVEl0Gw7EHmDs1pNZqvgHd09xRzrqP7ziFZ92XGalm7Y6FoL5VaHyaMbihig
         pWyDowiSxMiPKUk40769gzLM9Wv5Y9q34HxlOS9YJS2uazadRkCaAgy02mQty06LGuxB
         ze9oLTbfUBiWgobWTuATn2X0TDYWYs0CR1X/AchAF/3t7anQSbfqr4bn9aGg53kpo84t
         yfKg==
X-Gm-Message-State: AOJu0YwG8gQCalsGX4U9W2YNxakIakMCAlw8FG4hVTc5Q0MV0ofiUMHT
	1y2wLRintEtE7SITfSrs8XJ7HTz/S/15x+IiehHwSw==
X-Google-Smtp-Source: AGHT+IGmE/x/Q9wBAAP4WSVeu6Pzwkh80gJNXkwIoavJV9VXufokUhNCLXMfXFExg6GRm7Q1Y/p8TrFXYkay1vjqtA4=
X-Received: by 2002:ac8:5ac4:0:b0:41c:d62b:fb51 with SMTP id
 d4-20020ac85ac4000000b0041cd62bfb51mr39263562qtd.26.1701295220560; Wed, 29
 Nov 2023 14:00:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-10-pasha.tatashin@soleen.com> <20231128235254.GE1312390@ziepe.ca>
In-Reply-To: <20231128235254.GE1312390@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 29 Nov 2023 16:59:43 -0500
Message-ID: <CA+CK2bC=vMU54wXz1GSzpOcLFCuX5vuE6tD49JF8cMbz4tis-g@mail.gmail.com>
Subject: Re: [PATCH 09/16] iommu/iommufd: use page allocation function
 provided by iommu-pages.h
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com, 
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
	robin.murphy@arm.com, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, virtualization@lists.linux.dev, 
	wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 6:52=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Nov 28, 2023 at 08:49:31PM +0000, Pasha Tatashin wrote:
> > Convert iommu/iommufd/* files to use the new page allocation functions
> > provided in iommu-pages.h.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  drivers/iommu/iommufd/iova_bitmap.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> This is a short term allocation, it should not be counted, that is why
> it is already not using GFP_KERNEL_ACCOUNT.

I made this change for completeness. I changed all calls to
get_free_page/alloc_page etc under driver/iommu to use the
iommu_alloc_* variants, this also helps future developers in this area
to use the right allocation functions.
The accounting is implemented using cheap per-cpu counters, so should
not affect the performance, I think it is OK to keep them here.
