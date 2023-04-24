Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F984C77B7C
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 07:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A5F6B4010C;
	Mon, 24 Apr 2023 07:25:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5F6B4010C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VY+yDDLd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dIGg8Y8YOcHH; Mon, 24 Apr 2023 07:25:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 492E740114;
	Mon, 24 Apr 2023 07:25:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 492E740114
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25498C0036;
	Mon, 24 Apr 2023 07:25:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E3BAC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 07:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DF29960E90
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 07:25:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF29960E90
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VY+yDDLd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id niNtUo85BppV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 07:25:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E42BD60E28
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E42BD60E28
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 07:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1682321122; x=1713857122;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zZqG1kr5+do9SHXvQu0cK1uQWdWAD9R6oZjJ252FdHQ=;
 b=VY+yDDLdl87tsx7/v9dumz2b4SeTmyEaO1mXmky6Tr90FS5XYEv6tLNe
 tpP27GHP136PWUEKxFzjJ4DH7TjZsGoF18Wt/KzpYVClxPJA1nhdJvj/k
 VkQXt/2UVueLEVsubva1HzX+CnzQFZGppxbwMF+HvBMSpw/hUcIkEw8Fd
 oYprsoVLmfL7+TJrtdaEYIPheqCaTfoWkoh+hp5UmgV/kkeOsom9UigXY
 nEYFhdEiybqac1Z4GRolSzNkKISCafBJrBIqkPeLxtb6J5HvwxIVaJUWC
 9Y9kXWT9LShsawsKSWszDLF9LORsZLvA0PbNuOeGD+jhc8JSvCTGiYmgd Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="325991505"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; d="scan'208";a="325991505"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2023 00:25:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="782307380"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; d="scan'208";a="782307380"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.249.168.173])
 ([10.249.168.173])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2023 00:25:20 -0700
Message-ID: <d7dd2e2f-0ced-8ee7-99ce-a235cfda640c@intel.com>
Date: Mon, 24 Apr 2023 15:25:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 0/5] vDPA/ifcvf: implement immediate initialization
 mechanism
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
 <20230424005130-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230424005130-mutt-send-email-mst@kernel.org>
Cc: virtualization@lists.linux-foundation.org
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



On 4/24/2023 12:51 PM, Michael S. Tsirkin wrote:
> On Sat, Apr 01, 2023 at 04:48:49AM +0800, Zhu Lingshan wrote:
>> Formerly, ifcvf driver has implemented a lazy-initialization mechanism
>> for the virtqueues and other config space contents,
>> it would store all configurations that passed down from the userspace,
>> then load them to the device config space upon DRIVER_OK.
>>
>> This can not serve live migration, so this series implement an
>> immediate initialization mechanism, which means rather than the
>> former store-load process, the virtio operations like vq ops
>> would take immediate actions by access the virtio registers.
>>
>> This series also implement irq synchronization in the reset
>> routine
>
> Please, prefix each patch subject with vDPA/ifcvf:
I will fix this in V2. Thanks
>
>
>> Zhu Lingshan (5):
>>    virt queue ops take immediate actions
>>    get_driver_features from virito registers
>>    retire ifcvf_start_datapath and ifcvf_add_status
>>    synchronize irqs in the reset routine
>>    a vendor driver should not set _CONFIG_S_FAILED
>>
>>   drivers/vdpa/ifcvf/ifcvf_base.c | 162 +++++++++++++++++++-------------
>>   drivers/vdpa/ifcvf/ifcvf_base.h |  16 ++--
>>   drivers/vdpa/ifcvf/ifcvf_main.c |  97 ++++---------------
>>   3 files changed, 122 insertions(+), 153 deletions(-)
>>
>> -- 
>> 2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
