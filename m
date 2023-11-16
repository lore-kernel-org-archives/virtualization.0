Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC97ECE
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 01:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkDmRGbr"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01B3782D0F
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 01:42:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 01B3782D0F
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nkDmRGbr
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.297
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8pQHJWmIwAXU
	for <virtualization@lists.linux-foundation.org>;
	Thu, 16 Nov 2023 01:42:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3D53682D07
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 01:42:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D53682D07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700098952; x=1731634952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8V9GxQGhmWnHBzLUfmWUpWRTkqOnn/65G7sZH4jO9eQ=;
  b=nkDmRGbrXspRXV5VeOZwalooLlfrN1dra02NJDtVYr8bvXbPORkwk7gZ
   SYex2/FI6t/iwjJkzKyyd7EX28G6sUVerfaj/QM6REHw/8cQLH4O2EO5B
   +uFSbviPzEsvN9lTZQ1uV4i1GL3D4aWYj8QQy71x7VFbyT8XdvceSqY6/
   roLoECnPkNid2QLIpX+ViVyG8OArSphdDnngZj0z18okwcYQrfWyMtUCd
   7kGSt566KQAjA/xM7wgmgBczRdZt9A0MNfWhrtM++ab4sdLU/YkJ2kuNt
   wyWM+t2phrejevv1U2HcZj+L17PV28wiQGLPE2TZ5NqztHJSZDehf1Hfw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="422084509"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="422084509"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 17:42:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="908957353"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="908957353"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 17:42:30 -0800
Received: from [10.93.24.3] (liujing-mobl1.ccr.corp.intel.com [10.93.24.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0E2F2580D77;
	Wed, 15 Nov 2023 17:42:25 -0800 (PST)
Message-ID: <8f24918e-aa57-4160-902a-58d10021246e@linux.intel.com>
Date: Thu, 16 Nov 2023 09:42:23 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
 <c774e157-9b47-4fb8-80dd-37441c69b43d@linux.intel.com>
 <ZVTObiybC1MYlSam@ziepe.ca>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
In-Reply-To: <ZVTObiybC1MYlSam@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jason,

On 11/15/2023 9:58 PM, Jason Gunthorpe wrote:
> On Wed, Nov 15, 2023 at 01:17:06PM +0800, Liu, Jing2 wrote:
>
>> This is the right way to approach it,
>>
>>     I learned that there was discussion about using io_uring to get the
>>     page fault without
>>
>>     eventfd notification in [1], and I am new at io_uring and studying the
>>     man page of
>>
>>     liburing, but there're questions in my mind on how can QEMU get the
>>     coming page fault
>>
>>     with a good performance.
>>
>>     Since both QEMU and Kernel don't know when comes faults, after QEMU
>>     submits one
>>
>>     read task to io_uring, we want kernel pending until fault comes. While
>>     based on
>>
>>     hwpt_fault_fops_read() in [patch v2 4/6], it just returns 0 since
>>     there's now no fault,
>>
>>     thus this round of read completes to CQ but it's not what we want. So
>>     I'm wondering
>>
>>     how kernel pending on the read until fault comes. Does fops callback
>>     need special work to
> Implement a fops with poll support that triggers when a new event is
> pushed and everything will be fine.

Does userspace need also setup a POLL flag to let io_uring go into poll, 
or io_uring

always try to poll?

> There are many examples in the
> kernel. The ones in the mlx5 vfio driver spring to mind as a scheme I
> recently looked at.

Thank you very much for guiding the way. We will study the example to 
understand

more.

BRs,

Jing

> Jason
