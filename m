Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F0A27AC45
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765162064; cv=none; b=Ly9Y8r8EJxd4SMNTSfD33RyLmb4IgWbUikZasYN5NzKPhkaFk3oVD61r8Cz7hnK1VlZzRLbfc7q0RXPymSdVNv/+ghP663WhJo85hF+92H418bUASjSAScxb+4roIiPFKYyKVHoLkESEY1MzvoImxMI/KZlPZ0WpDXGXu1zn4l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765162064; c=relaxed/simple;
	bh=6TwHcb5iUovQX1XFCXHnFY38ZruK56VM+5PnT7qnu20=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L5HxhCjsQMLToOdi7I4ExmRRYuZLfTEbJnjrZ24lQ64qcMZ7+1RisRGPYUi3O5M1RgJtNBoNKOwxH9QNynvYTMm+vB0ZdNvAYGl07BLT95cbIaF5/O1tqLpvA+ytwd04Np1Z8zJIH2jQe4I1rbX95jqkokT+0c2AEeujAFnmud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlxYSQnw; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlxYSQnw"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E69360D98
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 02:47:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UaxC5FJRHYVw for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Dec 2025 02:47:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=wangyang.guo@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0F87560D80
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F87560D80
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jlxYSQnw
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0F87560D80
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 02:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765162061; x=1796698061;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=6TwHcb5iUovQX1XFCXHnFY38ZruK56VM+5PnT7qnu20=;
  b=jlxYSQnwk5nAkZxzetA7E9U9SlwhBs1zkIZLkGEfUDJSnJagDeEvmvGr
   kCuz18Dc8w77ZQmJhhSDHXDkbM8RuFXwv70f3jLm5MvliHyAkRSPP9elr
   x/ik2oTqQBcC/Ffe+WnoB5rDnV7Oj1T+HxDS7o5xoYHIvu2vh2ipQzker
   OQsI3dLoHvFgaO+85E/uwLk30nquYB+GYCOxLZFvXUdhlZQTuCvDjNVdt
   Vb6cNsP7nXDfoIWYPyRiDXBiSOSeCUml+PHtubG/8thItnJSgeV151veY
   tUz660l01qNOqdQaRpdow42f6iKVaH19OgwWldSrN+GYmykSmEWgqy/Yy
   Q==;
X-CSE-ConnectionGUID: Pf/+vhNAQRGab4GyyPWWfA==
X-CSE-MsgGUID: /4Q9jhgCS4a77Rd9Y2TJQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="70957763"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="70957763"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 18:47:40 -0800
X-CSE-ConnectionGUID: uJPi9MaPTbeYe7fO5XbNjw==
X-CSE-MsgGUID: aPr5tsLvTxWcHxRb5YKL8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="195848648"
Received: from unknown (HELO [10.238.3.27]) ([10.238.3.27])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 18:47:36 -0800
Message-ID: <585538f9-10b8-4da9-8566-179fa789f4ab@intel.com>
Date: Mon, 8 Dec 2025 10:47:26 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] lib/group_cpus: make group CPU cluster aware
From: "Guo, Wangyang" <wangyang.guo@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Tianyou Li <tianyou.li@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, Dan Liang <dan.liang@intel.com>
References: <20251111020608.1501543-1-wangyang.guo@intel.com>
 <aRKssW96lHFrT2ZN@fedora> <b94a0d74-0770-4751-9064-2ef077fada14@intel.com>
 <aRMnR5DRdsU8lGtU@fedora> <a101fe80-ca0b-4b4b-94b1-f08db1b164fc@intel.com>
 <aRU2sC5q5hCmS_eM@fedora> <da1d6b4e-038c-48dc-830d-5eadb3ac943f@intel.com>
 <aR0i2f91VGv47swo@fedora> <7ec85f26-25fa-4c77-9e46-347261723d95@intel.com>
Content-Language: en-US
In-Reply-To: <7ec85f26-25fa-4c77-9e46-347261723d95@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/24/2025 3:58 PM, Guo, Wangyang wrote:
> On 11/19/2025 9:52 AM, Ming Lei wrote:
>> On Tue, Nov 18, 2025 at 02:29:20PM +0800, Guo, Wangyang wrote:
>>> On 11/13/2025 9:38 AM, Ming Lei wrote:
>>>> On Wed, Nov 12, 2025 at 11:02:47AM +0800, Guo, Wangyang wrote:
>>>>> On 11/11/2025 8:08 PM, Ming Lei wrote:
>>>>>> On Tue, Nov 11, 2025 at 01:31:04PM +0800, Guo, Wangyang wrote:
>>>>>> They still should share same L3 cache, and cpus_share_cache() 
>>>>>> should be
>>>>>> true when the IO completes on the CPU which belong to different L2 
>>>>>> with the
>>>>>> submission CPU, and remote completion via IPI won't be triggered.
>>>>> Yes, remote IPI not triggered.
>>>>
>>>> OK, in my test on AMD zen4, NVMe performance can be dropped to 1/2 - 
>>>> 1/3 if
>>>> remote IPI is triggered in case of crossing L3, which is 
>>>> understandable.
>>>>
>>>> I will check if topo cluster can cover L3, if yes, the patch still 
>>>> can be
>>>> simplified a lot by introducing sub-node spread by changing 
>>>> build_node_to_cpumask()
>>>> and adding nr_sub_nodes.
>>>
>>> Do you mean using cluster as "NUMA" nodes to spread CPU, instead of two
>>> level NUMA-cluster spreading?
>>
>> Yes, I think the change may be minimized by introducing sub-numa-node for
>> covering it, what do you think of this approach?
>>
>> However, it is bad to use cluster as sub-numa-node at default, because 
>> cluster
>> is aligned with CPUs sharing L2 cache, so there could be too many 
>> clusters
>> for many systems in which one cluster just includes two CPUs, then the 
>> finally
>> calculated mapping crosses clusters inevitably because nr_queues is
>> less than nr_clusters.
>>
>> I'd suggest to map CPUs sharing L3 cache into one sub-numa-node.
>>
>> For your case, either adding one kernel parameter, or adding 
>> group_cpus_cluster()
>> API for the unusual case by sharing single code path.
> 
> Yes, it will make the change simpler, but no matter using cluster or L3 
> cache as sub-numa-node, as CPU core count increase, there is potential 
> risk that nr_queues < nr_sub_numa_node, which will make CPU spreading no 
> affinity at all.
> 
> I think we need to keep two level NUMA/sub-NUMA spreading to avoid such 
> regression.
> 
> For most platforms, there is no need for 2nd level spreading since L2 is 
> not shared between physical cores and L3 mapping is the same as NUMA. I 
> think we can add a platform specified configuration: by default, only 
> NUMA spreading is used; if platform like Intel Xeon E or some AMD 
> platform need second level spreading, we can config it to use L3 or 
> cluster as sub-numa-node for 2nd level spreading.
> 
> How does that sound to you?

Hi Ming,

Hope you're doing well.

Just wanted to kindly follow up on my previous email. Please let me know 
if you have any further feedback/guidance on the proposed changes or if 
there’s anything I can do to help move this forward.

Thanks for your time and guidance!

BR
Wangyang

