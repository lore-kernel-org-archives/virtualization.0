Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E1D52F
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZlFXTab"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 961B9408FB
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 08:18:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 961B9408FB
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PZlFXTab
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.297
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JlO5vTMgFjh2
	for <virtualization@lists.linux-foundation.org>;
	Wed,  8 Nov 2023 08:18:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7DD84408BC
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 08:18:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7DD84408BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699431527; x=1730967527;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o4b+vqtKY9OOVsB1rEVpRTkAptYNaJoA44xLfvE+DI0=;
  b=PZlFXTaboe+cKui+Gk6boQI113HJOq4qqUKvHjGRDhK3JS1tO4i2gAdx
   lnCyOHhCN5JU/EwVgNC3mmpY/xsLm/J2uE/G97iwwFDEhaUoKWR4Y96uZ
   nKi1tM9DWc1WtKTrH8rblP/L0oUTxi+leE55kfuIbqt69Wmghu7jTuGBZ
   5r0P9B6XgdoUPLo54bv+H3C6GQ1yRJnf+fGe6EH9xljrB1dEtcGgdBPJ1
   7OxMMni8OTNFPH/oyIaZ6PKUyi3T3t0hwB6O5YKZyTwQm7h5QZcmxf+Kw
   e8xr0I2RjUW7iXysXBj89a7oa1xhYyz4NhhXUyE/0pg4DnzOVfQzQXTgp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="420823081"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="420823081"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 00:18:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="828883803"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="828883803"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.63]) ([10.254.215.63])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 00:18:32 -0800
Message-ID: <f7e69801-e651-471d-9768-43ddf1702f91@linux.intel.com>
Date: Wed, 8 Nov 2023 16:18:30 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 17/17] iommu: Mark dev_iommu_priv_set() with a lockdep
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, acpica-devel@lists.linuxfoundation.org,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>,
 asahi@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>, Frank Rowand
 <frowand.list@gmail.com>, Hanjun Guo <guohanjun@huawei.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Christoph Hellwig <hch@lst.de>,
 iommu@lists.linux.dev, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin
 <marcan@marcan.st>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Moore <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Sven Peter <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>,
 virtualization@lists.linux-foundation.org, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>
References: <17-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <17-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/11/4 0:45, Jason Gunthorpe wrote:
> A perfect driver would only call dev_iommu_priv_set() from its probe
> callback. We've made it functionally correct to call it from the of_xlate
> by adding a lock around that call.
> 
> lockdep assert that iommu_probe_device_lock is held to discourage misuse.
> 
> Exclude PPC kernels with CONFIG_FSL_PAMU turned on because FSL_PAMU uses a
> global static for its priv and abuses priv for its domain.
> 
> Remove the pointless stores of NULL, all these are on paths where the core
> code will free dev->iommu after the op returns.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> ---
>   drivers/iommu/amd/iommu.c                   | 2 --
>   drivers/iommu/apple-dart.c                  | 1 -
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 -
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       | 1 -
>   drivers/iommu/intel/iommu.c                 | 2 --
>   drivers/iommu/iommu.c                       | 9 +++++++++
>   drivers/iommu/omap-iommu.c                  | 1 -
>   include/linux/iommu.h                       | 5 +----
>   8 files changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
