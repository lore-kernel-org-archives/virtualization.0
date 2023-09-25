Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35BFCE7A95
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 13:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A80781E22;
	Mon, 25 Sep 2023 13:08:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A80781E22
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D_52zVldm16r; Mon, 25 Sep 2023 13:07:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA07681C67;
	Mon, 25 Sep 2023 13:07:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA07681C67
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73C5AC0071;
	Mon, 25 Sep 2023 13:07:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E265AC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 13:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9A8341559
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 13:07:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A9A8341559
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K8_7G8ZSPOXj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 13:07:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id AABF840185
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 13:07:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AABF840185
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEE8CDA7;
 Mon, 25 Sep 2023 06:08:32 -0700 (PDT)
Received: from [10.57.0.188] (unknown [10.57.0.188])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 832CE3F5A1;
 Mon, 25 Sep 2023 06:07:53 -0700 (PDT)
Message-ID: <ade90cd5-bbf1-f4f9-0511-75e0e18d1a83@arm.com>
Date: Mon, 25 Sep 2023 14:07:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
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
 <123c53c3-d259-9c20-9aa6-0c216d7eb3c0@arm.com>
 <20230922233309.GI13795@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230922233309.GI13795@ziepe.ca>
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

On 2023-09-23 00:33, Jason Gunthorpe wrote:
> On Fri, Sep 22, 2023 at 07:07:40PM +0100, Robin Murphy wrote:
> 
>> virtio isn't setting ops->pgsize_bitmap for the sake of direct mappings
>> either; it sets it once it's discovered any instance, since apparently it's
>> assuming that all instances must support identical page sizes, and thus once
>> it's seen one it can work "normally" per the core code's assumptions. It's
>> also I think the only driver which has a "finalise" bodge but *can* still
>> properly support map-before-attach, by virtue of having to replay mappings
>> to every new endpoint anyway.
> 
> Well it can't quite do that since it doesn't know the geometry - it
> all is sort of guessing and hoping it doesn't explode on replay. If it
> knows the geometry it wouldn't need finalize...

I think it's entirely reasonable to assume that any direct mappings 
specified for a device are valid for that device and its IOMMU. However, 
in the particular case of virtio, it really shouldn't ever have direct 
mappings anyway, since even if the underlying hardware did have any, the 
host can enforce the actual direct-mapping aspect itself, and just 
present them as unusable regions to the guest.

>>> What do you think about something like this to replace
>>> iommu_create_device_direct_mappings(), that does enforce things
>>> properly?
>>
>> I fail to see how that would make any practical difference. Either the
>> mappings can be correctly set up in a pagetable *before* the relevant device
>> is attached to that pagetable, or they can't (if the driver doesn't have
>> enough information to be able to do so) and we just have to really hope
>> nothing blows up in the race window between attaching the device to an empty
>> pagetable and having a second try at iommu_create_device_direct_mappings().
>> That's a driver-level issue and has nothing to do with pgsize_bitmap either
>> way.
> 
> Except we don't detect this in the core code correctly, that is my
> point. We should detect the aperture conflict, not pgsize_bitmap to
> check if it is the first or second try.

Again, that's irrelevant. It can only be about whether the actual 
->map_pages call succeeds or not. A driver could well know up-front that 
all instances support the same pgsize_bitmap and aperture, and set both 
at ->domain_alloc time, yet still be unable to handle an actual mapping 
without knowing which instance(s) that needs to interact with (e.g. 
omap-iommu).

Thanks,
Robin.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
