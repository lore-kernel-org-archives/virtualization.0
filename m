Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB626158C
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Nov 2025 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762839080; cv=none; b=qPWZT5yMnUMIXoQ4ZY/2N52/D2XsVk7XEVQ5vugfJ917TpVsK87Ag8btRLIx01U6jP1L/3DoQBOsLID5KQMaz5LpsutseOPlQrfcSHtNKdl7+4uO/mOgpAjD1JgYs0AHr/0mjwUiCxaBYbQHGCYkzcbwXxCGEiolNIubeLM4OKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762839080; c=relaxed/simple;
	bh=qmB23KBZam3+BYAe/TpOP+kDi8RzRSN2DKhHCUO1HcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBJjuznbLNmmA4Gq5FZ6Av5mXUIh+68EctifPTC7ayiExT3OdxQL9mlPkzNS+852QX6WKsDvpQgbKkolcGQMRE5vg8FhFYuZiegfX8Yb/RtzecLUTWhQr44b78tIrqCVpXpkMSJQg+WyECpRXx30xuKKXoSrj5as1nlY4J0lZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HiY5fwDx; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HiY5fwDx"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B0A460B3B
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Nov 2025 05:31:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y9mE3j9t14qD for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Nov 2025 05:31:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=wangyang.guo@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 19D0D60B36
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19D0D60B36
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HiY5fwDx
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 19D0D60B36
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Nov 2025 05:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762839079; x=1794375079;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qmB23KBZam3+BYAe/TpOP+kDi8RzRSN2DKhHCUO1HcE=;
  b=HiY5fwDxPSd4PmNLSymFJ08ld3yIea0a2dEJDfaOxgRvBE4vu1X/k/jo
   mdYnrYvdCfNJgnXvdqkHMqxkeVOtJ1TtgwXSpiyBWN2mNEKNCob85Fnp8
   qVmLa/uQGaYZpQtLSRemJp33+4rSPYQWOk9EvY8HOJm+2CWJ+boq1N6+V
   RA0gK7NYXxLtBJhWnUam/SP4xrM/2xMRqDlZ60kxkGjqg8sVyziw5I7cP
   ATB0zFQitxK1kRTbir2rn/goMicUs+lFmjZsED5ajpba9PBTvEzXiB2ZJ
   JK2AAtXeHB202oUTUW6uvkTGxyeUK/vbRsVV0lpGgpnica8mQdaZDjguP
   A==;
X-CSE-ConnectionGUID: Svt+HM30RGOHGRWSFuTtTg==
X-CSE-MsgGUID: HFiypyO2Tj+I/uHv/RRrUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="76000631"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="76000631"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 21:31:17 -0800
X-CSE-ConnectionGUID: GpuEIhUYSumZNIgV9aF2cQ==
X-CSE-MsgGUID: W+UFF+FATv+zwiSXibzg0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="193870829"
Received: from unknown (HELO [10.238.2.7]) ([10.238.2.7])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 21:31:14 -0800
Message-ID: <b94a0d74-0770-4751-9064-2ef077fada14@intel.com>
Date: Tue, 11 Nov 2025 13:31:04 +0800
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
 <aRKssW96lHFrT2ZN@fedora>
Content-Language: en-US
From: "Guo, Wangyang" <wangyang.guo@intel.com>
In-Reply-To: <aRKssW96lHFrT2ZN@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/2025 11:25 AM, Ming Lei wrote:
> On Tue, Nov 11, 2025 at 10:06:08AM +0800, Wangyang Guo wrote:
>> As CPU core counts increase, the number of NVMe IRQs may be smaller than
>> the total number of CPUs. This forces multiple CPUs to share the same
>> IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
>> performance penalty can be observed on some platforms.
> 
> Can you add details why/how CPU cluster isn't aligned with IRQ
> affinity? And how performance penalty is caused?

Intel Xeon E platform packs 4 CPU cores as 1 module (cluster) and share 
the L2 cache. Let's say, if there are 40 CPUs in 1 NUMA domain and 11 
IRQs to dispatch. The existing algorithm will map first 7 IRQs each with 
4 CPUs and remained 4 IRQs each with 3 CPUs each. The last 4 IRQs may 
have cross cluster issue. For example, the 9th IRQ which pinned to 
CPU32, then for CPU31, it will have cross L2 memory access.

CPU |28 29 30 31|32 33 34 35|36 ...
      -------- -------- --------
IRQ      8        9       10

If this patch applied, then first 2 IRQs each mapped with 2 CPUs and 
rest 9 IRQs each mapped with 4 CPUs, which avoids the cross cluster 
memory access.

CPU |00 01 02 03|04 05 06 07|08 09 10 11| ...
      ----- ----- ----------- -----------
IRQ  1      2        3           4


BR
Wangyang
