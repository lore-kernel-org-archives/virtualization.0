Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F34C4708F
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 02:03:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A7E613BA
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 02:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A7E613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B5A14404DA;
	Thu,  3 Jun 2021 02:03:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id He1KKK2Kh9Tg; Thu,  3 Jun 2021 02:03:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 16313400C1;
	Thu,  3 Jun 2021 02:03:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC78FC000E;
	Thu,  3 Jun 2021 02:03:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2077C0001;
 Thu,  3 Jun 2021 02:03:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA21483D2A;
 Thu,  3 Jun 2021 02:03:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i8F61nXwAxQq; Thu,  3 Jun 2021 02:03:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E234083D24;
 Thu,  3 Jun 2021 02:03:50 +0000 (UTC)
IronPort-SDR: Wm5gJDMsWCw50md3kDIKO7vJAylZTTvwBp6e8Lz26pfz5YeQxiYd9RcbOPEryJaxNOvlwcK15o
 l23h1JeBoKGw==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="191292477"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="191292477"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 19:03:49 -0700
IronPort-SDR: 3l4OYGXTPqbxSxOvUGo09jcOcihVNH59aPcFpeSbajzoXQVVvKgjW1rvBE9b2XrPPmhaLf+Wnv
 PHYqc7c/f80A==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="550521295"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.87.193])
 ([10.209.87.193])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 19:03:48 -0700
Subject: Re: [PATCH v1 5/8] dma: Use size for swiotlb boundary checks
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-6-ak@linux.intel.com>
 <YLg096ycQ60lcuHe@localhost.localdomain>
From: Andi Kleen <ak@linux.intel.com>
Message-ID: <665925d2-d6d5-218f-15f8-c6c5abaaba40@linux.intel.com>
Date: Wed, 2 Jun 2021 19:03:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLg096ycQ60lcuHe@localhost.localdomain>
Content-Language: en-US
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, mst@redhat.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, jpoimboe@redhat.com, robin.murphy@arm.com,
 hch@lst.de, m.szyprowski@samsung.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


On 6/2/2021 6:48 PM, Konrad Rzeszutek Wilk wrote:
> On Wed, Jun 02, 2021 at 05:41:30PM -0700, Andi Kleen wrote:
>> swiotlb currently only uses the start address of a DMA to check if something
>> is in the swiotlb or not. But with virtio and untrusted hosts the host
>> could give some DMA mapping that crosses the swiotlb boundaries,
>> potentially leaking or corrupting data. Add size checks to all the swiotlb
>> checks and reject any DMAs that cross the swiotlb buffer boundaries.
> I seem to be only CC-ed on this and #7, so please bear with me.
You weren't cc'ed originally so if you get partial emails it must be 
through some list.
>
> But could you explain to me why please:
>
> commit daf9514fd5eb098d7d6f3a1247cb8cc48fc94155 (swiotlb/stable/for-linus-5.12)
> Author: Martin Radev <martin.b.radev@gmail.com>
> Date:   Tue Jan 12 16:07:29 2021 +0100
>
>      swiotlb: Validate bounce size in the sync/unmap path
>
> does not solve the problem as well?

Thanks. I missed that patch, race condition.

One major difference of my patch is that it supports an error return, 
which allows virtio to error out. This is important in virtio because 
otherwise you'll end up with uninitialized memory on the target without 
any indication. This uninitialized memory could be an potential attack 
vector on the guest memory, e.g. if the attacker finds some way to echo 
it out again.

But the error return could be added to your infrastructure too and what 
would make this patch much shorter. I'll take a look at that.

-Andi





_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
