Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F27C433EF
	for <virtualization@archiver.kernel.org>; Wed, 19 Jan 2022 08:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F1A334052D;
	Wed, 19 Jan 2022 08:35:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qnJbEcbygeDQ; Wed, 19 Jan 2022 08:35:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3AF61400CB;
	Wed, 19 Jan 2022 08:35:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 004A9C0031;
	Wed, 19 Jan 2022 08:35:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F554C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 08:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 28A99827FB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 08:35:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ywg2A5foJrG7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 08:35:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 28234827C9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 08:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642581312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xwg+6z8AawPOjIGMCZJjM2yrr7vjC2MnyhAKdepDDaE=;
 b=gSXE5xICXCTAwjje8XZ0anH7N1VSomR5cS9KWEAfCNMNLOsMRVbpGU74P5w1pw5teI2Q5N
 gCoCmWwsPhG9y2AzdEsi5Pinil2NvNQ4OaR76jF3mm9qcu8uzNMjRjNNClbFqgPf1WxxgE
 1hRxyo+E4XbBbZ5RmjZsl0PHdwOaknc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-WOxeGjAJPEO4BZyfSLfCpA-1; Wed, 19 Jan 2022 03:35:08 -0500
X-MC-Unique: WOxeGjAJPEO4BZyfSLfCpA-1
Received: by mail-wm1-f70.google.com with SMTP id
 o193-20020a1ca5ca000000b0034d78423625so2505293wme.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 00:35:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=Xwg+6z8AawPOjIGMCZJjM2yrr7vjC2MnyhAKdepDDaE=;
 b=y5I8zdHMAQPrt6QDZE5nAkXW9fR4E603sW0eVGTffup7VrA1Er9FNiEDuB11IG2PzK
 7kGEqHOZGDqWy3BOrTdzT6kOPWK7t8vr3m16g7ZfUsUHE2HKyr4nm1ppobtK09/ni4nD
 FeWO741Skyw0YfWc06aXUrgm7NA1MnxhVHo3q0uejR5xeNlD7LtpfYsSRq0XvtRe2fWu
 pMuDa+TXl7Olmz0t+suH5tTDWm/rxp7LI53KQQz3sZYNVaczcwT9IkZnLuZ7AoK5+29l
 5DzsiXNzQbS0hjG6Ov8rF1dOq4gn3ssQPk8skw/Le0zxQunkDG/KeeM250cPwwzqJI6s
 nfKQ==
X-Gm-Message-State: AOAM531GPbAYAiz21XtbBoimpSt6tZxE6OjDgZij2fxI7zj1zxgY/jsG
 WiBe2aCYVw0tpgrsjEwSoHxxZD9oPz4FnNy2huER73asMxYM6foT3JRJPoVAI8VUjUPYss5Jnsk
 KtHpuuDic9NqMKQz5/FhJ5sfxNriVJi6/2iHIYwMQLQ==
X-Received: by 2002:adf:a59a:: with SMTP id g26mr27670178wrc.262.1642581306842; 
 Wed, 19 Jan 2022 00:35:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTmIhKuOtd47nk6Zrlrh6kBgqjouWlLPsjGVm1bhha13W17yzHj0t6lUsQDagpDxcSociXtw==
X-Received: by 2002:adf:a59a:: with SMTP id g26mr27670155wrc.262.1642581306643; 
 Wed, 19 Jan 2022 00:35:06 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:fb00:c6c0:1fe6:bfa1:e868?
 (p200300cbc705fb00c6c01fe6bfa1e868.dip0.t-ipconnect.de.
 [2003:cb:c705:fb00:c6c0:1fe6:bfa1:e868])
 by smtp.gmail.com with ESMTPSA id h8sm4873075wmq.26.2022.01.19.00.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jan 2022 00:35:06 -0800 (PST)
Message-ID: <50422908-1917-bda9-ead5-40b02d57c545@redhat.com>
Date: Wed, 19 Jan 2022 09:35:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3] drivers/virtio: Enable virtio mem for ARM64
To: Gavin Shan <gshan@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20220119010551.181405-1-gshan@redhat.com>
 <20220119022611-mutt-send-email-mst@kernel.org>
 <d8cedad1-bbb6-b7ea-57b2-f3832776fe1e@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <d8cedad1-bbb6-b7ea-57b2-f3832776fe1e@redhat.com>
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

On 19.01.22 08:46, Gavin Shan wrote:
> Hi Michael,
> 
> On 1/19/22 3:39 PM, Michael S. Tsirkin wrote:
>> On Wed, Jan 19, 2022 at 09:05:51AM +0800, Gavin Shan wrote:
>>> This enables virtio-mem device support by allowing to enable the
>>> corresponding kernel config option (CONFIG_VIRTIO_MEM) on the
>>> architecture.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>> v3: Pick ack-by tags from Jonathan and Michael
>>> ---
>>>   drivers/virtio/Kconfig | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>>> index 34f80b7a8a64..74c8b0c7bc33 100644
>>> --- a/drivers/virtio/Kconfig
>>> +++ b/drivers/virtio/Kconfig
>>> @@ -106,7 +106,7 @@ config VIRTIO_BALLOON
>>>   config VIRTIO_MEM
>>>   	tristate "Virtio mem driver"
>>>   	default m
>>> -	depends on X86_64
>>> +	depends on X86_64 || ARM64
>>>   	depends on VIRTIO
>>>   	depends on MEMORY_HOTPLUG
>>>   	depends on MEMORY_HOTREMOVE
>>> @@ -116,8 +116,9 @@ config VIRTIO_MEM
>>>   	 This driver provides access to virtio-mem paravirtualized memory
>>>   	 devices, allowing to hotplug and hotunplug memory.
>>>   
>>> -	 This driver was only tested under x86-64, but should theoretically
>>> -	 work on all architectures that support memory hotplug and hotremove.
>>> +	 This driver was only tested under x86-64 and arm64, but should
>>> +	 theoretically work on all architectures that support memory hotplug
>>> +	 and hotremove.
>>>   
>>
>> BTW isn't there a symbol saying "memory hotplug" that we can depend on?
>>

You mean

 	depends on MEMORY_HOTPLUG
 	depends on MEMORY_HOTREMOVE

We still need a manual opt-in from architectures, because devil's in the
detail. (e.g., memblock stuff we had to adjust)

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
