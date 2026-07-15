Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4E1A681C
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083530; cv=none; b=acMniC/H50HgSj0xfhcQUunx76h9zWEPC/GBAA7VCMVY0QndAk840xzJE2cSLb2+iA0WMuffYmacPSAM2neblirgJXMOaSTxbZkaD0gkrQoA1t5lU5o0GBlAy06nHQDKF9rBobivDTk8T/5WCVXQAFzIoKh8hVH8muczszQ9nbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083530; c=relaxed/simple;
	bh=lJumYtZ5ydp9NdPe7Lzm3US3xmOZni2BKZeiYyrGKAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rHJiMA7MKHCGMZAeSTaAcRPur8bIV4JNdnkZ49jfsA2dKuKSewL6ox20912roDcAd0CX+1e/8R5X2tCPyg0MANmwBP+Q81BHiPRC2/Pwvfi+oMtDVImW4pcaaigb0TSaqGA4tu6gnGHa8lhJVOgqqFgLmwEeg9pfuHRi4dSVMOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PYNZnOPY; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PYNZnOPY"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TDog+YKAsc49OcZ4M4VaMgRAlHrOOGPjtQhO/Mw+GJI=;
	b=PYNZnOPYIVY4DUEshuLAwOEJwzc1keWUyuJXQtwHzuA/KPPnR3ikjPW/oyziC6iaSHPz0y2cN
	7kXvf+5V+JszrjwfcRdffsHN60sppU68g2t2Fn536QoOlEZizzurLjBnpG/OXJfHTq5nOO43xdg
	jm9wZqSD6s+3hlokXTs7YsI=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h0Kzb4PwwzKmTp;
	Wed, 15 Jul 2026 10:35:55 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D66B40578;
	Wed, 15 Jul 2026 10:45:16 +0800 (CST)
Received: from [10.67.121.183] (10.67.121.183) by
 dggpemf500013.china.huawei.com (7.185.36.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Jul 2026 10:45:15 +0800
Message-ID: <5df1a86e-7136-4d0c-a67f-10710486694f@huawei.com>
Date: Wed, 15 Jul 2026 10:45:14 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_net: fix infinite loop in virtnet_poll_cleantx
 when device is broken
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <liuyonglong@huawei.com>,
	<wangzhou1@hisilicon.com>, <linuxarm@huawei.com>
References: <20260713132025.703147-1-yangjinqian1@huawei.com>
 <20260714091622-mutt-send-email-mst@kernel.org>
From: Jinqian Yang <yangjinqian1@huawei.com>
In-Reply-To: <20260714091622-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500013.china.huawei.com (7.185.36.188)

Hi,

On 2026/7/14 21:17, Michael S. Tsirkin wrote:
> On Mon, Jul 13, 2026 at 09:20:25PM +0800, Jinqian Yang wrote:
>> virtnet_poll_cleantx() contains a do-while loop that cleans up
>> transmitted TX buffers and calls virtqueue_enable_cb_delayed() to check
>> whether more buffers need processing. When the virtio backend stops
>> responding during guest reboot, used->idx is never updated, so
>> virtqueue_enable_cb_delayed() always returns false and the loop never
>> terminates. Then it will block reboot process, and the guest will hang.
>>
>> The problem occurs during guest reboot under network traffic:
>>
>>    1. kernel_restart() -> device_shutdown() traverses the device list
>>    2. virtio_dev_shutdown() calls virtio_break_device() which sets
>>       vq->broken = true
>>    3. virtio_dev_shutdown() then calls virtio_synchronize_cbs() to wait
>>       for in-flight callbacks to complete
>>    4. A virtio interrupt fires, softirq is deferred to ksoftirqd which
>>       calls net_rx_action() -> virtnet_poll() -> virtnet_poll_cleantx()
>>    5. virtnet_poll_cleantx() enters the do-while loop and never exits
>>       because the QEMU backend has stopped updating used->idx, despite
>>       vq->broken having been set to true in step 2.
>>
>> Since the loop runs inside ksoftirqd (a SCHED_OTHER kthread), it is
>> visible to the scheduler and does not trigger a hard lockup. However,
>> the kthread never leaves the loop, so RCU detects it as a CPU stall
>> and reports it periodically. Meanwhile, the reboot process remains
>> blocked in device_shutdown() because virtio_dev_shutdown() cannot
>> complete its synchronization step, and the guest hangs permanently.
>>
>> This can be reproduced on a guest with a virtio-net device: run iperf3
>> traffic in the guest, then trigger reboot. The reboot occasionally hangs
>> permanently with RCU stall on ksoftirqd.
>>
>> Observed on ARM64 KVM guest:
>>
>>    CPU#1 RCU stall (ksoftirqd/1), repeated periodically:
>>      virtqueue_enable_cb_delayed_split <- virtnet_poll <- __napi_poll <-
>>      net_rx_action <- handle_softirqs <- run_ksoftirqd <-
>>      smpboot_thread_fn <- kthread
>>
>> Fix by adding a virtqueue_is_broken() check to the loop condition, so
>> that the loop exits immediately when the device is broken, allowing
>> the device shutdown to proceed.
>>
>> Signed-off-by: Jinqian Yang <yangjinqian1@huawei.com>
> 
> I'd expect lots of drivers have this issue?  Wouldn't it make more sense
> to check virtqueue_is_broken in
> virtqueue_enable_cb_delayed/virtqueue_enable_cb? This way it works for
> all drivers.
> 

In virtqueue_enable_cb->virtqueue_poll, a check for vq->broken is
performed, so other devices do not have this issue.

Indeed, it is more reasonable to check vq->broken inside
virtqueue_enable_cb_delayed. I will make the changes in v2.

Thanks,
Jinqian

> 
> 
>> ---
>>   drivers/net/virtio_net.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 7d2eeb9b1226..c8d2d420c31d 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -2970,7 +2970,8 @@ static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
>>   		do {
>>   			virtqueue_disable_cb(sq->vq);
>>   			free_old_xmit(sq, txq, !!budget);
>> -		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>> +		} while (!virtqueue_is_broken(sq->vq) &&
>> +			 unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>>   
>>   		if (sq->vq->num_free >= MAX_SKB_FRAGS + 2)
>>   			virtnet_tx_wake_queue(vi, sq);
>> -- 
>> 2.33.0
> 
> 

