Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA950C6FA8A
	for <virtualization@archiver.kernel.org>; Thu,  8 Sep 2022 10:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B47D41B51;
	Thu,  8 Sep 2022 10:26:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B47D41B51
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ebsAZNbJRJpk; Thu,  8 Sep 2022 10:26:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 51CCE41A5C;
	Thu,  8 Sep 2022 10:26:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51CCE41A5C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27B50C0032;
	Thu,  8 Sep 2022 10:26:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8A92C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 10:26:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AECDE41A5D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 10:26:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AECDE41A5D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ty1AitKFFtow
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 10:26:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6803F41A5C
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6803F41A5C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 10:26:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94A8D14BF;
 Thu,  8 Sep 2022 03:26:14 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D059C3F71A;
 Thu,  8 Sep 2022 03:25:52 -0700 (PDT)
Message-ID: <7ef259b2-121e-643e-49c2-0b65923d392d@arm.com>
Date: Thu, 8 Sep 2022 11:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v6 1/5] iommu: Return -EMEDIUMTYPE for incompatible domain
 and device/group
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
References: <20220815181437.28127-1-nicolinc@nvidia.com>
 <20220815181437.28127-2-nicolinc@nvidia.com> <YxiRkm7qgQ4k+PIG@8bytes.org>
 <Yxig+zfA2Pr4vk6K@nvidia.com> <9f91f187-2767-13f9-68a2-a5458b888f00@arm.com>
 <YxjOPo5FFqu2vE/g@nvidia.com> <0b466705-3a17-1bbc-7ef2-5adadc22d1ae@arm.com>
 <Yxk6sR4JiAAn3Jf5@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yxk6sR4JiAAn3Jf5@nvidia.com>
Cc: marcan@marcan.st, mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
 thierry.reding@gmail.com, will@kernel.org, alyssa@rosenzweig.io,
 jean-philippe@linaro.org, kvm@vger.kernel.org, zhang.lyra@gmail.com,
 jon@solid-run.com, jonathanh@nvidia.com, iommu@lists.linux.dev,
 Nicolin Chen <nicolinc@nvidia.com>, yangyingliang@huawei.com,
 orsonzhai@gmail.com, gerald.schaefer@linux.ibm.com, sven@svenpeter.dev,
 linux-arm-msm@vger.kernel.org, vdumpa@nvidia.com,
 christophe.jaillet@wanadoo.fr, baolin.wang@linux.alibaba.com,
 thunder.leizhen@huawei.com, linux-tegra@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 cohuck@redhat.com, shameerali.kolothum.thodi@huawei.com, robdclark@gmail.com,
 asahi@lists.linux.dev, suravee.suthikulpanit@amd.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com
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

On 2022-09-08 01:43, Jason Gunthorpe wrote:
> On Wed, Sep 07, 2022 at 08:41:13PM +0100, Robin Murphy wrote:
> 
>>>> FWIW, we're now very close to being able to validate dev->iommu against
>>>> where the domain came from in core code, and so short-circuit ->attach_dev
>>>> entirely if they don't match.
>>>
>>> I don't think this is a long term direction. We have systems now with
>>> a number of SMMU blocks and we really are going to see a need that
>>> they share the iommu_domains so we don't have unncessary overheads
>>> from duplicated io page table memory.
>>>
>>> So ultimately I'd expect to pass the iommu_domain to the driver and
>>> the driver will decide if the page table memory it represents is
>>> compatible or not. Restricting to only the same iommu instance isn't
>>> good..
>>
>> Who said IOMMU instance?
> 
> Ah, I completely misunderstood what 'dev->iommu' was referring too, OK
> I see.
> 
>> Again, not what I was suggesting. In fact the nature of iommu_attach_group()
>> already rules out bogus devices getting this far, so all a driver currently
>> has to worry about is compatibility of a device that it definitely probed
>> with a domain that it definitely allocated. Therefore, from a caller's point
>> of view, if attaching to an existing domain returns -EINVAL, try another
>> domain; multiple different existing domains can be tried, and may also
>> return -EINVAL for the same or different reasons; the final attempt is to
>> allocate a fresh domain and attach to that, which should always be nominally
>> valid and *never* return -EINVAL. If any attempt returns any other error,
>> bail out down the usual "this should have worked but something went wrong"
>> path. Even if any driver did have a nonsensical "nothing went wrong, I just
>> can't attach my device to any of my domains" case, I don't think it would
>> really need distinguishing from any other general error anyway.
> 
> The algorithm you described is exactly what this series does, it just
> used EMEDIUMTYPE instead of EINVAL. Changing it to EINVAL is not a
> fundamental problem, just a bit more work.
> 
> Looking at Nicolin's series there is a bunch of existing errnos that
> would still need converting, ie EXDEV, EBUSY, EOPNOTSUPP, EFAULT, and
> ENXIO are all returned as codes for 'domain incompatible with device'
> in various drivers. So the patch would still look much the same, just
> changing them to EINVAL instead of EMEDIUMTYPE.
> 
> That leaves the question of the remaining EINVAL's that Nicolin did
> not convert to EMEDIUMTYPE.
> 
> eg in the AMD driver:
> 
> 	if (!check_device(dev))
> 		return -EINVAL;
> 
> 	iommu = rlookup_amd_iommu(dev);
> 	if (!iommu)
> 		return -EINVAL;
> 
> These are all cases of 'something is really wrong with the device or
> iommu, everything will fail'. Other drivers are using ENODEV for this
> already, so we'd probably have an additional patch changing various
> places like that to ENODEV.
> 
> This mixture of error codes is the basic reason why a new code was
> used, because none of the existing codes are used with any
> consistency.
> 
> But OK, I'm on board, lets use more common errnos with specific
> meaning, that can be documented in a comment someplace:
>   ENOMEM - out of memory
>   ENODEV - no domain can attach, device or iommu is messed up
>   EINVAL - the domain is incompatible with the device
>   <others> - Same behavior as ENODEV, use is discouraged.
> 
> I think achieving consistency of error codes is a generally desirable
> goal, it makes the error code actually useful.
> 
> Joerg this is a good bit of work, will you be OK with it?
> 
>> Thus as long as we can maintain that basic guarantee that attaching
>> a group to a newly allocated domain can only ever fail for resource
>> allocation reasons and not some spurious "incompatibility", then we
>> don't need any obscure trickery, and a single, clear, error code is
>> in fact enough to say all that needs to be said.
> 
> As above, this is not the case, drivers do seem to have error paths
> that are unconditional on the domain. Perhaps they are just protective
> assertions and never happen.

Right, that's the gist of what I was getting at - I think it's worth 
putting in the effort to audit and fix the drivers so that that *can* be 
the case, then we can have a meaningful error API with standard codes 
effectively for free, rather than just sighing at the existing mess and 
building a slightly esoteric special case on top.

Case in point, the AMD checks quoted above are pointless, since it 
checks the same things in ->probe_device, and if that fails then the 
device won't get a group so there's no way for it to even reach 
->attach_dev any more. I'm sure there's a *lot* of cruft that can be 
cleared out now that per-device and per-domain ops give us this kind of 
inherent robustness.

Cheers,
Robin.

> Regardless, it doesn't matter. If they return ENODEV or EINVAL the
> VFIO side algorithm will continue to work fine, it just does alot more
> work if EINVAL is permanently returned.
> 
> Thanks,
> Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
