Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC456BFC7
	for <virtualization@lists.linux-foundation.org>; Mon,  1 Jul 2024 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719813356; cv=none; b=CqNqZ2DyxC9FntRpyMrDfJCyKsXPCLJXmaK6q13FgSeMiYRUlA7cS1Xhei3pFXtBIYIUr94zLlNmHeOwT8SbwOLT6/zJFLegV3qMky+CeCswpRuheqYMX97l0A6xU9lghylX9C55flMdCxYKEMr7batu7fA6Hz9kAYV15zz/2Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719813356; c=relaxed/simple;
	bh=zoolY0j9tBgKN2MEBj7jMgK5u98hB3qhLdhkSd0qq80=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i66WyzHyQX2Hl7nlE1JmMavWwihxMhYb/+A3ULMCVdpvE4/SNaPu+EXzeDLLAeH+4+gHcfBmptlgXgM1UZkKjk/WFDBeGCQ6UjSsoLPGdhQGCuKeOnMdyvMo6JH19bEBO5W4Irpx0bK5kF3bCcVCaH1ltcN6IID3BlM/dgm6zys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LP5spFtX; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LP5spFtX"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9DDEE40448
	for <virtualization@lists.linux-foundation.org>; Mon,  1 Jul 2024 05:55:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iN82Vg_HXnln for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Jul 2024 05:55:53 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BAEBD40141
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BAEBD40141
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LP5spFtX
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BAEBD40141
	for <virtualization@lists.linux-foundation.org>; Mon,  1 Jul 2024 05:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719813352; x=1751349352;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zoolY0j9tBgKN2MEBj7jMgK5u98hB3qhLdhkSd0qq80=;
  b=LP5spFtXEaMvFKozYy/6rLP2Mr3nBmHb0dPRRzjehocPx9YQi1HphItl
   +sw0v1CE+ZZjVMgwU7gsL+BEsyNnZaeWnMzckei3cakpELTVbSu/Fs68n
   xV+0iL8y+pqyCbVd2iYI2M97EUYE61qqg7AzNSpeeaXH4gdq3dHe61zMU
   NzVbWRlM/GuVWY087Z4oluCuGBWvuyGtXYoYz72sYR/gnO+Q7YvY3OK/Z
   5hl9Ej9heYDybGfPU82/EqZMEFQokRR8HI8ZFb9MCiU/XUBIhx/wBbMqH
   G39F0sMAC9gZKl2CFa6C/l6uoaGQF9chIi+cFoHaL+AfnYgSwbycgJrqK
   A==;
X-CSE-ConnectionGUID: xYbypqqQQIW8kWUDa0wEyA==
X-CSE-MsgGUID: tloxCsNJQciigaV15OkH5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="19817044"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="19817044"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 22:55:17 -0700
X-CSE-ConnectionGUID: YvK3MWzjQP6f2lsibkttYQ==
X-CSE-MsgGUID: p91iEwuIRdqyjcfXzEouHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="49860164"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 22:55:14 -0700
Message-ID: <7421b923-0bd6-4c9d-81e6-07d954085171@linux.intel.com>
Date: Mon, 1 Jul 2024 13:55:12 +0800
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
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-8-baolu.lu@linux.intel.com>
 <Zn8oZ80p0p1bHgBC@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Zn8oZ80p0p1bHgBC@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/29 5:17, Jason Gunthorpe wrote:
> On Sun, Jun 16, 2024 at 02:11:52PM +0800, Lu Baolu wrote:
>> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
>> +{
>> +	struct device *dev = idev->dev;
>> +	int ret;
>> +
>> +	/*
>> +	 * Once we turn on PCI/PRI support for VF, the response failure code
>> +	 * should not be forwarded to the hardware due to PRI being a shared
>> +	 * resource between PF and VFs. There is no coordination for this
>> +	 * shared capability. This waits for a vPRI reset to recover.
>> +	 */
>> +	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
>> +		return -EINVAL;
> I don't quite get this remark, isn't not supporting PRI on VFs kind of
> useless? What is the story here?

This remark is trying to explain why attaching an iopf-capable hwpt to a
VF is not supported for now. The PCI sepc (section 10.4.2.1) states that
a response failure will disable the PRI on the function. But for PF/VF
case, the PRI is a shared resource, therefore a response failure on a VF
might cause iopf on other VFs to malfunction. So, we start from simple
by not allowing it.

Best regards,
baolu
