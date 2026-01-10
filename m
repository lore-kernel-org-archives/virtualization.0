Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DFF211A05
	for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768033425; cv=none; b=qt7LX1F0qZUfAgsIAWXeCb/RfeMVyLXew6khYXVUMovpRVOWD790PwiMwmipUMf6u9620ey9syR82mVwocl2I0UR/nLWACENJVj9EO7rcAe3CRxbjl2363DmxD+KKEXcdDrq9GaCQJNzR0CwlliD3nMYJPG4Y0EwqXzkci22NKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768033425; c=relaxed/simple;
	bh=r2eEmiwIMswi/KIcQchbLwESKW9bSNI5Wwpf6dmjcII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMogKtSbEMQIlOoCTS6RwB6sIdBPFOGNNRkGYWi2wOB82fowLbU947ZeiSqMlWlZEn9Z/p37u9yt4ZhzQk/oArI6MCONAj7fcrPv29vDgok3oSaKwwYbgVvrFLGowEgYFkI/SKYhDG9sgFiMBtkH8xNinhkbMVuVSypqWvYQZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHx6S5x1; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHx6S5x1"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81e7477828bso645448b3a.0
        for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 00:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768033423; x=1768638223; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85VZqRS0HMw6ZG3sDTQxV/1q2B5Gy6mG+8xTLfX4fdI=;
        b=JHx6S5x1G7TWMH1JuaZkNu19z3K/aJTY2HIB7C3xYBP/w2IPfgc/Oayo7CkSCNx+jH
         y0fwPDw9P3fs9oZSMNOlFKxUcYOC/RnSat1Pt7s3DLBiGPstZ6UKnJ48WjTe74a1hoHQ
         JAc0xvJr6U2vFAR0a3QKAjcWCshPnkprMHBTtzrVsIsSX1ZF1Kwb8Vdj2lCoprCh7mXX
         +9d/C94IZpyRI0ds+QtCKhzf9q0tSbOWVQiTBCIDWGd/2w47bByC+sx3P4vwCnihV6K/
         ThW+p5GgKsRdkpdejUcft48oAaRKR9mdJ/blkflG1Yt9pawfxc3X9r/DiR08BYbtmlSD
         SfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768033423; x=1768638223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85VZqRS0HMw6ZG3sDTQxV/1q2B5Gy6mG+8xTLfX4fdI=;
        b=o+ImUfjxON2YGnDvlKRGHA8Y2HADaQT5Auah+CVp/j8fzDt3ajNhOqgbbysrV793R5
         SOuCCjUtEJX7mTVQ8q/PmtmM+NtTP5p1R12ipnOeSBjna426rYbceKKoZOpbEaK3grRo
         /ajXCvKCxEG6vnHF6v2lHaYROoxOJomLpE1Gth7Yir8PUPfhbJ7b8e2W7juWx8OS/62W
         4X0GF+g6/FrlAXuGyzBGUpBQoiQdytVDMLWiY7P7qr4BYCy3OAA+23IWyAous8LtbHCV
         CUCgaho1ggCfBf5yDOWwca6W9dAVfAbDwTAdGRih/Qig14h7v/KspgLZaESOEQp6jpRt
         gsAw==
X-Forwarded-Encrypted: i=1; AJvYcCUoswDrWLO424WKDR9EbUGFN2N2mOK9/bxBCIBdpMag06ziRikPvt8I6c6SHq0qCxs2AiqQsVqGEw1iEBn0Cw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2ZiN/ofEE80gdqdq3HeEv3/Nm/MN7c6iTqZXfnB+SO4YAp98l
	7Wz+m+3CGzahzrd0ZyGqNv7aeM9Al/G3cX2mouZagcO0ygIoQ1AZuqY9
X-Gm-Gg: AY/fxX7dKzGdMNIpBe+1OlrhlIGz9sWXO3LDdC9+hE5/qrIGFZP1A5ii4dSl7saZWTh
	2P6uk0Zksi+YukrheLbGROdDWzFDkaHmMAgkgBkvtsfh7+Q9bvbvQK67EiovwS3RkDrgLbg9079
	VGtwwtKVswv6iv1aU3GSAWKDEZtLwOvQSKv/otxVZgyxMZy152gLVcUwRlo2FFyMh06QzuOxAXB
	ZmWSAxoqXXGfsCFfxvCfHbXNpbaPTiT/R76SAf5+QTZ/a2ah1fLBgI+yLueNgu8Om1g5u8Q2/sT
	6BZ+5HvpB2aIuFCirJ1jg7b7Bp2+GuI7tTXEIclzL7w+J5Xy4afQRoJHkqClI1sF6L70py2fKs7
	NYiDxNdlPKjU20IH18SQMqAFat3b8GDDo8Jefi3lcfgeds2icINxU2CWn7LmXkx+lCbCty5lwfC
	up7jsqB0SUHVcAZv2ms1vAKG/SYvMZcUYT0KUJJmmJfPcPRCsjrrkcvcztRoLpHf8=
X-Google-Smtp-Source: AGHT+IHoygcVcBOXZTvHirg+fAWu4JoVecE6IMiVQAjqDcaQfChsGHo9TIym3L2ijvCSLqJ0rzIU0g==
X-Received: by 2002:a05:6a00:ae02:b0:81a:a5cc:da16 with SMTP id d2e1a72fcca58-81aa5ccdc92mr11900544b3a.32.1768033423234;
        Sat, 10 Jan 2026 00:23:43 -0800 (PST)
Received: from ?IPV6:2402:800:63b5:c9e8:e91e:c1cc:2faf:cf91? ([2402:800:63b5:c9e8:e91e:c1cc:2faf:cf91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e7c16sm12245985b3a.53.2026.01.10.00.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 00:23:42 -0800 (PST)
Message-ID: <2542db74-0e72-421d-932a-b1667fb16e56@gmail.com>
Date: Sat, 10 Jan 2026 15:23:36 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] virtio-net: don't schedule delayed refill
 worker
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
 <20260106150438.7425-2-minhquangbui99@gmail.com>
 <20260109181239.1c272f88@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20260109181239.1c272f88@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/10/26 09:12, Jakub Kicinski wrote:
> On Tue,  6 Jan 2026 22:04:36 +0700 Bui Quang Minh wrote:
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
> Happy to see this go FWIW. If it causes issues we should consider
> adding some retry logic in the core (NAPI) rather than locally in
> the driver..
>
>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> The Closes should probably point to Paolo's report. We'll wipe these CI
> logs sooner or later but the lore archive will stick around.

I'll fix it in the next version.

>
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
> We should enforce _some_ minimal fill level at the time of open().
> If the ring is completely empty no traffic will ever flow, right?
> Perhaps I missed scheduling the NAPI somewhere..

The NAPI is enabled and scheduled in virtnet_napi_enable(). The code 
path is like this

virtnet_enable_queue_pair
-> virtnet_napi_enable
   -> virtnet_napi_do_enable
     -> virtqueue_napi_schedule

The same happens in __virtnet_rx_resume().

>
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
> Similar thing here? Tho not sure we can fail here..
>
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
> nit: spurious new line

I'll delete it in the next version.

>
>> +		local_bh_enable();
>> +	}
>>   
>>   	return 0;
>>   }

