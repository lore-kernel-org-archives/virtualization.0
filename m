Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD966C7EE22
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 03:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4192D60B8C;
	Wed, 10 May 2023 03:43:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4192D60B8C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Ljp10SFZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tZ_Fjby-qztI; Wed, 10 May 2023 03:43:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 68A0A6073F;
	Wed, 10 May 2023 03:43:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68A0A6073F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F761C0036;
	Wed, 10 May 2023 03:43:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C6F5C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0B4C846F7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:43:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0B4C846F7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com
 header.a=rsa-sha256 header.s=google header.b=Ljp10SFZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aqCzpUXyhNkm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:43:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A38DD846F6
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A38DD846F6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:43:24 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-24e4e23f378so4727723a91.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 May 2023 20:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1683690204; x=1686282204;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Up0qD8aWokjqXRs5dcKMaGJ5ZKCh0P7UibkRsSUf25A=;
 b=Ljp10SFZSoIcIMmGN3S6gsuIw9oiS0RjsKs4Mq4Q/YHzB4dZYPp4wjtmp430rj/XcN
 4JrODj8PrQe3JbS6B+L7Y54ab0Qwur7AY8UV4MeyLuVNK6zUVjxuZpFIiEmRpPqs4C3X
 JZKTVJLHO7NWb6m19jQ2mBOWdoxDesDkFP5fzg8xYMfnoq7I1HMaLElPG1pE6cojflzI
 tpDRyjnpRlG0UyRGiKTJ1YuN0ZKhA5bSi9P1sFxZ1ChR6AdDGH5LWBBXRipU/VdFPMTe
 2RpEaB2sCudM8NgIW5mqSMghS5uhypI75vmyW6K1kgnU//MYz5wkRjFEAYuI1L/SjYhP
 xSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683690204; x=1686282204;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Up0qD8aWokjqXRs5dcKMaGJ5ZKCh0P7UibkRsSUf25A=;
 b=ZaTs9bM9FtuvErzy/hOTg11Yb6h1b+4MgItfWyESo9JNDsw1k4NEW9jrF8jRyAoDDl
 lIiM+Ts2FyW6GtucGZ5N98sH9tJxymNgvfcJdMVqxxAozoCCnYT9JgoeczpuuIkgLVbO
 IYaqNM9Wi7K8Tp6i+7P1wj0w5J8fbIzlvKd/JQ4+U8d+YxpnmJiVzt1w7B8OgLj8pGDr
 UzOfPh3L+HOZmR9XSHo4DRfLlAwB6P2lyhSrQTTM0YscjBCHI2caAmZtYfzNb0D8N5D6
 cjMOv2e5d/W4Xrk55uxRk3G07C4MCEVMEOlWJg0kV7vHkR2WGIMiCB2PrzEo0nTPdUo1
 9+0w==
X-Gm-Message-State: AC+VfDwaoVu/RqePGdVgcmhQFsK8OkX7NkR86Zxffu90nspUKOrX7SKy
 O/5jLrRTsVtg87VGYSgDHvRvvQ==
X-Google-Smtp-Source: ACHHUZ501WiLNY+LiAVPIAA+oM18qukCTdb4p29DQu3Yjjsw9E6IL06ZzNEDHtEly8N/ktugz5amDQ==
X-Received: by 2002:a17:90a:5e45:b0:24b:af7d:201d with SMTP id
 u5-20020a17090a5e4500b0024baf7d201dmr16930570pji.24.1683690204061; 
 Tue, 09 May 2023 20:43:24 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.9]) by smtp.gmail.com with ESMTPSA id
 o6-20020a17090ac08600b00250ad795d72sm2193584pjs.44.2023.05.09.20.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 May 2023 20:43:23 -0700 (PDT)
Message-ID: <a19c3853-a152-253b-7ee4-de9506a22eaa@bytedance.com>
Date: Wed, 10 May 2023 11:41:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
 <20230509233929-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230509233929-mutt-send-email-mst@kernel.org>
Cc: xuanzhuo@linux.alibaba.com, Joerg Roedel <jroedel@suse.de>,
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



On 5/10/23 11:39, Michael S. Tsirkin wrote:
> On Wed, May 10, 2023 at 10:54:37AM +0800, zhenwei pi wrote:
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
> 
> 
> is this a theoretical concern or do you manage to trigger this
> somehow?
> 

I never hit any issue about this, I notice here during diving into the 
symbols exported by virtio_ring.ko.

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
> 

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
