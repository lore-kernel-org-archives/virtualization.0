Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09DCC433EF
	for <virtualization@archiver.kernel.org>; Fri,  4 Feb 2022 14:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8110F40510;
	Fri,  4 Feb 2022 14:25:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lP-GSc4QW6fe; Fri,  4 Feb 2022 14:25:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A779F404DD;
	Fri,  4 Feb 2022 14:25:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D950C001A;
	Fri,  4 Feb 2022 14:25:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 575B4C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 14:25:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37E3940880
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 14:25:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s-rnwUaFgRYK
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 14:25:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7046F40865
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643984720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8T52awEwxca8WL8O3lEYEvOUcGZcA+Yjruzs8DUoxRg=;
 b=ahYZioSekvYAad/ZpVlRj3/ZkjJ+V3lmQUIEhynuJssRr0jn8sldRCzZOoa57+lhJTr/LR
 s0/pVgCW2QZg3oJJdqvVf7Kw4OWcZtxei8vrjkRj/zyA4unPAoq9inMvDNv9URXI2o/s6K
 wG9oP9t71XzR3mp5GIgMpVyWrwprYhg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-w84k4xWYOeyhIfEugC4Ivw-1; Fri, 04 Feb 2022 09:25:17 -0500
X-MC-Unique: w84k4xWYOeyhIfEugC4Ivw-1
Received: by mail-wm1-f69.google.com with SMTP id
 l20-20020a05600c1d1400b0035153bf34c3so7655009wms.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Feb 2022 06:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=8T52awEwxca8WL8O3lEYEvOUcGZcA+Yjruzs8DUoxRg=;
 b=qN6zfWg8dNqU4zVyeghpk1lpMxK0+HTdckhKAcxdkFfDoFdg2PAKKmcRvlQaHw3pO/
 uJjHoshxKlijlIc5dr3x79e4Hk8VmQsSIi3lP6uQn/eO62B7hzCUiC/mD9Dyvl7ORy3I
 aLAGfrJe4ZMRUyewMI9EdoIwR0onvunEr2x0r9ygYCp1KtpuKrIpS48VbNnxmJQJaZKz
 ocXgE7yrwz1NPjMXJ66Qn77Y9rU0FxNDklcyOIDPERtpmIVF1Q2c4FLb2YH6KUSXGmGx
 KOnwW9sZrt0DSyw86teZvS4Cx24Ozx/Y+I2Y3q6mcfn9SgIJQe8EDWI3o+1pEY7fvGrR
 3lBA==
X-Gm-Message-State: AOAM531yoEPyiICik+RQRf4TNeV26fF5IsPWi4LwNQhSy6ac6wN82FSc
 lx9v4xb1ev54vvdzrMwRlELK9mrL2YtFavAvYaW/EPsecRO3vNDYBwKhz0Ub6uzlINO7+UGZLTI
 oHyL6aQvjczS5YhuP6zIYepqCMFr6GleojbmAB6J/hQ==
X-Received: by 2002:a7b:cb94:: with SMTP id m20mr1684466wmi.46.1643984715947; 
 Fri, 04 Feb 2022 06:25:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzX/5aeYxhewXc9d0DJ5IzUyqxPlfrQ4DEozgsgztrqQNNyQgoU0WWP1QWP7pNyHH/vpCbR9A==
X-Received: by 2002:a7b:cb94:: with SMTP id m20mr1684449wmi.46.1643984715657; 
 Fri, 04 Feb 2022 06:25:15 -0800 (PST)
Received: from ?IPV6:2003:d8:2f11:9700:838c:3860:6500:5284?
 (p200300d82f119700838c386065005284.dip0.t-ipconnect.de.
 [2003:d8:2f11:9700:838c:3860:6500:5284])
 by smtp.gmail.com with ESMTPSA id a24sm9574927wmm.31.2022.02.04.06.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Feb 2022 06:25:15 -0800 (PST)
Message-ID: <f1314427-92ab-5b0e-d040-96e15bdb2aa4@redhat.com>
Date: Fri, 4 Feb 2022 15:25:14 +0100
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
 <45a4987f-3a87-8c04-73a9-3ae68fafffcd@redhat.com>
 <20220204090403-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220204090403-mutt-send-email-mst@kernel.org>
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

On 04.02.22 15:04, Michael S. Tsirkin wrote:
> On Fri, Feb 04, 2022 at 02:29:39PM +0100, David Hildenbrand wrote:
>> On 04.02.22 14:24, Michael S. Tsirkin wrote:
>>> On Wed, Jan 19, 2022 at 09:35:05AM +0100, David Hildenbrand wrote:
>>>> On 19.01.22 08:46, Gavin Shan wrote:
>>>>> Hi Michael,
>>>>>
>>>>> On 1/19/22 3:39 PM, Michael S. Tsirkin wrote:
>>>>>> On Wed, Jan 19, 2022 at 09:05:51AM +0800, Gavin Shan wrote:
>>>>>>> This enables virtio-mem device support by allowing to enable the
>>>>>>> corresponding kernel config option (CONFIG_VIRTIO_MEM) on the
>>>>>>> architecture.
>>>>>>>
>>>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>>>>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>>> ---
>>>>>>> v3: Pick ack-by tags from Jonathan and Michael
>>>>>>> ---
>>>>>>>   drivers/virtio/Kconfig | 7 ++++---
>>>>>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>>>>>>> index 34f80b7a8a64..74c8b0c7bc33 100644
>>>>>>> --- a/drivers/virtio/Kconfig
>>>>>>> +++ b/drivers/virtio/Kconfig
>>>>>>> @@ -106,7 +106,7 @@ config VIRTIO_BALLOON
>>>>>>>   config VIRTIO_MEM
>>>>>>>   	tristate "Virtio mem driver"
>>>>>>>   	default m
>>>>>>> -	depends on X86_64
>>>>>>> +	depends on X86_64 || ARM64
>>>>>>>   	depends on VIRTIO
>>>>>>>   	depends on MEMORY_HOTPLUG
>>>>>>>   	depends on MEMORY_HOTREMOVE
>>>>>>> @@ -116,8 +116,9 @@ config VIRTIO_MEM
>>>>>>>   	 This driver provides access to virtio-mem paravirtualized memory
>>>>>>>   	 devices, allowing to hotplug and hotunplug memory.
>>>>>>>   
>>>>>>> -	 This driver was only tested under x86-64, but should theoretically
>>>>>>> -	 work on all architectures that support memory hotplug and hotremove.
>>>>>>> +	 This driver was only tested under x86-64 and arm64, but should
>>>>>>> +	 theoretically work on all architectures that support memory hotplug
>>>>>>> +	 and hotremove.
>>>>>>>   
>>>>>>
>>>>>> BTW isn't there a symbol saying "memory hotplug" that we can depend on?
>>>>>>
>>>>
>>>> You mean
>>>>
>>>>  	depends on MEMORY_HOTPLUG
>>>>  	depends on MEMORY_HOTREMOVE
>>>>
>>>> We still need a manual opt-in from architectures, because devil's in the
>>>> detail. (e.g., memblock stuff we had to adjust)
>>>
>>> Is there any chance of documenting some of this here? The current comment makes it
>>> look like it's just a question of whitelisting an architecture.
>>
>> I can send a patch to add more details.
> 
> oks so that will be a patch on top?

Yes, it's independent of arm64 support.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
