Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BBFC6FA8B
	for <virtualization@archiver.kernel.org>; Wed, 14 Sep 2022 19:53:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5995840C51;
	Wed, 14 Sep 2022 19:53:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5995840C51
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jxAwr05C0HVK; Wed, 14 Sep 2022 19:53:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A6697403E2;
	Wed, 14 Sep 2022 19:53:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A6697403E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69C98C0033;
	Wed, 14 Sep 2022 19:53:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E14EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 19:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54FD060AF2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 19:53:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54FD060AF2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EESW-VZy7kur
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 19:53:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F3F060AE7
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F3F060AE7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 19:53:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 956841576;
 Wed, 14 Sep 2022 12:53:23 -0700 (PDT)
Received: from [10.57.18.118] (unknown [10.57.18.118])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CB443F73B;
 Wed, 14 Sep 2022 12:53:12 -0700 (PDT)
Message-ID: <5f049bb8-76e6-901a-9f8e-b48d270bc4a0@arm.com>
Date: Wed, 14 Sep 2022 20:53:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/5] iommu: Regulate errno in ->attach_dev callback
 functions
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220913082448.31120-1-nicolinc@nvidia.com>
 <20220913082448.31120-5-nicolinc@nvidia.com> <YyB3F/o3RfymqiFW@myrica>
 <YyGaqsXSDMn8R12R@nvidia.com> <YyGjtsB2Yq4fQICS@myrica>
 <YyIWQ6rX6AR9KX5E@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YyIWQ6rX6AR9KX5E@Asurada-Nvidia>
Cc: heiko@sntech.de, konrad.dybcio@somainline.org, bjorn.andersson@linaro.org,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com, will@kernel.org,
 zhang.lyra@gmail.com, joro@8bytes.org, jon@solid-run.com, jonathanh@nvidia.com,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev, agross@kernel.org,
 linux-arm-kernel@lists.infradead.org, yangyingliang@huawei.com,
 orsonzhai@gmail.com, linux-arm-msm@vger.kernel.org, vdumpa@nvidia.com,
 christophe.jaillet@wanadoo.fr, baolin.wang@linux.alibaba.com,
 thunder.leizhen@huawei.com, matthias.bgg@gmail.com, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, yong.wu@mediatek.com,
 dwmw2@infradead.org, linux-kernel@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com, robdclark@gmail.com,
 suravee.suthikulpanit@amd.com, linux-mediatek@lists.infradead.org,
 sricharan@codeaurora.org, baolu.lu@linux.intel.com
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

On 2022-09-14 18:58, Nicolin Chen wrote:
> On Wed, Sep 14, 2022 at 10:49:42AM +0100, Jean-Philippe Brucker wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Wed, Sep 14, 2022 at 06:11:06AM -0300, Jason Gunthorpe wrote:
>>> On Tue, Sep 13, 2022 at 01:27:03PM +0100, Jean-Philippe Brucker wrote:
>>>> I think in the future it will be too easy to forget about the constrained
>>>> return value of attach() while modifying some other part of the driver,
>>>> and let an external helper return EINVAL. So I'd rather not propagate ret
>>>> from outside of viommu_domain_attach() and finalise().
>>>
>>> Fortunately, if -EINVAL is wrongly returned it only creates an
>>> inefficiency, not a functional problem. So we do not need to be
>>> precise here.
>>
>> Ah fair. In that case the attach_dev() documentation should indicate that
>> EINVAL is a hint, so that callers don't rely on it (currently words "must"
>> and "exclusively" indicate that returning EINVAL for anything other than
>> device-domain incompatibility is unacceptable). The virtio-iommu
>> implementation may well return EINVAL from the virtio stack or from the
>> host response.
> 
> How about this?
> 
> + * * EINVAL    - mainly, device and domain are incompatible, or something went
> + *               wrong with the domain. It's suggested to avoid kernel prints
> + *               along with this errno. And it's better to convert any EINVAL
> + *               returned from kAPIs to ENODEV if it is device-specific, or to
> + *               some other reasonable errno being listed below

FWIW, I'd say something like:

"The device and domain are incompatible. If this is due to some previous 
configuration of the domain, drivers should not log an error, since it 
is legitimate for callers to test reuse of an existing domain. 
Otherwise, it may still represent some fundamental problem."

And then at the public interfaces state it from other angle:

"The device and domain are incompatible. If the domain has already been 
used or configured in some way, attaching the same device to a different 
domain may be expected to succeed. Otherwise, it may still represent 
some fundamental problem."

[ and to save another mail, I'm not sure copying the default comment for 
ENOSPC is all that helpful either - what is "space" for something that 
isn't a storage device? I'd guess limited hardware resources in some 
form, but in the IOMMU context, potential confusion with address space 
is maybe a little too close for comfort? ]

>>>> Since we can't guarantee that APIs like virtio or ida won't ever return
>>>> EINVAL, we should set all return values:
>>>
>>> I dislike this alot, it squashes all return codes to try to optimize
>>> an obscure failure path :(
> 
> Hmm...should I revert all the driver changes back to this version?

Yeah, I don't think we need to go too mad here. Drivers shouldn't emit 
their *own* -EINVAL unless appropriate, but if it comes back from some 
external API then that implies something's gone unexpectedly wrong 
anyway - maybe it's a transient condition and a subsequent different 
attach might actually work out OK? We can't really say in general. 
Besides, if the driver sees an error which implies it's done something 
wrong itself, it probably shouldn't be trusted to try to reason about it 
further. The caller can handle any error as long as we set their 
expectations correctly.

Thanks,
Robin.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
