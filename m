Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C37F3B9608
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005795; cv=none; b=qDFh9UDJ8Rq0DcrOKdKgVwKe2VAA5nqTbBH3YaiN+dwsXvc6QNAT/SDbUBac1ybNpgNQg9sK4aSCZ2YTo4BA2kwg4K6oDnMTpUUKj18lnmMGNbCOLUkMapIgIvPpc1ZABz7p80yx0Yni8cHjPJeBgY0NQJVOV2kvfqFNFu4djqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005795; c=relaxed/simple;
	bh=KagpBM1xhCXcwRRQAyfDGwB0x0YrZNc/aSqT1LfkuFk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZOeQs2haCQdwdoHs4oz0cMNjl7GKgVO1HtXEgvFjLlq8tcPjaYAArVsWED4qcaAszTnSSXqmjSlUgo/26PwFRmbRHuTXLhRYRerYbxXTxODoJGFEWo2or6pDyAYeB4s3l3GGnzZwpACklDV/vqsojgMQIoF0t3oBwVOJV1YBwrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QWEbSFYE; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QWEbSFYE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769005782; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=k5BQxu6CMUOTbyhVOtJ/lDBq0GrbMvlHNo3WQj6zhqc=;
	b=QWEbSFYEhuYjNj7cXsJsGwzmnssAqoFE8brJDPWupf9CKihy298XCqpcr34KyF72CJ63mke7hfHxHJfHK3X22ksDhTACxKsF4LqHkVANia1LT/RzGO/ayAkS4PrE6T+3cWaUQcD2VYf3PIXczOpp6hpUNLga7GjhFfGZcFSz1Sg=
Received: from 30.221.145.201(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WxYU0Oi_1769005781 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 Jan 2026 22:29:42 +0800
Message-ID: <51e8d8ce-f291-4e31-a938-2c1a0e8684c2@linux.alibaba.com>
Date: Wed, 21 Jan 2026 22:29:41 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
From: Wen Gu <guwen@linux.alibaba.com>
To: Thomas Gleixner <tglx@linutronix.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Dust Li <dust.li@linux.alibaba.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David Woodhouse <dwmw2@infradead.org>, virtualization@lists.linux.dev,
 Nick Shi <nick.shi@broadcom.com>, Sven Schnelle <svens@linux.ibm.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-clk@vger.kernel.org
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
In-Reply-To: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/9 10:56, Wen Gu wrote:
> 
> #
> ## Proposal
> #
> 
> 1. Reorganize drivers/ptp/ to make the interface/implementation split
>     explicit,
> 
>     * drivers/ptp/core      : PTP core infrastructure and API.
>                               (e.g. ptp_chardev.c, ptp_clock.c,
>                                ptp_sysfs.c, etc.)
> 
>     * drivers/ptp/pure      : Non-network ("pure clock") implementation,
>                               they are typically platform/architecture/
>                               virtualization-provided time sources.
>                               (e.g. ptp_kvm, ptp_vmw, ptp_vmclock,
>                                ptp_s390, etc.)
> 
>     * drivers/ptp/*         : Network timestamping oriented implementation,
>                               they primarily used together with IEEE1588
>                               over the network.
>                               (e.g. ptp_qoriq, ptp_pch, ptp_dp83640,
>                                ptp_idt82p33 etc.)
> 

Thanks for the feedback so far. It seems we are close to consensus on
the directory split, as [1] summarized:

- drivers/ptp/core       : PTP core infrastructure and API
- drivers/ptp/1588       : network/IEEE 1588 oriented PTP clocks
- drivers/ptp/emulating  : platform/hardware/hypervisor-provided pure clocks

For how the existing drivers in `drivers/ptp` are categorized into the
directories above, please also refer to [1] and the follow-up replies.

> 2. Transition drivers/ptp/pure from netdev maintainership to
>     clock/time maintainership (with an appropriate MAINTAINERS entry,
>     e.g. PURE TIME PHC), since these PHC implementations are primarily
>     clock devices and not network-oriented. New similar drivers can be
>     added under drivers/ptp/pure as well.


Then the open item now is maintainership and the merge path.

Based on previous guidance[2] and the current MAINTAINERS structure,
it seems reasonable to have it maintained under the clock/timekeeping
domain (following the existing timekeeping pull chain), with a
dedicated MAINTAINERS entry.


Hi Thomas and clock/timekeeping maintainers,

Would you agree with this approach? If so, could you please advise on
the appropriate maintainer/reviewer for this MAINTAINERS entry?

Below is a strawman MAINTAINERS entry (happy to adjust):

EMULATING PTP CLOCK SUPPORT
L:     linux-kernel@vger.kernel.org
S:     Maintained
F:     drivers/ptp/emulating/*


We (Alibaba) are also willing to be the maintainer for this entry as
a fallback.

[1] https://lore.kernel.org/netdev/b5a60753-85ed-4d61-a652-568393e0dff3@linux.alibaba.com/
[2] https://lore.kernel.org/netdev/20251216135848.174e010f@kernel.org/

Regards.
