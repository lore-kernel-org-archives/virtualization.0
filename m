Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF7335B138
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549102; cv=none; b=euWUjse3mmG/IRkVrKaPxcpiNS64AxPfP8SYpBHsQP38iQymI2INVQwmiiNBuM2CvvivJuURAjsHd+mNLNrxO7xMmcrucbVa7gkSequ+TYmEWnX8C8ab2efVs55MGOlKgCFoi+PKBOvzkQkdYChKZ2oGPDBik1hP2xj7M6hmlSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549102; c=relaxed/simple;
	bh=et+NHrUN6S65x0cES6jWebxf6MM1u7PmMvpuO/NJb1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rG8sON0dHF6P4FJ2oiO6tAjcDdqAWl1Syrc6e2nDFC5UPo5vhvFinOtQzZNLiXs6CIGM6iYGUC88F6K8y7Vf7mQ+avBfRg2ZzULgq+abqboB5EryzHP9jzXn07uQF06JTmTsHAz3DkYyEFFD2W9GRcVO4XfSVleInkNbLle2A9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fT/o2jy+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT/o2jy+"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3598581ed7bso1003508a91.2
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 06:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772549101; x=1773153901; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJlXz4Gm3Iulh7PKjxbOyaJJ98URo0iEgHacDLY1vjg=;
        b=fT/o2jy+dx8Vyixq4JULqGJSVRiNeq61frbC15Kr2U3p+bKIBNpQaWTltG28NyKa2f
         xCprNFsl4bKlhyCs8uM2290+Ks8p9hIf4NnN8p0CDE5QHRrabFYEbuwqfgrIHZ2tByG0
         J5ayhqWasauvENOtcaW090f7g27HOqrHRSh/MXCtu2QdkFBMfkY74VS7PFQ8+79/+mFS
         CPq+tu/u+IgOMV6my2+hBDT71X4pBBln0+RzBSfIhuYqh4CUpRIRD9x/jEi5+3T8pFTX
         gX7QPtpfRfLGASZmRztfYmHWJbzXnEgXLAf3O5D44L/GUUjhRpxygVzJ/5MJcEod9nnh
         SfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772549101; x=1773153901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJlXz4Gm3Iulh7PKjxbOyaJJ98URo0iEgHacDLY1vjg=;
        b=I7U9dmazhYXL6f8IQF8PFRyo2YVrLvuZ/EuAIAlgkDPDwypCXfsYgmCV0vJJxtXUPT
         EzosG2beah6S3x7ho5d7sLjM6+vbWStZGC8NzwV7OiPcG6U9XKt01YYpLIiU52WH1w2A
         P/BOY9ym079kgeTiMF/GxPOomDom++t7hVYMqggpbGQCd3Lt8dEat1invNb+SY4Wid+i
         P0s+rlXXmg3U+fpO7dyJa57Hiyi2BvDsJDKrk0yW9uv9kkJN6/dCfFyvoY+BTS0lbKjG
         DsPFb2oSB7+nNR3LeYYxgCpT5sEi3ltPAa9vnxzM+STNw8PxxJrMkxd3bXABf6hO7cHZ
         EdYw==
X-Forwarded-Encrypted: i=1; AJvYcCX63qHvtG9GHONYA3cbBPBGhe5E376Iyt+rEeaYFm2D6htSw0CkkOVTIVTYGjPHiGd0VjE5iK9PeekblhmrSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YweBhv7b6mBTAmgEoGNqRHBP8vbXSyJsIV1S1ItDyieHQ65t8gK
	Bli+GWLO/yUBWRBgNsY8/r3Dkf7dnjz9pHIIp0f35Or2fM/mPxDgjnOW
X-Gm-Gg: ATEYQzzFXVs5BfTC2R7Tlczh71KnyOBSWDXAMLUBuuU0cOuC6Ex8wHIG78ssc+4k//u
	UDjfRdiFDIi4WS1rZzxm1oainWaUnJgK4Bq84XV0s17o05xDKBQxElwxasrRvcmtay+mgwDpGFy
	tHm+Cfu1Ze0VN3DdQ9a54m6QZoIJUyNl1Ij7Y8u4dLBgofrp7RxIYgm3aUwFUM56XfGUgBcT1Rj
	GXr3L7J1oop/hN//EUX9bpYdaJ95E6yUKMDeJk8jceJcs6f5KDnXHuWNtnkGy5Rblk5mUyEWEHT
	qSZIAR1sFZx9w3xbSs2RtJPW54dEmcipKdg9+Rq0XmwiZTrsDZPkRiH3uKGXs+MAmodeHOYuqEB
	0eQuWV/h0w3vqpfpZAr7bP+ZLI9btSZ3WcyrGkFJshrQ7Trvs/I+MfgWXtMXV3yaCdnlNTXRtAe
	FrNwfdeg9cKVgTXtfF5zpuvTxZt6aBPMrOwlYc5xRUPXdn+m0nwukR6gugjFR4qpEbq+6uUkxeK
	GkTTA==
X-Received: by 2002:a17:90b:51cc:b0:359:7906:d998 with SMTP id 98e67ed59e1d1-3597906df0bmr11388993a91.18.1772549100406;
        Tue, 03 Mar 2026 06:45:00 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f0f:b1d0:3f07:f8d8:f49b:c576? ([2001:ee0:4f0f:b1d0:3f07:f8d8:f49b:c576])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a03fbsm226689635ad.43.2026.03.03.06.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 06:45:00 -0800 (PST)
Message-ID: <935c773d-e6d5-4445-b5e3-ed8daf60001c@gmail.com>
Date: Tue, 3 Mar 2026 21:44:53 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] virtio-net: xsk: Support wakeup on RX side
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260302164158.4394-1-minhquangbui99@gmail.com>
 <20260302135032-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20260302135032-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/26 01:53, Michael S. Tsirkin wrote:
> On Mon, Mar 02, 2026 at 11:41:58PM +0700, Bui Quang Minh wrote:
>> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
>> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
>> wasting CPU cycles on polling. Users will be notified and they need to
>> make a wakeup call after refilling the ring.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> Changes in v2:
>> - Fix the flag check in virtnet_xsk_wakeup
>> - Link to v1: https://lore.kernel.org/netdev/20260227150949.13089-1-minhquangbui99@gmail.com/
>> ---
>>   drivers/net/virtio_net.c | 35 +++++++++++++++++++++++++++--------
>>   1 file changed, 27 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index db88dcaefb20..3614002fc87c 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -1454,8 +1454,19 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>>   	xsk_buffs = rq->xsk_buffs;
>>   
>>   	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
>> -	if (!num)
>> +	if (!num) {
>> +		if (xsk_uses_need_wakeup(pool)) {
>> +			xsk_set_rx_need_wakeup(pool);
>> +			/* Return 0 instead of -ENOMEM so that NAPI is
>> +			 * descheduled.
>> +			 */
>> +			return 0;
> With this change, try_fill_recv() can return true even though zero RX
> buffers were posted in need_wakeup mode, which contradicts its
> documentation ("Returns false if we couldn't fill entirely (OOM)").
>
> Methinks we need to at least update the comment near try_fill_recv.

I'll update the comment of try_fill_recv function.

Thanks,
Quang Minh.

>
>
>
>> +		}
>> +
>>   		return -ENOMEM;
>> +	} else {
>> +		xsk_clear_rx_need_wakeup(pool);
>> +	}
>>   
>>   	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
>>   
>> @@ -1588,20 +1599,19 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>>   	return sent;
>>   }
>>   
>> -static void xsk_wakeup(struct send_queue *sq)
>> +static void xsk_wakeup(struct napi_struct *napi, struct virtqueue *vq)
>>   {
>> -	if (napi_if_scheduled_mark_missed(&sq->napi))
>> +	if (napi_if_scheduled_mark_missed(napi))
>>   		return;
>>   
>>   	local_bh_disable();
>> -	virtqueue_napi_schedule(&sq->napi, sq->vq);
>> +	virtqueue_napi_schedule(napi, vq);
>>   	local_bh_enable();
>>   }
>>   
>>   static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>>   {
>>   	struct virtnet_info *vi = netdev_priv(dev);
>> -	struct send_queue *sq;
>>   
>>   	if (!netif_running(dev))
>>   		return -ENETDOWN;
>> @@ -1609,9 +1619,18 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>>   	if (qid >= vi->curr_queue_pairs)
>>   		return -EINVAL;
>>   
>> -	sq = &vi->sq[qid];
>> +	if (flag & XDP_WAKEUP_TX) {
>> +		struct send_queue *sq = &vi->sq[qid];
>> +
>> +		xsk_wakeup(&sq->napi, sq->vq);
>> +	}
>> +
>> +	if (flag & XDP_WAKEUP_RX) {
>> +		struct receive_queue *rq = &vi->rq[qid];
>> +
>> +		xsk_wakeup(&rq->napi, rq->vq);
>> +	}
>>   
>> -	xsk_wakeup(sq);
>>   	return 0;
>>   }
>>   
>> @@ -1623,7 +1642,7 @@ static void virtnet_xsk_completed(struct send_queue *sq, int num)
>>   	 * wakeup the tx napi to consume the xsk tx queue, because the tx
>>   	 * interrupt may not be triggered.
>>   	 */
>> -	xsk_wakeup(sq);
>> +	xsk_wakeup(&sq->napi, sq->vq);
>>   }
>>   
>>   static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>> -- 
>> 2.43.0

