Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F54199949
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Nov 2025 03:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762917004; cv=none; b=iGbRV/twqwSuoEJUYI9tyEXcn25izklGQLd3vN7lbUP0Mq07U/fAUJ4FFnWixnfmLo0OyVE8uvwOVimiuodgGTorzDIBnorKVjY+lIYL/JJ75sKQfmGss8aTX490FXzHXhf6BtJH/Ihqc2zzTHAEV389NFqV0O3HdZfvmmlgZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762917004; c=relaxed/simple;
	bh=0CzASL4FQtni4BE+5yAo9I0TqTLhNXvwqY61AaPkOZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzkqTXoFQnLJZWftXqFtypZ8w+hlV9NrKzNxIdX/72tb5iTThHxZwR3K6JscVV4UpdDFQW3drgNdelJZThTUDJXhQZZB+NaCVLYkvb+FEY30ObHBC6BSkhX+UcweO0ceZCc9VsCrincNjaRu2nMplIUMn4sKRAsFiHi37j2D++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJIrIgNE; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJIrIgNE"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94AE080C27
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Nov 2025 03:10:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yqz1V-q8SmKv for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Nov 2025 03:10:01 +0000 (UTC)
X-Greylist: delayed 427 seconds by postgrey-1.37 at util1.osuosl.org; Wed, 12 Nov 2025 03:10:00 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D4DD180BED
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4DD180BED
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BJIrIgNE
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=wangyang.guo@intel.com; receiver=<UNKNOWN> 
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D4DD180BED
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Nov 2025 03:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762917000; x=1794453000;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0CzASL4FQtni4BE+5yAo9I0TqTLhNXvwqY61AaPkOZs=;
  b=BJIrIgNE+5hDac7xEhLqO/dx0GM4QAns+d9ApV7XPyk42uPyjCzX+5Tm
   dbfdgI2t1EFHksw4zmj3yg4Hm2PPoWFFSHyrPgo6mn5zFLxM7lsqbFbyb
   HSDgvtK5LtvZOTpOZxC3vUYDyXMBJA2/Jb3RTy6OtDg0GTXfN5VVMIEUC
   T/D20BQGaLvjYLFZ1vodHnoGYen9c/D6DIUI2ELp+Inoo82okmgjzsySB
   801mFY0omYVbcJp4bARA4rICSTE40o7y/nG/ZAjm8xI/rhpgZbBGG/ibW
   kwlpe3wR7C7kifMFlkPqQg4y5Wql1kNL7xVhpGLZXH4sljhNyJqYHzYJ1
   A==;
X-CSE-ConnectionGUID: pnNQgyLdTFmw0NijdKQ9Tg==
X-CSE-MsgGUID: BUgLhiekTQiBuZhu1kCzjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="63981340"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="63981340"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 19:02:53 -0800
X-CSE-ConnectionGUID: vPPwIXwoShCC59bAM+JeaQ==
X-CSE-MsgGUID: mJrBIcSfTDGkGIwwzBS3AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="189531161"
Received: from unknown (HELO [10.238.2.7]) ([10.238.2.7])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 19:02:49 -0800
Message-ID: <a101fe80-ca0b-4b4b-94b1-f08db1b164fc@intel.com>
Date: Wed, 12 Nov 2025 11:02:47 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] lib/group_cpus: make group CPU cluster aware
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
 <aRMnR5DRdsU8lGtU@fedora>
Content-Language: en-US
From: "Guo, Wangyang" <wangyang.guo@intel.com>
In-Reply-To: <aRMnR5DRdsU8lGtU@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/2025 8:08 PM, Ming Lei wrote:
> On Tue, Nov 11, 2025 at 01:31:04PM +0800, Guo, Wangyang wrote:
>> On 11/11/2025 11:25 AM, Ming Lei wrote:
>>> On Tue, Nov 11, 2025 at 10:06:08AM +0800, Wangyang Guo wrote:
>>>> As CPU core counts increase, the number of NVMe IRQs may be smaller than
>>>> the total number of CPUs. This forces multiple CPUs to share the same
>>>> IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
>>>> performance penalty can be observed on some platforms.
>>>
>>> Can you add details why/how CPU cluster isn't aligned with IRQ
>>> affinity? And how performance penalty is caused?
>>
>> Intel Xeon E platform packs 4 CPU cores as 1 module (cluster) and share the
>> L2 cache. Let's say, if there are 40 CPUs in 1 NUMA domain and 11 IRQs to
>> dispatch. The existing algorithm will map first 7 IRQs each with 4 CPUs and
>> remained 4 IRQs each with 3 CPUs each. The last 4 IRQs may have cross
>> cluster issue. For example, the 9th IRQ which pinned to CPU32, then for
>> CPU31, it will have cross L2 memory access.
> 
> 
> CPUs sharing L2 usually have small number, and it is common to see one queue
> mapping includes CPUs from different L2.
> 
> So how much does crossing L2 hurt IO perf?
We see 15%+ performance difference in FIO libaio/randread/bs=8k.

> They still should share same L3 cache, and cpus_share_cache() should be
> true when the IO completes on the CPU which belong to different L2 with the
> submission CPU, and remote completion via IPI won't be triggered.
Yes, remote IPI not triggered.


BR
Wangyang
