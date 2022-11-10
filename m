Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B77CC4332F
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 06:20:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA4AC81272;
	Thu, 10 Nov 2022 06:20:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA4AC81272
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eNEeL3x7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jizE_096u5jN; Thu, 10 Nov 2022 06:20:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4150980C60;
	Thu, 10 Nov 2022 06:20:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4150980C60
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1752EC0033;
	Thu, 10 Nov 2022 06:20:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16C1CC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:20:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D1D0A4017B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:20:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D1D0A4017B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eNEeL3x7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cm491ErHN-_9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:20:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EBE74400E7
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EBE74400E7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668061225; x=1699597225;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=hGWyxUkydtXJwvX4mK86sh+r5ydD25pAvx1mMuicHDs=;
 b=eNEeL3x7QYC0/zOC/SHTAwp31a2DZPMhaNbfV3//zPPRhJ/PStGpGC+c
 zkUPEJd99zwv7S3sP821SdWwBon+184B4nfJ1d7Q6/vAiWSEYrsCFriOc
 d0RSYa6QVA1DwGRJoo1Lcw4wsh6znEhtB8Bi+bvlAmfaXgBZFNFv7aNp1
 g2gZANYpdQV6dQAY+xumNipyxThWUx/v7gheXOr4W8M1uAbOSWLo0lHje
 6B3b7zAqNCVNfB1oXziHwr7BTsHv8Hq6vr5/SfCoo3wwzzzMr8iiyPoNL
 WfMNpT7c/fxpQoeHAuCo1HlVWvZ8Qcl/YRaxQvPdwEm8ChkeRp/VAjOh5 w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="309939709"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; d="scan'208";a="309939709"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2022 22:20:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="779647842"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; d="scan'208";a="779647842"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.249.171.70])
 ([10.249.171.70])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2022 22:20:14 -0800
Message-ID: <03657084-98ab-93bc-614a-e6cc7297d93e@intel.com>
Date: Thu, 10 Nov 2022 14:20:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH 0/4] ifcvf/vDPA implement features provisioning
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20221107093345.121648-1-lingshan.zhu@intel.com>
 <CACGkMEs9af1E1pLd2t8E71YBPF=rHkhfN8qO9_3=x6HVaCMAxg@mail.gmail.com>
 <0b15591f-9e49-6383-65eb-6673423f81ec@intel.com>
 <CACGkMEujqOFHv7QATWgYo=SdAKef5jQXi2-YksjgT-hxEgKNDQ@mail.gmail.com>
 <80cdd80a-16fa-ac75-0a89-5729b846efed@intel.com>
 <CACGkMEu-5TbA3Ky2qgn-ivfhgfJ2b12mDJgq8iNgHce8qu3ApA@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEu-5TbA3Ky2qgn-ivfhgfJ2b12mDJgq8iNgHce8qu3ApA@mail.gmail.com>
Cc: piotr.uminski@intel.com, hang.yuan@intel.com,
 virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com
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



On 11/10/2022 11:49 AM, Jason Wang wrote:
> On Wed, Nov 9, 2022 at 5:06 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>>
>>
>> On 11/9/2022 4:59 PM, Jason Wang wrote:
>>> On Wed, Nov 9, 2022 at 4:14 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>>>>
>>>> On 11/9/2022 2:51 PM, Jason Wang wrote:
>>>>> On Mon, Nov 7, 2022 at 5:42 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>>>>>> This series implements features provisioning for ifcvf.
>>>>>> By applying this series, we allow userspace to create
>>>>>> a vDPA device with selected (management device supported)
>>>>>> feature bits and mask out others.
>>>>> I don't see a direct relationship between the first 3 and the last.
>>>>> Maybe you can state the reason why the restructure is a must for the
>>>>> feature provisioning. Otherwise, we'd better split the series.
>>>> When introducing features provisioning ability to ifcvf, there is a need
>>>> to re-create vDPA devices
>>>> on a VF with different feature bits.
>>> This seems a requirement even without feature provisioning? Device
>>> could be deleted from the management device anyhow.
>> Yes, we need this to delete and re-create a vDPA device.
> I wonder if we need something that works for -stable.
I can add a fix tag, so these three patches could apply to stable
>
> AFAIK, we can move the vdpa_alloc_device() from probe() to dev_add()
> and it seems to work?
Yes and this is done in this series and that's why we need these
refactoring code.

By the way, do you have any comments to the patches?

Thanks,
Zhu Lingshan
>
> Thanks
>
>> We create vDPA device from a VF, so without features provisioning
>> requirements,
>> we don't need to re-create the vDPA device. But with features provisioning,
>> it is a must now.
>>
>> Thanks
>>
>>
>>> Thakns
>>>
>>>> When remove a vDPA device, the container of struct vdpa_device (here is
>>>> ifcvf_adapter) is free-ed in
>>>> dev_del() interface, so we need to allocate ifcvf_adapter in dev_add()
>>>> than in probe(). That's
>>>> why I have re-factored the adapter/mgmt_dev code.
>>>>
>>>> For re-factoring the irq related code and ifcvf_base, let them work on
>>>> struct ifcvf_hw, the
>>>> reason is that the adapter is allocated in dev_add(), if we want theses
>>>> functions to work
>>>> before dev_add(), like in probe, we need them work on ifcvf_hw than the
>>>> adapter.
>>>>
>>>> Thanks
>>>> Zhu Lingshan
>>>>> Thanks
>>>>>
>>>>>> Please help review
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Zhu Lingshan (4):
>>>>>>      vDPA/ifcvf: ifcvf base layer interfaces work on struct ifcvf_hw
>>>>>>      vDPA/ifcvf: IRQ interfaces work on ifcvf_hw
>>>>>>      vDPA/ifcvf: allocate ifcvf_adapter in dev_add()
>>>>>>      vDPA/ifcvf: implement features provisioning
>>>>>>
>>>>>>     drivers/vdpa/ifcvf/ifcvf_base.c |  32 ++-----
>>>>>>     drivers/vdpa/ifcvf/ifcvf_base.h |  10 +-
>>>>>>     drivers/vdpa/ifcvf/ifcvf_main.c | 156 +++++++++++++++-----------------
>>>>>>     3 files changed, 89 insertions(+), 109 deletions(-)
>>>>>>
>>>>>> --
>>>>>> 2.31.1
>>>>>>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
