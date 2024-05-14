Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6E3EC5
	for <virtualization@lists.linux.dev>; Tue, 14 May 2024 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649393; cv=none; b=LG7hThpWQ3aGy+maktdsfXGd+CjpdiD9No/4kRLDplI30C9P0FqBxM7EXSVoXxZOcDsP2/tRen8lxmO2Ff8YkyMTaV4L4Pd8kh8JZ+6++WSuGzkH93a2EmgcmkrS/8eGgqQ+kk8ldzajipAH0XX/jS4b2uON2P9zlgftXPrJvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649393; c=relaxed/simple;
	bh=RAPbQJGjjDic2iAPdMENG7cR9zjIc6r8k6u7kuNr9XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJ7DrW/6ONUPTnklvkDJUJ3d/FCjG5D4Je38nOe2Vt8y3y+KLmtRax/2bc98NAcBnQjjHVYo6iYXVnyDbcNMc1BM4sMjrpQzQ9yps879H6D7I6uVDmRg0BBR6HF9SwrYeojdg/i/vPxSMmZrW8iXJqeC7OH7OA9uJn5BAnn3IJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPu+bj8l; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPu+bj8l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715649391; x=1747185391;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RAPbQJGjjDic2iAPdMENG7cR9zjIc6r8k6u7kuNr9XM=;
  b=TPu+bj8lqW3ApEiY721wzfvviZfEUw11Tk/9VM3UNp5G0a3Dkmi+Qfd8
   +3f5//5PvHFBll4ed2eeyivvAaBP8TXUxKvXkC3WrkJ/iQ3EKBduwcBYr
   cnaDkTtQk7E5KZSbSBVNwJX+xDxsvMV7Jqm0cKFIGyDPJXjHQspRAZ+Y5
   rXgnFo/VlK5eu/LhAvlj5s33/zMEliFWjLo8nCa6TFa2iad/LcjiRkaMD
   qp38/s7BOCgAtwlIe5wpMRSG90+Q0rNDEQV5pkgkjv3/NlBb5+tshYVS0
   kNQJFXrWsoNu0TviARIhovy3PGD32SV9oTScLUkEU8kJRQzwPn0gC+Cq5
   g==;
X-CSE-ConnectionGUID: BB/GNqfBTzmjPhGwA1Xa5Q==
X-CSE-MsgGUID: yMe6zVAhSRmrBDZO/eBTDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="15400726"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="15400726"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 18:16:24 -0700
X-CSE-ConnectionGUID: f0TVJg1SQ+q98s5eHlej7A==
X-CSE-MsgGUID: IvluKwOzStWodcUR5aC6gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30516943"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.125.245.197]) ([10.125.245.197])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 18:16:22 -0700
Message-ID: <efe1f606-11bd-45f6-8e29-7dffb7ca25e9@intel.com>
Date: Tue, 14 May 2024 09:16:20 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Change lingshan's email to kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, lingshan.zhu@kernel.org,
 virtualization@lists.linux.dev
References: <20240513212750.10158-1-lingshan.zhu@intel.com>
 <20240513093842-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20240513093842-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/2024 9:39 PM, Michael S. Tsirkin wrote:
> On Tue, May 14, 2024 at 05:27:50AM +0800, Zhu Lingshan wrote:
>> This commit changes lingshan's email from intel.com
>> to kernel.org.
>>
>> This commit also changes the title since ifcvf drives
>> standard virtio pci devices now.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>>   MAINTAINERS | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d75527f7bb0d..b69239cf30a3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10465,8 +10465,8 @@ F:	include/net/nl802154.h
>>   F:	net/ieee802154/
>>   F:	net/mac802154/
>>   
>> -Intel VIRTIO DATA PATH ACCELERATOR
>> -M:	Zhu Lingshan <lingshan.zhu@intel.com>
>> +Intel AND STANDARD VIRTIO DATA PATH ACCELERATOR
>> +M:	Zhu Lingshan <lingshan.zhu@kernel.org>
> Confused. Isn't it still for intel devices?
It still drives Intel devices, however only bar4 is intel specific, all 
other
implementations are standard virtio pci.
>
> We have drivers for standard virtio devices already.
yes we have vp_vdpa, but I think no harmful let ifcvf drive also
work for standard virtio pci devices.
>
>
>>   L:	virtualization@lists.linux.dev
>>   S:	Supported
>>   F:	drivers/vdpa/ifcvf/
>> -- 
>> 2.43.0

