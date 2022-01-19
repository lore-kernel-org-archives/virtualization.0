Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29498C433EF
	for <virtualization@archiver.kernel.org>; Wed, 19 Jan 2022 01:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9124C60E6E;
	Wed, 19 Jan 2022 01:08:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c7V_FIWFvho7; Wed, 19 Jan 2022 01:08:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 166BD60E5C;
	Wed, 19 Jan 2022 01:08:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFF7BC0031;
	Wed, 19 Jan 2022 01:08:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99F38C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 01:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7ACAB40275
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 01:08:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gPeXXg1QizbW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 01:08:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B82A0401B7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 01:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642554534;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zO9+BVra9IYNNRwSo2JUNFeoG/S+PA5bDwvAJD1WNHo=;
 b=il/Q9k11dY0ICO+JWjhS6Y+I4aB7Dv8PipWEJt7OPBkT8Xe9EX0GBKgP5TphriSCKRi4XW
 0nNE7Jo049Tzw4F8cHEGkU0/fazv7t/QYlRg5ci5PrLhrRjUFoFteaC0ZUpeZbtRFfNdWM
 Bk6QQ+fQ+rXqXIIpBYDyFP8Q6j8V7v8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-TZR7x0VcMTy2Kq42sT3C_Q-1; Tue, 18 Jan 2022 20:08:53 -0500
X-MC-Unique: TZR7x0VcMTy2Kq42sT3C_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 281C42F45;
 Wed, 19 Jan 2022 01:08:52 +0000 (UTC)
Received: from [10.72.12.147] (ovpn-12-147.pek2.redhat.com [10.72.12.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98DA15D6BA;
 Wed, 19 Jan 2022 01:08:12 +0000 (UTC)
Subject: Re: [PATCH v2] drivers/virtio: Enable virtio mem for ARM64
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220118084858.175305-1-gshan@redhat.com>
 <2f0d1a5f-7e75-04b1-f2a1-f52385dae3b5@redhat.com>
 <20220118110512-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <883104a2-02a9-fc39-3898-9abdfb4490e1@redhat.com>
Date: Wed, 19 Jan 2022 09:08:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220118110512-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gshan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shan Gavin <shan.gavin@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 virtualization@lists.linux-foundation.org
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
Reply-To: Gavin Shan <gshan@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 1/19/22 12:05 AM, Michael S. Tsirkin wrote:
> On Tue, Jan 18, 2022 at 05:38:20PM +0800, Gavin Shan wrote:
>> On 1/18/22 4:48 PM, Gavin Shan wrote:
>>> This enables virtio-mem device support by allowing to enable the
>>> corresponding kernel config option (CONFIG_VIRTIO_MEM) on the
>>> architecture.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>> ---
>>> v2: Improved the comments about the kernel config option (David)
>>> ---
>>>    drivers/virtio/Kconfig | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> My git-sendemail should have been broken. A list of receivers are
>> dropped automatically though they were explicitly specified, but
>> linux-arm-kernel@lists.infradead.org was missed to be copied.
>> Fixing all of them through thunderbird :)
>>
>> Thanks,
>> Gavin
> 
> Pls bounce the original patch to me so I can queue it.
> 

Yes, Please merge the following one, which was just posted. The ack-by
tags from Jonathan and you are also added to v3.

[PATCH v3] drivers/virtio: Enable virtio mem for ARM64

Thanks,
Gavin

> 
>>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>>> index 34f80b7a8a64..74c8b0c7bc33 100644
>>> --- a/drivers/virtio/Kconfig
>>> +++ b/drivers/virtio/Kconfig
>>> @@ -106,7 +106,7 @@ config VIRTIO_BALLOON
>>>    config VIRTIO_MEM
>>>    	tristate "Virtio mem driver"
>>>    	default m
>>> -	depends on X86_64
>>> +	depends on X86_64 || ARM64
>>>    	depends on VIRTIO
>>>    	depends on MEMORY_HOTPLUG
>>>    	depends on MEMORY_HOTREMOVE
>>> @@ -116,8 +116,9 @@ config VIRTIO_MEM
>>>    	 This driver provides access to virtio-mem paravirtualized memory
>>>    	 devices, allowing to hotplug and hotunplug memory.
>>> -	 This driver was only tested under x86-64, but should theoretically
>>> -	 work on all architectures that support memory hotplug and hotremove.
>>> +	 This driver was only tested under x86-64 and arm64, but should
>>> +	 theoretically work on all architectures that support memory hotplug
>>> +	 and hotremove.
>>>    	 If unsure, say M.
>>>
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
