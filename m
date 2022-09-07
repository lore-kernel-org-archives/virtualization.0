Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9061AC54EE9
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 14:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16BB3401DA;
	Wed,  7 Sep 2022 14:23:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16BB3401DA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EgaKoaoEAuEL; Wed,  7 Sep 2022 14:23:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 624C9401F4;
	Wed,  7 Sep 2022 14:23:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 624C9401F4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36771C0033;
	Wed,  7 Sep 2022 14:23:32 +0000 (UTC)
Received: from smtp4.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe79:d16b])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7326DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CCDC401F4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:23:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4CCDC401F4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id akVyhXTvA19D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:23:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5CC6401DA
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5CC6401DA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:23:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCDD91042;
 Wed,  7 Sep 2022 07:23:32 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B9E63F71A;
 Wed,  7 Sep 2022 07:23:15 -0700 (PDT)
Message-ID: <9f91f187-2767-13f9-68a2-a5458b888f00@arm.com>
Date: Wed, 7 Sep 2022 15:23:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v6 1/5] iommu: Return -EMEDIUMTYPE for incompatible domain
 and device/group
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
References: <20220815181437.28127-1-nicolinc@nvidia.com>
 <20220815181437.28127-2-nicolinc@nvidia.com> <YxiRkm7qgQ4k+PIG@8bytes.org>
 <Yxig+zfA2Pr4vk6K@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yxig+zfA2Pr4vk6K@nvidia.com>
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

On 2022-09-07 14:47, Jason Gunthorpe wrote:
> On Wed, Sep 07, 2022 at 02:41:54PM +0200, Joerg Roedel wrote:
>> On Mon, Aug 15, 2022 at 11:14:33AM -0700, Nicolin Chen wrote:
>>> Provide a dedicated errno from the IOMMU driver during attach that the
>>> reason attached failed is because of domain incompatability. EMEDIUMTYPE
>>> is chosen because it is never used within the iommu subsystem today and
>>> evokes a sense that the 'medium' aka the domain is incompatible.
>>
>> I am not a fan of re-using EMEDIUMTYPE or any other special value. What
>> is needed here in EINVAL, but with a way to tell the caller which of the
>> function parameters is actually invalid.
> 
> Using errnos to indicate the nature of failure is a well established
> unix practice, it is why we have hundreds of error codes and don't
> just return -EINVAL for everything.
> 
> What don't you like about it?
> 
> Would you be happier if we wrote it like
> 
>   #define IOMMU_EINCOMPATIBLE_DEVICE xx
> 
> Which tells "which of the function parameters is actually invalid" ?

FWIW, we're now very close to being able to validate dev->iommu against 
where the domain came from in core code, and so short-circuit 
->attach_dev entirely if they don't match. At that point -EINVAL at the 
driver callback level could be assumed to refer to the domain argument, 
while anything else could be taken as something going unexpectedly wrong 
when the attach may otherwise have worked. I've forgotten if we actually 
had a valid case anywhere for "this is my device but even if you retry 
with a different domain it's still never going to work", but I think we 
wouldn't actually need that anyway - it should be clear enough to a 
caller that if attaching to an existing domain fails, then allocating a 
fresh domain and attaching also fails, that's the point to give up.

Robin.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
