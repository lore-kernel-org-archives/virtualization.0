Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E244C433EF
	for <virtualization@archiver.kernel.org>; Fri,  4 Feb 2022 13:29:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB58381BB0;
	Fri,  4 Feb 2022 13:29:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RZZamYQOCMzQ; Fri,  4 Feb 2022 13:29:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7367781BCF;
	Fri,  4 Feb 2022 13:29:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54ACFC0011;
	Fri,  4 Feb 2022 13:29:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05F75C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 13:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E79BA404DD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 13:29:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0KywCXju4vdc
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 13:29:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC845403AA
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 13:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643981383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cUrgC7ZPDwd9ypG7wapsAYini1Oc/WGJxsbJSS3jbuc=;
 b=Jc76oDHIesCM7zjVTE5y11NRHte+xvAGNMG+F44EF8lODhU6aAXKIP2Z/Cc7UZklyoJcfm
 JxK39UCoiSCr+/iuA40g/uJtT63g3Eb0UfkKfv/Sw1RK81zWveb22ktXOJ158hKkdfVSyI
 BL3i0J8W1GmIuZEBZkoYMAHggE2FmMM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-fYsE8DpOOdqrkwArP7vuLA-1; Fri, 04 Feb 2022 08:29:42 -0500
X-MC-Unique: fYsE8DpOOdqrkwArP7vuLA-1
Received: by mail-wr1-f72.google.com with SMTP id
 j21-20020adfa555000000b001db55dd5a1dso2024968wrb.15
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Feb 2022 05:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=cUrgC7ZPDwd9ypG7wapsAYini1Oc/WGJxsbJSS3jbuc=;
 b=vuS3bIBVGx7AL8/Sa13eHR0roEylqWjr6aBvbowWcGa/rrbMdRtcPD3YgjCHzGDKHs
 cXsKh5Lfb+axJZZAQ473kiArkR5wVIslIDC1sPAkR0MXbTJ+J+z+zXqBEhnvaojgyXFC
 +GhcdnuyissBMUztjru6tfllEOoej3rJrSI6Rz3xU8GFNxIMP+oYw8XcPor0hPk6KyAA
 iRZoXvCziw3HsFUWnLUg4gG7ZdCCpR87uMElaSX0aERG1+iBnrijR5apkNInMpjiDhpb
 ykNURikZDMy4jY1qIEQNN9rky9riIw+5e4HEriGpxULq/Un/SpCMgntEfcHvfwOT/gF0
 o/MA==
X-Gm-Message-State: AOAM530TXfKWehUrQJ6xouB9sjPu8npZZdSIHW52BEjhw178BYWkWImz
 BCFkxhqWrLrVN7cPW+kzVuGIl/t9EB8UlYGNulQMb+K7huRYPB8xcsw8dPIt631atwJ2lZwYcWM
 QszrGFO61RZUiF8N2bVwbicXHjDFQYg1BUcauJZncmw==
X-Received: by 2002:adf:e350:: with SMTP id n16mr2434164wrj.160.1643981381362; 
 Fri, 04 Feb 2022 05:29:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZ38bRNXgunml/7DCV21Ao0Pud0v5LzU8NDx1YgCFGcfR2VNHVJ0aIiHFBPjMEQbD3+T7JhQ==
X-Received: by 2002:adf:e350:: with SMTP id n16mr2434149wrj.160.1643981381134; 
 Fri, 04 Feb 2022 05:29:41 -0800 (PST)
Received: from ?IPV6:2003:d8:2f11:9700:838c:3860:6500:5284?
 (p200300d82f119700838c386065005284.dip0.t-ipconnect.de.
 [2003:d8:2f11:9700:838c:3860:6500:5284])
 by smtp.gmail.com with ESMTPSA id y6sm1461588wma.48.2022.02.04.05.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Feb 2022 05:29:40 -0800 (PST)
Message-ID: <45a4987f-3a87-8c04-73a9-3ae68fafffcd@redhat.com>
Date: Fri, 4 Feb 2022 14:29:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3] drivers/virtio: Enable virtio mem for ARM64
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220119010551.181405-1-gshan@redhat.com>
 <20220119022611-mutt-send-email-mst@kernel.org>
 <d8cedad1-bbb6-b7ea-57b2-f3832776fe1e@redhat.com>
 <50422908-1917-bda9-ead5-40b02d57c545@redhat.com>
 <20220204082351-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220204082351-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jonathan.Cameron@huawei.com, shan.gavin@gmail.com,
 linux-arm-kernel@lists.infradead.org,
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

On 04.02.22 14:24, Michael S. Tsirkin wrote:
> On Wed, Jan 19, 2022 at 09:35:05AM +0100, David Hildenbrand wrote:
>> On 19.01.22 08:46, Gavin Shan wrote:
>>> Hi Michael,
>>>
>>> On 1/19/22 3:39 PM, Michael S. Tsirkin wrote:
>>>> On Wed, Jan 19, 2022 at 09:05:51AM +0800, Gavin Shan wrote:
>>>>> This enables virtio-mem device support by allowing to enable the
>>>>> corresponding kernel config option (CONFIG_VIRTIO_MEM) on the
>>>>> architecture.
>>>>>
>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> ---
>>>>> v3: Pick ack-by tags from Jonathan and Michael
>>>>> ---
>>>>>   drivers/virtio/Kconfig | 7 ++++---
>>>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>>>>> index 34f80b7a8a64..74c8b0c7bc33 100644
>>>>> --- a/drivers/virtio/Kconfig
>>>>> +++ b/drivers/virtio/Kconfig
>>>>> @@ -106,7 +106,7 @@ config VIRTIO_BALLOON
>>>>>   config VIRTIO_MEM
>>>>>   	tristate "Virtio mem driver"
>>>>>   	default m
>>>>> -	depends on X86_64
>>>>> +	depends on X86_64 || ARM64
>>>>>   	depends on VIRTIO
>>>>>   	depends on MEMORY_HOTPLUG
>>>>>   	depends on MEMORY_HOTREMOVE
>>>>> @@ -116,8 +116,9 @@ config VIRTIO_MEM
>>>>>   	 This driver provides access to virtio-mem paravirtualized memory
>>>>>   	 devices, allowing to hotplug and hotunplug memory.
>>>>>   
>>>>> -	 This driver was only tested under x86-64, but should theoretically
>>>>> -	 work on all architectures that support memory hotplug and hotremove.
>>>>> +	 This driver was only tested under x86-64 and arm64, but should
>>>>> +	 theoretically work on all architectures that support memory hotplug
>>>>> +	 and hotremove.
>>>>>   
>>>>
>>>> BTW isn't there a symbol saying "memory hotplug" that we can depend on?
>>>>
>>
>> You mean
>>
>>  	depends on MEMORY_HOTPLUG
>>  	depends on MEMORY_HOTREMOVE
>>
>> We still need a manual opt-in from architectures, because devil's in the
>> detail. (e.g., memblock stuff we had to adjust)
> 
> Is there any chance of documenting some of this here? The current comment makes it
> look like it's just a question of whitelisting an architecture.

I can send a patch to add more details.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
