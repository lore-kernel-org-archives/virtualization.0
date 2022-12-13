Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC876C4332F
	for <virtualization@archiver.kernel.org>; Tue, 13 Dec 2022 06:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3BEA44058F;
	Tue, 13 Dec 2022 06:58:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BEA44058F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QPjjYnwp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jn4PqTJMLqQP; Tue, 13 Dec 2022 06:58:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 980A74053E;
	Tue, 13 Dec 2022 06:58:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 980A74053E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F9D6C0032;
	Tue, 13 Dec 2022 06:58:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81F7BC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 06:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58A4D60B48
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 06:58:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58A4D60B48
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QPjjYnwp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CYKz4L4907al
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 06:58:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2421460B27
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2421460B27
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 06:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670914680; x=1702450680;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=HBfcINep82HVPFPIwMFOcydpeusXlzwEf1BgRX/cP9Y=;
 b=QPjjYnwpikNz409YIQRmseyFnylngW/rg1/sAY0ZrdS8IKm2SuBoBBnD
 j8r9VcTSqMddfI4FWH4f5I/WsUh5q5PuX2Kbd/ew18tJRLBHTG3JxLY3z
 r7jzUye+OVQbpD++ujxjCkkdJx9sgGvPQYoRejt7Z91S8Sk6LGzviQ/b/
 SN1myMkHhOiPMhrlq1d1Bwfqscr2PWlCobdqB1/3QekeHD0QJsV8xG8uT
 xLGIF6yRILzwsh+uIHHVIukeBCIdgHPD6si40Cix8f4sTZeGu6yR0Ewaz
 64dEpKF8FtJyk/bJTs6ZwWs2yxG31Cs9Ihct4kEAXkIoWjPIaahySfGam Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="305701043"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; d="scan'208";a="305701043"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2022 22:57:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="598726978"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; d="scan'208";a="598726978"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.249.171.9])
 ([10.249.171.9])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2022 22:57:21 -0800
Message-ID: <845d9829-a766-3a07-83bb-1d764ace604d@intel.com>
Date: Tue, 13 Dec 2022 14:57:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH V2 00/12] ifcvf/vDPA implement features provisioning
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20221125145724.1129962-1-lingshan.zhu@intel.com>
 <CACGkMEvEwutEZT4UyosOZmTcKjvhhS6covy6FgyMWm4nmtKn8w@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEvEwutEZT4UyosOZmTcKjvhhS6covy6FgyMWm4nmtKn8w@mail.gmail.com>
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



On 12/6/2022 4:25 PM, Jason Wang wrote:
> On Fri, Nov 25, 2022 at 11:06 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>> This series implements features provisioning for ifcvf.
>> By applying this series, we allow userspace to create
>> a vDPA device with selected (management device supported)
>> feature bits and mask out others.
>>
>> Examples:
>> a)The management device supported features:
>> $ vdpa mgmtdev show pci/0000:01:00.5
>> pci/0000:01:00.5:
>>    supported_classes net
>>    max_supported_vqs 9
>>    dev_features MTU MAC MRG_RXBUF CTRL_VQ MQ ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>>
>> b)Provision a vDPA device with all supported features:
>> $ vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.5
>> $ vdpa/vdpa dev config show vdpa0
>> vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 4 mtu 1500
>>    negotiated_features MRG_RXBUF CTRL_VQ MQ VERSION_1 ACCESS_PLATFORM
>>
>> c)Provision a vDPA device with a subset of the supported features:
>> $ vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.5 device_features 0x300020020
>> $ vdpa dev config show vdpa0
>> mac 00:e8:ca:11:be:05 link up link_announce false
>>    negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
>>
>> Please help review
>>
>> Thanks
>>
>> Changes from V1:
>> split original patch 1 ~ patch 3 to small patches that are less
>> than 100 lines,
> True but.
>
>> so they can be applied to stalbe kernel(Jason)
>>
> It requires each patch fixes a real issue so I think those can not go
> to -stable.
>
> Btw, looking at git history what you want to decouple is basically
> functional equivalent to a partial revert of this commit:
>
> commit 378b2e956820ff5c082d05f42828badcfbabb614
> Author: Zhu Lingshan <lingshan.zhu@intel.com>
> Date:   Fri Jul 22 19:53:05 2022 +0800
>
>      vDPA/ifcvf: support userspace to query features and MQ of a
> management device
>
>      Adapting to current netlink interfaces, this commit allows userspace
>      to query feature bits and MQ capability of a management device.
>
>      Currently both the vDPA device and the management device are the VF itself,
>      thus this ifcvf should initialize the virtio capabilities in probe() before
>      setting up the struct vdpa_mgmt_dev.
>
>      Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>      Message-Id: <20220722115309.82746-3-lingshan.zhu@intel.com>
>      Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> Before this commit. adapter was allocated/freed in device_add/del
> which should be fine.
>
> Can we go back to doing things that way?
Hi Jason

Thanks for your advice, my concern is, even revert this commit 378b2e95,
we still need to re-implement the feature "support userspace to query 
features and MQ of a management device"
in stable kernel(still not a patch fix something but implement 
something), or we remove a feature in the stable kernel.
And there may still need to split patches to meet the <100 lines requirement

The reason why I place the adapter allocation in probe is that currently 
the management device is the VF itself,
move it from dev_add to probe can lighten the organization of data 
structures, it is not a good design anyway,
so this series tries to fix them as well.

Maybe not to to sable

Thanks
>
> Thanks
>
>> Zhu Lingshan (12):
>>    vDPA/ifcvf: decouple hw features manipulators from the adapter
>>    vDPA/ifcvf: decouple config space ops from the adapter
>>    vDPA/ifcvf: alloc the mgmt_dev before the adapter
>>    vDPA/ifcvf: decouple vq IRQ releasers from the adapter
>>    vDPA/ifcvf: decouple config IRQ releaser from the adapter
>>    vDPA/ifcvf: decouple vq irq requester from the adapter
>>    vDPA/ifcvf: decouple config/dev IRQ requester and vectors allocator
>>      from the adapter
>>    vDPA/ifcvf: ifcvf_request_irq works on ifcvf_hw
>>    vDPA/ifcvf: manage ifcvf_hw in the mgmt_dev
>>    vDPA/ifcvf: allocate the adapter in dev_add()
>>    vDPA/ifcvf: retire ifcvf_private_to_vf
>>    vDPA/ifcvf: implement features provisioning
>>
>>   drivers/vdpa/ifcvf/ifcvf_base.c |  32 ++-----
>>   drivers/vdpa/ifcvf/ifcvf_base.h |  10 +-
>>   drivers/vdpa/ifcvf/ifcvf_main.c | 162 +++++++++++++++-----------------
>>   3 files changed, 91 insertions(+), 113 deletions(-)
>>
>> --
>> 2.31.1
>>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
