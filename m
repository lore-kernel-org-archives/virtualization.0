Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043361364
	for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710897639; cv=none; b=nlSCLdvG+/sTcc8fPM1GfiU0OkHWhN06ZZfXo88rhxtKCHzOy4D8TllYay7l5yDxhmZ6dOgrjTSoyi96D94c+DOroahG5Y+CBkNIhIX9Io6suGEJ6ZGiHghHNWbqdWa9SzUR5tJyKEd38ildAI/vJFo7cClCfqiZfYUKLe4h0cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710897639; c=relaxed/simple;
	bh=lVysItcq9CayId6tXihYM/lEFVJ/SBu7XnT87PdMpsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJRmYTVrORredQqTu0DhVOa1IYevwRJV+GT004HlkkG2ZOp29zb3l8d5SrpTbSpoGE5D348En3kTie0NoSN3+A2tcIkjUlUIW1kOlw/PsAZocj+iWSbNHRMj/YXXa9aQf4IHAe23/vORZW2ZQBvvrXkOPeuFGbGMtHPY5xEuViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FobfGMr/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FobfGMr/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710897638; x=1742433638;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lVysItcq9CayId6tXihYM/lEFVJ/SBu7XnT87PdMpsI=;
  b=FobfGMr/gQ809li8bTBoQ9C6PGRx7KZm4AKKFQgHv5bNsJIJOUrxd79+
   kq7jLzGN4sV2Q5P2VAEYCw8zxZT/RK8cDHN3I3qUGVjvy2D6n9aI96PlW
   8Qx2D3AqL8plZiemZBtpMLTldCrN89D1AFwsuXwWJPcgh6Zq35ZDQqQtv
   3jsfRbCITVIZJI9Yjq+99xGBUxIxuy6EEfo3zIeKHPiWcA1O3hYF9DJws
   m0HvRuuj3fmqSf0tFLdTq7ztuoOkTYCR3YkiQCmdUlTkhjmh4Zfurm03A
   6p2v/JUEN2sOEn3WAfqbyL6qoO4XIv4EffB9CnW4yKE/Fg7/GjAgiXA79
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17251419"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="17251419"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 18:20:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="14068554"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.124.224.9]) ([10.124.224.9])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 18:20:36 -0700
Message-ID: <56561c45-e338-4a5a-b2a9-255eb0e516f2@intel.com>
Date: Wed, 20 Mar 2024 09:20:33 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: apply maintainer role of Intel vDPA driver
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtualization@lists.linux.dev
References: <20240227144519.555554-1-lingshan.zhu@intel.com>
 <09fbc96c-9083-4280-b64e-e5159279b4ce@intel.com>
 <20240319083521-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20240319083521-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Many Thanks!!!!!

On 3/19/2024 8:35 PM, Michael S. Tsirkin wrote:
> My bad I messed up my tree. I think this is ok to merge
> after the window closes, will do.
>
> On Mon, Mar 04, 2024 at 01:50:18PM +0800, Zhu, Lingshan wrote:
>> Gentle Ping
>>
>> Thanks
>> Zhu Lingshan
>>
>> On 2/27/2024 10:45 PM, Zhu Lingshan wrote:
>>> This commit applies maintainer role of Intel vDPA
>>> driver for myself.
>>>
>>> I am the author of this driver and have been contributing to
>>> it for long time, I would like to help this solution evolve
>>> in future.
>>>
>>> This driver is still under virito maintenance.
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>> ---
>>>    MAINTAINERS | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 2ecaaec6a6bf..128ec843eb19 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -10365,8 +10365,10 @@ F:	include/net/nl802154.h
>>>    F:	net/ieee802154/
>>>    F:	net/mac802154/
>>> -IFCVF VIRTIO DATA PATH ACCELERATOR
>>> -R:	Zhu Lingshan <lingshan.zhu@intel.com>
>>> +Intel VIRTIO DATA PATH ACCELERATOR
>>> +M:	Zhu Lingshan <lingshan.zhu@intel.com>
>>> +L:	virtualization@lists.linux.dev
>>> +S:	Supported
>>>    F:	drivers/vdpa/ifcvf/
>>>    IFE PROTOCOL

