Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7053CCD484A
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 18:07:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E04E614E7;
	Fri, 22 Sep 2023 18:07:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E04E614E7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n5xosXUFlTbR; Fri, 22 Sep 2023 18:07:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 72AB4610DB;
	Fri, 22 Sep 2023 18:07:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72AB4610DB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B466C0071;
	Fri, 22 Sep 2023 18:07:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2399CC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 18:07:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B74B614E7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 18:07:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B74B614E7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QsMplXpnIdrA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 18:07:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7688610DB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 18:07:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7688610DB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 876C7C15;
 Fri, 22 Sep 2023 11:08:23 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50FC03F59C;
 Fri, 22 Sep 2023 11:07:45 -0700 (PDT)
Message-ID: <123c53c3-d259-9c20-9aa6-0c216d7eb3c0@arm.com>
Date: Fri, 22 Sep 2023 19:07:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica> <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica> <20230922124130.GD13795@ziepe.ca>
 <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
 <20230922162714.GH13795@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230922162714.GH13795@ziepe.ca>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>,
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

On 22/09/2023 5:27 pm, Jason Gunthorpe wrote:
> On Fri, Sep 22, 2023 at 02:13:18PM +0100, Robin Murphy wrote:
>> On 22/09/2023 1:41 pm, Jason Gunthorpe wrote:
>>> On Fri, Sep 22, 2023 at 08:57:19AM +0100, Jean-Philippe Brucker wrote:
>>>>>> They're not strictly equivalent: this check works around a temporary issue
>>>>>> with the IOMMU core, which calls map/unmap before the domain is
>>>>>> finalized.
>>>>>
>>>>> Where? The above points to iommu_create_device_direct_mappings() but
>>>>> it doesn't because the pgsize_bitmap == 0:
>>>>
>>>> __iommu_domain_alloc() sets pgsize_bitmap in this case:
>>>>
>>>>           /*
>>>>            * If not already set, assume all sizes by default; the driver
>>>>            * may override this later
>>>>            */
>>>>           if (!domain->pgsize_bitmap)
>>>>                   domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
>>>
>>> Dirver's shouldn't do that.
>>>
>>> The core code was fixed to try again with mapping reserved regions to
>>> support these kinds of drivers.
>>
>> This is still the "normal" code path, really; I think it's only AMD that
>> started initialising the domain bitmap "early" and warranted making it
>> conditional.
> 
> My main point was that iommu_create_device_direct_mappings() should
> fail for unfinalized domains, setting pgsize_bitmap to allow it to
> succeed is not a nice hack, and not necessary now.

Sure, but it's the whole "unfinalised domains" and rewriting 
domain->pgsize_bitmap after attach thing that is itself the massive 
hack. AMD doesn't do that, and doesn't need to; it knows the appropriate 
format at allocation time and can quite happily return a fully working 
domain which allows map before attach, but the old ops->pgsize_bitmap 
mechanism fundamentally doesn't work for multiple formats with different 
page sizes. The only thing I'd accuse it of doing wrong is the weird 
half-and-half thing of having one format as a default via one mechanism, 
and the other as an override through the other, rather than setting both 
explicitly.

virtio isn't setting ops->pgsize_bitmap for the sake of direct mappings 
either; it sets it once it's discovered any instance, since apparently 
it's assuming that all instances must support identical page sizes, and 
thus once it's seen one it can work "normally" per the core code's 
assumptions. It's also I think the only driver which has a "finalise" 
bodge but *can* still properly support map-before-attach, by virtue of 
having to replay mappings to every new endpoint anyway.

> What do you think about something like this to replace
> iommu_create_device_direct_mappings(), that does enforce things
> properly?

I fail to see how that would make any practical difference. Either the 
mappings can be correctly set up in a pagetable *before* the relevant 
device is attached to that pagetable, or they can't (if the driver 
doesn't have enough information to be able to do so) and we just have to 
really hope nothing blows up in the race window between attaching the 
device to an empty pagetable and having a second try at 
iommu_create_device_direct_mappings(). That's a driver-level issue and 
has nothing to do with pgsize_bitmap either way.

Thanks,
Robin.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
