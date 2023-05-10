Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCF7C77B7C
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 07:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FA6060F25;
	Wed, 10 May 2023 07:54:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8FA6060F25
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=YaMHHRBq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ht15-cE9N84D; Wed, 10 May 2023 07:54:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AE3EF60B88;
	Wed, 10 May 2023 07:54:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE3EF60B88
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79C3CC0036;
	Wed, 10 May 2023 07:54:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4F32C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 07:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D75F83EFB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 07:54:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D75F83EFB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com
 header.a=rsa-sha256 header.s=google header.b=YaMHHRBq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NPnLXigOmrky
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 07:54:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43E1183EC5
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43E1183EC5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 07:54:15 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-643995a47f7so6936819b3a.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 00:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1683705255; x=1686297255;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7q73aRqorgOcknsCbwBW7p8VJg521sVWQzKmYQBnQok=;
 b=YaMHHRBqvYEppbP9MhGxOEuJqH2pwde8SRyoa9tntc1oCxq7iQ+Z6jHQMWQYyNlUfH
 acHzXMBdBmDaGfkjxdZqZiPQ7pbULH3tV+0JoESt2YQwhC8zYB7D5Xwe4bACkbG2bclf
 /rT4+JaAmlIp6K0OIBrat5TkqefvnGjDJqukWbvwLS5bcVnHPKyeI5YT7ABfF62erQdn
 nWlEjz9O6NZXFpihkgfzuoRn3Xt3fXCgElkkEF3h/TsiDUM8HiY+FU+EgK+1CVIdES9S
 QMg3JS7uzAdPFvOljFxfybx/ATIqXO272WGC/amB1cKOm1OFS+kfJtIsxhgd7bHx2ASZ
 /Ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683705255; x=1686297255;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7q73aRqorgOcknsCbwBW7p8VJg521sVWQzKmYQBnQok=;
 b=Jc5ZsXiurtvkbZTPqDThCMUwas5MFWVlfHasySX0PPdvDVU74UIvC8qfjQ5N8FGbEZ
 z2UNx8+TMzRI4C1+/t82Av3wRoxlAmSeuyDue6EPB2oosLGHDJgE0VHvL7Jlq9xiQ9lX
 84gTblaFzEbsrukdXK/CKqHdURlMd3FaY/2AZYcqogjqeqyJ70TA3nL+tHo10AZ5sUvx
 OZtJPZf6o9Et21+ljJTxHQKOD6J9+r/dXV9NKWaJYgxQbwHyZp7FbqVSlOSFHhUyE9Ym
 UZAYPWwrkVoaAEnTuz0znpvgy/O/Jdsdcf2NN9SSFT9tCgRqSl9syXGTKIzTjk09UMeu
 kCAg==
X-Gm-Message-State: AC+VfDxLP+6UHwSZlwHHX3x+eBpVEGlW7GFvdjSvac1XXtfaaLQHP2zh
 M1FfiR3zfqzFuo2ZQ9Q8ejwejA==
X-Google-Smtp-Source: ACHHUZ7S5mZ25pzyjyTGOW2qmzisuZigWqCxJk/tR7QPbGt6SrtGod5RsiwLeeIB3fwbCOD6tTafnw==
X-Received: by 2002:a05:6a20:918c:b0:100:28e0:6854 with SMTP id
 v12-20020a056a20918c00b0010028e06854mr14651943pzd.45.1683705255396; 
 Wed, 10 May 2023 00:54:15 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.6]) by smtp.gmail.com with ESMTPSA id
 17-20020aa79251000000b006468222af91sm2986619pfp.48.2023.05.10.00.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 May 2023 00:54:14 -0700 (PDT)
Message-ID: <8254f1bb-dfd0-5ff0-651f-7f664bca65ba@bytedance.com>
Date: Wed, 10 May 2023 15:52:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
Content-Language: en-US
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
 <1683689214.9647853-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1683689214.9647853-1-xuanzhuo@linux.alibaba.com>
Cc: Joerg Roedel <jroedel@suse.de>, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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



On 5/10/23 11:26, Xuan Zhuo wrote:
> On Wed, 10 May 2023 10:54:37 +0800, zhenwei pi <pizhenwei@bytedance.com> wrote:
>> Both split ring and packed ring use 32bits to describe the length of
>> a descriptor: see struct vring_desc and struct vring_packed_desc.
>> This means the max segment size supported by virtio is U32_MAX.
>>
>> An example of virtio_max_dma_size in virtio_blk.c:
>>    u32 v, max_size;
>>
>>    max_size = virtio_max_dma_size(vdev);  -> implicit convert
>>    err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
>>                               struct virtio_blk_config, size_max, &v);
>>    max_size = min(max_size, v);
>>
>> There is a risk during implicit convert here, once virtio_max_dma_size
>> returns 4G, max_size becomes 0.
>>
>> Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
>> Cc: Joerg Roedel <jroedel@suse.de>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   drivers/virtio/virtio_ring.c | 12 ++++++++----
>>   include/linux/virtio.h       |  2 +-
>>   2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index c5310eaf8b46..55cfecf030a1 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -289,12 +289,16 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
>>   	return false;
>>   }
>>
>> -size_t virtio_max_dma_size(const struct virtio_device *vdev)
>> +u32 virtio_max_dma_size(const struct virtio_device *vdev)
> 
> 
> LGTM
> 
> But, should we change the parameter to vq, then use the dma_dev?
> 
> @Jason
> 
> Thanks.
> 

The max DMA size is a attribute of a virtio device rather than any VQ, 
so I guess virtio_max_dma_size(const struct virtio_device *vdev) is clear.

On the other hand, if changing the parameter to vq, we need select a VQ, 
then the question is:
1, which VQ to select? VQ0 or a random one? this leads confusing.
2, The virtio spec defines: Each device can have zero or more virtqueues


> 
>>   {
>> -	size_t max_segment_size = SIZE_MAX;
>> +	u32 max_segment_size = U32_MAX;
>>
>> -	if (vring_use_dma_api(vdev))
>> -		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
>> +	if (vring_use_dma_api(vdev)) {
>> +		size_t max_dma_size = dma_max_mapping_size(vdev->dev.parent);
>> +
>> +		if (max_dma_size < max_segment_size)
>> +			max_segment_size = max_dma_size;
>> +	}
>>
>>   	return max_segment_size;
>>   }
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index b93238db94e3..1a605f408329 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -147,7 +147,7 @@ int virtio_device_restore(struct virtio_device *dev);
>>   #endif
>>   void virtio_reset_device(struct virtio_device *dev);
>>
>> -size_t virtio_max_dma_size(const struct virtio_device *vdev);
>> +u32 virtio_max_dma_size(const struct virtio_device *vdev);
>>
>>   #define virtio_device_for_each_vq(vdev, vq) \
>>   	list_for_each_entry(vq, &vdev->vqs, list)
>> --
>> 2.20.1
>>

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
