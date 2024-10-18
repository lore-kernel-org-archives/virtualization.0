Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590E82488
	for <virtualization@lists.linux-foundation.org>; Fri, 18 Oct 2024 01:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729216726; cv=none; b=O0nsgp3BWnBSY6M31GSg4ciHrzdAoWEdlG58hKys+NJQFlN8DvUob6Dqz20BgQzGesl4PVKY//zyDKVOw4+DGAZWq/RM42YxU1zWJi2opiLqwSiPCIqx/M7rKvYlt89WIQrYLg7C5+tJ/hroficafNxaCCc2D8W4g04qvUSW7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729216726; c=relaxed/simple;
	bh=z0TiPjA1esacraE/iuy/u3ZF8AIUwcsbFBy9SdtcBr8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oLveqdo0aE3HvN3Rtc7xESVgEhbkTGE8BStsWwYZ7oAPqUGN35ctfO2wivMyO6408hAfYizgCcOizxKj8zWXnVE9PA1jgnBVpamjLibr1BA8QoNgKpszBgkOtsJe6lYhzpQY9k+pvBiyJfXG7Ywd0pq8tN00/SSvqcXZ3xkBOO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dav5vNsf; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dav5vNsf"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D08A381361
	for <virtualization@lists.linux-foundation.org>; Fri, 18 Oct 2024 01:58:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.99
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RmLBKnYJkRcM for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Oct 2024 01:58:44 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E086A8135F
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E086A8135F
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dav5vNsf
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E086A8135F
	for <virtualization@lists.linux-foundation.org>; Fri, 18 Oct 2024 01:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729216724; x=1760752724;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z0TiPjA1esacraE/iuy/u3ZF8AIUwcsbFBy9SdtcBr8=;
  b=Dav5vNsf6IKis8GcECj07n6Sl2zZWdurZEP1PzIMLz3dfZIoq/Ne24JT
   pt/tgePgGWv2BZaWVj8ssihmUpzmRkwqwOW7BaWbYZ/cXouihNR5GASGI
   cD+FNnfUjf1M+ajDcTLgoCpG+3hs5GiQRRsm0A2dqZRpxkk8qNfalVM/u
   E47pnPp+9W7J7oFkeYlGMW5D42ExKVBu3p/LDMQJ6nSW96/MzQtk9pL78
   i6n5gEBHMSDTER9y0+TyMW+7bV/SQBcyiUaC+DHasvSHBUM/FWnsLuKQG
   lhBsRM9seS5cO58++7ArgjpKSVIV2YLQKYkzK5EbRAfD6kw1XZKrQCJJy
   A==;
X-CSE-ConnectionGUID: Ihvv7SRPSpqfVMnoQrcQEg==
X-CSE-MsgGUID: e7xRKmnpSg2fse3cbhsTbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28613705"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28613705"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:58:43 -0700
X-CSE-ConnectionGUID: WslB4K4WRX+jx3xs76Nskg==
X-CSE-MsgGUID: rMHC0WJ4QO+roVP274Zd6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78774900"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:58:39 -0700
Message-ID: <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>
Date: Fri, 18 Oct 2024 09:58:37 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
To: Jason Gunthorpe <jgg@ziepe.ca>, Zhangfei Gao <zhangfei.gao@linaro.org>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
 <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
 <20241017120518.GI4020792@ziepe.ca>
 <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
 <20241017130805.GA926121@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241017130805.GA926121@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/17 21:08, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 08:35:24PM +0800, Zhangfei Gao wrote:
> 
>> Yes, you are right
>>   I am using SRIOV vf and stall feature, so is_virtfn == true
>>
>> Our ACC devices are fake pci endpoint devices which supports stall,
>> And they also supports sriov
>>
>> So I have to ignore the limitation.
> I see, so that is more complicated.
> 
> Lu, what do you think about also checking if the PCI function has PRI
> ? If not PRI assume the fault is special and doesn't follow PRI rules?
> 
> Or maybe we can have the iommu driver tag the event as a PRI/not-PRI
> fault?

This limitation applies to PRI on PCI/SRIOV VFs because the PRI might be
a shared resource and current iommu subsystem is not ready to support
enabling/disabling PRI on a VF without any impact on others.

In my understanding, it's fine to remove this limitation from the use
case of non-PRI on SRIOV VFs. Perhaps something like below?

	if (dev_is_pci(dev)) {
		struct pci_dev *pdev = to_pci_dev(dev);
		if (pdev->is_virtfn && pci_pri_supported(pdev))
			return -EINVAL;
	}

Thanks,
baolu
