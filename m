Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE47DC83F3F
	for <virtualization@archiver.kernel.org>; Mon,  4 Sep 2023 16:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 26A3E40C96;
	Mon,  4 Sep 2023 16:34:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 26A3E40C96
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Fn4rKE9u0tV; Mon,  4 Sep 2023 16:34:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 77DF540C5A;
	Mon,  4 Sep 2023 16:34:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 77DF540C5A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E364C0071;
	Mon,  4 Sep 2023 16:34:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A955C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 16:33:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8B134087E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 16:33:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8B134087E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P_2V29yNTWMt
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 16:33:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 880ED40875
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 16:33:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 880ED40875
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CA53143D;
 Mon,  4 Sep 2023 09:34:34 -0700 (PDT)
Received: from [10.57.5.181] (unknown [10.57.5.181])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EF223F766;
 Mon,  4 Sep 2023 09:33:55 -0700 (PDT)
Message-ID: <f1259993-2419-9c9e-30d3-0631ef938679@arm.com>
Date: Mon, 4 Sep 2023 17:33:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] iommu/virtio: Add ops->flush_iotlb_all and enable
 deferred flush
Content-Language: en-GB
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>
References: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
 <20230825-viommu-sync-map-v1-2-56bdcfaa29ec@linux.ibm.com>
 <20230904153403.GB815284@myrica>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230904153403.GB815284@myrica>
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org
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

On 2023-09-04 16:34, Jean-Philippe Brucker wrote:
> On Fri, Aug 25, 2023 at 05:21:26PM +0200, Niklas Schnelle wrote:
>> Add ops->flush_iotlb_all operation to enable virtio-iommu for the
>> dma-iommu deferred flush scheme. This results inn a significant increase
> 
> in
> 
>> in performance in exchange for a window in which devices can still
>> access previously IOMMU mapped memory. To get back to the prior behavior
>> iommu.strict=1 may be set on the kernel command line.
> 
> Maybe add that it depends on CONFIG_IOMMU_DEFAULT_DMA_{LAZY,STRICT} as
> well, because I've seen kernel configs that enable either.

Indeed, I'd be inclined phrase it in terms of the driver now actually 
being able to honour lazy mode when requested (which happens to be the 
default on x86), rather than as if it might be some 
potentially-unexpected change in behaviour.

Thanks,
Robin.

>> Link: https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> ---
>>   drivers/iommu/virtio-iommu.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
>> index fb73dec5b953..1b7526494490 100644
>> --- a/drivers/iommu/virtio-iommu.c
>> +++ b/drivers/iommu/virtio-iommu.c
>> @@ -924,6 +924,15 @@ static int viommu_iotlb_sync_map(struct iommu_domain *domain,
>>   	return viommu_sync_req(vdomain->viommu);
>>   }
>>   
>> +static void viommu_flush_iotlb_all(struct iommu_domain *domain)
>> +{
>> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
>> +
>> +	if (!vdomain->nr_endpoints)
>> +		return;
> 
> As for patch 1, a NULL check in viommu_sync_req() would allow dropping
> this one
> 
> Thanks,
> Jean
> 
>> +	viommu_sync_req(vdomain->viommu);
>> +}
>> +
>>   static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>>   {
>>   	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
>> @@ -1049,6 +1058,8 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
>>   	switch (cap) {
>>   	case IOMMU_CAP_CACHE_COHERENCY:
>>   		return true;
>> +	case IOMMU_CAP_DEFERRED_FLUSH:
>> +		return true;
>>   	default:
>>   		return false;
>>   	}
>> @@ -1069,6 +1080,7 @@ static struct iommu_ops viommu_ops = {
>>   		.map_pages		= viommu_map_pages,
>>   		.unmap_pages		= viommu_unmap_pages,
>>   		.iova_to_phys		= viommu_iova_to_phys,
>> +		.flush_iotlb_all	= viommu_flush_iotlb_all,
>>   		.iotlb_sync		= viommu_iotlb_sync,
>>   		.iotlb_sync_map		= viommu_iotlb_sync_map,
>>   		.free			= viommu_domain_free,
>>
>> -- 
>> 2.39.2
>>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
