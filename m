Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B145C17
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 595038451B
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 12:09:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 595038451B
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RjRC0HQhP8Bk
	for <virtualization@lists.linux-foundation.org>;
	Thu, 30 Nov 2023 12:09:50 +0000 (UTC)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A2BDE8451A
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 12:09:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A2BDE8451A
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VxRQ4Df_1701346182;
Received: from 30.222.48.140(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VxRQ4Df_1701346182)
          by smtp.aliyun-inc.com;
          Thu, 30 Nov 2023 20:09:43 +0800
Message-ID: <6f78d5e0-a8a8-463e-938c-9a9b49cf106f@linux.alibaba.com>
Date: Thu, 30 Nov 2023 20:09:38 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/4] virtio-net: support rx netdim
To: Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: jasowang@redhat.com, mst@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, hawk@kernel.org,
 john.fastabend@gmail.com, ast@kernel.org, horms@kernel.org,
 xuanzhuo@linux.alibaba.com, yinjun.zhang@corigine.com
References: <cover.1701050450.git.hengqi@linux.alibaba.com>
 <12c0a070d31f29e394b78a8abb4c009274b8a88c.1701050450.git.hengqi@linux.alibaba.com>
 <8d2ee27f10a7a6c9414f10e8c0155c090b5f11e3.camel@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <8d2ee27f10a7a6c9414f10e8c0155c090b5f11e3.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/11/30 下午5:33, Paolo Abeni 写道:
> On Mon, 2023-11-27 at 10:55 +0800, Heng Qi wrote:
>> @@ -4738,11 +4881,14 @@ static void remove_vq_common(struct virtnet_info *vi)
>>   static void virtnet_remove(struct virtio_device *vdev)
>>   {
>>   	struct virtnet_info *vi = vdev->priv;
>> +	int i;
>>   
>>   	virtnet_cpu_notif_remove(vi);
>>   
>>   	/* Make sure no work handler is accessing the device. */
>>   	flush_work(&vi->config_work);
>> +	for (i = 0; i < vi->max_queue_pairs; i++)
>> +		cancel_work(&vi->rq[i].dim.work);
> If the dim work is still running here, what prevents it from completing
> after the following unregister/free netdev?

Yes, no one here is trying to stop it, the situation is like 
unregister/free netdev
when rss are being set, so I think this is ok.

>
> It looks like you want need to call cancel_work_sync here?

In v4, Yinjun Zhang mentioned that _sync() can cause deadlock[1].
Therefore, cancel_work() is used here instead of cancel_work_sync() to 
avoid possible deadlock.

[1] 
https://lore.kernel.org/all/20231122092939.1005591-1-yinjun.zhang@corigine.com/

>
> Additionally the later remove_vq_common() will needless call
> cancel_work() again;

Yes. remove_vq_common() now does not call cancel_work().

> possibly is better to consolidate a single (sync)
> call there.

Do you mean add it in virtnet_freeze()?
cancel_work() has existed in the path virtnet_freeze() -> 
virtnet_freeze_down() -> virtnet_close().

Thanks!

>
> Cheers,
>
> Paolo

