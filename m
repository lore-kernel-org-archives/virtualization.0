Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75333CD54A8
	for <virtualization@archiver.kernel.org>; Tue, 19 Sep 2023 08:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F051782B21;
	Tue, 19 Sep 2023 08:28:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F051782B21
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QJvTEgztmGNU; Tue, 19 Sep 2023 08:28:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2D2C7822DA;
	Tue, 19 Sep 2023 08:28:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D2C7822DA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0DDFC0071;
	Tue, 19 Sep 2023 08:28:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19429C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 08:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB0FE61590
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 08:28:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB0FE61590
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lEFyh3L4I_tO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 08:28:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id C6F98614D3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 08:28:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6F98614D3
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BE031FB;
 Tue, 19 Sep 2023 01:28:52 -0700 (PDT)
Received: from [10.57.94.129] (unknown [10.57.94.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9CDE3F59C;
 Tue, 19 Sep 2023 01:28:13 -0700 (PDT)
Message-ID: <1d513178-bab9-0522-87f5-1a058bb8121d@arm.com>
Date: Tue, 19 Sep 2023 09:28:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Content-Language: en-GB
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230919081519.GA3860249@myrica>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, Will Deacon <will@kernel.org>
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

On 2023-09-19 09:15, Jean-Philippe Brucker wrote:
> On Mon, Sep 18, 2023 at 05:37:47PM +0100, Robin Murphy wrote:
>>> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
>>> index 17dcd826f5c2..3649586f0e5c 100644
>>> --- a/drivers/iommu/virtio-iommu.c
>>> +++ b/drivers/iommu/virtio-iommu.c
>>> @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
>>>    	int ret;
>>>    	unsigned long flags;
>>> +	/*
>>> +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
>>> +	 * is initialized e.g. via iommu_create_device_direct_mappings()
>>> +	 */
>>> +	if (!viommu)
>>> +		return 0;
>>
>> Minor nit: I'd be inclined to make that check explicitly in the places where
>> it definitely is expected, rather than allowing *any* sync to silently do
>> nothing if called incorrectly. Plus then they could use
>> vdomain->nr_endpoints for consistency with the equivalent checks elsewhere
>> (it did take me a moment to figure out how we could get to .iotlb_sync_map
>> with a NULL viommu without viommu_map_pages() blowing up first...)
> 
> They're not strictly equivalent: this check works around a temporary issue
> with the IOMMU core, which calls map/unmap before the domain is finalized.
> Once we merge domain_alloc() and finalize(), then this check disappears,
> but we still need to test nr_endpoints in map/unmap to handle detached
> domains (and we still need to fix the synchronization of nr_endpoints
> against attach/detach). That's why I preferred doing this on viommu and
> keeping it in one place.

Fair enough - it just seems to me that in both cases it's a detached 
domain, so its previous history of whether it's ever been otherwise or 
not shouldn't matter. Even once viommu is initialised, does it really 
make sense to send sync commands for a mapping on a detached domain 
where we haven't actually sent any map/unmap commands?

Thanks,
Robin.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
