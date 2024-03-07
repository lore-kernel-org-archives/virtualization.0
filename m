Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A8C5221
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Mar 2024 01:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709776503; cv=none; b=qixlNP+BJPtZAq+SvegIg8bU70L6SKpiJor7X9sBmz8FSbELKQlDVTfqgV+Vq/yID2tG79r6q2Qdj0lazym/Ccjynopz8WPHhKg/M0zuDdJkwnJ8QUgiQ++iZcORBLZHZH8K/vuJ+Y19X9CmSXln8ML1NqnWxwBNtiYuMwWQzY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709776503; c=relaxed/simple;
	bh=5WFadBJ053HVtxwSAi8UYcspvQWJ8KI5l/JwPFHYq1w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uaKbFGg7lKludOAA8g4CyK1G+1PpOMV+sgOasikETaPj0CAQMasdWWzFt9UW++iggVr/hzlEhTX5nW+38+bv7c7DHbRiW/CxSDy6QCl3Qq86JUCAtgX2K4dhsK31khwx2/oNqp+F9pdwzK5R7duMkPoDUKzAXn5yndMraj6i0/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLPfM1+j; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLPfM1+j"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EE0EA4043E
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Mar 2024 01:55:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 93SwLgziyPIl
	for <virtualization@lists.linux-foundation.org>;
	Thu,  7 Mar 2024 01:55:01 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4246B401F3
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4246B401F3
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MLPfM1+j
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4246B401F3
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Mar 2024 01:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709776501; x=1741312501;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5WFadBJ053HVtxwSAi8UYcspvQWJ8KI5l/JwPFHYq1w=;
  b=MLPfM1+jcF5Um2EwgKmvB3VszInR+o3Ma/gHzkGtaXt7FSzvoYTLBxHz
   oTMFJMnsmKTjeSoB9ovtAhOOnLu+DCTtKUMAAWz35KD1RiC8n1extvrLk
   KCGsxaKipbNtHjk9BngNyJCt27VAPX5ZXttIFMaCDvUySuZRV8P5zYyDV
   B7a+QDdXzEoIUMQXYrEGWyVXzQe++go/rFwHwXtcnjvlSLC0Gb2d2qKeo
   p2OGjwXwaMK9ByLHhGVoDWSahTHjnNSnZrUuJE5efDWLFRoYUsIlOzLZH
   D1CRmfwvEKymiB5yX6IVkxocKO+abfNSAoyTBFTVQ5gL8Mz7p4vILIXr0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4311267"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4311267"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 17:54:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="14510975"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.185]) ([10.254.213.185])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 17:54:56 -0800
Message-ID: <74d6f11a-9415-48e5-a165-7b9f5b87873d@linux.intel.com>
Date: Thu, 7 Mar 2024 09:54:53 +0800
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
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
To: Jason Gunthorpe <jgg@ziepe.ca>, Zhangfei Gao <zhangfei.gao@linaro.org>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
 <CABQgh9FwOVsFe3+5VG0_rDruJVW0ueHTcsnxUcVAvFqrF4Vz6Q@mail.gmail.com>
 <CABQgh9G5yFZ_p+tfvnJqOQo+Be62rMDatsEX1rhD_oTiXDaw5w@mail.gmail.com>
 <20240306160120.GN9225@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240306160120.GN9225@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/7 0:01, Jason Gunthorpe wrote:
> On Wed, Mar 06, 2024 at 11:15:50PM +0800, Zhangfei Gao wrote:
>> Double checked, this does not send flags, 0 is OK,
>> Only domain_alloc_user in iommufd_hwpt_paging_alloc requires flags.
>>
>> In my debug, I need this patch, otherwise NULL pointer errors happen
>> since SVA is not set.
> This is some driver bug, we need to get rid of these
> iommu_dev_enable_feature() requirements.

Yes. Especially iopf should be independent of SVA.

The problem in the arm smmu v3 driver is that enabling iopf is actually
done in the enabling SVA path, while the enabling iopf path does nothing
except for some checks. It doesn't matter if iopf is tied with SVA, but
when it comes to delivering iopf to user space, we need to decouple it.

Best regards,
baolu
