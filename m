Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246D8C77B75
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 03:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A6DE441C5A;
	Wed, 17 May 2023 03:53:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A6DE441C5A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=JvDtQ4Mv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GrjeZujQVgDG; Wed, 17 May 2023 03:53:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 38FFA41C59;
	Wed, 17 May 2023 03:53:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38FFA41C59
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 086F8C0037;
	Wed, 17 May 2023 03:53:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2971C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 03:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A5BB429B0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 03:53:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A5BB429B0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j56_5_1A8--f
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 03:53:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BBCDE41C59
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BBCDE41C59
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 03:53:08 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6439f186366so166807b3a.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 20:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1684295587; x=1686887587;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=itmdkIN8S/Snq7UqRVM4GC+PuwMWErICpyh8a55mXY0=;
 b=JvDtQ4Mv53NXAi15Kn4d8PbpCm0JVoxRijfGdjmQg4Vnlv2d2aVx8H9ZE0z2dyy7JQ
 6tA642v883StlQN/OizoG+K4jTVTwsT2E9H62rF44Uq9O/2ZRHjTg8IvvbI6m0Jfkyde
 2/BKmzJ4W9XNUVohiWxIqcX4CX86oK5FxLmBzupFhmx5tCcTSIagXhf4vaxbTZ43DmSz
 AS+tSPe1qkUBHM6ACsLBBvYApFiwLax29pIeIWbbhJxHM38W8g1ovzYA0ED2a0dTEL8P
 BbisGGY7pxzRU88h9vocIjsFL6Ulnz0Itl9PIxMh0uhZxHdhOZLiNXiRk5IyrCwJtUF3
 eCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684295587; x=1686887587;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=itmdkIN8S/Snq7UqRVM4GC+PuwMWErICpyh8a55mXY0=;
 b=Qj0rBUu6VkYQyA5fnPHYUF20pPQYu8WMxmAoX8lfpLcHeVavamTmJ/uTnfwZXb0PVN
 QbUxYT8lxsSPxf+ZUbCJYfCp70E3aPp1hteV1/lRSPJMsx/Lot1O1U0X4z18SkVwBIrr
 7ijEkwwRDUfnNwMDfDN5rPlUcNWfbeLEJUCTz6r8POWW0Lu3Dl8StE0eZ5c0BcfhAoMp
 Rsu74dH+HyLMEwQtzSuat+n4wGe4ODkpGIFBKgS4roKITE46Qcqxbh9UPJSHu5ob6pvQ
 hjEhce19nPybFeIOb7KCCKmMbEKO4K0zE/ExuCZQrCrmHk/G/FxcX/ue/jaVZBIfXuhf
 a6Cw==
X-Gm-Message-State: AC+VfDwohKlx4ETvH45gN0TFwwSaLsiXPKIsKKv98uo/R4QkTNIF/XKI
 uwM4VRJC04UMJWbxBuMOGRBqyg==
X-Google-Smtp-Source: ACHHUZ7G3yKUqEwQVvWagTG2cW3EWp9bjOD5mDuiwvReZYIy6wcWQoesa1xNr8SuIUlqnp9ZFX34CA==
X-Received: by 2002:a05:6a20:9153:b0:105:dafa:fec2 with SMTP id
 x19-20020a056a20915300b00105dafafec2mr12018255pzc.53.1684295587683; 
 Tue, 16 May 2023 20:53:07 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.6]) by smtp.gmail.com with ESMTPSA id
 n24-20020a17090ac69800b0024499d4b72esm384115pjt.51.2023.05.16.20.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 20:53:07 -0700 (PDT)
Message-ID: <8f3ca136-0276-49ca-d703-715c83cff557@bytedance.com>
Date: Wed, 17 May 2023 11:51:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: [PATCH v2 0/2] virtio: abstract virtqueue related methods
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230516234444-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230516234444-mutt-send-email-mst@kernel.org>
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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
From: zhenwei pi via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: zhenwei pi <pizhenwei@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 5/17/23 11:46, Michael S. Tsirkin wrote:
> On Wed, May 17, 2023 at 10:54:22AM +0800, zhenwei pi wrote:
>> v1 -> v2:
>> - Suggested by MST, use fast path for vring based performance
>> sensitive API.
>> - Reduce changes in tools/virtio.
>>
>> Add test result(no obvious change):
>> Before:
>> time ./vringh_test --parallel
>> Using CPUS 0 and 191
>> Guest: notified 10036893, pinged 68278
>> Host: notified 68278, pinged 3093532
>>
>> real	0m14.463s
>> user	0m6.437s
>> sys	0m8.010s
>>
>> After:
>> time ./vringh_test --parallel
>> Using CPUS 0 and 191
>> Guest: notified 10036709, pinged 68347
>> Host: notified 68347, pinged 3085292
>>
>> real	0m14.196s
>> user	0m6.289s
>> sys	0m7.885s
>>
>> v1:
>> Hi,
>>
>> 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
>> https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
>>
>> Jason and Stefan pointed out that a non-vring based virtqueue has a
>> chance to overwrite virtqueue instead of using vring virtqueue.
>>
>> Then I try to abstract virtqueue related methods in this series, the
>> details changes see the comment of patch 'virtio: abstract virtqueue related methods'.
>>
>> Something is still remained:
>> - __virtqueue_break/__virtqueue_unbreak is supposed to use by internal
>>    virtio core, I'd like to rename them to vring_virtqueue_break
>>    /vring_virtqueue_unbreak. Is this reasonable?
> 
> Why? These just set a flag?
> 

Rename '__virtqueue_break' to 'vring_virtqueue_break', to make symbols 
exported from virtio_ring.ko have unified prefix 'vring_virtqueue_xxx'.

>> - virtqueue_get_desc_addr/virtqueue_get_avail_addr/virtqueue_get_used_addr
>>    /virtqueue_get_vring is vring specific, I'd like to rename them like
>>    vring_virtqueue_get_desc_addr. Is this reasonable?
>> - there are still some functions in virtio_ring.c with prefix *virtqueue*,
>>    for example 'virtqueue_add_split', just keep it or rename it to
>>    'vring_virtqueue_add_split'?
>> zhenwei pi (2):
>>    virtio: abstract virtqueue related methods
>>    tools/virtio: implement virtqueue in test
>>
>>   drivers/virtio/virtio_ring.c | 285 +++++-----------------
>>   include/linux/virtio.h       | 441 +++++++++++++++++++++++++++++++----
>>   include/linux/virtio_ring.h  |  26 +++
>>   tools/virtio/linux/virtio.h  | 355 +++++++++++++++++++++++++---
>>   4 files changed, 807 insertions(+), 300 deletions(-)
>>
>> -- 
>> 2.20.1
> 

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
