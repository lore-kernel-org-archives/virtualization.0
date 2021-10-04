Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C232C433FE
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 14:49:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11745613A8
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 14:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11745613A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D2B2C40862;
	Mon,  4 Oct 2021 14:49:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rsqf1IPr57ay; Mon,  4 Oct 2021 14:48:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 43BAF402DD;
	Mon,  4 Oct 2021 14:48:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1939C0023;
	Mon,  4 Oct 2021 14:48:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5103BC000D;
 Mon,  4 Oct 2021 14:48:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 23B8A4072B;
 Mon,  4 Oct 2021 14:48:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AXr7CtnuWAqy; Mon,  4 Oct 2021 14:48:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6EFA402DD;
 Mon,  4 Oct 2021 14:48:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA8DDD6E;
 Mon,  4 Oct 2021 07:48:54 -0700 (PDT)
Received: from [10.57.22.120] (unknown [10.57.22.120])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F33813F70D;
 Mon,  4 Oct 2021 07:48:52 -0700 (PDT)
Subject: Re: [PATCH 0/5] iommu: Some IOVA code reorganisation
To: Will Deacon <will@kernel.org>, John Garry <john.garry@huawei.com>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <20211004114418.GC27373@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <87b782d7-339a-fcd0-8fae-659e2d9da078@arm.com>
Date: Mon, 4 Oct 2021 15:48:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211004114418.GC27373@willie-the-truck>
Content-Language: en-GB
Cc: mst@redhat.com, joro@8bytes.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, iommu@lists.linux-foundation.org,
 thunder.leizhen@huawei.com, baolu.lu@linux.intel.com
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

On 2021-10-04 12:44, Will Deacon wrote:
> On Fri, Sep 24, 2021 at 06:01:52PM +0800, John Garry wrote:
>> The IOVA domain structure is a bit overloaded, holding:
>> - IOVA tree management
>> - FQ control
>> - IOVA rcache memories
>>
>> Indeed only a couple of IOVA users use the rcache, and only dma-iommu.c
>> uses the FQ feature.
>>
>> This series separates out that structure. In addition, it moves the FQ
>> code into dma-iommu.c . This is not strictly necessary, but it does make
>> it easier for the FQ domain lookup the rcache domain.
>>
>> The rcache code stays where it is, as it may be reworked in future, so
>> there is not much point in relocating and then discarding.
>>
>> This topic was initially discussed and suggested (I think) by Robin here:
>> https://lore.kernel.org/linux-iommu/1d06eda1-9961-d023-f5e7-fe87e768f067@arm.com/
> 
> It would be useful to have Robin's Ack on patches 2-4. The implementation
> looks straightforward to me, but the thread above isn't very clear about
> what is being suggested.

FWIW I actually got about half-way through writing my own equivalent of 
patches 2-3, except tackling it from the other direction - simplifying 
the FQ code *before* moving whatever was left to iommu-dma, then I got 
side-tracked trying to make io-pgtable use that freelist properly, and 
then I've been on holiday the last 2 weeks. I've got other things to 
catch up on first but I'll try to get to this later this week.

> To play devil's advocate: there aren't many direct users of the iovad code:
> either they'll die out entirely (and everybody will use the dma-iommu code)
> and it's fine having the flush queue code where it is, or we'll get more
> users and the likelihood of somebody else wanting flush queues increases.

I think the FQ code is mostly just here as a historical artefact, since 
the IOVA allocator was the only thing common to the Intel and AMD DMA 
ops when the common FQ implementation was factored out of those, so 
although it's essentially orthogonal it was still related enough that it 
was an easy place to stick it.

Cheers,
Robin.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
