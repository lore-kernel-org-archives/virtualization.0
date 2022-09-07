Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C957C6FA8D
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 19:41:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF62983E34;
	Wed,  7 Sep 2022 19:41:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF62983E34
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pGIa_bjZX4ci; Wed,  7 Sep 2022 19:41:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3B57283E4F;
	Wed,  7 Sep 2022 19:41:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B57283E4F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14A88C0032;
	Wed,  7 Sep 2022 19:41:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB543C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3DAB83E4F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:41:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3DAB83E4F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WyMyRRyYaoiw
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:41:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 547C583E34
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 547C583E34
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 19:41:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 913CA106F;
 Wed,  7 Sep 2022 12:41:40 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A19FF3F7B4;
 Wed,  7 Sep 2022 12:41:20 -0700 (PDT)
Message-ID: <0b466705-3a17-1bbc-7ef2-5adadc22d1ae@arm.com>
Date: Wed, 7 Sep 2022 20:41:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v6 1/5] iommu: Return -EMEDIUMTYPE for incompatible domain
 and device/group
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220815181437.28127-1-nicolinc@nvidia.com>
 <20220815181437.28127-2-nicolinc@nvidia.com> <YxiRkm7qgQ4k+PIG@8bytes.org>
 <Yxig+zfA2Pr4vk6K@nvidia.com> <9f91f187-2767-13f9-68a2-a5458b888f00@arm.com>
 <YxjOPo5FFqu2vE/g@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YxjOPo5FFqu2vE/g@nvidia.com>
Cc: marcan@marcan.st, mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
 thierry.reding@gmail.com, will@kernel.org, alyssa@rosenzweig.io,
 jean-philippe@linaro.org, kvm@vger.kernel.org, zhang.lyra@gmail.com,
 Joerg Roedel <joro@8bytes.org>, jon@solid-run.com, jonathanh@nvidia.com,
 iommu@lists.linux.dev, Nicolin Chen <nicolinc@nvidia.com>,
 yangyingliang@huawei.com, orsonzhai@gmail.com, gerald.schaefer@linux.ibm.com,
 sven@svenpeter.dev, linux-arm-msm@vger.kernel.org, vdumpa@nvidia.com,
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

On 2022-09-07 18:00, Jason Gunthorpe wrote:
> On Wed, Sep 07, 2022 at 03:23:09PM +0100, Robin Murphy wrote:
>> On 2022-09-07 14:47, Jason Gunthorpe wrote:
>>> On Wed, Sep 07, 2022 at 02:41:54PM +0200, Joerg Roedel wrote:
>>>> On Mon, Aug 15, 2022 at 11:14:33AM -0700, Nicolin Chen wrote:
>>>>> Provide a dedicated errno from the IOMMU driver during attach that the
>>>>> reason attached failed is because of domain incompatability. EMEDIUMTYPE
>>>>> is chosen because it is never used within the iommu subsystem today and
>>>>> evokes a sense that the 'medium' aka the domain is incompatible.
>>>>
>>>> I am not a fan of re-using EMEDIUMTYPE or any other special value. What
>>>> is needed here in EINVAL, but with a way to tell the caller which of the
>>>> function parameters is actually invalid.
>>>
>>> Using errnos to indicate the nature of failure is a well established
>>> unix practice, it is why we have hundreds of error codes and don't
>>> just return -EINVAL for everything.
>>>
>>> What don't you like about it?
>>>
>>> Would you be happier if we wrote it like
>>>
>>>    #define IOMMU_EINCOMPATIBLE_DEVICE xx
>>>
>>> Which tells "which of the function parameters is actually invalid" ?
>>
>> FWIW, we're now very close to being able to validate dev->iommu against
>> where the domain came from in core code, and so short-circuit ->attach_dev
>> entirely if they don't match.
> 
> I don't think this is a long term direction. We have systems now with
> a number of SMMU blocks and we really are going to see a need that
> they share the iommu_domains so we don't have unncessary overheads
> from duplicated io page table memory.
> 
> So ultimately I'd expect to pass the iommu_domain to the driver and
> the driver will decide if the page table memory it represents is
> compatible or not. Restricting to only the same iommu instance isn't
> good..

Who said IOMMU instance? As a reminder, the patch I currently have[1] is 
matching the driver (via the device ops), which happens to be entirely 
compatible with drivers supporting cross-instance domains. Mostly 
because we already have drivers that support cross-instance domains and 
callers that use them.

>> At that point -EINVAL at the driver callback level could be assumed
>> to refer to the domain argument, while anything else could be taken
>> as something going unexpectedly wrong when the attach may otherwise
>> have worked. I've forgotten if we actually had a valid case anywhere
>> for "this is my device but even if you retry with a different domain
>> it's still never going to work", but I think we wouldn't actually
>> need that anyway - it should be clear enough to a caller that if
>> attaching to an existing domain fails, then allocating a fresh
>> domain and attaching also fails, that's the point to give up.
> 
> The point was to have clear error handling, we either have permenent
> errors or 'this domain will never work with this device error'.
> 
> If we treat all error as temporary and just retry randomly it can
> create a mess. For instance we might fail to attach to a perfectly
> compatible domain due to ENOMEM or something and then go on to
> successfully a create a new 2nd domain, just due to races.
> 
> We can certainly code the try everything then allocate scheme, it is
> just much more fragile than having definitive error codes.

Again, not what I was suggesting. In fact the nature of 
iommu_attach_group() already rules out bogus devices getting this far, 
so all a driver currently has to worry about is compatibility of a 
device that it definitely probed with a domain that it definitely 
allocated. Therefore, from a caller's point of view, if attaching to an 
existing domain returns -EINVAL, try another domain; multiple different 
existing domains can be tried, and may also return -EINVAL for the same 
or different reasons; the final attempt is to allocate a fresh domain 
and attach to that, which should always be nominally valid and *never* 
return -EINVAL. If any attempt returns any other error, bail out down 
the usual "this should have worked but something went wrong" path. Even 
if any driver did have a nonsensical "nothing went wrong, I just can't 
attach my device to any of my domains" case, I don't think it would 
really need distinguishing from any other general error anyway.

Once multiple drivers are in play, the only addition is that the 
"gatekeeper" check inside iommu_attach_group() may also return -EINVAL 
if the device is managed by a different driver, since that still fits 
the same "try again with a different domain" message to the caller.

It's actually quite neat - basically the exact same thing we've tried to 
do with -EMEDIUMTYPE here, but more self-explanatory, since the fact is 
that a domain itself should never be invalid for attaching to via its 
own ops, and a group should never be inherently invalid for attaching to 
a suitable domain, it is only ever a particular combination of group (or 
device at the internal level) and domain that may not be valid together. 
Thus as long as we can maintain that basic guarantee that attaching a 
group to a newly allocated domain can only ever fail for resource 
allocation reasons and not some spurious "incompatibility", then we 
don't need any obscure trickery, and a single, clear, error code is in 
fact enough to say all that needs to be said.

Whether iommu_attach_device() should also join the party and start 
rejecting non-singleton-group devices with a different error, or 
maintain its current behaviour since its legacy users already have their 
expectations set, is another matter in its own right.

Cheers,
Robin.

[1] 
https://gitlab.arm.com/linux-arm/linux-rm/-/commit/683cdff1b2d4ae11f56e38d93b37e66e8c939fc9
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
