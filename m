Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75677C433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Jul 2022 13:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0495460B33;
	Thu, 14 Jul 2022 13:39:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0495460B33
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yIMLuX9O1lcq; Thu, 14 Jul 2022 13:39:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 67F92607C7;
	Thu, 14 Jul 2022 13:39:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 67F92607C7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CA05C0035;
	Thu, 14 Jul 2022 13:39:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD933C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 13:39:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 897B542649
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 13:39:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 897B542649
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s4HcF7cjZoR1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 13:39:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 279194265B
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 279194265B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 13:39:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0D501CE2;
 Thu, 14 Jul 2022 06:39:39 -0700 (PDT)
Received: from [10.57.86.49] (unknown [10.57.86.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A85EC3F73D;
 Thu, 14 Jul 2022 06:39:37 -0700 (PDT)
Message-ID: <ddd64256-7553-a1aa-ed63-2138d77ae6af@arm.com>
Date: Thu, 14 Jul 2022 14:39:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] iommu/virtio: Advertise IOMMU_CAP_CACHE_COHERENCY
Content-Language: en-GB
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220714111059.708735-1-jean-philippe@linaro.org>
 <f701a947-3b93-d47e-f806-fd47d281d371@arm.com> <YtATYaBOz5UnTNC6@myrica>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YtATYaBOz5UnTNC6@myrica>
Cc: eric.auger@redhat.com, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, virtualization@lists.linux-foundation.org
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

On 2022-07-14 14:00, Jean-Philippe Brucker wrote:
> On Thu, Jul 14, 2022 at 01:01:37PM +0100, Robin Murphy wrote:
>> On 2022-07-14 12:11, Jean-Philippe Brucker wrote:
>>> Fix virtio-iommu interaction with VFIO, as VFIO now requires
>>> IOMMU_CAP_CACHE_COHERENCY. virtio-iommu does not support non-cacheable
>>> mappings, and always expects to be called with IOMMU_CACHE.
>>
>> Can we know this is actually true though? What if the virtio-iommu
>> implementation is backed by something other than VFIO, and the underlying
>> hardware isn't coherent? AFAICS the spec doesn't disallow that.
> 
> Right, I should add a note about that. If someone does actually want to
> support non-coherent device, I assume we'll add a per-device property, a
> 'non-cacheable' mapping flag, and IOMMU_CAP_CACHE_COHERENCY will hold.
> I'm also planning to add a check on (IOMMU_CACHE && !IOMMU_NOEXEC) in
> viommu_map(), but not as a fix.

But what about all the I/O-coherent PL330s? :P (IIRC you can actually 
make a Juno do that with S2CR.MTCFG hacks...)

> In the meantime we do need to restore VFIO support under virtio-iommu,
> since userspace still expects that to work, and the existing use-cases are
> coherent devices.

Yeah, I'm not necessarily against adding this as a horrible bodge for 
now - the reality is that people using VFIO must be doing it on coherent 
systems or it wouldn't be working properly anyway - as long as we all 
agree that that's what it is.

Next cycle I'll be sending the follow-up patches to bring 
device_iommu_capable() to its final form (hoping the outstanding VDPA 
patch lands in the meantime), at which point we get to sort-of-fix the 
SMMU drivers[1], and can do something similar here too. I guess the main 
question for virtio-iommu is whether it needs to be described/negotiated 
in the protocol itself, or can be reliably described by other standard 
firmware properties (with maybe just a spec not to clarify that 
coherency must be consistent).

Cheers,
Robin.

[1] 
https://gitlab.arm.com/linux-arm/linux-rm/-/commit/d8256bf48c8606cbaa6f0815696c2a6dbb72f1b0
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
