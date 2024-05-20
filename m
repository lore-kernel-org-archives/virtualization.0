Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D9E4C80
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716169240; cv=none; b=rkexp/bSmeFk9sQYi273uqMVRgyjMB5qLYXhsV6TSTB+Dde4UlTZxtqd7ENx2yQ2EjYyt+LegrlHtI7FQIfoTvv0GEL9TH7m2G53vk6osFnWg2IaEaNEd8IySBg37B9K+7oA/D8KjDJEhaQ9W9+yUsQXliIj1nnCmikbMyzleRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716169240; c=relaxed/simple;
	bh=v7BNjDNjna79xAB70CuhL0W6lWarPN4nUAKjM5i0OJM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R8nGK+Pd1ETfTlhm6rcGKGzgswzeMCdbekkejcyccWU5f0v+9OoqZ+zANDw3OjeMWa0PsqmqO6n77mA78oS6AMirURJFD2gwFXGdE+H7D+vhzpBEQwGC4SCWfbtRLcmqT0e85nDN3W5C+gIRYRRN8mNmEARbtt/jtm+818A30gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBbgjuZB; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBbgjuZB"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 407994049C
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 01:40:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OTrLWNs5enML for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 01:40:38 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8530E40459
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8530E40459
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EBbgjuZB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8530E40459
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 01:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716169239; x=1747705239;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v7BNjDNjna79xAB70CuhL0W6lWarPN4nUAKjM5i0OJM=;
  b=EBbgjuZBX0Q5VnQOlY1jf2AWghvxwHt2906ImyevhH9yIbzom+A+WZNP
   eXWAcxuddsDgA7rY/gJRnxWQh3JZlnDVsx7upuUx4PNRoeKW0bxcTs1/B
   DVuUw3oub8TenARS2qywaBg9Uq+/7gO65E4b7Xal4xcRt8DD9e9PgyAOd
   uNP06lydsaWsgqLmv+lLsEsswJNaPCda7Y1KHklZizf4BY7qBqG7RMcK1
   7veazvOIzjefQKJtRa24OvzuNMrH+NvXXmYtpKfWjJz4e2h4v1RPEuTDK
   3IpU3X9lYkn9d8HSZtDcg/ZMhtseJ5Qi3xNW/8xR32ABZxTm78+2c9oot
   g==;
X-CSE-ConnectionGUID: bCp3uIcEQjm8783tQNxi0g==
X-CSE-MsgGUID: fg7kokL4TiS8nZSSzmMehg==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="15222446"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="15222446"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 18:40:37 -0700
X-CSE-ConnectionGUID: FFh+bDzaR+iXthcEUOL9DQ==
X-CSE-MsgGUID: qneolWTNTlKzAfNseBaoiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32278942"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 19 May 2024 18:40:33 -0700
Message-ID: <10df7c77-4848-42d2-ad00-70badc7a9ae8@linux.intel.com>
Date: Mon, 20 May 2024 09:38:42 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52769AC595B6BDA8FB4639258CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52769AC595B6BDA8FB4639258CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 4:37 PM, Tian, Kevin wrote:
>> +		iopf_free_group(group);
>> +		done += response_size;
>> +
>> +		iommufd_put_object(fault->ictx, &idev->obj);
> get/put is unpaired:
> 
> 		if (!idev || idev->obj.id != response.dev_id)
> 			idev = iommufd_get_object();
> 
> 		...
> 
> 		iommufd_put_object(idev);
> 
> The intention might be reusing idev if multiple fault responses are
> for a same idev. But idev is always put in each iteration then following
> messages will access the idev w/o holding the reference.

Good catch. Let me fix it by putting the response queue in the fault
object.

Best regards,
baolu
