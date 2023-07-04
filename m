Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC320EB64D9
	for <virtualization@archiver.kernel.org>; Tue,  4 Jul 2023 07:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38A4B60BDC;
	Tue,  4 Jul 2023 07:46:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 38A4B60BDC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=IiFnQ6k4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Odif9D5GS5ka; Tue,  4 Jul 2023 07:46:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9139C608A6;
	Tue,  4 Jul 2023 07:46:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9139C608A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52464C0072;
	Tue,  4 Jul 2023 07:46:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FA6FC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 07:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DAC074049F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 07:46:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAC074049F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com
 header.a=rsa-sha256 header.s=google header.b=IiFnQ6k4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RrHVI_Azpdu7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 07:46:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC627403C9
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC627403C9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 07:46:27 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-51b4ef5378bso3905915a12.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Jul 2023 00:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1688456787; x=1691048787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IVJjknruJb91ILVpOuTcCRbdbnC4UY5wlBTxHKWCG44=;
 b=IiFnQ6k4jSqvVtGDd37kR9HS1IRREBh0LWHshQDJC0J8UoQ6OCjcMpnEs3y9vZBHcz
 RsTQVzP5dplWmuOHkwLoOnMkIABilANtpzn39ZeLtfHtIvtBZQuuUWD39eKjy5mvvfVw
 Ew73LL9qg+ZOAemXXv1xghzPTRoLttpAyt2ZOUAkRmXDfDysbX7+idCxaxjX57+pjUl5
 Gg+l+mkDLNF0khSu6m+l9PiIvnkNrwNpnW2rGUOaaCDbUz+iobgw9h6uEeOvzwwVBsBO
 YaRxIyweZ9WulbS00uvDzLDQ62z6gmyLAHMG4XxObCaPkGXFrotOOwFolgFKUGrfJ2Cf
 BeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688456787; x=1691048787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IVJjknruJb91ILVpOuTcCRbdbnC4UY5wlBTxHKWCG44=;
 b=NTnrG6I/RunjBUi0byZWT457DF1dnU7BMKErZERx2qNxAf4C4zC/x8V1+EIg8SnF8j
 9H9kyvQ1x9iG4VjceGFJgLyDUEjK7BrRT0ARkHlCDtG6LsNBpXeReJeTxHMIjV0zuZCK
 m6+VC1sVMbSjqyJNnmlxTQZpFXzaK5XJVgYrEsGTFoJWTVQfLoNxs4obDPIkfcRUG67z
 WFF6aKzAykXqo4DumdBZ4G0ZDgrJ8oQSTpjQ5IQlorTdwkhNlpfDZhb2XlR6vLo43YUS
 CMnvFbDHUv+W+OyejAx0w8vBfzD/ZD4ECxcgiofD0OBcsHMb8xwM7hRVZ7DUSpSMx3kL
 eWrQ==
X-Gm-Message-State: ABy/qLZJLJ+cNPey1ZU0zIIe1U6tJiTJOCDF2rKSA26BHUM6+FIzaQmF
 5Fls5ahEdRga7Ww3kH+TAeVtDw==
X-Google-Smtp-Source: APBJJlF43xSytPxPqxmGeaHTubWssn8yi2AZhYVjZZJvdpJJKnSdgyJW/0FUJfHMqBm1tTkdsgm40w==
X-Received: by 2002:a17:90a:e54f:b0:262:f449:4497 with SMTP id
 ei15-20020a17090ae54f00b00262f4494497mr13001266pjb.2.1688456786888; 
 Tue, 04 Jul 2023 00:46:26 -0700 (PDT)
Received: from [10.255.136.59] ([139.177.225.236])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a17090a68c900b0025bf1ea918asm16239528pjj.55.2023.07.04.00.46.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 00:46:26 -0700 (PDT)
Message-ID: <334e0fb2-f070-fa80-550c-bfd9d2886fa6@bytedance.com>
Date: Tue, 4 Jul 2023 15:46:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
 <20230704020935-mutt-send-email-mst@kernel.org>
Content-Language: en-US
In-Reply-To: <20230704020935-mutt-send-email-mst@kernel.org>
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



On 7/4/23 14:21, Michael S. Tsirkin wrote:
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
> 
> Took a while for me to get this, it's confusing.  I think the issue is
> really in virtio blk, so I would just change max_size there to size_t
> and be done with it.
> 
> 

Fine.

> 
> 
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
