Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEED830D1E
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10F5860746
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 16:18:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10F5860746
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.148
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NemAPq0eOvXD
	for <virtualization@lists.linux-foundation.org>;
	Wed,  8 Nov 2023 16:18:26 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6916360615
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 16:18:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6916360615
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6cf65093780so4340093a34.0
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Nov 2023 08:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699460305; x=1700065105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYkPle1MdHD/QkRy5uvWyvoGAuw8CDQwR9sXIE03ZSs=;
        b=moC40L/g67C54qpXJtu3rdOiSukM6oEFGim0R0t+kuIMCJJksx3EYDO/Be2t+vgzFh
         N7KoKo5RodTb77N5vGf0i9VzqHGpBGuuNVOflLfBtP5EMmDbn1Z5ujwBYURp/JqMX12O
         IE5Xy331k77CQ4QffoPOgMpK0SCeQhcQSFCXTuFVaXk+Di2M4SLPqJrpeQHnEUCQLFUB
         8zjNcvZJG57kJjQqASSyUZBky9NtQwd5QWILN3haXTb+oSSKbhr71gS+1AKZL0DnqLYP
         i7VzwaUxeqP5mX1B+MhMMJAS5EBujRdUk3XLcm3O19R3WFXjIpn18pbA+6huhuw+16F5
         W3TQ==
X-Gm-Message-State: AOJu0Yw+6NAX5jC1NeFTdDUtaJovW12wXrkjnaIhuowrQjn8feiKHYxz
	xuen2GmYKxBM1dLlAvfcfw==
X-Google-Smtp-Source: AGHT+IHdx3/gHf0uiMEsZF6g8NbonKAcCJCMoAU+4cEwM7tQNoaEke7MS1G/3+EpNqOeJUuZFsInWw==
X-Received: by 2002:a05:6830:4394:b0:6d5:4daf:9894 with SMTP id s20-20020a056830439400b006d54daf9894mr2008363otv.7.1699460305289;
        Wed, 08 Nov 2023 08:18:25 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ew20-20020a0568303d9400b006b89dafb721sm1939661otb.78.2023.11.08.08.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 08:18:24 -0800 (PST)
Received: (nullmailer pid 2333673 invoked by uid 1000);
	Wed, 08 Nov 2023 16:18:22 -0000
Date: Wed, 8 Nov 2023 10:18:22 -0600
From: Rob Herring <robh@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linuxfoundation.org, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, 
	Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
	linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Hector Martin <marcan@marcan.st>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter <sven@svenpeter.dev>, 
	Thierry Reding <thierry.reding@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>, 
	virtualization@lists.linux-foundation.org, Wei Liu <wei.liu@kernel.org>, 
	Will Deacon <will@kernel.org>, Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 01/17] iommu: Remove struct iommu_ops *iommu from
 arch_setup_dma_ops()
Message-ID: <20231108161822.GC2254211-robh@kernel.org>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <1-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>

On Fri, Nov 03, 2023 at 01:44:46PM -0300, Jason Gunthorpe wrote:
> This is not being used to pass ops, it is just a way to tell if an
> iommu driver was probed. These days this can be detected directly via
> device_iommu_mapped(). Call device_iommu_mapped() in the two places that
> need to check it and remove the iommu parameter everywhere.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  arch/arc/mm/dma.c               |  2 +-
>  arch/arm/mm/dma-mapping-nommu.c |  2 +-
>  arch/arm/mm/dma-mapping.c       | 10 +++++-----
>  arch/arm64/mm/dma-mapping.c     |  4 ++--
>  arch/mips/mm/dma-noncoherent.c  |  2 +-
>  arch/riscv/mm/dma-noncoherent.c |  2 +-
>  drivers/acpi/scan.c             |  3 +--
>  drivers/hv/hv_common.c          |  2 +-
>  drivers/of/device.c             |  2 +-

Acked-by: Rob Herring <robh@kernel.org>

>  include/linux/dma-map-ops.h     |  4 ++--
>  10 files changed, 16 insertions(+), 17 deletions(-)
