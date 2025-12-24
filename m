Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CC21D5ACE
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595795; cv=none; b=XRHxim7MLy28kybWaAMpwDzgUdNxtIRHXn+ro0IsZcpoIAE3rn82D60KytXppiEbw8mm1zjt+rzktZ/6FbvFK7EjicpQV12H1ANjkpmGBd9/GFGRhRPWuVKSJqOA+8hjfz1gdI7uL5/u/ivhfMyIdDf/wLcvoSm4UMfY1tgaGQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595795; c=relaxed/simple;
	bh=GUEsHePXJccZBUEQIKf7hMa2tACPPNw1UhQtnr2KHyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjXwMwZZK6/IH1uK90crcFdIf0uecWX4dKDqrLgXGgl7Ga1lctbKmJu1XL0MefZLjRVVxZFWE7D5/0TNgsf4nxhun6YGVDg3UiPK5f6yJu4uAvNYNOX+ve7HJ4+8gm6Sulx/54wa511kr6UqyroGwFp2TRfIp9E16isoTBVDBKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cshc99a3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cshc99a3"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0c09bb78cso44031325ad.0
        for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 09:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766595792; x=1767200592; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCfHdOhWgISiOalVEY40nhNWKj/HaViIguTCgQhvFHo=;
        b=Cshc99a3lgu3JCv52vtOvGk+irjMf82aXQrI3EcPzBl6toJVtwGGru+egLoPArrvmL
         FQV8irfluVI3MX+F5HhC5PD/NraZ3IcuM+lzBkLyRRYkxG1Km79YS0Brcx2qf0JkTEAU
         jcpMgOLFVIYqZrIBJPaKKD/oi6bvw9qJ+OVVCaLoowZOX7F4ZLoyZ9COI5wLCEzuNYgA
         XeeJmZ97eVQSSQv9legtpeWNLOsNbHh8iPwsiNFBQF4IblB3JuWMzYddksq6tITGbZeu
         bUrMrFxJK/KTDtc51cXZC9bvxaYD3izWX5YG2h+ZDki+z1qSqB/S1Q/iEIU1f2T33hRt
         +zIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766595792; x=1767200592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCfHdOhWgISiOalVEY40nhNWKj/HaViIguTCgQhvFHo=;
        b=wzGqN3RaauiRrd8bhLwHLzB9ukd822WF4ArVyp0iNvsIX8GA0lhhiMusJi1znH5XyB
         IO/4nMa7KvDAjvk12Z4+afQ4XTTcGfzrsPfl8ZzZlFo2JC0nTPef8wTYcybl45LgACDh
         U6J1PBA1fjloWy/qOWgMXdpPbHM7ffDpRirpYEFM9FJnDiTcLLLcO7bi1c7OjrTWf5eV
         GBu2QRseSvKYGjg4JbKulrGcfqH/EpY3OUV+pfD4E/zwy2x3PGdZwZu28wT3ttZyyDum
         Jfb4KBbKgajEBgXJk0pDWuqLkvGNyBVFanc+QgsCfjwsU2BMlCz6gJLNLRjbkYoRyjPe
         DhCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsPkFB8gJ00rQybUkVnMSWVxkpiFUiXXOF3qUHSSD8zljXLZ9GsmHCMiukofhORNDB5LYVbSG5khaBTa3W8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCIjhk4hnPl252Nqz/UhsUt2k0dl2oREXGWJZTRsAjmC49bzAt
	06Dc2JMG2cy0fhrUeednqYaAdd/kdY/36xcGyQihBNx3qmagkjSaih0o
X-Gm-Gg: AY/fxX4nHb4nnkpWRPr7uc1dEbZ3eGgnThFMcyWhY5noG7Q+1h1nmKDI1doFr4k4i4M
	Qi6T6YxnrMre8YVcl9edLEo8hod1DtjI6i1MaURhCYV7QW0iHBR0eXkr5ezQUWQNf+cL33zcKZ7
	frM0xFkCRQ0To5YFNc/ezFVlUWW746joVFlfq+ftIRiv13GXnvue1ZMO+QKIcBqmsFusJU5MyUy
	HV4zpHyVleJKzEme4RuF+QP06yASrqfz1TQ1by9cUYdJhSldCTphRMAPxZG8Tod5+cl7EwDT8gR
	N98vaPbWd8MBhFEGUIVDN9KzN3Uhfy2mIcnVpFsNq6EQuRGCVLWhf83Z2EuFgmTqhI5nrZ7AiRn
	+tRAqS41TxlHXmcoJSgMSjf3p5d2x2wCqnvcC5HegPH7jsdJbygPn8C5JN0Nv+qZZJsGTWaDoKi
	B8oOO0XyGAQXLkElTLvqoZVVvrO3KyPLfkIqZTAmPQkbzJPJ3Fy2AkQx3X20o=
X-Google-Smtp-Source: AGHT+IHpWU862HlyVsx8am6zA2CXpWuSs0vK40terwCQF3VgbvVKSY08lJguDlryd5ndestdlzep7Q==
X-Received: by 2002:a17:902:e785:b0:2a0:93e7:eba with SMTP id d9443c01a7336-2a2f0d5fea4mr192836595ad.30.1766595792291;
        Wed, 24 Dec 2025 09:03:12 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:c711:242:cd10:6c98? ([2001:ee0:4f4c:210:c711:242:cd10:6c98])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7961b4d0sm14833334a12.5.2025.12.24.09.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 09:03:11 -0800 (PST)
Message-ID: <0d5469f9-9918-4707-a390-533f53eadbe4@gmail.com>
Date: Thu, 25 Dec 2025 00:03:05 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
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
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <20251224051747-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20251224051747-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 17:19, Michael S. Tsirkin wrote:
> On Tue, Dec 23, 2025 at 10:25:31PM +0700, Bui Quang Minh wrote:
>> Currently, the refill work is a global delayed work for all the receive
>> queues. This commit makes the refill work a per receive queue so that we
>> can manage them separately and avoid further mistakes. It also helps the
>> successfully refilled queue avoid the napi_disable in the global delayed
>> refill work like before.
>>
> this commit log is unreadable. before what? what is the problem with
> "refilled queue napi_disable" this refers to.

I mean that currently even if one RX queue is refilled successfully but 
another is not, then the successful one still gets napi_disable() in the 
global refill work. It will unnecessarily disrupt that queue I think.

>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 155 ++++++++++++++++++---------------------
>>   1 file changed, 72 insertions(+), 83 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 1bb3aeca66c6..63126e490bda 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -379,6 +379,15 @@ struct receive_queue {
>>   	struct xdp_rxq_info xsk_rxq_info;
>>   
>>   	struct xdp_buff **xsk_buffs;
>> +
>> +	/* Is delayed refill enabled? */
>> +	bool refill_enabled;
>> +
>> +	/* The lock to synchronize the access to refill_enabled */
>> +	spinlock_t refill_lock;
>> +
>> +	/* Work struct for delayed refilling if we run low on memory. */
>> +	struct delayed_work refill;
>>   };
>>   
>>   #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
>> @@ -441,9 +450,6 @@ struct virtnet_info {
>>   	/* Packet virtio header size */
>>   	u8 hdr_len;
>>   
>> -	/* Work struct for delayed refilling if we run low on memory. */
>> -	struct delayed_work refill;
>> -
>>   	/* UDP tunnel support */
>>   	bool tx_tnl;
>>   
>> @@ -451,12 +457,6 @@ struct virtnet_info {
>>   
>>   	bool rx_tnl_csum;
>>   
>> -	/* Is delayed refill enabled? */
>> -	bool refill_enabled;
>> -
>> -	/* The lock to synchronize the access to refill_enabled */
>> -	spinlock_t refill_lock;
>> -
>>   	/* Work struct for config space updates */
>>   	struct work_struct config_work;
>>   
>> @@ -720,18 +720,18 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
>>   		put_page(virt_to_head_page(buf));
>>   }
>>   
>> -static void enable_delayed_refill(struct virtnet_info *vi)
>> +static void enable_delayed_refill(struct receive_queue *rq)
>>   {
>> -	spin_lock_bh(&vi->refill_lock);
>> -	vi->refill_enabled = true;
>> -	spin_unlock_bh(&vi->refill_lock);
>> +	spin_lock_bh(&rq->refill_lock);
>> +	rq->refill_enabled = true;
>> +	spin_unlock_bh(&rq->refill_lock);
>>   }
>>   
>> -static void disable_delayed_refill(struct virtnet_info *vi)
>> +static void disable_delayed_refill(struct receive_queue *rq)
>>   {
>> -	spin_lock_bh(&vi->refill_lock);
>> -	vi->refill_enabled = false;
>> -	spin_unlock_bh(&vi->refill_lock);
>> +	spin_lock_bh(&rq->refill_lock);
>> +	rq->refill_enabled = false;
>> +	spin_unlock_bh(&rq->refill_lock);
>>   }
>>   
>>   static void enable_rx_mode_work(struct virtnet_info *vi)
>> @@ -2950,38 +2950,19 @@ static void virtnet_napi_disable(struct receive_queue *rq)
>>   
>>   static void refill_work(struct work_struct *work)
>>   {
>> -	struct virtnet_info *vi =
>> -		container_of(work, struct virtnet_info, refill.work);
>> +	struct receive_queue *rq =
>> +		container_of(work, struct receive_queue, refill.work);
>>   	bool still_empty;
>> -	int i;
>> -
>> -	for (i = 0; i < vi->curr_queue_pairs; i++) {
>> -		struct receive_queue *rq = &vi->rq[i];
>>   
>> -		/*
>> -		 * When queue API support is added in the future and the call
>> -		 * below becomes napi_disable_locked, this driver will need to
>> -		 * be refactored.
>> -		 *
>> -		 * One possible solution would be to:
>> -		 *   - cancel refill_work with cancel_delayed_work (note:
>> -		 *     non-sync)
>> -		 *   - cancel refill_work with cancel_delayed_work_sync in
>> -		 *     virtnet_remove after the netdev is unregistered
>> -		 *   - wrap all of the work in a lock (perhaps the netdev
>> -		 *     instance lock)
>> -		 *   - check netif_running() and return early to avoid a race
>> -		 */
>> -		napi_disable(&rq->napi);
>> -		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
>> -		virtnet_napi_do_enable(rq->vq, &rq->napi);
>> +	napi_disable(&rq->napi);
>> +	still_empty = !try_fill_recv(rq->vq->vdev->priv, rq, GFP_KERNEL);
>> +	virtnet_napi_do_enable(rq->vq, &rq->napi);
>>   
>> -		/* In theory, this can happen: if we don't get any buffers in
>> -		 * we will *never* try to fill again.
>> -		 */
>> -		if (still_empty)
>> -			schedule_delayed_work(&vi->refill, HZ/2);
>> -	}
>> +	/* In theory, this can happen: if we don't get any buffers in
>> +	 * we will *never* try to fill again.
>> +	 */
>> +	if (still_empty)
>> +		schedule_delayed_work(&rq->refill, HZ / 2);
>>   }
>>   
>>   static int virtnet_receive_xsk_bufs(struct virtnet_info *vi,
>> @@ -3048,10 +3029,10 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>>   
>>   	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
>>   		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
>> -			spin_lock(&vi->refill_lock);
>> -			if (vi->refill_enabled)
>> -				schedule_delayed_work(&vi->refill, 0);
>> -			spin_unlock(&vi->refill_lock);
>> +			spin_lock(&rq->refill_lock);
>> +			if (rq->refill_enabled)
>> +				schedule_delayed_work(&rq->refill, 0);
>> +			spin_unlock(&rq->refill_lock);
>>   		}
>>   	}
>>   
>> @@ -3226,13 +3207,13 @@ static int virtnet_open(struct net_device *dev)
>>   	struct virtnet_info *vi = netdev_priv(dev);
>>   	int i, err;
>>   
>> -	enable_delayed_refill(vi);
>> -
>>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>> -		if (i < vi->curr_queue_pairs)
>> +		if (i < vi->curr_queue_pairs) {
>> +			enable_delayed_refill(&vi->rq[i]);
>>   			/* Make sure we have some buffers: if oom use wq. */
>>   			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>> -				schedule_delayed_work(&vi->refill, 0);
>> +				schedule_delayed_work(&vi->rq[i].refill, 0);
>> +		}
>>   
>>   		err = virtnet_enable_queue_pair(vi, i);
>>   		if (err < 0)
>> @@ -3251,10 +3232,9 @@ static int virtnet_open(struct net_device *dev)
>>   	return 0;
>>   
>>   err_enable_qp:
>> -	disable_delayed_refill(vi);
>> -	cancel_delayed_work_sync(&vi->refill);
>> -
>>   	for (i--; i >= 0; i--) {
>> +		disable_delayed_refill(&vi->rq[i]);
>> +		cancel_delayed_work_sync(&vi->rq[i].refill);
>>   		virtnet_disable_queue_pair(vi, i);
>>   		virtnet_cancel_dim(vi, &vi->rq[i].dim);
>>   	}
>> @@ -3447,14 +3427,15 @@ static void virtnet_rx_pause_all(struct virtnet_info *vi)
>>   {
>>   	int i;
>>   
>> -	/*
>> -	 * Make sure refill_work does not run concurrently to
>> -	 * avoid napi_disable race which leads to deadlock.
>> -	 */
>> -	disable_delayed_refill(vi);
>> -	cancel_delayed_work_sync(&vi->refill);
>> -	for (i = 0; i < vi->max_queue_pairs; i++)
>> +	for (i = 0; i < vi->max_queue_pairs; i++) {
>> +		/*
>> +		 * Make sure refill_work does not run concurrently to
>> +		 * avoid napi_disable race which leads to deadlock.
>> +		 */
>> +		disable_delayed_refill(&vi->rq[i]);
>> +		cancel_delayed_work_sync(&vi->rq[i].refill);
>>   		__virtnet_rx_pause(vi, &vi->rq[i]);
>> +	}
>>   }
>>   
>>   static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>> @@ -3463,8 +3444,8 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>>   	 * Make sure refill_work does not run concurrently to
>>   	 * avoid napi_disable race which leads to deadlock.
>>   	 */
>> -	disable_delayed_refill(vi);
>> -	cancel_delayed_work_sync(&vi->refill);
>> +	disable_delayed_refill(rq);
>> +	cancel_delayed_work_sync(&rq->refill);
>>   	__virtnet_rx_pause(vi, rq);
>>   }
>>   
>> @@ -3481,25 +3462,26 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>>   		virtnet_napi_enable(rq);
>>   
>>   	if (schedule_refill)
>> -		schedule_delayed_work(&vi->refill, 0);
>> +		schedule_delayed_work(&rq->refill, 0);
>>   }
>>   
>>   static void virtnet_rx_resume_all(struct virtnet_info *vi)
>>   {
>>   	int i;
>>   
>> -	enable_delayed_refill(vi);
>>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>> -		if (i < vi->curr_queue_pairs)
>> +		if (i < vi->curr_queue_pairs) {
>> +			enable_delayed_refill(&vi->rq[i]);
>>   			__virtnet_rx_resume(vi, &vi->rq[i], true);
>> -		else
>> +		} else {
>>   			__virtnet_rx_resume(vi, &vi->rq[i], false);
>> +		}
>>   	}
>>   }
>>   
>>   static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>>   {
>> -	enable_delayed_refill(vi);
>> +	enable_delayed_refill(rq);
>>   	__virtnet_rx_resume(vi, rq, true);
>>   }
>>   
>> @@ -3830,10 +3812,16 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>   succ:
>>   	vi->curr_queue_pairs = queue_pairs;
>>   	/* virtnet_open() will refill when device is going to up. */
>> -	spin_lock_bh(&vi->refill_lock);
>> -	if (dev->flags & IFF_UP && vi->refill_enabled)
>> -		schedule_delayed_work(&vi->refill, 0);
>> -	spin_unlock_bh(&vi->refill_lock);
>> +	if (dev->flags & IFF_UP) {
>> +		int i;
>> +
>> +		for (i = 0; i < vi->curr_queue_pairs; i++) {
>> +			spin_lock_bh(&vi->rq[i].refill_lock);
>> +			if (vi->rq[i].refill_enabled)
>> +				schedule_delayed_work(&vi->rq[i].refill, 0);
>> +			spin_unlock_bh(&vi->rq[i].refill_lock);
>> +		}
>> +	}
>>   
>>   	return 0;
>>   }
>> @@ -3843,10 +3831,6 @@ static int virtnet_close(struct net_device *dev)
>>   	struct virtnet_info *vi = netdev_priv(dev);
>>   	int i;
>>   
>> -	/* Make sure NAPI doesn't schedule refill work */
>> -	disable_delayed_refill(vi);
>> -	/* Make sure refill_work doesn't re-enable napi! */
>> -	cancel_delayed_work_sync(&vi->refill);
>>   	/* Prevent the config change callback from changing carrier
>>   	 * after close
>>   	 */
>> @@ -3857,6 +3841,10 @@ static int virtnet_close(struct net_device *dev)
>>   	cancel_work_sync(&vi->config_work);
>>   
>>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>> +		/* Make sure NAPI doesn't schedule refill work */
>> +		disable_delayed_refill(&vi->rq[i]);
>> +		/* Make sure refill_work doesn't re-enable napi! */
>> +		cancel_delayed_work_sync(&vi->rq[i].refill);
>>   		virtnet_disable_queue_pair(vi, i);
>>   		virtnet_cancel_dim(vi, &vi->rq[i].dim);
>>   	}
>> @@ -5802,7 +5790,6 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>>   
>>   	virtio_device_ready(vdev);
>>   
>> -	enable_delayed_refill(vi);
>>   	enable_rx_mode_work(vi);
>>   
>>   	if (netif_running(vi->dev)) {
>> @@ -6559,8 +6546,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
>>   	if (!vi->rq)
>>   		goto err_rq;
>>   
>> -	INIT_DELAYED_WORK(&vi->refill, refill_work);
>>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>> +		INIT_DELAYED_WORK(&vi->rq[i].refill, refill_work);
>> +		spin_lock_init(&vi->rq[i].refill_lock);
>>   		vi->rq[i].pages = NULL;
>>   		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
>>   				      i);
>> @@ -6901,7 +6889,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>>   
>>   	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
>>   	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
>> -	spin_lock_init(&vi->refill_lock);
>>   
>>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
>>   		vi->mergeable_rx_bufs = true;
>> @@ -7165,7 +7152,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>>   	net_failover_destroy(vi->failover);
>>   free_vqs:
>>   	virtio_reset_device(vdev);
>> -	cancel_delayed_work_sync(&vi->refill);
>> +	for (i = 0; i < vi->max_queue_pairs; i++)
>> +		cancel_delayed_work_sync(&vi->rq[i].refill);
>> +
>>   	free_receive_page_frags(vi);
>>   	virtnet_del_vqs(vi);
>>   free:
>> -- 
>> 2.43.0

