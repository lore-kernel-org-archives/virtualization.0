Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8711B35F5E3
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 06:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784181940; cv=none; b=lP/NfHiFaJxOAzJih3bP06wKdUc6KZkDfo3kcJdJ5rG50bsKdTtU1dLyD311TyvDF5vcICiRoUdBET17Xok/LDnW7g3f0KRvhkQCs4T5Nj/MnblZKUXR4Gz978ecIkrUOKlwXt52Om/Yrr0qsS3I1yKTw8wEhMcbIrmi8+65X/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784181940; c=relaxed/simple;
	bh=GLO1pAxaJdY9mn06VprM5C+XrP2pmxP6RplRkS9TPoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nIzUHTNihSqieXj/K0zt1d4ntUPIeRjdczCyHZu1+WrxHGobWqdIFMSOok1+lAcU+rMVjJRlv/qpV9gll4Hh0FtvX1HXPz1NiGT5S+nI0SbEBhsVglqOGgPK1Ye1pc2VkunH0pOgZyrr1msUd1YB5wfZJzddui3XfIcmZgbH5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Z4F4K37w; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Z4F4K37w"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lvBdS4RGU9Yw/3MYdrQYhu+XNnpQLrYr2vG2OyUGajo=;
	b=Z4F4K37wPPA7OrmKUwNucPZyKjvIcIr4BcO1oa8mKXcE1vIqW2zk0M9GG+y+o5NaPVVBw3zhe
	YooKKdR2I0wuvkL1MesTJ4LPDlqoczrdRzSd1xOflLpq7IBx3Nbs+6bPvwHpjN1lU5zAs19Wq5d
	cc3DGZz5qWGXU71qTQ29rHk=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h12My6ttwznTtT;
	Thu, 16 Jul 2026 13:55:58 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id AE76040586;
	Thu, 16 Jul 2026 14:05:33 +0800 (CST)
Received: from [10.67.121.183] (10.67.121.183) by
 dggpemf500013.china.huawei.com (7.185.36.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Jul 2026 14:05:32 +0800
Message-ID: <a5ade771-151d-4c02-9c1c-a776c4cb3cdf@huawei.com>
Date: Thu, 16 Jul 2026 14:05:31 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio_net: fix infinite loop in virtnet_poll_cleantx
 when device is broken
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <liuyonglong@huawei.com>,
	<wangzhou1@hisilicon.com>, <linuxarm@huawei.com>
References: <20260716035201.3736582-1-yangjinqian1@huawei.com>
 <20260716011312-mutt-send-email-mst@kernel.org>
From: Jinqian Yang <yangjinqian1@huawei.com>
In-Reply-To: <20260716011312-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

Hi,

On 2026/7/16 13:14, Michael S. Tsirkin wrote:
> On Thu, Jul 16, 2026 at 11:52:01AM +0800, Jinqian Yang wrote:
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
> 
> Good thanks! Just the subject needs change so it's clear
> we are changing virtio core not virtio net.
> 

Thanks for the catch. Will change the subject prefix to "virtio_ring:"
and send v3 shortly.

Thanks,
Jinqian

>> ---
>> Changes in v2:
>>    - Moved vq->broken check to virtqueue_enable_cb_delayed().
>>
>> v1: https://lore.kernel.org/lkml/20260713132025.703147-1-yangjinqian1@huawei.com/
>> ---
>>   drivers/virtio/virtio_ring.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index b438dc2ce1b8..5c169fbb418a 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -3233,6 +3233,14 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
>>   {
>>   	struct vring_virtqueue *vq = to_vvq(_vq);
>>   
>> +	/*
>> +	 * When the device is broken there is no point in polling used->idx,
>> +	 * the backend will never update it. Return true to let callers
>> +	 * exit their cleanup loops instead of spinning forever.
>> +	 */
>> +	if (unlikely(vq->broken))
>> +		return true;
>> +
>>   	if (vq->event_triggered)
>>   		data_race(vq->event_triggered = false);
>>   
>> -- 
>> 2.33.0
> 
> 

