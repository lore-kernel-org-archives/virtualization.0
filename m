Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527DDC77B75
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 05:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6BDB4163E;
	Wed, 17 May 2023 05:00:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6BDB4163E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Y52AyCLs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nPEdGPJ620xP; Wed, 17 May 2023 05:00:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9982641600;
	Wed, 17 May 2023 05:00:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9982641600
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D372C0036;
	Wed, 17 May 2023 05:00:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40324C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D8CB81F6C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:00:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D8CB81F6C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com
 header.a=rsa-sha256 header.s=google header.b=Y52AyCLs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1RUlrU3SDl9K
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:00:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F31281F41
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F31281F41
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:00:15 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ae3fe67980so4591125ad.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 22:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1684299614; x=1686891614;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P0ayuQD1yG3R2Gd1MnzlrpUhS5iphVyxpsIrxm7q4sE=;
 b=Y52AyCLsbM4D/d67PD1bGzQZQoDlM3aHciAN1wrkyvnxm+Dn/vJhGSM1m1NJ8EZDdK
 sow8BXGsaLRPY50OiP8OBKQA3e0pB236P+5WExJr9yAJGZezvwKGm0lvVyt6G3Gjk4At
 FJRp5WjvDIjpeBi2ZSVC8gjxR9I2KrvqN6shK4SjY4tCvUtCKAL84GsNvVAkZ0r5rtcg
 605IaqoC07Wp4/mMDGp/U5LsjWQlwuCuJalwAw4GjgaXptnzyN2S+I5Z2Pk2OPtRdemu
 vk0YWUSAOmbJAgf9uE8LkzdKkEh1dWFgXABpbJqxcAV/2wLV9fmRQBvDF0A33Awl/uQ2
 b3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684299614; x=1686891614;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P0ayuQD1yG3R2Gd1MnzlrpUhS5iphVyxpsIrxm7q4sE=;
 b=SAHWgrE2CStoiCRI4m3qMrFiuVLuMuxe5tbrjepefpHqaJps+AJ7pFjCqXSfEA61KB
 enE+EsMIp4iql5/87Rwxem5UFKeFSYdHZ6Q+FE2whJoWjX7Z+iGWANeu/Yfp+SQinE+k
 GK3kyxgR1J3IHSfAIciOqm/TfZ5QPSOR1yH3D4G4mN45EqekVuSY0JcUjnzahimf361H
 zsjzebv8ZP5//4PZeWVZ8eLsr5TmCqH8ZmyJvKJdFE282Z35dAxB/2vfmbm8Q1xQlXDO
 Wl2Xiv4Y9LKvghLJoKJd1Gam7Ul3ia3+Z761JZDG+I7gQwYGQj7mkzmzYCQpbEFcmcAq
 lWkQ==
X-Gm-Message-State: AC+VfDyL4QWpEAAU/3Qx6Pw9dzWImr6iKOugHnk3P8Uo7h1O2F1xxOSk
 HEVali9AccUQHnzqFhk/sWd3FQ==
X-Google-Smtp-Source: ACHHUZ6UYgglmLRIeq+ymAQ0bT5ay0/DQJupZCh6QNbX/GBM1JVcTKNYewM68/CWfoTimBrPnuwinA==
X-Received: by 2002:a17:903:124f:b0:1ac:451d:34a with SMTP id
 u15-20020a170903124f00b001ac451d034amr52262835plh.33.1684299614560; 
 Tue, 16 May 2023 22:00:14 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.8]) by smtp.gmail.com with ESMTPSA id
 b20-20020a17090a8c9400b0024e1172c1d3sm524407pjo.32.2023.05.16.22.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 22:00:14 -0700 (PDT)
Message-ID: <949dd4db-89ea-4331-5fa7-700f96874ab3@bytedance.com>
Date: Wed, 17 May 2023 12:58:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: Re: [PATCH v2 0/2] virtio: abstract virtqueue related methods
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230516234444-mutt-send-email-mst@kernel.org>
 <8f3ca136-0276-49ca-d703-715c83cff557@bytedance.com>
 <20230516235541-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230516235541-mutt-send-email-mst@kernel.org>
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

On 5/17/23 11:57, Michael S. Tsirkin wrote:
> On Wed, May 17, 2023 at 11:51:03AM +0800, zhenwei pi wrote:
>>
>>
>> On 5/17/23 11:46, Michael S. Tsirkin wrote:
>>> On Wed, May 17, 2023 at 10:54:22AM +0800, zhenwei pi wrote:
>>>> v1 -> v2:
>>>> - Suggested by MST, use fast path for vring based performance
>>>> sensitive API.
>>>> - Reduce changes in tools/virtio.
>>>>
>>>> Add test result(no obvious change):
>>>> Before:
>>>> time ./vringh_test --parallel
>>>> Using CPUS 0 and 191
>>>> Guest: notified 10036893, pinged 68278
>>>> Host: notified 68278, pinged 3093532
>>>>
>>>> real	0m14.463s
>>>> user	0m6.437s
>>>> sys	0m8.010s
>>>>
>>>> After:
>>>> time ./vringh_test --parallel
>>>> Using CPUS 0 and 191
>>>> Guest: notified 10036709, pinged 68347
>>>> Host: notified 68347, pinged 3085292
>>>>
>>>> real	0m14.196s
>>>> user	0m6.289s
>>>> sys	0m7.885s
>>>>
>>>> v1:
>>>> Hi,
>>>>
>>>> 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
>>>> https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
>>>>
>>>> Jason and Stefan pointed out that a non-vring based virtqueue has a
>>>> chance to overwrite virtqueue instead of using vring virtqueue.
>>>>
>>>> Then I try to abstract virtqueue related methods in this series, the
>>>> details changes see the comment of patch 'virtio: abstract virtqueue related methods'.
>>>>
>>>> Something is still remained:
>>>> - __virtqueue_break/__virtqueue_unbreak is supposed to use by internal
>>>>     virtio core, I'd like to rename them to vring_virtqueue_break
>>>>     /vring_virtqueue_unbreak. Is this reasonable?
>>>
>>> Why? These just set a flag?
>>>
>>
>> Rename '__virtqueue_break' to 'vring_virtqueue_break', to make symbols
>> exported from virtio_ring.ko have unified prefix 'vring_virtqueue_xxx'.
> 
> I just do not see why you need these callbacks at all.
> 

I use these callbacks for break/unbreak device like:
static inline void virtio_break_device(struct virtio_device *dev)
{
	struct virtqueue *vq;

	spin_lock(&dev->vqs_list_lock);
	list_for_each_entry(vq, &dev->vqs, list) {
		vq->__break(vq);
	}
	spin_unlock(&dev->vqs_list_lock);
}

>>>> - virtqueue_get_desc_addr/virtqueue_get_avail_addr/virtqueue_get_used_addr
>>>>     /virtqueue_get_vring is vring specific, I'd like to rename them like
>>>>     vring_virtqueue_get_desc_addr. Is this reasonable?
>>>> - there are still some functions in virtio_ring.c with prefix *virtqueue*,
>>>>     for example 'virtqueue_add_split', just keep it or rename it to
>>>>     'vring_virtqueue_add_split'?
>>>> zhenwei pi (2):
>>>>     virtio: abstract virtqueue related methods
>>>>     tools/virtio: implement virtqueue in test
>>>>
>>>>    drivers/virtio/virtio_ring.c | 285 +++++-----------------
>>>>    include/linux/virtio.h       | 441 +++++++++++++++++++++++++++++++----
>>>>    include/linux/virtio_ring.h  |  26 +++
>>>>    tools/virtio/linux/virtio.h  | 355 +++++++++++++++++++++++++---
>>>>    4 files changed, 807 insertions(+), 300 deletions(-)
>>>>
>>>> -- 
>>>> 2.20.1
>>>
>>
>> -- 
>> zhenwei pi
> 

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
