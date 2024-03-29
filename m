Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0868D1103
	for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678788; cv=none; b=nOeJybiZuLx5T61M8srlSQjlxCe6U+HR9bJZctITIvUp68UFa1B5RsCLo0jIGFK5n6rGvzd82V+WcVjnWZ0ugk9Igp9CCFt7JPqZDOZzLOidHBcM3hNIZrsQfqtJfzWgfSABEuXn1KVElT1cY2sSlp5b8l49Zcbi/jyLkT9V128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678788; c=relaxed/simple;
	bh=vjYhNwASg0V5g2Y+TK6645+2ZQWPSnve6CfEGIIphCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBqQVCVeR1s3y45bG84ZJW5RyATgSXPpiBIoO5h8+Rq5ANCkqEOW4qQ0zDUXM2qiCgswr/eyv0sdXlivgaYrouc75eQvpVqx7XL1GY4x35JJXYt/vJj+VfbKvcOpxbBwhWcGuW3BMAGYAYSYsUJdaxFsmP/S0RB4oo5kx0zeGzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CYkULqtp; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CYkULqtp"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711678783; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Z/B197cNsjXR46QvzrG56537BGJxZxD76L67Zd/+Cgo=;
	b=CYkULqtpJOxB9eimuUQU6QFVpQ9uO0PKmF/4GaCMV10bniZu5snqU88dZWjqxoAYSl1J2i6uNeUfUSs3yNq4D/aP6biwiBUiQtwA96rFPeR3S0ZQOz27hPJ9e6IBZbiHFifTcB83wWG5KSXDY9QCQ1e5z9XloddjFqNuJB9hV5g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W3V.fWk_1711678782;
Received: from 30.221.147.241(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3V.fWk_1711678782)
          by smtp.aliyun-inc.com;
          Fri, 29 Mar 2024 10:19:43 +0800
Message-ID: <3ca681b5-4844-4199-8e8c-d5d0dd82ea86@linux.alibaba.com>
Date: Fri, 29 Mar 2024 10:19:40 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] virtio-net: fix possible dim status unrecoverable
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Jurgens <danielj@nvidia.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>
References: <1711434338-64848-1-git-send-email-hengqi@linux.alibaba.com>
 <8097366d5c7dcbb916b32855d2a56189a3e6dda2.camel@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <8097366d5c7dcbb916b32855d2a56189a3e6dda2.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/28 下午6:34, Paolo Abeni 写道:
> On Tue, 2024-03-26 at 14:25 +0800, Heng Qi wrote:
>> When the dim worker is scheduled, if it fails to acquire the lock,
>> dim may not be able to return to the working state later.
>>
>> For example, the following single queue scenario:
>>    1. The dim worker of rxq0 is scheduled, and the dim status is
>>       changed to DIM_APPLY_NEW_PROFILE;
>>    2. The ethtool command is holding rtnl lock;
>>    3. Since the rtnl lock is already held, virtnet_rx_dim_work fails
>>       to acquire the lock and exits;
>>
>> Then, even if net_dim is invoked again, it cannot work because the
>> state is not restored to DIM_START_MEASURE.
>>
>> Patch has been tested on a VM with 16 NICs, 128 queues per NIC
>> (2kq total):
>> With dim enabled on all queues, there are many opportunities for
>> contention for RTNL lock, and this patch introduces no visible hotspots.
>> The dim performance is also stable.
>>
>> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> Acked-by: Jason Wang <jasowang@redhat.com>
>> ---
>> v1->v2:
>>    - Update commit log. No functional changes.
>>
>>   drivers/net/virtio_net.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index c22d111..0ebe322 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3563,8 +3563,10 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>>   	struct dim_cq_moder update_moder;
>>   	int i, qnum, err;
>>   
>> -	if (!rtnl_trylock())
>> +	if (!rtnl_trylock()) {
>> +		schedule_work(&dim->work);
>>   		return;
> I'm really scared by this change. VMs are (increasingly) used to run
> containers orchestration, which in turns puts a lot of pressure on the
> RTNL lock. Any rtnl_trylock+ reschedule may hang for a very long time.
> Addressing this kind of issues later becomes _extremely_ painful, see:
>
> https://lore.kernel.org/netdev/20231018154804.420823-1-atenart@kernel.org/
>
> I really think a different solution is needed. What about moving
> virtnet_send_command() under protection of a new mutex?

Daniel did additional work:

https://lore.kernel.org/all/20240328044715.266641-1-danielj@nvidia.com/

Use spin lock to protect ctrlq access, therefore, rtnl lock can be 
removed in rx_dim_work,
which will make the problem non-existent.

Thanks,
Heng

>
> I understand it will complicate future hardening works around cvq, but
> really rtnl_trylock()/<spin/retry> is bad for the whole system.
>
> Cheers,
>
> Paolo

