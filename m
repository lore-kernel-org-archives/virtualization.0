Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA269C77B7D
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 06:23:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 030F76FE7D;
	Wed, 17 May 2023 06:23:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 030F76FE7D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gzfNDUbP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ovgXecMxN80Q; Wed, 17 May 2023 06:23:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5BD7060F84;
	Wed, 17 May 2023 06:23:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5BD7060F84
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30939C0036;
	Wed, 17 May 2023 06:23:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8DDBC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 06:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D79940105
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 06:23:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D79940105
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com
 header.a=rsa-sha256 header.s=google header.b=gzfNDUbP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qkaKVK3HJ4ZD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 06:23:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2209340101
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2209340101
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 06:23:14 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6439d505274so247460b3a.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 23:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1684304594; x=1686896594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S8xG/ucQIOaIYGpSjCWzsY6cnPGAUcadaAlpMAVKgmI=;
 b=gzfNDUbPPhjD5Fp/5SaloCYxFwtQf+d4QOB9BBz/TRq6p0c1tffvaWPQzOElg/ecap
 bLU/4osg+td8ASq34TGx+mJSfL0gJKs8ro3OGz6MPgL6oafoseR70kpCvBvByl2OGKrU
 +4vbxBr4K295RoNsPlLjQqk7U68panLzb83C+8caM3ZXdt3X5vCb3d26x5mzmBUvep0E
 L6nWcfq6J+r59wO9LwtlPEBN3QTaoJNDlBwvKReQdMWsSGd5R3EQWtgqHP9MddNrktGd
 f1cH0GmtFzm6YDfCncHQUz6YLRXGZ4PUtVyDTX7shZ7R93QUgY65WU6Tr0TB+qLH8TOI
 +T/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684304594; x=1686896594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S8xG/ucQIOaIYGpSjCWzsY6cnPGAUcadaAlpMAVKgmI=;
 b=NOmS4twqJpb86BQEQ4jWZV4FeVcMXKU3ZemawXqZmoEeInq++A4EZqn2edCM6s+Tqx
 ZB6R6839cX295C4Bny1Wp1wgkrzPzHqHX/bQGw6smhWfDyJsSHtV28NrjohtPuMZVe8h
 DkfgC8xfCYalKi5LdlCWEdQhlihoPgLMyYSL+QySReCiUioljgqTVS0dc/ZZ0gJivlgy
 GLkSQCBHRX88rTlu39GDcielIJBeRQF2Sa7WbxmgDFrifOkTTQ6mdlaSHvfrUmiR79RY
 GtWqxw54Phldo12mNd7jeTgh6s1M49URVOYERfa9g/U2oYs3Ve7TM6PoV/tfbXIzVtbk
 OxKw==
X-Gm-Message-State: AC+VfDyZQXqVg5c2ncGtS+y5H7787DZEfwHjtqZSHFE0oSsiOaf/EgSi
 Zwxu7oCYCSDZRz/iNtp+rKjwSQ==
X-Google-Smtp-Source: ACHHUZ4mVrADD3DWoUpYWlg+nDKr8S6jQpmPIUFciDbeMFt538Frq9eoEbThtFrKwUslbTUTgNM6kA==
X-Received: by 2002:a05:6a00:1149:b0:647:1cb7:b714 with SMTP id
 b9-20020a056a00114900b006471cb7b714mr32721060pfm.3.1684304594248; 
 Tue, 16 May 2023 23:23:14 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.13])
 by smtp.gmail.com with ESMTPSA id
 x21-20020aa784d5000000b006259e883ee9sm13919400pfn.189.2023.05.16.23.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 23:23:13 -0700 (PDT)
Message-ID: <b0b69e9d-da8a-791b-545f-c521dc752b88@bytedance.com>
Date: Wed, 17 May 2023 14:21:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: Re: Re: [PATCH v2 0/2] virtio: abstract virtqueue related
 methods
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230516234444-mutt-send-email-mst@kernel.org>
 <8f3ca136-0276-49ca-d703-715c83cff557@bytedance.com>
 <20230516235541-mutt-send-email-mst@kernel.org>
 <949dd4db-89ea-4331-5fa7-700f96874ab3@bytedance.com>
 <20230517020947-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230517020947-mutt-send-email-mst@kernel.org>
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

On 5/17/23 14:10, Michael S. Tsirkin wrote:
> On Wed, May 17, 2023 at 12:58:10PM +0800, zhenwei pi wrote:
>> On 5/17/23 11:57, Michael S. Tsirkin wrote:
>>> On Wed, May 17, 2023 at 11:51:03AM +0800, zhenwei pi wrote:
>>>>
>>>>
>>>> On 5/17/23 11:46, Michael S. Tsirkin wrote:
>>>>> On Wed, May 17, 2023 at 10:54:22AM +0800, zhenwei pi wrote:
>>>>>> v1 -> v2:
>>>>>> - Suggested by MST, use fast path for vring based performance
>>>>>> sensitive API.
>>>>>> - Reduce changes in tools/virtio.
>>>>>>
>>>>>> Add test result(no obvious change):
>>>>>> Before:
>>>>>> time ./vringh_test --parallel
>>>>>> Using CPUS 0 and 191
>>>>>> Guest: notified 10036893, pinged 68278
>>>>>> Host: notified 68278, pinged 3093532
>>>>>>
>>>>>> real	0m14.463s
>>>>>> user	0m6.437s
>>>>>> sys	0m8.010s
>>>>>>
>>>>>> After:
>>>>>> time ./vringh_test --parallel
>>>>>> Using CPUS 0 and 191
>>>>>> Guest: notified 10036709, pinged 68347
>>>>>> Host: notified 68347, pinged 3085292
>>>>>>
>>>>>> real	0m14.196s
>>>>>> user	0m6.289s
>>>>>> sys	0m7.885s
>>>>>>
>>>>>> v1:
>>>>>> Hi,
>>>>>>
>>>>>> 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
>>>>>> https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
>>>>>>
>>>>>> Jason and Stefan pointed out that a non-vring based virtqueue has a
>>>>>> chance to overwrite virtqueue instead of using vring virtqueue.
>>>>>>
>>>>>> Then I try to abstract virtqueue related methods in this series, the
>>>>>> details changes see the comment of patch 'virtio: abstract virtqueue related methods'.
>>>>>>
>>>>>> Something is still remained:
>>>>>> - __virtqueue_break/__virtqueue_unbreak is supposed to use by internal
>>>>>>      virtio core, I'd like to rename them to vring_virtqueue_break
>>>>>>      /vring_virtqueue_unbreak. Is this reasonable?
>>>>>
>>>>> Why? These just set a flag?
>>>>>
>>>>
>>>> Rename '__virtqueue_break' to 'vring_virtqueue_break', to make symbols
>>>> exported from virtio_ring.ko have unified prefix 'vring_virtqueue_xxx'.
>>>
>>> I just do not see why you need these callbacks at all.
>>>
>>
>> I use these callbacks for break/unbreak device like:
>> static inline void virtio_break_device(struct virtio_device *dev)
>> {
>> 	struct virtqueue *vq;
>>
>> 	spin_lock(&dev->vqs_list_lock);
>> 	list_for_each_entry(vq, &dev->vqs, list) {
>> 		vq->__break(vq);
>> 	}
>> 	spin_unlock(&dev->vqs_list_lock);
>> }
> 
> why do this? backend knows they are broken.
> 

I grep 'virtio_break_device' in the latest code:
arch/um/drivers/virtio_uml.c:1147:	virtio_break_device(&vu_dev->vdev);
arch/um/drivers/virtio_uml.c:1285:	virtio_break_device(&vu_dev->vdev);
drivers/crypto/virtio/virtio_crypto_core.c:269:	 
virtio_break_device(vcrypto->vdev);
drivers/s390/virtio/virtio_ccw.c:1251:			virtio_break_device(&vcdev->vdev);
drivers/s390/virtio/virtio_ccw.c:1268:		virtio_break_device(&vcdev->vdev);
drivers/firmware/arm_scmi/virtio.c:489: 
virtio_break_device(vioch->vqueue->vdev);
drivers/char/virtio_console.c:1956:	virtio_break_device(vdev);

Some virtio drivers use 'virtio_break_device'...

>>>>>> - virtqueue_get_desc_addr/virtqueue_get_avail_addr/virtqueue_get_used_addr
>>>>>>      /virtqueue_get_vring is vring specific, I'd like to rename them like
>>>>>>      vring_virtqueue_get_desc_addr. Is this reasonable?
>>>>>> - there are still some functions in virtio_ring.c with prefix *virtqueue*,
>>>>>>      for example 'virtqueue_add_split', just keep it or rename it to
>>>>>>      'vring_virtqueue_add_split'?
>>>>>> zhenwei pi (2):
>>>>>>      virtio: abstract virtqueue related methods
>>>>>>      tools/virtio: implement virtqueue in test
>>>>>>
>>>>>>     drivers/virtio/virtio_ring.c | 285 +++++-----------------
>>>>>>     include/linux/virtio.h       | 441 +++++++++++++++++++++++++++++++----
>>>>>>     include/linux/virtio_ring.h  |  26 +++
>>>>>>     tools/virtio/linux/virtio.h  | 355 +++++++++++++++++++++++++---
>>>>>>     4 files changed, 807 insertions(+), 300 deletions(-)
>>>>>>
>>>>>> -- 
>>>>>> 2.20.1
>>>>>
>>>>
>>>> -- 
>>>> zhenwei pi
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
