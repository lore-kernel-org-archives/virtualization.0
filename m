Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7618130D1E
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D5944400BA
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 16:17:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D5944400BA
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.148
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZTcyOoWH8gz2
	for <virtualization@lists.linux-foundation.org>;
	Wed,  8 Nov 2023 16:17:07 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 86213400A4
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 16:17:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 86213400A4
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-586f1db1a83so3843747eaf.2
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Nov 2023 08:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699460226; x=1700065026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhueBKTq066e4mLfKHRgK40ZdUHgCtrKWznR5J+LNwA=;
        b=W8zoPg/Qxnt4bPBr8r36uQVcKNcDNLxhGPUxcg+0kfEv5gVawmOieyFNndwu0M2fiA
         79E8mp7EAOlFFaDOcc7WIZzV2uC0FUPAX8mOlNUOsZuSvvu7VjiiWtvzB+p0SyWMGoWU
         s5xSWk+65P/5oXvKOXMabB6aXsZHRI+OvEw+0I7Bcx5CmzqhFc0u3tS5uMJOoCzpgOAW
         tG7oeuUjJS/bieZoZtUc0MDNt/pcm9IDaWxi7rifVMYrZ4rJNprlx0m8058tQkiJdHy0
         alhbbnSwklPzRGEibd3yGA/t3wyqRKaPAAUG8gkVU2HeDJzkjvt/4//tLwP4c0rkokb6
         w7hw==
X-Gm-Message-State: AOJu0Yz75Sk2rUFQLKqC1yMRfvzrUR0uA6vKrJcInLYnErrgm937z5X3
	MZDGxlKoycyI6YjmFkAU+A==
X-Google-Smtp-Source: AGHT+IFe/wqQx7jqSarQLsP5AynmlF1OwPY0v3LIXJSKefg7OTaZGlvutVeUSHDrZS8dzbY2HrAlbA==
X-Received: by 2002:a4a:c208:0:b0:581:ff36:702b with SMTP id z8-20020a4ac208000000b00581ff36702bmr2227049oop.8.1699460225482;
        Wed, 08 Nov 2023 08:17:05 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b24-20020a9d6b98000000b006bf0f95f702sm1914773otq.64.2023.11.08.08.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 08:17:04 -0800 (PST)
Received: (nullmailer pid 2331961 invoked by uid 1000);
	Wed, 08 Nov 2023 16:17:02 -0000
Date: Wed, 8 Nov 2023 10:17:02 -0600
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
Subject: Re: [PATCH RFC 02/17] of: Do not return struct iommu_ops from
 of_iommu_configure()
Message-ID: <20231108161702.GB2254211-robh@kernel.org>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <2-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>

On Fri, Nov 03, 2023 at 01:44:47PM -0300, Jason Gunthorpe wrote:
> Nothing needs this pointer. Return a normal error code with the usual
> IOMMU semantic that ENODEV means 'there is no IOMMU driver'.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/of_iommu.c | 29 ++++++++++++++++++-----------
>  drivers/of/device.c      | 22 +++++++++++++++-------

Acked-by: Rob Herring <robh@kernel.org>

>  include/linux/of_iommu.h | 13 ++++++-------
>  3 files changed, 39 insertions(+), 25 deletions(-)
