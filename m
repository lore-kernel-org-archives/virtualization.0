Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E0E548F9
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841922; cv=none; b=SVNtho+pnBZdHF3GOn27c+Y3O0SOTfRJN0Z7PWDFFYnNfOTOoV2z2TL2zZTo1PIOIFi3INS9GDgyM59QxaSf4cNy9IV8zgwdQDg1+aPfD6Cc5pVeS940/Rb+U48eyk29clTXPUvpSioAeoewp3TfoEbBminBN1IYwZDDpVCQAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841922; c=relaxed/simple;
	bh=piytSOK3Xc/vNcme9MWSfC+2n9FoBe8ooKi8TE9QfUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZz9qNXL+moJ77W4bGgT+CV0wPaGM8Rkh0MSQ8vYrnXrh2sj1kKutpN+a0zjH1JKktK6itJu807O107d1vhgYtK6yBrIDRJDXCldvTqThabZe8fNOwFf1mnM0HSDmVLZhve8e1/JhwlFJwefToXYu7w7z34Zm+oP6HYcJ7k61OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZc5WcL7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZc5WcL7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710841921; x=1742377921;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=piytSOK3Xc/vNcme9MWSfC+2n9FoBe8ooKi8TE9QfUM=;
  b=WZc5WcL70WnRn6b8RACOZJmtZBc6KI46lICyGEN8e/1ZdXkGIt2knMf8
   +4M27OsADBEciHZFhi7q2CuMXbPYjtOZ98wbY0OchLNENbnJcDcgKrWpp
   Gjb7tUSxBfTPpNYe3oZGC+Duh55anyQrVN4+A6akVCA3YJI/xhTjTCrNT
   P+ub9hv8nhMw4ji+Ti1+a7Eo99NHgZWtG1Gxb/vy6p66ZBmckImtoZZ2V
   2eyERVev7o6cGPKjp+zWvqa59KvWvnvd0Yf8uPUdpoLjZY1Dx2jQeCld6
   Yl3Cq3tL+rXH9rof+KrLxfgcVSHu9p+51wCMOKMnNY6GcySsKnoJG6wg3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="9465426"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="9465426"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 02:51:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18425415"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.124.224.9]) ([10.124.224.9])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 02:51:56 -0700
Message-ID: <ed8fdc47-2a11-4c29-bfe2-865b38630988@intel.com>
Date: Tue, 19 Mar 2024 17:51:53 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: apply maintainer role of Intel vDPA driver
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev
References: <20240227144519.555554-1-lingshan.zhu@intel.com>
 <CACGkMEsBaC8HDsfbOWG9ix9Ho3ZVYkSPHaW26PiucJfOwXpYDg@mail.gmail.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEsBaC8HDsfbOWG9ix9Ho3ZVYkSPHaW26PiucJfOwXpYDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michael,

Gentle ping

Thanks
Zhu Lingshan

On 3/7/2024 1:34 PM, Jason Wang wrote:
> On Tue, Feb 27, 2024 at 2:45 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>> This commit applies maintainer role of Intel vDPA
>> driver for myself.
>>
>> I am the author of this driver and have been contributing to
>> it for long time, I would like to help this solution evolve
>> in future.
>>
>> This driver is still under virito maintenance.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
>> ---
>>   MAINTAINERS | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2ecaaec6a6bf..128ec843eb19 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10365,8 +10365,10 @@ F:     include/net/nl802154.h
>>   F:     net/ieee802154/
>>   F:     net/mac802154/
>>
>> -IFCVF VIRTIO DATA PATH ACCELERATOR
>> -R:     Zhu Lingshan <lingshan.zhu@intel.com>
>> +Intel VIRTIO DATA PATH ACCELERATOR
>> +M:     Zhu Lingshan <lingshan.zhu@intel.com>
>> +L:     virtualization@lists.linux.dev
>> +S:     Supported
>>   F:     drivers/vdpa/ifcvf/
>>
>>   IFE PROTOCOL
>> --
>> 2.39.3
>>
>

