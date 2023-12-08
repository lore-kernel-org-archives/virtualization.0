Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719697491
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEe79FMD"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB7186F50C
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 06:29:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB7186F50C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KEe79FMD
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IW4WTs6MnnXF
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Dec 2023 06:29:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E18F06F504
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 06:29:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E18F06F504
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702016945; x=1733552945;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hhwvQW5d3F0DRDnekXHWCaEI+t4hV1ugkZDv0LKCQdU=;
  b=KEe79FMDWRtimlx7bDVfVrjN3aLFQ8EAvp4EDiOkcRYHDP6B5MRN8t38
   1rs+ANl9xbvDz+8D2tD0ZC15rRcrsKMFy60861Yxk+VBeJFmwH1yyYZla
   HkJceMXE6sDEb0onzU0hYQn7jCsoOYeaX0lMHUk2MLFHfwU3FrVcuN1St
   XBI2S7r8MYWxBn5do6V2Md2SGCNC9lQBErZ2/YlUqgIQvT3TGZdO/nlW7
   gP0rKwpug8uzcwhP0ea2307RYAKl6qejKByCno8DONWX861LOXky1XXqv
   H338caozRu0kgcpi4Tb+Ye7oiSZXXTo+dqSSrKqbSTYgFqtcrmHPFDAph
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="394103560"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="394103560"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 22:28:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="862757803"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="862757803"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2023 22:28:56 -0800
Message-ID: <e6504514-9e95-4f68-a276-35582db3881e@linux.intel.com>
Date: Fri, 8 Dec 2023 14:24:19 +0800
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
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iommu: Add iommu page fault cookie helpers
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-2-baolu.lu@linux.intel.com>
 <20231201143810.GK1394392@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231201143810.GK1394392@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/23 10:38 PM, Jason Gunthorpe wrote:
> On Thu, Oct 26, 2023 at 10:49:25AM +0800, Lu Baolu wrote:
> 
>> +void *iopf_pasid_cookie_get(struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
>> +	void *curr;
>> +
>> +	if (!iopf_param)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	xa_lock(&iopf_param->pasid_cookie);
>> +	curr = xa_load(&iopf_param->pasid_cookie, pasid);
>> +	xa_unlock(&iopf_param->pasid_cookie);
> No need for this locking, the caller has to provide some kind of
> locking to protect the returned pointer.
> 
> I'm not sure how this can work really..
> 
> What iommfd wants is to increment the device object refcount under
> this xa_lock.
> 
> I'm not sure this is the right arrangement: Basically you want to
> have a cookie per domain attachment for iopf domains that is forwarded
> to the handler.
> 
> So maybe this entire thing is not quite right, instead of having a
> generic iopf attached to the domain the iopf should be supplied at
> domain attach time? Something like:
> 
> iommu_domain_attach_iopf(struct iommu_domain *, struct device *,
>                           ioasid_t pasid, struct iopf *, void *cookie);
> 
> The per-attach cookie would be passed to the iopf function
> automatically by the infrastructure.
> 
> Detach would have the necessary locking to ensure that no handler is
> running across detach
> 
> Then the cookie is logically placed in the API and properly protected
> with natural locking we already need.

Great idea! In a subsequent series, we could arrange the enabling and
disabling of IOPF in this API, thereby eliminating the calling of
iommu_dev_enable/disable_feature(dev, IOMMU_DEV_FEAT_IOPF) from the
device drivers.

Best regards,
baolu
