Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D734BC433F5
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 09:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C69D60D76;
	Tue, 18 Jan 2022 09:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4T5lBxAOLyp5; Tue, 18 Jan 2022 09:34:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1004E60D6B;
	Tue, 18 Jan 2022 09:34:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3111C0031;
	Tue, 18 Jan 2022 09:34:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E53FBC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 09:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D3C11408DF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 09:34:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MnMicJW57vQX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 09:34:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F8DE408D5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 09:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642498450;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3hNiXnrj4IaurDgV0eKpBDVjnpYyu+wQUiSTgzrSlIo=;
 b=QHMSn0nIolhnZyAQZc7/bhqCRmLDHLNw1JLfqnsaZYWd8cx7USeNUREBkp1djrwKyBr/gO
 2bHZRogDY3PTV4EqkyboPrcqS9+Db/6gwlveKhjdlKZcX9jT6r/VoYmyzb8QmqgP4L+Ya6
 Rn2brrdgcxkiwRrsaD748bwuYFHD+Xc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-fJILnFj3NK2AOzS6exgimg-1; Tue, 18 Jan 2022 04:34:07 -0500
X-MC-Unique: fJILnFj3NK2AOzS6exgimg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F29BD1023F4E;
 Tue, 18 Jan 2022 09:34:05 +0000 (UTC)
Received: from [10.72.13.118] (ovpn-13-118.pek2.redhat.com [10.72.13.118])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C2EB1F305;
 Tue, 18 Jan 2022 09:34:02 +0000 (UTC)
Subject: Re: [PATCH] drivers/virtio: Enable virtio mem for ARM64
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20220118013431.167347-1-gshan@redhat.com>
 <4fe8127e-6e24-64bd-c53b-bf4ffa15b4b4@redhat.com>
 <85df7add-993c-2100-4a74-eb5bfa661e09@redhat.com>
 <20220118092249.0000358c@Huawei.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <725ea1be-618e-cc5c-514c-34d0fcc695b8@redhat.com>
Date: Tue, 18 Jan 2022 17:33:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220118092249.0000358c@Huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gshan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org,
 "Michael S . Tsirkin" <mst@redhat.com>, shan.gavin@gmail.com
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

On 1/18/22 5:22 PM, Jonathan Cameron wrote:
> On Tue, 18 Jan 2022 16:42:55 +0800
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> On 1/18/22 4:38 PM, David Hildenbrand wrote:
>>> On 18.01.22 02:34, Gavin Shan wrote:
>>>> This enables virtio-mem device support by allowing to enable the
>>>> corresponding kernel config option (CONFIG_VIRTIO_MEM) on the
>>>> architecture.
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> 
> Probably wroth a +CC for linux-arm-kernel@lists.infradead.org
> so a wider crowd have visibility.
> 

Yes, but v2 was posted. Let me reply to v2 to include
linux-arm-kernel@lists.infradead.org.

Thanks,
Gavin

>>>> ---
>>>>    drivers/virtio/Kconfig | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>>>> index 34f80b7a8a64..bf3f6ebdaa3b 100644
>>>> --- a/drivers/virtio/Kconfig
>>>> +++ b/drivers/virtio/Kconfig
>>>> @@ -106,7 +106,7 @@ config VIRTIO_BALLOON
>>>>    config VIRTIO_MEM
>>>>    	tristate "Virtio mem driver"
>>>>    	default m
>>>> -	depends on X86_64
>>>> +	depends on X86_64 || ARM64
>>>>    	depends on VIRTIO
>>>>    	depends on MEMORY_HOTPLUG
>>>>    	depends on MEMORY_HOTREMOVE
>>>
>>> With MEMBLOCK_DRIVER_MANAGED in place upstream, kexec should be fine.
>>>
>>>
>>> Can you adjust/rephrase the comment as well? Like
>>>
>>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>>> index 34f80b7a8a64..88028ca01c8f 100644
>>> --- a/drivers/virtio/Kconfig
>>> +++ b/drivers/virtio/Kconfig
>>> @@ -116,8 +116,9 @@ config VIRTIO_MEM
>>>            This driver provides access to virtio-mem paravirtualized memory
>>>            devices, allowing to hotplug and hotunplug memory.
>>>    
>>> -        This driver was only tested under x86-64, but should theoretically
>>> -        work on all architectures that support memory hotplug and hotremove.
>>> +        This driver was only tested under x86-64 and arm64, but should
>>> +        theoretically work on all architectures that support memory hotplug and
>>> +        hotremove.
>>>    
>>>            If unsure, say M.
>>>    
>>>
>>>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>    
>>
>> Yup, It was obviously missed from the original patch. v2 will include the changes.
>>
>> Thanks,
>> Gavin
>>
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
