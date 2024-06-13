Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06598137C44
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261229; cv=none; b=cOt1m+F1HA9OLpkqkQNTPOMQjfqhn5mmWdR83maLfHURgCtqwIgyw/0YDL3R3lxPyu0rGMXEZHlGdZE/on6XhTqdgCPXsJYZ99pYp1QROM7kxWvNAipORIP55sqFv7XAaT2nyyK/wSXNoAeFdgn4WrlAU9+ZrJvZTXwW78K40TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261229; c=relaxed/simple;
	bh=hKFBgo1zxsvPe2XZH3PZju070f1XZgJSoxjnv76xuss=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S9NYjrag2mrr+S0NCP/XfqrauZqE16MOHHEjCcBm//QPmDOaGrO6yV4le8/hvsjIN+td92paeFhuHgb5u3aN5hek2jQs/e0eFQeJQipzDyilhc60HJCbNB27B0tgHWEFac6UEtrv8a9MNA+Ay3MgZIWPcC3VfoMrGWxTCOGZgWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGAgzDHQ; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGAgzDHQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A4E124025E
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:47:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id biu-uAY_aQ8t for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jun 2024 06:47:07 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A38BF40167
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A38BF40167
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MGAgzDHQ
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A38BF40167
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718261226; x=1749797226;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hKFBgo1zxsvPe2XZH3PZju070f1XZgJSoxjnv76xuss=;
  b=MGAgzDHQwGD0TqrbxdBJvXDDNr104kWZKZSmD2d2nwoF/REuOjALJkfg
   8JZOol0ddOOwFPeGyN3cWsQInMAAAcGKk1bazqzthJ7xCP4GSrtJ1PiMg
   jFUwnqn6PHqSJsJk8R22GMBcKMI9lc0SLvsR5MEMS830bPLFz8Jbhwx+8
   LFL8Ed8zzcJNEbMskJCe7xok8jPe7if3Tsln45rlG5Ehd2fcR2Me+yWxu
   9mURx/Z6E4BRV0I2zv12XaDoqHYPk+MWqJFVBXEK3TrB1xzBSfGMPNPbg
   R6nyuU5Vle5vvSKF7/q8JFMGXfOWX/fyAJV0G58k9ru7e+H1Fuk85lPWL
   w==;
X-CSE-ConnectionGUID: +TdmnoKTR6++9bgJzwb68Q==
X-CSE-MsgGUID: xQNzSfzPTpe1ma1mJpKJnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="32546805"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="32546805"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:47:06 -0700
X-CSE-ConnectionGUID: HnzvIUYeRd2KKrf3gOlWZw==
X-CSE-MsgGUID: yKKRf0CPSI6AvloXzCwYhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40149228"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa009.jf.intel.com with ESMTP; 12 Jun 2024 23:47:02 -0700
Message-ID: <75d459d5-1d04-4d10-bc04-71ea83e55ccc@linux.intel.com>
Date: Thu, 13 Jun 2024 14:44:43 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 06/10] iommufd: Add iommufd fault object
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-7-baolu.lu@linux.intel.com>
 <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a17113d3-500e-45ef-a2d2-747d890c9c5e@linux.intel.com>
 <20240612132531.GV791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240612132531.GV791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 9:25 PM, Jason Gunthorpe wrote:
> On Sat, Jun 08, 2024 at 05:58:34PM +0800, Baolu Lu wrote:
> 
>>>> +static int iommufd_fault_fops_release(struct inode *inode, struct file *filep)
>>>> +{
>>>> +	struct iommufd_fault *fault = filep->private_data;
>>>> +
>>>> +	iommufd_ctx_put(fault->ictx);
>>>> +	refcount_dec(&fault->obj.users);
>>>> +	return 0;
> 
> This is in the wrong order, dec users before ctx_put.

Done.

Best regards,
baolu
