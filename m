Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ADDC4332F
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 09:06:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B640560E82;
	Wed,  9 Nov 2022 09:06:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B640560E82
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J8r4IY4I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AkEn89ITAz5c; Wed,  9 Nov 2022 09:06:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5498D60E91;
	Wed,  9 Nov 2022 09:06:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5498D60E91
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29187C0032;
	Wed,  9 Nov 2022 09:06:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4DA8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 09:06:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A1B81401FC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 09:06:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1B81401FC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=J8r4IY4I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M5EVtnoyPqe6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 09:06:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD4E041773
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD4E041773
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 09:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667984770; x=1699520770;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=+JNLCXbPm/UrqSsWNqXLmoAAPfj8mhI4bJ9CrK93e6o=;
 b=J8r4IY4IEMqGmo4Toh5xXyuOWPcQgHEj1sc4hNkPdezrfol1ReT0jH/m
 UfLvCoOIipCx4raFHj0kxhCp/B9lBAvQ95LIEP831HbC6Yr6QLkP8qnFn
 g4ya7o7OmWf2CARuMouS0HOM9vEY2SJlow0S9q3Img9NdwUor7r/FNxL8
 dMBUUwYncSLxynLxPcgOdvkxNRpyRAEJjfxJHhnWFxIrhK2tmsVrtiaQC
 VNShlBNUnAzUnNkNk+E5Xs3Xr+J5BxZDBZkk6+vDMJFCAtXMJzyGMxRTP
 AXhjWadINaQ3i3bJJ6MA8jBkwaeU9sa2cZxrjExgq46Nig0hNI+R1HDvM Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="312090451"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; d="scan'208";a="312090451"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2022 01:06:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="811564536"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; d="scan'208";a="811564536"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.255.29.36])
 ([10.255.29.36])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2022 01:06:03 -0800
Message-ID: <80cdd80a-16fa-ac75-0a89-5729b846efed@intel.com>
Date: Wed, 9 Nov 2022 17:06:01 +0800
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
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEujqOFHv7QATWgYo=SdAKef5jQXi2-YksjgT-hxEgKNDQ@mail.gmail.com>
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



On 11/9/2022 4:59 PM, Jason Wang wrote:
> On Wed, Nov 9, 2022 at 4:14 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>>
>>
>> On 11/9/2022 2:51 PM, Jason Wang wrote:
>>> On Mon, Nov 7, 2022 at 5:42 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>>>> This series implements features provisioning for ifcvf.
>>>> By applying this series, we allow userspace to create
>>>> a vDPA device with selected (management device supported)
>>>> feature bits and mask out others.
>>> I don't see a direct relationship between the first 3 and the last.
>>> Maybe you can state the reason why the restructure is a must for the
>>> feature provisioning. Otherwise, we'd better split the series.
>> When introducing features provisioning ability to ifcvf, there is a need
>> to re-create vDPA devices
>> on a VF with different feature bits.
> This seems a requirement even without feature provisioning? Device
> could be deleted from the management device anyhow.
Yes, we need this to delete and re-create a vDPA device.

We create vDPA device from a VF, so without features provisioning 
requirements,
we don't need to re-create the vDPA device. But with features provisioning,
it is a must now.

Thanks


>
> Thakns
>
>> When remove a vDPA device, the container of struct vdpa_device (here is
>> ifcvf_adapter) is free-ed in
>> dev_del() interface, so we need to allocate ifcvf_adapter in dev_add()
>> than in probe(). That's
>> why I have re-factored the adapter/mgmt_dev code.
>>
>> For re-factoring the irq related code and ifcvf_base, let them work on
>> struct ifcvf_hw, the
>> reason is that the adapter is allocated in dev_add(), if we want theses
>> functions to work
>> before dev_add(), like in probe, we need them work on ifcvf_hw than the
>> adapter.
>>
>> Thanks
>> Zhu Lingshan
>>> Thanks
>>>
>>>> Please help review
>>>>
>>>> Thanks
>>>>
>>>> Zhu Lingshan (4):
>>>>     vDPA/ifcvf: ifcvf base layer interfaces work on struct ifcvf_hw
>>>>     vDPA/ifcvf: IRQ interfaces work on ifcvf_hw
>>>>     vDPA/ifcvf: allocate ifcvf_adapter in dev_add()
>>>>     vDPA/ifcvf: implement features provisioning
>>>>
>>>>    drivers/vdpa/ifcvf/ifcvf_base.c |  32 ++-----
>>>>    drivers/vdpa/ifcvf/ifcvf_base.h |  10 +-
>>>>    drivers/vdpa/ifcvf/ifcvf_main.c | 156 +++++++++++++++-----------------
>>>>    3 files changed, 89 insertions(+), 109 deletions(-)
>>>>
>>>> --
>>>> 2.31.1
>>>>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
