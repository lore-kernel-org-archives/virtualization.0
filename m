Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1CC14600B
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jul 2024 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719902533; cv=none; b=owMFoTbYt8Ckg75Kfj3w/al/nJponB/nA7ufqxPrgGIuQmWSMCSgNHNpE2gzUTZYNx/Zyv0D5Ui4egjDsPKcZvIoWanJnrSvcMcJpYoWQPRIdpw7HnZrDQjtk4JgEQoxE51DRbwTeWUxhglkV8bawVXRH4Mi92Wf/Jub9VR9mu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719902533; c=relaxed/simple;
	bh=skiLNaS3OynVBSdw38XH6gPIue0IpenzfUX6kSiea30=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GW2fK+u803D1Bc7/Dx4Kh6U87BdOCqDWOJV2+tBUZVieQGK6bXPda88qVFCjWWy8LCPy9RNbC4cCinGdj6aB+Ul39YpNJsnUJIGgS5bI4vmHAE1IJsnmrBmStobuu9KSe6nZktXejgcexc148koYzRl9FYnspyCvrB9hlshL6Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SVrwdmrR; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVrwdmrR"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D475A40CCB
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jul 2024 06:42:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yTukzIN5CB14 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Jul 2024 06:42:11 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D32F740620
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D32F740620
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SVrwdmrR
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D32F740620
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jul 2024 06:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719902531; x=1751438531;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=skiLNaS3OynVBSdw38XH6gPIue0IpenzfUX6kSiea30=;
  b=SVrwdmrRd37Jjri28XjgSD2ZYd4Z6s2O+KNq5AG7BoMmPmGcgjPMotCE
   k10UEAzIDQHiCJ3ZrNC8ZG3moK1tLRnolgKlC16oG5PiTc7++CTnVkFBS
   s3l0IIzLBUncAVxruNogOqSjMJmOfsKDIEENjADUvl6XEeGBhHi1vfHkm
   twoBXaMxcV9jRhqjGgNvuY+lPw7XKkxUxk5/VppxA3XleBeUU+V1iimOM
   gW6n0eCBDJp4wuGxXDZSg2ntyGxVhcDelHww9S8stNvRhRujUYqlzpN0b
   E7E5la8JfLG9AafNn7KkV5nXBZaCaOKTVStzBWhFi07LLEkVYbh4rVN7l
   g==;
X-CSE-ConnectionGUID: qMF6CzkWRcaxEufXh17s9w==
X-CSE-MsgGUID: Z7SU/5sWRcq5QM9DHJADFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28191022"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="28191022"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:42:10 -0700
X-CSE-ConnectionGUID: SwpiZGu1SJ6+7oRuLo4zTA==
X-CSE-MsgGUID: HOHVsNC2RseI+/0lRuG0XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="76510909"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.100]) ([10.124.237.100])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:42:06 -0700
Message-ID: <21baa9fd-124c-4ab5-87da-2b225c4b1efc@linux.intel.com>
Date: Tue, 2 Jul 2024 14:42:04 +0800
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
Subject: Re: [PATCH v7 00/10] IOMMUFD: Deliver IO page faults to user space
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <Zn814+VwyCJ/okax@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Zn814+VwyCJ/okax@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/29 6:14, Jason Gunthorpe wrote:
> On Sun, Jun 16, 2024 at 02:11:45PM +0800, Lu Baolu wrote:
> 
>> Lu Baolu (10):
>>    iommu: Introduce domain attachment handle
>>    iommu: Remove sva handle list
>>    iommu: Add attach handle to struct iopf_group
>>    iommu: Extend domain attach group with handle support
>>    iommufd: Add fault and response message definitions
>>    iommufd: Add iommufd fault object
>>    iommufd: Fault-capable hwpt attach/detach/replace
>>    iommufd: Associate fault object with iommufd_hw_pgtable
>>    iommufd/selftest: Add IOPF support for mock device
>>    iommufd/selftest: Add coverage for IOPF test
> Small remarks aside this all looks fine to me, send a v8 and I'll try
> to pick it up next week

Sure. I have updated the series and posted a v8 in another thread.

Best regards,
baolu
