Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62118184D
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Mar 2024 03:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711338784; cv=none; b=ioWuKrunbypF+Fp5+1k4RuFD1y+QiwqB9HvJ797XCa8E+grkmcvq+NsiIluJAdg/6eyU5kSFj5OJSAyIS37RWeoVNP3+SoTAy/V1ShsJvuJKrT7Vwe000GRYX7z4CTW/mJ/mVfxO/kLwz2ekcHCV3IiMXF3Q1e/AAorCvh3zYnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711338784; c=relaxed/simple;
	bh=fm/ErcL7W49rS5AmQMWHiVhN2nRexSlcv3UfZogZWnk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oRjAjgWBZFHWxda2MggSF4mpMZxjMpgFP6LvDkmT31Fm5QHMWdbPr9q/WgBzlAMk4Ew5pqmd1lPlOjZLwPwdFWpjUxpKgV183sfiYKdzPyQ5xPzozia3791KaS0eeiPqU7KEm7TDBorAymOZdyl6qW6mMOSokRBfD9OheDNCU1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vz7WHdqg; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vz7WHdqg"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEAEB60849
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Mar 2024 03:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id un0sEvTCvOfR for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Mar 2024 03:53:01 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4ECE86083F
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4ECE86083F
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vz7WHdqg
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4ECE86083F
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Mar 2024 03:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711338781; x=1742874781;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fm/ErcL7W49rS5AmQMWHiVhN2nRexSlcv3UfZogZWnk=;
  b=Vz7WHdqgOJfA9Ot+KPvqDCD8OyVdjIjLVVh7wEfbqPyVSXathEjA4lvP
   7LDMhVlOpIxTZKLnISM5UeGMr3cq/2EatBsKMdnSohhqx1ZqvILk6cLq0
   5IyV2gG3PjfxYr5Of6WJClCUqcB8gC5bRFrXrQT2nFZjs0DXbIRc+Rz3D
   feGQwvHwtMuPN20JZ7l71IBi3Ij/zI9Uln6OgUuAVSQHrZI4lRZ2VoOpE
   bVRbfHjcMRw2ApkDGdh6IcFbLAcQUkz3X/nFO6R2WF20VivjzcK2xiG6f
   BJLalEwGGkfYKFm3d/wL/2jCCtfopRk8R4cgrb7oYcU3F5/WpfD/lz9s0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="10093992"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="10093992"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 20:52:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="20033103"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 24 Mar 2024 20:52:55 -0700
Message-ID: <0d12a5f4-0380-4e00-8c23-b4f63e3b93e7@linux.intel.com>
Date: Mon, 25 Mar 2024 11:52:05 +0800
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
Subject: Re: [PATCH v3 2/8] iommu/sva: Use iopf domain attach/detach interface
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-3-baolu.lu@linux.intel.com>
 <20240308174605.GV9225@ziepe.ca>
 <b33bf29b-2fe5-4a2a-a2ce-9fd8d67c5f6f@linux.intel.com>
 <20240322165927.GG66976@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240322165927.GG66976@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/23/24 12:59 AM, Jason Gunthorpe wrote:
> On Thu, Mar 14, 2024 at 03:41:23PM +0800, Baolu Lu wrote:
> 
>> The whole cookie mechanism aims to address two things:
>>
>> - Extend the domain lifetime until all pending page faults are
>> resolved.
> Like you answered, I think the flush is a simpler scheme..

Yeah! Let me head this direction.

> 
>> - Associate information about the iommu device with each attachment of
>>    the domain so that the iommufd device object ID could be quickly
>>    retrieved in the fault delivering path.
>   
>>> I see we also need to stick a pointer in the domain for iommufd to get
>>> back to the hwpt, but that doesn't seem to need such a big system to
>>> accomplish - just add a void *. It would make sense for the domain to
>>> have some optional pointer to a struct for all the fault related data
>>> that becomes allocated when a PRI domain is created..
>> It's not getting back hwpt from domain, just getting the iommufd_device
>> in the fault delivering path. The iommufd_device is not per-domain, but
>> per-domain-attachment.
> It does make sense you'd need that, but I think something like this is
> a more direct way to get it. Caller allocates the handle struct. The
> iopf will provide the handle from the XA to the
> callback. container_of() not void * is used to in the caller's API.

Your code looks attractive to me. It's much simpler. Thank you!

Best regards,
baolu
