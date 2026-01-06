Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B8344034
	for <virtualization@lists.linux.dev>; Tue,  6 Jan 2026 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713958; cv=none; b=YDgZmUUOCdx+3hvrRMiee+gdKEalDjlhxNwC0Ojd6h4zWrcfBl32MFP2AVNQx3iY+trB/7HUU8TkPgW4+nH3jhjgE3M3oKkT5Kr/j88dsCM1SLLqOPMRsE7Kv7T3Tfc/TWgeAfWklCeNedQPeqE41On+MNh1/B5Y1XOJ8Do0kAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713958; c=relaxed/simple;
	bh=D4XuZS2ZZKPSGLViie1fG90SrMO9FTV7FKRiDM5R9zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3zuQShymXTWemVyp1c7nN6WX864wdJKSDezB892Jb32A+dOpmEVN5IS6YrUbVas9dobLHrGhKe7MvhseEAGwEnxendjYH6zYnJ+tNozuLTnaQzUoogwuCILqYoI8/LSI+RUl1O5gqaa6ZrhlUIExRx+w0uYPhMSCz3iyBxVq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hi0IMkHm; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi0IMkHm"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c03e8ac1da3so773200a12.2
        for <virtualization@lists.linux.dev>; Tue, 06 Jan 2026 07:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767713957; x=1768318757; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+nev3k8GrDkYwcfroMD2vo+UrG57sb0fdXcs5RtCMf0=;
        b=Hi0IMkHm3AQKQA+BueoGaui94B3kti+hTwHAydrPqW57zEQ2FrfD7yXDTUC0TMOCmm
         5+122tH12qGepDrwH/Z4UKFg2arwaeUiM2BmBhw2r+63QiFweU91/Yk2iGAnis/ajvsk
         pbOtJLzWfoVlb+kf9i3scFaFXfIkErecHwMEDdVAqWKtqfH84LOC6eGbIIaxZq6Hjk1g
         w0HLdby2g2xWBobB9GbHNNNgMiAz2XEV8YytUwjItrhTACnFU333OOLma8BlkuECdErN
         qosyjaHardIfVhqcVNdC2Hs1Kzwh3dxNWxWoymV8pRFjWSv9p2Cv5jyrQXwRu0yo5Opb
         407A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713957; x=1768318757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nev3k8GrDkYwcfroMD2vo+UrG57sb0fdXcs5RtCMf0=;
        b=bV6WbWMQh1aAwfZZY78M6joEZ3j17fBRmLQk7Y7H9iZa+p9vQuE39/A4SdVPM0Xx/E
         nDdQ7psxhhNh2AlWVj7ZKcCpWNTzCtBNBlyzs5FQRLzBAJ9dWGiu3IvdddN2XODyHES0
         CkcngjNQrZu7hUlnCoT24+xrvgnedLs0iKK3/qsOjLKbqRMsvKaFOVsk7gstyJImyV2T
         YQmDSPAzE3GizwJntcHBHFfTJDTk05JqVt9lwX9dNpbt9felg+tNHaXsmr3zQuLz8BKK
         nVo70MiHs7sMCqhiVMh/jvbtdXAH9WvDaytkCabbCZ8LWO0/Ebw04rr+Vym0oICBQhSb
         xqSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYIJQ150h2StHB6VG5t/vYfep7uEwiHY4VvCLTVJkZS/f8+22rO0moNVfS/ezBUnAhKpIMR9tOgSBF9FYImA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEWxtDrGf0XYFq8kuMfe9Gd0cY9ahFxr682wEhaio0oB4egxVd
	uKstEC7Btem41LNyH/UeCEPwwCdpDQSfFUnmbDrRW+Ot6ZnMDRAHcyps
X-Gm-Gg: AY/fxX4yG6fOYVsry0TUzhdE/Mr9Tl7K8NKODBJ9aGFAhfCCo6rAFXT0g2/WU+Cw2AL
	HljbRghfibAyxb274k2JRW/rYUWRvw0YhCEcL6WyNRBgMRzFKUDzT43W0urbTR4ViU88k1APUW0
	j7AVtMb00umw1a3rOs1wlSmR5nceKW0iXCoifbCA7zybR+N9vWKrTmD3nrxlsbuHv2OTt74UZqp
	hwdbpC6mr27KWAb1r5M3SQ9dXMD0/+2NMctNQzS0llGM9aCyhrxneh/hDeOl4dUoqDABik9RcCR
	zoQsY7T4i3fju8jS7CgXFxDRV0vQTkqIR5r9l7Y2KjeHtbsBsKEeNNDcekGk8L8y1yFlrwWJljo
	T8q4BwZykeyM+XGfiUPOrEkn6kb8WyQgx9GDJ6e9+taFEoqFI1O1dV9zE3jcoMeCHegrSf3kteu
	YmCvvx3Wf4j1q+r/yrkg1H
X-Google-Smtp-Source: AGHT+IF0mZFbkjRBIubqLKVOfr698jKaejtisA/43GyJJji0AoxWu2L/C2JuZyOyvdKgIUNJcZv0HA==
X-Received: by 2002:a05:6a21:6da1:b0:366:584c:62ef with SMTP id adf61e73a8af0-389823c3f46mr3343295637.65.1767713956663;
        Tue, 06 Jan 2026 07:39:16 -0800 (PST)
Received: from [192.168.0.118] ([14.187.47.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc95d5f10sm2712050a12.26.2026.01.06.07.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 07:39:16 -0800 (PST)
Message-ID: <e8db28a3-61ae-4988-9ac6-ba67926056ab@gmail.com>
Date: Tue, 6 Jan 2026 22:39:09 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] virtio-net: don't schedule delayed refill
 worker
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
 <20260106150438.7425-2-minhquangbui99@gmail.com>
 <20260106100959-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20260106100959-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/26 22:29, Michael S. Tsirkin wrote:
> On Tue, Jan 06, 2026 at 10:04:36PM +0700, Bui Quang Minh wrote:
>> When we fail to refill the receive buffers, we schedule a delayed worker
>> to retry later. However, this worker creates some concurrency issues.
>> For example, when the worker runs concurrently with virtnet_xdp_set,
>> both need to temporarily disable queue's NAPI before enabling again.
>> Without proper synchronization, a deadlock can happen when
>> napi_disable() is called on an already disabled NAPI. That
>> napi_disable() call will be stuck and so will the subsequent
>> napi_enable() call.
>>
>> To simplify the logic and avoid further problems, we will instead retry
>> refilling in the next NAPI poll.
>>
>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>> Cc: stable@vger.kernel.org
>> Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> and CC stable I think. Can you do that pls?

I've added Cc stable already.

Thanks for you review.

>
>> ---
>>   drivers/net/virtio_net.c | 48 +++++++++++++++++++++-------------------
>>   1 file changed, 25 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 1bb3aeca66c6..f986abf0c236 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3046,16 +3046,16 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>>   	else
>>   		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
>>   
>> +	u64_stats_set(&stats.packets, packets);
>>   	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
>> -		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
>> -			spin_lock(&vi->refill_lock);
>> -			if (vi->refill_enabled)
>> -				schedule_delayed_work(&vi->refill, 0);
>> -			spin_unlock(&vi->refill_lock);
>> -		}
>> +		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
>> +			/* We need to retry refilling in the next NAPI poll so
>> +			 * we must return budget to make sure the NAPI is
>> +			 * repolled.
>> +			 */
>> +			packets = budget;
>>   	}
>>   
>> -	u64_stats_set(&stats.packets, packets);
>>   	u64_stats_update_begin(&rq->stats.syncp);
>>   	for (i = 0; i < ARRAY_SIZE(virtnet_rq_stats_desc); i++) {
>>   		size_t offset = virtnet_rq_stats_desc[i].offset;
>> @@ -3230,9 +3230,10 @@ static int virtnet_open(struct net_device *dev)
>>   
>>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>>   		if (i < vi->curr_queue_pairs)
>> -			/* Make sure we have some buffers: if oom use wq. */
>> -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>> -				schedule_delayed_work(&vi->refill, 0);
>> +			/* Pre-fill rq agressively, to make sure we are ready to
>> +			 * get packets immediately.
>> +			 */
>> +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
>>   
>>   		err = virtnet_enable_queue_pair(vi, i);
>>   		if (err < 0)
>> @@ -3472,16 +3473,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>>   				struct receive_queue *rq,
>>   				bool refill)
>>   {
>> -	bool running = netif_running(vi->dev);
>> -	bool schedule_refill = false;
>> +	if (netif_running(vi->dev)) {
>> +		/* Pre-fill rq agressively, to make sure we are ready to get
>> +		 * packets immediately.
>> +		 */
>> +		if (refill)
>> +			try_fill_recv(vi, rq, GFP_KERNEL);
>>   
>> -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>> -		schedule_refill = true;
>> -	if (running)
>>   		virtnet_napi_enable(rq);
>> -
>> -	if (schedule_refill)
>> -		schedule_delayed_work(&vi->refill, 0);
>> +	}
>>   }
>>   
>>   static void virtnet_rx_resume_all(struct virtnet_info *vi)
>> @@ -3829,11 +3829,13 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>   	}
>>   succ:
>>   	vi->curr_queue_pairs = queue_pairs;
>> -	/* virtnet_open() will refill when device is going to up. */
>> -	spin_lock_bh(&vi->refill_lock);
>> -	if (dev->flags & IFF_UP && vi->refill_enabled)
>> -		schedule_delayed_work(&vi->refill, 0);
>> -	spin_unlock_bh(&vi->refill_lock);
>> +	if (dev->flags & IFF_UP) {
>> +		local_bh_disable();
>> +		for (int i = 0; i < vi->curr_queue_pairs; ++i)
>> +			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
>> +
>> +		local_bh_enable();
>> +	}
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.43.0

