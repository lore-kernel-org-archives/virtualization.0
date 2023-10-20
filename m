Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6909AC001DF
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 02:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E95E66107D;
	Fri, 20 Oct 2023 02:28:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E95E66107D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=FEkxcrHp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IhdmvniQhOkE; Fri, 20 Oct 2023 02:28:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5002C60FA3;
	Fri, 20 Oct 2023 02:28:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5002C60FA3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15790C0071;
	Fri, 20 Oct 2023 02:28:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4F5CC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 02:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 99D3D4CB7B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 02:28:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99D3D4CB7B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com
 header.a=rsa-sha256 header.s=google header.b=FEkxcrHp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jvs9-6gS0CW4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 02:28:11 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D6B04B6DA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 02:28:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D6B04B6DA
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c9e072472bso2550235ad.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 19:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1697768890; x=1698373690;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ozb5PuMIZdsqagwbp/IYOMYWWOwC8ObSgQZuuvWYiSM=;
 b=FEkxcrHpNVaFhrztAYrqUXxfq3S54sa7ORkh+NVs/nv+wzbkyZs1HXfR8s8t5d2P92
 Jw1xN7z6YtxJP7gEJeoehRHSK27MQecsePXAl3A0a7v3jfCg+y45GDPvOgjbxRm8Q29h
 tH2wCONxmL8b3CAh36MACk/g1eXlEMAQDIi5UeyziwRo3J3zh3LNDjw9zNTCcEbxqWeT
 WmWJ5axbf1f8tgtaXD9P54jypK9bCxs/W0QqJTcDT9ZgG7V+GbrqSCIVKRrt8UTIushT
 tws7qNRh2zJFZI0oFdWV0r0e7lWS5jg/DiIIMwHEVwmhI8aZlpKR5rv63ZG5TkQsQiqH
 xEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697768890; x=1698373690;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ozb5PuMIZdsqagwbp/IYOMYWWOwC8ObSgQZuuvWYiSM=;
 b=tlruF22Q3kTPtjte44/8fDTewRJydx0Z8CZu5s3PJXRTs2jnxTssOIcMHt3s2Bpaci
 oHwvqvrdJRO4/46CrLAKD/gXQG8HxXVnL7lFPVkcjCanXUDHgmAma4QncAyI6fk9O/8I
 yLVI1FvkJqea+l4X47+mDx/HW1Ck9ADuvIjKIMiX7/nsYuS78ZV33xbQ7mTOol6+js1i
 3f3FGp1lNP1DKo5VNRF7Ee/CNaruRP+KqUXFH4SQWFHXshk0k69EZkpN8rJmNMZdKwwH
 eO4mIce83YO03vO3zSPEjqdfBHaZphzxFP7kYrEWduM5lq6j4tC/rZz2HPvDSLZNlO+r
 t6LQ==
X-Gm-Message-State: AOJu0Yyg4hBrL3f1WqJhwAt4hCmNnMtipF1VfqCmMTf0Ced8BrfEP3hI
 2IADRLfqLiijYF3bjG2RIEUMYQ==
X-Google-Smtp-Source: AGHT+IGPzSu8z7N8BOvXmKb71n1EXEIifbc7KWTuWe0hibEZb8vTw4C5raH1U6Tb9c8pVDjjjnyIJg==
X-Received: by 2002:a17:902:ea09:b0:1c5:de06:9e5a with SMTP id
 s9-20020a170902ea0900b001c5de069e5amr606142plg.21.1697768890168; 
 Thu, 19 Oct 2023 19:28:10 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.12])
 by smtp.gmail.com with ESMTPSA id
 iy20-20020a170903131400b001c5fc11c085sm384506plb.264.2023.10.19.19.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 19:28:09 -0700 (PDT)
Message-ID: <f1795a37-d615-4260-ac29-97f0d0ad3c8f@bytedance.com>
Date: Fri, 20 Oct 2023 10:23:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: PING: [PATCH] virtio-blk: fix implicit overflow on
 virtio_max_dma_size
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230904061045.510460-1-pizhenwei@bytedance.com>
 <dedde8ee-6edb-4950-aa8b-e89e025440b7@bytedance.com>
 <20231019055134-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231019055134-mutt-send-email-mst@kernel.org>
Cc: axboe@kernel.dk, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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

Cc Paolo, Stefan, Xuan and linux-block.

On 10/19/23 17:52, Michael S. Tsirkin wrote:
> On Thu, Oct 19, 2023 at 05:43:55PM +0800, zhenwei pi wrote:
>> Hi Michael,
>>
>> This seems to have been ignored as you suggested.
>>
>> LINK: https://www.spinics.net/lists/linux-virtualization/msg63015.html
> 
> Pls Cc more widely then:
> 
> Paolo Bonzini <pbonzini@redhat.com> (reviewer:VIRTIO BLOCK AND SCSI DRIVERS)
> Stefan Hajnoczi <stefanha@redhat.com> (reviewer:VIRTIO BLOCK AND SCSI DRIVERS)
> Xuan Zhuo <xuanzhuo@linux.alibaba.com> (reviewer:VIRTIO CORE AND NET DRIVERS)
> Jens Axboe <axboe@kernel.dk> (maintainer:BLOCK LAYER)
> linux-block@vger.kernel.org (open list:BLOCK LAYER)
> 
> would all be good people to ask to review this.
> 
> 
>> On 9/4/23 14:10, zhenwei pi wrote:
>>> The following codes have an implicit conversion from size_t to u32:
>>> (u32)max_size = (size_t)virtio_max_dma_size(vdev);
>>>
>>> This may lead overflow, Ex (size_t)4G -> (u32)0. Once
>>> virtio_max_dma_size() has a larger size than U32_MAX, use U32_MAX
>>> instead.
>>>
>>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>>> ---
>>>    drivers/block/virtio_blk.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>> index 1fe011676d07..4a4b9bad551e 100644
>>> --- a/drivers/block/virtio_blk.c
>>> +++ b/drivers/block/virtio_blk.c
>>> @@ -1313,6 +1313,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>>>    	u16 min_io_size;
>>>    	u8 physical_block_exp, alignment_offset;
>>>    	unsigned int queue_depth;
>>> +	size_t max_dma_size;
>>>    	if (!vdev->config->get) {
>>>    		dev_err(&vdev->dev, "%s failure: config access disabled\n",
>>> @@ -1411,7 +1412,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>>>    	/* No real sector limit. */
>>>    	blk_queue_max_hw_sectors(q, UINT_MAX);
>>> -	max_size = virtio_max_dma_size(vdev);
>>> +	max_dma_size = virtio_max_dma_size(vdev);
>>> +	max_size = max_dma_size > U32_MAX ? U32_MAX : max_dma_size;
>>>    	/* Host can optionally specify maximum segment size and number of
>>>    	 * segments. */
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
