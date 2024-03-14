Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C035CDE7
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Mar 2024 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710402094; cv=none; b=n7dvYt8y4auxD0waarcOnP54aIcjIoq+CFjmDUGT2w5f0WEl5Z+9tC1UuIGJk7PC5m1hcglKRsxMpEPOOcpdcefh+Ma/bxfdXd1zmS0S0uu4D7qmBkeung93P92hp6NEXYE/FnZ0mBVMlvr+We39sYWWasUFk5swZF6M1x3cDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710402094; c=relaxed/simple;
	bh=tYLRFrjCwOGp9whBxYAiRelcKZZjcsXaVqhFiwh3zBg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c+Ssrszdelxy5MGHW/LAYOIQ/o+jwXkAKeKVoeGBiWUVboDkxzHD/O2Ticy4BspeZwFgVOEU7wzOSzQLHD157dJrci8ETY2A9RkHRvLq19T2ejgXDClSJ3E3eInuOtnoS0BO7DSWqNl4ES04drOCLt15NDPE5zRqEkOoZSyiMKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Si3EgK1a; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Si3EgK1a"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57C7D408C8
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Mar 2024 07:41:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9qZVOFsLS102
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Mar 2024 07:41:31 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 03CB9408C6
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03CB9408C6
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Si3EgK1a
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 03CB9408C6
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Mar 2024 07:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710402091; x=1741938091;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tYLRFrjCwOGp9whBxYAiRelcKZZjcsXaVqhFiwh3zBg=;
  b=Si3EgK1aCVpWvocmMonXkzGwLi3BsbnWD7/2/x1vW9AdajFILCpe7pGL
   tO7mXh2yxLGI7jGTFLK5sDYlPIwnBdRf2oFzuaYqbmFxJYXHjwc1u/7xd
   YxljE5Asz4Z6tyTEKMlM1ct9OIYdk1ukjOJaXU5ZdoRP7Ch6fnsrhpDld
   dCb4uY9aD6E4j9U9CsszxeiPxCESWeCXC+jNe8jb4ks+dr2RtskJIfww6
   uqbGWIXxm2nHXWfxGQTXedlMBeOr94qZyZRY91bSgfNr7CazPb3tO3+ll
   PnOp420HI/KXrEYq3/uO0IlzTxOICg5GDih8QKk9SfpiJyGH2BhEtQcnU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="30644723"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="30644723"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 00:41:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="16798366"
Received: from schen8x-mobl.ccr.corp.intel.com (HELO [10.255.29.38]) ([10.255.29.38])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 00:41:26 -0700
Message-ID: <b33bf29b-2fe5-4a2a-a2ce-9fd8d67c5f6f@linux.intel.com>
Date: Thu, 14 Mar 2024 15:41:23 +0800
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
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-3-baolu.lu@linux.intel.com>
 <20240308174605.GV9225@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240308174605.GV9225@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/9 1:46, Jason Gunthorpe wrote:
> On Mon, Jan 22, 2024 at 03:38:57PM +0800, Lu Baolu wrote:
>> @@ -215,7 +202,23 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
>>   		group = abort_group;
>>   	}
>>   
>> +	cookie = iopf_pasid_cookie_get(iopf_param->dev, pasid);
>> +	if (!cookie && pasid != IOMMU_NO_PASID)
>> +		cookie = iopf_pasid_cookie_get(iopf_param->dev, IOMMU_NO_PASID);
>> +	if (IS_ERR(cookie) || !cookie) {
>> +		/*
>> +		 * The PASID of this device was not attached by an I/O-capable
>> +		 * domain. Ask the caller to abort handling of this fault.
>> +		 * Otherwise, the reference count will be switched to the new
>> +		 * iopf group and will be released in iopf_free_group().
>> +		 */
>> +		kfree(group);
>> +		group = abort_group;
>> +		cookie = NULL;
>> +	}
> 
> If this is the main point of the cookie mechansim - why not just have
> a refcount inside the domain itself?
> 
> I'm really having a hard time making sense of this cookie thing, we
> have a lifetime issue on the domain pointer, why is adding another
> structure the answer?

The whole cookie mechanism aims to address two things:

- Extend the domain lifetime until all pending page faults are resolved.
- Associate information about the iommu device with each attachment of
   the domain so that the iommufd device object ID could be quickly
   retrieved in the fault delivering path.


> I see we also need to stick a pointer in the domain for iommufd to get
> back to the hwpt, but that doesn't seem to need such a big system to
> accomplish - just add a void *. It would make sense for the domain to
> have some optional pointer to a struct for all the fault related data
> that becomes allocated when a PRI domain is created..

It's not getting back hwpt from domain, just getting the iommufd_device
in the fault delivering path. The iommufd_device is not per-domain, but
per-domain-attachment.

> 
> Also, I thought we'd basically said that domain detatch is supposed to
> flush any open PRIs before returning, what happened to that as a
> solution to the lifetime problem?

If I remember it correctly, what we discussed was to flush all pending
page faults when disabling PRI. Anyway, the current driver behavior is
to flush faults during domain detachment. And if we keep this behavior,
we no longer need to worry about domain lifetime anymore.

> 
> Regardless I think we should split this into two series - improve the PRI
> lifetime model for domains and then put iommufd on top of it..

Yes, agreed. Let's tackle those two points in a separate series.

Best regards,
baolu
