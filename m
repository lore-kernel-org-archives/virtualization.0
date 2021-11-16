Return-Path: <SRS0=Mct1=QD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89E4C43217
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 14:26:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8160963212
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 14:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8160963212
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D03140497;
	Tue, 16 Nov 2021 14:26:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 31tn7usUaJMS; Tue, 16 Nov 2021 14:26:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0420340499;
	Tue, 16 Nov 2021 14:26:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91DB6C0033;
	Tue, 16 Nov 2021 14:26:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEB3DC0012;
 Tue, 16 Nov 2021 14:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E92040412;
 Tue, 16 Nov 2021 14:25:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IirDvKBREoe2; Tue, 16 Nov 2021 14:25:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47407401B2;
 Tue, 16 Nov 2021 14:25:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88B4A6D;
 Tue, 16 Nov 2021 06:25:57 -0800 (PST)
Received: from [10.57.82.45] (unknown [10.57.82.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA8BF3F766;
 Tue, 16 Nov 2021 06:25:55 -0800 (PST)
Message-ID: <cf539ded-5c9b-38b9-ad8f-a2ea4b28ec37@arm.com>
Date: Tue, 16 Nov 2021 14:25:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/5] iommu: Some IOVA code reorganisation
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <20211004114418.GC27373@willie-the-truck>
 <cdb502c5-4896-385b-8872-f4f20e9c7e34@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <cdb502c5-4896-385b-8872-f4f20e9c7e34@huawei.com>
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

On 2021-11-16 14:21, John Garry wrote:
> On 04/10/2021 12:44, Will Deacon wrote:
>> On Fri, Sep 24, 2021 at 06:01:52PM +0800, John Garry wrote:
>>> The IOVA domain structure is a bit overloaded, holding:
>>> - IOVA tree management
>>> - FQ control
>>> - IOVA rcache memories
>>>
>>> Indeed only a couple of IOVA users use the rcache, and only dma-iommu.c
>>> uses the FQ feature.
>>>
>>> This series separates out that structure. In addition, it moves the FQ
>>> code into dma-iommu.c . This is not strictly necessary, but it does make
>>> it easier for the FQ domain lookup the rcache domain.
>>>
>>> The rcache code stays where it is, as it may be reworked in future, so
>>> there is not much point in relocating and then discarding.
>>>
>>> This topic was initially discussed and suggested (I think) by Robin 
>>> here:
>>> https://lore.kernel.org/linux-iommu/1d06eda1-9961-d023-f5e7-fe87e768f067@arm.com/ 
>>>
>> It would be useful to have Robin's Ack on patches 2-4. The implementation
>> looks straightforward to me, but the thread above isn't very clear about
>> what is being suggested.
> 
> Hi Robin,
> 
> Just wondering if you had made any progress on your FQ code rework or 
> your own re-org?

Hey John - as it happens I started hacking on that in earnest about half 
an hour ago, aiming to get something out later this week.

Cheers,
Robin.

> I wasn't planning on progressing 
> https://lore.kernel.org/linux-iommu/1626259003-201303-1-git-send-email-john.garry@huawei.com/ 
> until this is done first (and that is still a big issue), even though 
> not strictly necessary.
> 
> Thanks,
> John
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
