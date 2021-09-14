Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF07C433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 11:57:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23D2610FB
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 11:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B23D2610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77D0A60690;
	Tue, 14 Sep 2021 11:57:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c4YwrIbrvC8T; Tue, 14 Sep 2021 11:57:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E622F60AC6;
	Tue, 14 Sep 2021 11:57:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB6D8C0011;
	Tue, 14 Sep 2021 11:57:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF7C2C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 11:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C90FA60690
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 11:57:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7pMBTB8L4mGC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 11:57:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC33D605BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 11:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631620649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjBNsUJZhb+CoTbkZeanK9icxsVOilejMTC0HAi65SM=;
 b=in4qvABgwsEWaCZieQsxIN72obCeVdZfwb3lyUThFiobU3nwFsvZwjz6BxZ5cNhopbMzbU
 rRlYMAO3sadBibwjY/JvgYdiKg9bxo2RtlhkV2Z32P2pj3N8AgeSVlUSieifSwQXB5ZTFt
 KVw6vXKpQtdVFTWhNM1pdp7F+oRu68k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-o7LyNn6cOpCNUZ3hZjZORA-1; Tue, 14 Sep 2021 07:57:28 -0400
X-MC-Unique: o7LyNn6cOpCNUZ3hZjZORA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5-20020a1c00050000b02902e67111d9f0so6345388wma.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 04:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=kjBNsUJZhb+CoTbkZeanK9icxsVOilejMTC0HAi65SM=;
 b=N+dy5ICud9cTwNVz8Digk+Bho+uaUkQDofz1cvPZZz4ALe/X+p1hvYEp0KywRpQ+tR
 zRiNzEftNXdcdY1IqL/nDfWswrrzVrtzOPBwsX7Uij7dJCc4TtZgn3tKr7YKYeig5k2u
 s0rYbHYwgSgOBqPDmZieKT13OZFL0VJxH1Mi3q5DkN3bKJq2Yv37OIqJsAyhxoN2kU6Y
 4uPkcxURDt9pemz5huBGyY0fLrzwNfTl5S/BecsqIlW8lyy2TpU812DF/4yj6Ju/DJqL
 XcuS++78Q+KJqCyzcL/zf68PkX0DlMi3ytg66QIpxI0nitWJIW+7jvXewfaHCecBfxHm
 A/wg==
X-Gm-Message-State: AOAM531UKW0BG+IuIsCWm0yBk4eHY/509oGT53WIUCd8vJVkN6SQNBAp
 5pSroaNBpBKm8GCxQKZjSgEtgeVTmWfPy+IjYRGV0Vyb2dL+79KQ+0W5qVIHfRU3iP4NoA94zsn
 mNusKhCnsnfFhUeh08evrfEJ7kPieZ9BqjrWG+K3RzQ==
X-Received: by 2002:adf:b785:: with SMTP id s5mr18233999wre.30.1631620647008; 
 Tue, 14 Sep 2021 04:57:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+Cp51cW71Hx/HXa3ft0tf4MRVU/E3ocxIO1LloVlrNFZuxeHhOo+RIIhwRu78LdbPvR4dbQ==
X-Received: by 2002:adf:b785:: with SMTP id s5mr18233980wre.30.1631620646792; 
 Tue, 14 Sep 2021 04:57:26 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6041.dip0.t-ipconnect.de. [91.12.96.65])
 by smtp.gmail.com with ESMTPSA id
 i5sm10058563wrc.86.2021.09.14.04.57.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Sep 2021 04:57:26 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] virtio-mem: disallow mapping virtio-mem memory via
 /dev/mem
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210902160919.25683-1-david@redhat.com>
 <20210902160919.25683-4-david@redhat.com>
 <20210903025630-mutt-send-email-mst@kernel.org>
 <e5344ed1-6aaf-9e0a-a32d-f7cf69fe5a34@redhat.com>
 <20210914075046-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <cec01643-b6e4-0ba9-9c93-5c9c95939491@redhat.com>
Date: Tue, 14 Sep 2021 13:57:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914075046-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Hanjun Guo <guohanjun@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>
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

On 14.09.21 13:52, Michael S. Tsirkin wrote:
> On Tue, Sep 14, 2021 at 11:45:25AM +0200, David Hildenbrand wrote:
>> On 03.09.21 09:02, Michael S. Tsirkin wrote:
>>> On Thu, Sep 02, 2021 at 06:09:19PM +0200, David Hildenbrand wrote:
>>>> We don't want user space to be able to map virtio-mem device memory
>>>> directly (e.g., via /dev/mem) in order to have guarantees that in a sane
>>>> setup we'll never accidentially access unplugged memory within the
>>>> device-managed region of a virtio-mem device, just as required by the
>>>> virtio-spec.
>>>>
>>>> As soon as the virtio-mem driver is loaded, the device region is visible
>>>> in /proc/iomem via the parent device region. From that point on user space
>>>> is aware of the device region and we want to disallow mapping anything
>>>> inside that region (where we will dynamically (un)plug memory) until
>>>> the driver has been unloaded cleanly and e.g., another driver might take
>>>> over.
>>>>
>>>> By creating our parent IORESOURCE_SYSTEM_RAM resource with
>>>> IORESOURCE_EXCLUSIVE, we will disallow any /dev/mem access to our
>>>> device region until the driver was unloaded cleanly and removed the
>>>> parent region. This will work even though only some memory blocks are
>>>> actually currently added to Linux and appear as busy in the resource tree.
>>>>
>>>> So access to the region from user space is only possible
>>>> a) if we don't load the virtio-mem driver.
>>>> b) after unloading the virtio-mem driver cleanly.
>>>>
>>>> Don't build virtio-mem if access to /dev/mem cannot be restricticted --
>>>> if we have CONFIG_DEVMEM=y but CONFIG_STRICT_DEVMEM is not set.
>>>>
>>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>
>>>
>>>> ---
>>>>    drivers/virtio/Kconfig      | 1 +
>>>>    drivers/virtio/virtio_mem.c | 4 +++-
>>>>    2 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>>>> index ce1b3f6ec325..ff80cd03f1d1 100644
>>>> --- a/drivers/virtio/Kconfig
>>>> +++ b/drivers/virtio/Kconfig
>>>> @@ -101,6 +101,7 @@ config VIRTIO_MEM
>>>>    	depends on MEMORY_HOTPLUG_SPARSE
>>>>    	depends on MEMORY_HOTREMOVE
>>>>    	depends on CONTIG_ALLOC
>>>> +	depends on !DEVMEM || STRICT_DEVMEM
>>>>    	help
>>>>    	 This driver provides access to virtio-mem paravirtualized memory
>>>>    	 devices, allowing to hotplug and hotunplug memory.
>>>
>>> It would be nicer if there was a symbol in the MEMORY_ namespace
>>> we can depend on exported by mm and depending on !DEVMEM ||
>>> STRICT_DEVMEM.
>>>
>>> E.g.
>>>
>>> config MEMORY_EXCLUSIVE
>>>           def_bool y
>>>           depends on !DEVMEM || STRICT_DEVMEM
>>>
>>> and then in virtio
>>> 	depends on MEMORY_EXCLUSIVE
>>>
>>>
>>
>> Yes, but I'm not able to come up with an expressive name. MEMORY_EXCLUSIVE
>> can be highly misleading ...
> 
> 
> I mean ... it enables IORESOURCE_EXCLUSIVE ... but ok ...
> MEMORY_EXCLUSIVE_KERNEL_MAP ?

It enables IORESOURCE_EXCLUSIVE for IORESOURCE_SYSTEM_RAM ... and 
notably not for IORESOURCE_MEM.

MEMORY_EXCLUSIVE_SYSTEM_RAM ?

> 
>>
>>> the virtio change itself is ok though:
>>>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> Thanks!
>>
>>
>> -- 
>> Thanks,
>>
>> David / dhildenb
> 


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
