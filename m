Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BCAC433EF
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 10:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B12860D7F;
	Tue, 18 Jan 2022 10:49:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G-pCqwzuVWKc; Tue, 18 Jan 2022 10:49:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9F57A60D7B;
	Tue, 18 Jan 2022 10:49:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75B57C0039;
	Tue, 18 Jan 2022 10:49:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C023C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 10:49:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68C1D400C6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 10:49:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zqTZQQ8u1hth
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 10:49:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 814BA405EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 10:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642502943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkqm1p+o0L8V/MwAjXFvYiWEzassQNie9wlusNTXpbI=;
 b=J0VAwoJpn3F0r021/UrMus0Ob7W4ehQH4SCjdMGgioz7ih0fJBlu2ZTCuO45pu3+X8sQaS
 kNJHIBE1JaHnDX+0yjDSHa6Tus2wQW7RJC9FHmMXNuaUb3QTZQRw4wr/5PsmrZX4VxIx97
 zyU7+T7dHamYt/mNILgM94HglT5Kw3M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-lmmEqjqbMDCwuVaAGw7SgA-1; Tue, 18 Jan 2022 05:49:02 -0500
X-MC-Unique: lmmEqjqbMDCwuVaAGw7SgA-1
Received: by mail-wm1-f70.google.com with SMTP id
 r131-20020a1c4489000000b0034d5c66d8f5so756515wma.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 02:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=lkqm1p+o0L8V/MwAjXFvYiWEzassQNie9wlusNTXpbI=;
 b=zh/BDMshAaw23ZcgjA/IiqOES/NaHc7340GI/duYyKt9Ex0oI24/k91Gj5N45PO7fx
 6jLTQDqt+bEQ1GpGr1gpD/ddIq6du8DAdVym4syeDg/IIhxCa33j2mTVYMbd4Rf7GsvE
 pW5xhY4uf5yAgTVU5Mh1wh8tdffe+stULDq2JMk1UWwuNI/9PFdPaEoQSt/F+6cBth/u
 uraFfXxeKMU0g4D3NJrpnFuQ02Aw7thlnxRcxOUcJm/EOpo08oxr6GmwL14eq2Z0Bx7N
 OErLxtEmlPBk2mz+AML7i+0tAdkHxmjbYjubgqAq4TtVjqzAH7TIxOhbsIhhCE/pd8y3
 LClQ==
X-Gm-Message-State: AOAM533xVBoqWvS++Olijo+Dyre7P9lnNYb4iyBLYsqAfeO2VVL1gJtK
 BmW8vW9Fhhprpga7wXz7nrIdJrLOhvvL00dmYs7PM0h2AxI4NbAp7hCjEIK0KP5tAvs6nyBN5kq
 plK+1e4HzpDV5PcvZ3jaMKp1U6UyDB8a/GrhbgckUkg==
X-Received: by 2002:a05:6000:1885:: with SMTP id
 a5mr23204978wri.588.1642502941053; 
 Tue, 18 Jan 2022 02:49:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvDplgxKiyIsiEvkUKA+DBk+Xj7oVKM1NVeYGaWAiNp+aMGfvSAYD73zv5J6nH0Y0hHMeFtA==
X-Received: by 2002:a05:6000:1885:: with SMTP id
 a5mr23204964wri.588.1642502940868; 
 Tue, 18 Jan 2022 02:49:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:2500:5b4d:fa8e:5311:1e28?
 (p200300cbc70c25005b4dfa8e53111e28.dip0.t-ipconnect.de.
 [2003:cb:c70c:2500:5b4d:fa8e:5311:1e28])
 by smtp.gmail.com with ESMTPSA id o4sm2734099wmq.41.2022.01.18.02.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jan 2022 02:49:00 -0800 (PST)
Message-ID: <14fa24d9-8147-25a5-7f5c-d8ac403f3fd8@redhat.com>
Date: Tue, 18 Jan 2022 11:48:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] drivers/virtio: Enable virtio mem for ARM64
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220118013431.167347-1-gshan@redhat.com>
 <4fe8127e-6e24-64bd-c53b-bf4ffa15b4b4@redhat.com>
 <20220118054210-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220118054210-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, shan.gavin@gmail.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 18.01.22 11:43, Michael S. Tsirkin wrote:
> On Tue, Jan 18, 2022 at 09:38:21AM +0100, David Hildenbrand wrote:
>> On 18.01.22 02:34, Gavin Shan wrote:
>>> This enables virtio-mem device support by allowing to enable the
>>> corresponding kernel config option (CONFIG_VIRTIO_MEM) on the
>>> architecture.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>  drivers/virtio/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>>> index 34f80b7a8a64..bf3f6ebdaa3b 100644
>>> --- a/drivers/virtio/Kconfig
>>> +++ b/drivers/virtio/Kconfig
>>> @@ -106,7 +106,7 @@ config VIRTIO_BALLOON
>>>  config VIRTIO_MEM
>>>  	tristate "Virtio mem driver"
>>>  	default m
>>> -	depends on X86_64
>>> +	depends on X86_64 || ARM64
>>>  	depends on VIRTIO
>>>  	depends on MEMORY_HOTPLUG
>>>  	depends on MEMORY_HOTREMOVE
>>
>> With MEMBLOCK_DRIVER_MANAGED in place upstream, kexec should be fine.
>>
>>
>> Can you adjust/rephrase the comment as well? Like
>>
>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>> index 34f80b7a8a64..88028ca01c8f 100644
>> --- a/drivers/virtio/Kconfig
>> +++ b/drivers/virtio/Kconfig
>> @@ -116,8 +116,9 @@ config VIRTIO_MEM
>>          This driver provides access to virtio-mem paravirtualized memory
>>          devices, allowing to hotplug and hotunplug memory.
>>  
>> -        This driver was only tested under x86-64, but should theoretically
>> -        work on all architectures that support memory hotplug and hotremove.
>> +        This driver was only tested under x86-64 and arm64, but should
>> +        theoretically work on all architectures that support memory hotplug and
>> +        hotremove.
>>  
>>          If unsure, say M.
>>  
>>
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> with this:
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> I guess I will merge this? It's a small change so - let's go for this
> release straight away?

Yes, no need to wait for the next cycle.


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
