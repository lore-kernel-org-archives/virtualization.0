Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740CEC433EF
	for <virtualization@archiver.kernel.org>; Mon, 20 Jun 2022 10:11:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 50B4C40AE9;
	Mon, 20 Jun 2022 10:11:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50B4C40AE9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G23n1ZfNmVdD; Mon, 20 Jun 2022 10:11:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D261A40AE6;
	Mon, 20 Jun 2022 10:11:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D261A40AE6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58059C0083;
	Mon, 20 Jun 2022 10:11:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D12DDC002D;
 Mon, 20 Jun 2022 10:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A63EA83265;
 Mon, 20 Jun 2022 10:11:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A63EA83265
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BxYa6qmdaejp; Mon, 20 Jun 2022 10:11:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1FCB83231
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1FCB83231;
 Mon, 20 Jun 2022 10:11:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C40DE113E;
 Mon, 20 Jun 2022 03:11:10 -0700 (PDT)
Received: from [10.57.84.159] (unknown [10.57.84.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 162D83F7D7;
 Mon, 20 Jun 2022 03:11:05 -0700 (PDT)
Message-ID: <55e352d5-3fea-7e46-0530-b41d323b6fcf@arm.com>
Date: Mon, 20 Jun 2022 11:11:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 5/5] vfio/iommu_type1: Simplify group attachment
Content-Language: en-GB
To: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20220616000304.23890-1-nicolinc@nvidia.com>
 <20220616000304.23890-6-nicolinc@nvidia.com>
 <BL1PR11MB52710E360B50DDA99C9A65D18CAC9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YquxcH2S1fM+llOf@Asurada-Nvidia>
 <BN9PR11MB5276C7BFA77C2C176491B56A8CAF9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <BN9PR11MB5276C7BFA77C2C176491B56A8CAF9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "marcan@marcan.st" <marcan@marcan.st>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jordan@cosmicpenguin.net" <jordan@cosmicpenguin.net>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "will@kernel.org" <will@kernel.org>,
 "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "saiprakash.ranjan@codeaurora.org" <saiprakash.ranjan@codeaurora.org>,
 "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
 "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "isaacm@codeaurora.org" <isaacm@codeaurora.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
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

On 2022-06-17 03:53, Tian, Kevin wrote:
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: Friday, June 17, 2022 6:41 AM
>>
>>> ...
>>>> -     if (resv_msi) {
>>>> +     if (resv_msi && !domain->msi_cookie) {
>>>>                ret = iommu_get_msi_cookie(domain->domain,
>>>> resv_msi_base);
>>>>                if (ret && ret != -ENODEV)
>>>>                        goto out_detach;
>>>> +             domain->msi_cookie = true;
>>>>        }
>>>
>>> why not moving to alloc_attach_domain() then no need for the new
>>> domain field? It's required only when a new domain is allocated.
>>
>> When reusing an existing domain that doesn't have an msi_cookie,
>> we can do iommu_get_msi_cookie() if resv_msi is found. So it is
>> not limited to a new domain.
> 
> Looks msi_cookie requirement is per platform (currently only
> for smmu. see arm_smmu_get_resv_regions()). If there is
> no mixed case then above check is not required.
> 
> But let's hear whether Robin has a different thought here.

Yes, the cookie should logically be tied to the lifetime of the domain 
itself. In the relevant context, "an existing domain that doesn't have 
an msi_cookie" should never exist.

Thanks,
Robin.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
